`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/07 10:15:40
// Design Name: 
// Module Name: S_Ext16
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


module S_Ext16(
    input [15:0]data_in,
    output [31:0]data_out
    );
    assign data_out={{16{data_in[15]}},data_in};

endmodule
