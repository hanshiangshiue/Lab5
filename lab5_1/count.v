`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:15:21 08/20/2015 
// Design Name: 
// Module Name:    count 
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
module count(
    clk_out,
	 rst_n,
	 mode,
	 en,
	 c0,
	 c1,
	 c2,
	 c3
	 );


input clk_out;
input rst_n;
input [1:0] mode;
input en;

output [3:0] c0;
output [3:0] c1;
output [3:0] c2;
output [3:0] c3;


reg [3:0] c0,c1,c2,c3,c0_next,c1_next,c2_next,c3_next,c0_init,c1_init,c2_init,c3_init;


always@(mode)
begin
	case(mode)
		2'b00:
		begin
			c0_init=4'd0;
			c1_init=4'd0;
			c2_init=4'd3;
			c3_init=4'd0;
		end
		2'b01:
		begin
			c0_init=4'd0;
			c1_init=4'd1;
			c2_init=4'd0;
			c3_init=4'd0;
		end
		default:
		begin
			c0_init=4'd0;
			c1_init=4'd0;
			c2_init=4'd0;
			c3_init=4'd0;
		end
	endcase
end



always@(posedge clk_out or negedge rst_n)
begin
	if(~rst_n)
	begin
		c0<=c0_init;
		c1<=c1_init;
		c2<=c2_init;
		c3<=c3_init;
	end
	else
	begin
		c0<=c0_next;
		c1<=c1_next;
		c2<=c2_next;
		c3<=c3_next;
	end
end



always@(*)
begin
	if(en==0)
	begin
		c0_next=c0;
		c1_next=c1;
		c2_next=c2;
		c3_next=c3;
	end
	else
	begin
		if(c0==4'd0 && c1==4'd0 && c2==4'd0 && c3==4'd0)
		begin
			c0_next=4'd0;
			c1_next=4'd0;
			c2_next=4'd0;
			c3_next=4'd0;
		end
		else if(c1!=4'd0 && c2==4'd0 && c3==4'd0)
		begin
			c1_next=c1-4'd1;
			c2_next=4'd5;
			c3_next=4'd9;
		end
		else if(c1==4'd0 && c2!=4'd0 && c3==4'd0)
		begin
			c1_next=c1;
			c2_next=c2-4'd1;
			c3_next=4'd9;
		end
		else
		begin
			c1_next=c1;
			c2_next=c2;
			c3_next=c3-4'd1;
		end
	end
end


endmodule
