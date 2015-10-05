`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:43 08/24/2015 
// Design Name: 
// Module Name:    mode_fsm 
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
module mode_fsm(
    clk,
	 reset_n,
	 in,//input control
	 mode
	 );


input clk;
input reset_n;
input in;
output mode;



reg mode;
reg state;
reg next_state;


always@(*)
begin
	case(state)
	1'b0://reset時
	begin
		if(in)
		begin
			next_state=1'b1;
			mode=1'b1;
		end
		else
		begin
			next_state=1'b0;
			mode=1'b0;
		end
	end
	1'b1://30s
	begin
		if(in)//原為30s，再按一次 -> 1min
		begin
			next_state=1'b0;
			mode=1'b0;
		end
		else
		begin
			next_state=1'b1;
			mode=1'b1;
		end
	end
	default:
	begin
		next_state=1'b0;
		mode=1'b0;
	end
	endcase
end




always@(posedge clk or negedge reset_n)
begin
	if(~reset_n)
		state<=1'b0;
	else
		state<=next_state;
end

endmodule
