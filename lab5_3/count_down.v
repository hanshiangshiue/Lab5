`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:49 08/20/2015 
// Design Name: 
// Module Name:    count_down 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module count_down(
    clk,
	 //en,
	 mode_button,
	 ftsd_ctl,
	 display,
	 button,
	 LED,
	 led_en
	 
	 );

input clk;
//input en;
input mode_button;
input button;//control start or pause
output [3:0] ftsd_ctl;
output [14:0] display;
output [14:0] LED;
output led_en;



wire [3:0] bcd;
wire [1:0] clk_ctl;
wire [1:0] clk_out;
wire clk_150;
wire [3:0] in0,in1,in2,in3;


wire pb_debounced;
wire out_pulse;
wire en;
wire led_en;
wire reset_n;


wire mode_pb_debounced;
wire mode_out_pulse;
wire mode;



assign LED=(in0||in1||in2||in3)? 16'b0000_0000_0000_0000:16'b1111_1111_1111_1111;



freq_div f1(
	.clk_ctl(clk_ctl),
	.clk(clk),
	.clk_150(clk_150),
	.clk_out(clk_out)
	);




debounce d1(
	.clk_150(clk_150),
	.pb_in(button),
	.pb_debounced(pb_debounced)
	);




debounce d2(
	.clk_150(clk_150),
	.pb_in(mode_button),
	.pb_debounced(mode_pb_debounced)
	);




pressed_reset p1(
    .clk_out(clk_out),
	 .in_trig(pb_debounced),
	 .reset_n(reset_n)
	 );




one_pulse o1(
	.clk(clk),
	.reset_n(reset_n),
	.in_trig(pb_debounced),
	.out_pulse(out_pulse)
	);


one_pulse o2(
	.clk(clk),
	.reset_n(reset_n),
	.in_trig(mode_pb_debounced),
	.out_pulse(mode_out_pulse)
	);




fsm fs1(
	.clk(clk),
	.reset_n(reset_n),
	.in(out_pulse),
	.count_enable(en),
	.led_en(led_en)
	);



mode_fsm mf1(
    .clk(clk),
	 .reset_n(reset_n),
	 .in(mode_out_pulse),//input control
	 .mode(mode)
	 );



	
count c1(
	.clk_out(clk_out),
	.c0(in0),
	.c1(in1),
	.c2(in2),
	.c3(in3),
	.mode(mode),
	.en(en),
	.reset_n(reset_n)
);

bcd2ftsegdec b1( 
	.display(display), // 14-segment display output
	.bcd(bcd) // BCD input
	);

scan_ctl s1(
	.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
	.ftsd_in(bcd), // output to ftsd display
	.in0(in0), // 1st input
	.in1(in1), // 2nd input
	.in2(in2), // 3rd input
	.in3(in3), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
	);




endmodule
