`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/31 21:38:18
// Design Name: 
// Module Name: pcreg
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

module pcreg(
    input clk,
    input rst,//high level set zero
    input ena,//high level getin
    input [31:0] data_in,
    output reg[31:0] data_out
    );    
    //initial data_out<=32'h00400000;
     always @ (negedge clk or posedge rst)begin
		 if(rst)begin           
		   data_out<=32'h00400000;
         end
		 else if(ena)begin             
		        data_out<=data_in;
         end
		 else
		    data_out<=data_out;
	 end


endmodule
