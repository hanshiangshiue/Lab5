`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:52:48 08/21/2015 
// Design Name: 
// Module Name:    fsm 
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
module fsm(
    clk,
	 rst_n,
	 in,//input control
	 count_enable,
	 led_en
	 );


output count_enable;
output led_en;
input clk;
input rst_n;
input in;


reg count_enable;
reg led_en;
reg [1:0] state;
reg [1:0] next_state;


always@(*)
begin
	case(state)
	2'b00://reset®É
	begin
		if(in)
		begin
			next_state=2'b01;
			count_enable=1'b1;
			led_en=1'b1;
		end
		else
		begin
			next_state=2'b00;
			count_enable=1'b0;
			led_en=1'b0;
		end
	end
	2'b01://start®É
	begin
		if(in)//calculating and push button -> jump to pause
		begin
			next_state=2'b10;
			count_enable=1'b0;
			led_en=1'b0;
		end
		else
		begin
			next_state=2'b01;
			count_enable=1'b1;
			led_en=1'b1;
		end
	end
	2'b10://pause®É
	begin
		if(in)//pause and push button -> jump to start
		begin
			next_state=2'b01;
			count_enable=1'b1;
			led_en=1'b1;
		end
		else
		begin
			next_state=2'b10;
			count_enable=1'b0;
			led_en=1'b0;
		end
	end
	default:
	begin
		next_state=2'b00;
		count_enable=1'b0;
		led_en=1'b0;
	end
	endcase
end




always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		state<=2'b00;
	else
		state<=next_state;
end



endmodule
