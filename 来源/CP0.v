`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/03 12:21:04
// Design Name: 
// Module Name: CP0
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


module CP0(
    input clk,
    input rst,
    input mfc0,     //CP0中rd输出到GP rt
    input mtc0,     //GP rt->CP0 rd
    input [31:0] pc,
    input [4:0] Rd,     //指定CP0寄存器
    input [31:0]wdata,  //数据从GP寄存器到CP0寄存器
    input exception,    //1则有异常
    input eret,         //指令ERET（Exception Return）
    input [4:0] cause,  //01000 syscall; 01001 break; 01101 teq;
    //input intr,
    output [31:0]rdata,      //数据从CP0到GP寄存器
    output [31:0]status,
    //output reg timer_int,
    output [31:0] exc_addr  //异常起始地址
    );
    reg [31:0] CP0_array [31:0];
    reg [31:0] status_tmp;
    integer i;
	
	initial begin
		for(i=0; i<=31; i=i+1)begin
			CP0_array[i]<=32'b0;//待定
        end
    end

    always @ (negedge clk or posedge rst)
    begin
        if(rst==1)
        begin
            for(i=0; i<=31; i=i+1)begin
				CP0_array[i]<=32'b0;//待定
            end
            status_tmp<=32'b0;
        end
        else begin
            if(mtc0)begin
                CP0_array[Rd] <= wdata;
            end
            else if(exception&&(~eret))//有异常
            begin
                status_tmp<=CP0_array[12];
                CP0_array[12]<={CP0_array[12][26:0],5'b0};  //左移5位关中断
                CP0_array[13]<={25'b0,cause,2'b0};          //2-6记录原因
                CP0_array[14]<=pc;
            end
            else if(eret)//返回
            begin
                CP0_array[12]<=status_tmp;
            end
            else CP0_array[12]<=CP0_array[12];
        end
         
    end

    assign rdata = (mfc0) ? CP0_array[Rd] : 32'bz;
    assign exc_addr = (exception&&eret) ? CP0_array[14] : ((exception&&(~eret) ? 32'h00000004: 32'bz));
    assign status = CP0_array[12];
endmodule
