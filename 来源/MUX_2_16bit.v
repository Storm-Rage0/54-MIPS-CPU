`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 00:24:16
// Design Name: 
// Module Name: MUX_2_16bit
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


module MUX_2_16bit(
    input [15:0]a,
    input [15:0]b,
    input choose,
    output [15:0]z
    );
    assign z= choose ? b : a;

endmodule
