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

module DMEM1(
	input clk,	
	input ena,
	input wena,
	input rena,
	input [10:0]addr,
	input [31:0]wdata,
	output [31:0]data_out
);
	
	reg [31:0]array [0:2047];

	integer i;
	initial begin
		for(i = 0; i <= 2047; i = i +1) begin
			array [i] = 32'b0;
		end
	end

	always @(negedge clk) begin
		if(wena) begin
			array [addr] <= wdata;
		end else begin
			array [addr] <= array [addr];
		end	
	end
	
	assign data_out = ena ? array [addr] : 32'bz;
endmodule