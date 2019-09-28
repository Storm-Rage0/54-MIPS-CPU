`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 13:49:49
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    input [4:0] input_address,
    input [31:0] input_num,
    //output [31:0] inst,
    output [31:0] pc,
    output reg_IO_out_ena,
    output [255:0] from_reg
    );

    wire [31:0] inst;

    wire [31:0]rdata;   
    wire [31:0]addr_imem;
    wire [31:0]addr_dmem;
    wire [31:0]wdata;
    wire IM_R;
    wire DM_CS;
    wire DM_R;
    wire DM_W;
    wire [1:0] DM_bit;

    assign clk=clk_in;
    //Divider divider(clk_in,reset,clk);
    cpu sccpu(clk,reset,inst,rdata,addr_imem,addr_dmem,wdata,pc,IM_R,DM_CS,DM_R,DM_W,DM_bit,
                input_address,input_num,reg_IO_out_ena,from_reg);
    //seg7x16 segment(clk_in,reset,1'b1,addr_imem,o_seg,o_sel);
    IMEM_ip scimem(addr_imem[12:2],inst);
    //DMEM1 scdmem(~clk,DM_CS,DM_W,DM_R,addr_dmem[10:0],wdata,DM_bit,rdata);
    //DMEM scdmem(~clk,DM_CS,DM_W,DM_R,addr_dmem[12:0],wdata,DM_bit,rdata);
endmodule
