`timescale 1ns / 1ps

module MULT(
    input [31:0] a,
    input [31:0] b,
    input sign,
    //output [31:0] data_hi,
    //output [31:0] data_lo
    output [63:0] result
    );
    wire signed [31:0]t_a;
    wire signed [31:0]t_b;

    assign t_a=a;
    assign t_b=b;
    
    assign result = sign ? t_a*t_b : a*b;
    
endmodule
