`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/07/09 18:08:19
// Design Name: 
// Module Name: The_TopModule
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


module The_TopModule(
    input clk,
    input reset,
    input resetnum,
    
    //input port
    input start_press,
    input input_press,
    //input [15:0] input_num,
    input key_clk,
    input key_data,

    output [7:0]o_seg,
    output [7:0]o_sel,
    
    //VGA
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output HS,
    output VS
    );
    //定义状态机
    reg [2:0] Q = 0;
    reg [3:0] input_address;//外部输入数据写入地址  
    reg [4:0] input_count;//输入数据个数
    wire ready_input_press;
    wire ready_start_press;
    reg delay1_input, delay2_input, dalay3_input;
    reg delay1_start, delay2_start, dalay3_start;
    //CPU IO_out port

    //key board
    wire clk_board;
    wire key_state;
    wire [7:0] key_ascii;
    wire [28:0] final_num;

    wire reg_IO_out_ena = 1;
    wire [4:0] reg_address_IO_out = (Q == 0 || Q == 1 || Q == 2) ? {1'b0, input_address} : ((Q == 3 && reg_IO_out_ena) ? 31 : 0);
    wire [31:0] reg_input_IO_out = (Q == 0 || Q == 1 || Q == 2) ? {3'b0,final_num} : ((Q == 3 && reg_IO_out_ena) ? 32'hffffffff : 0);
    wire [31:0] pc;
 
    Divider #(200000) divider(clk,reset,clk_cpu);
    Divider #(500) divider_board (clk,reset,clk_board);
    wire [255:0] regs_from_cpu;
    sccomp_dataflow cpu_top(clk_cpu,reset,reg_address_IO_out,reg_input_IO_out,
                            pc,reg_IO_out_ena,regs_from_cpu);
    
    Keyboard_PS2 keyboard(clk_board,reset,key_clk,key_data,key_state,key_ascii);
    Input_Num inputnum(reset||resetnum,key_state,key_ascii,final_num);

    // VGA                   
    VGA_port VGA(clk,reset,Q,regs_from_cpu,R,G,B,HS,VS);
    
    seg7x16 segment(clk,reset,1'b1,{3'b0,final_num},o_seg,o_sel);
    
    //3级延迟判断是否输入
    always @(posedge clk_cpu or posedge reset)
    begin
        if(reset == 1)
        begin
            delay1_input <= 0; 
            delay2_input <= 0; 
            dalay3_input <= 0;

            delay1_start <= 0; 
            delay2_start <= 0; 
            dalay3_start <= 0;
        end
        else
        begin
            delay1_input <= input_press;
            delay2_input <= delay1_input;
            dalay3_input <= delay2_input;

            delay1_start <= start_press;
            delay2_start <= delay1_start;
            dalay3_start <= delay2_start;
        end
    end
    assign ready_input_press = delay1_input & delay2_input & dalay3_input;
    assign ready_start_press = delay1_start & delay2_start & dalay3_start;
     
    //使用状态机输入数据
    always @(posedge clk_cpu or posedge reset)
    begin
        if(reset == 1)
        begin
            Q <= 0;
            input_address <= 3;
            input_count <= 0;
        end
        else
        begin
            if(Q == 0)  //输入
            begin
                if(ready_input_press)
                begin
                    Q <= 1;
                    input_address <= input_address + 1'b1;
                end
            end
            else if(Q == 1) //缓冲
            begin
                if(input_address <= 10)//还未输入完毕，等待按键弹起后返回state0继续输入
                begin
                    if(ready_input_press == 0)
                        Q <= 0;
                end
                else
                    Q <= 2;
            end
            else if(Q == 2) //输入完成，等待开始排序
            begin
                if(ready_start_press)
                    Q <= 3;
            end
            else if(Q == 3)
            begin
                if(reg_IO_out_ena == 0)
                    Q <= 4;
            end
            else
                ;
        end
    end

    
endmodule