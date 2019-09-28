`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 10:30:34
// Design Name: 
// Module Name: Add
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


module Add(
    input [31:0] a,
    input [31:0] b,
    output [31:0] data_out,
    output overflow
    );
    assign data_out = a + b;
    assign overflow =(a[31]==b[31]&&a[31]!=data_out[31]) ? 1 : 0;
endmodule
