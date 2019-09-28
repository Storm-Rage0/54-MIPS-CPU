`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 00:04:42
// Design Name: 
// Module Name: MUX_8
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


module MUX_8(
    input [31:0]a1,
    input [31:0]a2,
    input [31:0]a3,
    input [31:0]a4,
    input [31:0]a5,
    
    input [2:0]choose,
    output reg[31:0]z
    );

    

    always @ (*)begin
        case(choose)
            3'b000:z<=a1;
            3'b001:z<=a2;
            3'b010:z<=a3;
            3'b011:z<=a4;
            3'b100:z<=a5;
            
            default: z<=32'bx;
        endcase
    end
endmodule