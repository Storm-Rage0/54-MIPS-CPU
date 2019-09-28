`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/12 10:11:12
// Design Name: 
// Module Name: VGA_Control
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


module VGA_Control
    #(
        parameter H_TOTAL = 1056,
        parameter V_TOTAL = 628
    )
    (
        input CLK,
        input RST,
        output reg [10:0] Hcnt,
        output reg [10:0] Vcnt
    );
    initial
    begin
        Hcnt <= 0;
        Vcnt <= 0;
    end
    wire VGA_CLK;
    Divider_25MHZ VGA_clk(CLK, RST, VGA_CLK);
    

    always @(posedge VGA_CLK or posedge RST)
    begin
        if(RST)
            Hcnt <= 11'd0;
        else
        begin
            if(Hcnt < H_TOTAL - 1)
                Hcnt <= Hcnt + 1;
            else
                Hcnt <= 11'd0;
        end
    end

    always @(posedge VGA_CLK or posedge RST)
    begin
        if(RST)
            Vcnt <= 11'd0;
        else if(Hcnt == H_TOTAL - 1) //ÐÐ½áÊø
        begin
            if(Vcnt < V_TOTAL - 1)
                Vcnt <= Vcnt + 1;
            else
                Vcnt <= 11'd0;
        end
    end
endmodule