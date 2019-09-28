`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/13 12:26:22
// Design Name: 
// Module Name: Input_Num
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


module Input_Num(
    input reset,//外部按钮按下就reset
    //input button_press,
    input key_state,
    input [7:0] key_ascii,
    output reg [28:0] final_num
    );

    initial final_num = 0;
    

    always @ (negedge key_state or posedge reset)begin
        
        if(reset)
            final_num <= 0;
        else 
            final_num <= final_num * 16 + key_ascii;

    end




endmodule
