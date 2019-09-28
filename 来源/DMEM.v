`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/11 22:32:45
// Design Name: 
// Module Name: DMEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module DMEM(
	input clk,	
	input ena,
	input wena,
	input rena,
	input [12:0]addr,
	input [31:0]wdata,
	input [1:0]data_bit,
	output [31:0]data_out,
	input [4:0] input_address,
    input [31:0] input_num
);
	
	reg [31:0]array [0:2047];

	integer i;
	initial begin
		for(i = 0; i <= 2047; i = i +1) begin
			array [i] <=32'b0;
		end
	end

	always @(negedge clk) begin
		if(input_address)
			array[{6'b100000,input_address}] <= input_num ; 
		else if(wena) begin
			case(data_bit)
				2'b00:
					array [addr] [7:0] <= wdata[7:0];
				2'b01:
					array[addr] [15:0]<= wdata[15:0];
				2'b11:
					array[addr] <= wdata;			
				
			endcase
		end 
		else begin
			array [addr] <= array [addr];
		end	
	end
	assign data_out = ena ? array [addr] : 32'bz;
endmodule