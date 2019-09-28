`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 13:29:06
// Design Name: 
// Module Name: reg_hilo
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


module reg_hilo(
    input clk, //下降沿写入数据
    input rst, //reset异步复位高有效
    input we, //寄存器读写有效信号，高电平时允许寄存器写入数据
    input [31:0] wdata, //写入数据
    output [31:0] rdata 
    );
    reg [31:0] array_reg;
	integer i;
	initial begin
		array_reg <= 32'b0;
	end
	
	always @(negedge clk or posedge rst) begin
		if(rst) begin
			array_reg <= 0;
		end
		else 
		begin
		    if(we)
				array_reg <= wdata;
		end
	end

	assign rdata = array_reg;
endmodule
