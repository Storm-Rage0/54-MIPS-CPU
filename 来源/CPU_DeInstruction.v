`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/18 17:51:23
// Design Name: 
// Module Name: CPU_DeInstruction
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


module CPU_DeInstruction(
    input [31:0] instruction,
    output [5:0] ins
    );
    wire [12:0] temp_ins;
    reg [5:0] reg_ins;
    assign temp_ins={instruction[31:26],instruction[5:0],instruction[23]};
    always @ (*)begin
        casex(temp_ins)
        //R指令
            13'b000000_100000x:reg_ins <= 0;//addu
            13'b000000_100001x:reg_ins <= 1;//add
            13'b000000_100010x:reg_ins <= 2;//subu
            13'b000000_100011x:reg_ins <= 3;//sub
            13'b000000_100100x:reg_ins <= 4;//and
            13'b000000_100101x:reg_ins <= 5;//or

            13'b000000_100110x:reg_ins <= 6;//xor
            13'b000000_100111x:reg_ins <= 7;//nor
            13'b000000_101010x:reg_ins <= 8;//slt
            13'b000000_101011x:reg_ins <= 9;//sltu
            13'b000000_000000x:reg_ins <= 10;//sll
            13'b000000_000010x:reg_ins <= 11;//srl

            13'b000000_000011x:reg_ins <= 12;//sra
            13'b000000_000100x:reg_ins <= 13;//sllv
            13'b000000_000110x:reg_ins <= 14;//srlv
            13'b000000_000111x:reg_ins <= 15;//srav
            13'b000000_001000x:reg_ins <= 16;//jr        
            13'b000000_001001x:reg_ins <= 17;//jalr

            13'b000000_010000x:reg_ins <= 18;//mfhi
            13'b000000_010010x:reg_ins <= 19;//mflo
            13'b000000_010001x:reg_ins <= 20;//mthi
            13'b000000_010011x:reg_ins <= 21;//mtlo
            13'b010000_0000000:reg_ins <= 22;//mfc0
            13'b010000_0000001:reg_ins <= 23;//mtc0

            13'b011100_100000x:reg_ins <= 24;//clz
            13'b011100_000010x:reg_ins <= 25;//mul
            13'b000000_011001x:reg_ins <= 26;//multu
            13'b000000_011010x:reg_ins <= 27;//div
            13'b000000_011011x:reg_ins <= 28;//divu


        //I指令
            13'b001000_xxxxxxx:reg_ins <= 29;//addi
            13'b001001_xxxxxxx:reg_ins <= 30;//addiu
            13'b001100_xxxxxxx:reg_ins <= 31;//andi
            13'b001101_xxxxxxx:reg_ins <= 32;//ori
            13'b001110_xxxxxxx:reg_ins <= 33;//xori
            13'b001111_xxxxxxx:reg_ins <= 34;//lui
            13'b100011_xxxxxxx:reg_ins <= 35;//lw
            13'b100000_xxxxxxx:reg_ins <= 36;//lb
            13'b100100_xxxxxxx:reg_ins <= 37;//lbu
            13'b100001_xxxxxxx:reg_ins <= 38;//lh
            13'b100101_xxxxxxx:reg_ins <= 39;//lhu

            13'b101011_xxxxxxx:reg_ins <= 40;//sw 
            13'b101000_xxxxxxx:reg_ins <= 41;//sb 
            13'b101001_xxxxxxx:reg_ins <= 42;//sh 
            13'b000100_xxxxxxx:reg_ins <= 43;//beq 
            13'b000101_xxxxxxx:reg_ins <= 44;//bne 
            13'b000001_xxxxxxx:reg_ins <= 45;//bgez 
            13'b001010_xxxxxxx:reg_ins <= 46;//slti 
            13'b001011_xxxxxxx:reg_ins <= 47;//sltiu 
        
        //J指令
            13'b000010_xxxxxxx:reg_ins <= 48;//j
            13'b000011_xxxxxxx:reg_ins <= 49;//jal

        //中断指令
            13'b000000_001101x:reg_ins <= 50;//break
            13'b000000_001100x:reg_ins <= 51;//syscall
            13'b010000_011000x:reg_ins <= 52;//eret
            13'b000000_110100x:reg_ins <= 53;//teq

            default: reg_ins <= 32'bx;
    endcase
    end

    assign ins=reg_ins;
endmodule
