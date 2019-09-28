`timescale 1ns / 1ps



module MUX_16(
    input [31:0]a1,
    input [31:0]a2,
    input [31:0]a3,
    input [31:0]a4,
    input [31:0]a5,
    input [31:0]a6,
    input [31:0]a7,
    input [31:0]a8,
    input [31:0]a9,
    input [31:0]a10,
    input [31:0]a11,
    input [31:0]a12,
    input [31:0]a13,
    input [3:0]choose,
    output reg[31:0]z
    );

    

    always @ (*)begin
        case(choose)
            4'b0000:z<=a1;
            4'b0001:z<=a2;
            4'b0010:z<=a3;
            4'b0011:z<=a4;
            4'b0100:z<=a5;
            4'b0101:z<=a6;
            4'b0110:z<=a7;
            4'b0111:z<=a8;
            4'b1000:z<=a9;
            4'b1001:z<=a10;
            4'b1010:z<=a11;
            4'b1011:z<=a12;
            4'b1100:z<=a13;
            default: z<=32'bx;
        endcase
    end
endmodule