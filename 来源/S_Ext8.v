`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 10:53:54
// Design Name: 
// Module Name: S_Ext8
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

module S_Ext8(
    input [7:0]data_in,
    output [31:0]data_out
    );
    assign data_out={{24{data_in[7]}},data_in};
endmodule

