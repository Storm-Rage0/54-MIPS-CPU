`timescale 1ns / 1ps

module DIV(
    input [31:0] a,
    input [31:0] b,
    input sign,
    //output [31:0] data_r,
    //output [31:0] data_q
    output [63:0] result
    );
    
    wire signed [31:0]t_a;
    wire signed [31:0]t_b;
    wire [31:0] temp_q;
    wire [31:0] temp_r;
    assign t_a=a;
    assign t_b=b;

    assign temp_r = sign ? t_a % t_b : a % b;
    assign temp_q = sign ? t_a / t_b : a / b;
    assign result = {temp_r , temp_q};
endmodule
