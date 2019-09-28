`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/07 20:01:37
// Design Name: 
// Module Name: Divider
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


module Divider#(parameter num = 2)(
    input I_CLK,
    input rst,
    output reg O_CLK
    );
    integer i=0;
    //parameter num=30000000;
    //parameter num=1;
    always @ (posedge I_CLK)
    begin
    if(rst==1)
        begin
        O_CLK<=0;
        i<=0;
        end
    else
    begin
        if(i==num-1)
        begin
        O_CLK<=~O_CLK;
        i<=0;
        end//end reset num
        else
        i<=i+1;
    end//end rst==0
    end//end always
endmodule
