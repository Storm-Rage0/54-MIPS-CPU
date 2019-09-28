`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 23:43:54
// Design Name: 
// Module Name: cpu
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


module cpu(
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,    //dmem读取数据
    output [31:0] addr_imem,
    output [31:0] addr_dmem,
    output [31:0] wdata,    //写入dmem数据
    output [31:0] pc,
    output        IM_R,     //指令寄存器读取
    output        DM_CS,
    output        DM_R,
    output        DM_W,
    output [1:0]  DM_bit,

    input [4:0] input_address,
    input [31:0] input_num,
    output reg_IO_out_ena,
    output [255:0] from_reg
    );
    //控制信号
    wire PC_CLK;                     
    wire PC_ENA; 
    wire RF_W;    
    wire RF_CLK;
    wire CP0_w;
    wire CP0_r;
    wire HI_w;
    wire LO_w;
    wire sign;
    wire [2:0]mux_pc;
    wire mux_add;                         
    wire [1:0]mux_rdc;                         
    wire [3:0]mux_rd;
    wire [1:0]mux_hi;
    wire [1:0]mux_lo;                         
    wire mux_ext5; 
    wire mux_ext16;                        
    wire mux_a;                         
    wire [1:0]mux_b;                         
    wire [3:0] aluc;                 
                     
    
    //ALU
    wire zero;                       
    wire carry;                      
    wire negative;                   
    wire overflow;                   
    wire add_overflow;               
    
    wire [5:0] INS;         
    
    //CP0
    wire mfc0;
    wire mtc0;
    wire exception;
    wire eret;
    wire [31:0]status;
    wire [31:0]exc_addr;
    wire [4:0]cause;

    //数据段
    wire [31:0] D_ALU;               
    wire [31:0] D_PC;                
    wire [31:0] D_RF;                
    wire [31:0] D_Rs;                
    wire [31:0] D_Rt;                
    wire [31:0] D_IM;                
    wire [31:0] D_DM; 
    wire [31:0] D_mux_add;               
    wire [31:0] D_mux_pc;              
    wire [4:0] D_mux_rdc;              
    wire [4:0] D_mux_rdc2;
    wire [31:0] D_mux_rd;              
    wire [4:0]  D_mux_ext5;  
    wire [15:0]  D_mux_ext16;              
    wire [31:0] D_mux_a;              
    wire [31:0] D_mux_b;  
    wire [31:0] D_HI_in;
    wire [31:0] D_LO_in; 
    wire [31:0] D_HI_out;
    wire [31:0] D_LO_out; 
    wire [31:0] D_CP0; 
    wire [31:0] D_CLZ;          
    
    wire [31:0] D_S_EXT16; 
    wire [31:0] D_S_EXT16_2; 
    wire [31:0] D_S_EXT8;  
    wire [31:0] D_EXT8;              
    wire [31:0] D_EXT5;              
    wire [31:0] D_EXT16;             
    wire [31:0] D_S_EXT18;             
    wire [31:0] D_ADD;               
    wire [31:0] D_ADD8;              
    wire [31:0] D_NPC;               
    wire [31:0] D_II;    
    wire [63:0] D_MULT;    
    wire [63:0] D_DIV; 
         
    wire [31:0] D_0x4_or_exc;
    assign PC_ENA = 1;
    
    assign addr_imem = D_PC;
    assign addr_dmem = D_ALU;
    assign wdata = D_Rt;
    assign pc=D_PC;
    assign D_DM = rdata;
   
    
    CPU_DeInstruction cpu_ins(inst,INS);
    CPU_Control cpu_opcode (clk,zero,~negative,INS,PC_CLK,IM_R,RF_W,RF_CLK,DM_R,DM_W,DM_CS,DM_bit,CP0_w,CP0_r,HI_w,LO_w,sign,
                            mux_pc,mux_add,mux_rdc,mux_rd,mux_hi,mux_lo,mux_ext5,mux_ext16,mux_a,mux_b,aluc,mfc0,mtc0,exception,eret,cause);
    
    pcreg   pc_out      (clk,reset,PC_ENA,D_mux_pc,D_PC);
    ALU     cpu_alu     (D_mux_a,D_mux_b,aluc,D_ALU,zero,carry,negative,overflow);
    regfile cpu_ref     (RF_CLK,reset,RF_W,inst[25:21],inst[20:16],D_mux_rdc,D_mux_rd,D_Rs,D_Rt,
                        input_address,input_num,reg_IO_out_ena,from_reg);
    
    MUX_2   cpu_mux_cp0 (32'h0040_0004,exc_addr,eret,D_0x4_or_exc);
    MUX_8   cpu_mux_pc  (D_NPC,D_Rs,D_ADD,D_II,D_0x4_or_exc,mux_pc,D_mux_pc);
    MUX_16   cpu_mux_rd  (D_ALU,D_ADD,D_HI_out,D_LO_out,D_CP0,D_DM,D_CLZ,D_S_EXT8,D_EXT8,D_S_EXT16_2,D_EXT16,{inst[15:0],16'b0},D_MULT[31:0],mux_rd,D_mux_rd);
    MUX_4   cpu_mux_b   (.a1(D_Rt),.a2(D_S_EXT16),.a3(D_EXT16),.a4(32'b0),.choose(mux_b),.z(D_mux_b));
    MUX5    cpu_muxext5    (inst[10:6],D_Rs[4:0],mux_ext5,D_mux_ext5);
    MUX_4_5bit   cpu_rdc     (inst[15:11],inst[20:16],5'b11111,5'b11110,mux_rdc,D_mux_rdc);  
    MUX_2   cpu_mux_a   (D_Rs,D_EXT5,mux_a,D_mux_a);
    MUX_2   cpu_mux_add   (D_S_EXT18,32'b0000,mux_add,D_mux_add);
    MUX_2_16bit   cpu_mux_ext16   (inst[15:0],D_DM[15:0],mux_ext16,D_mux_ext16);

    MUX_4   cpu_mux_hi   (D_Rs,D_MULT[63:32],D_DIV[63:32],32'b0,mux_hi,D_HI_in);
    MUX_4   cpu_mux_lo   (D_Rs,D_MULT[31:0],D_DIV[31:0],32'b0,mux_lo,D_LO_in);

    Ext5 cpu_ext5    (D_mux_ext5,D_EXT5);
    Ext8 cpu_ext8    (D_DM[7:0],D_EXT8);
    S_Ext8 cpu_s_ext8 (D_DM[7:0],D_S_EXT8);
    Ext16 cpu_ext16  (D_mux_ext16,D_EXT16);
    S_Ext16 cpu_s_ext16(inst[15:0],D_S_EXT16);
    S_Ext16 cpu_s_ext16_2(D_DM[15:0],D_S_EXT16_2);
    S_Ext18 cpu_s_ext18  (inst[15:0], D_S_EXT18);
    Add     cpu_add     (D_NPC,D_mux_add,D_ADD,add_overflow);
    CLZ     cpu_clz     (D_Rs,D_CLZ);
    npc     cpu_npc     (D_PC,reset,D_NPC);
    II      cpu_II      (D_NPC[31:28],inst[25:0], D_II);
//CP0
    CP0     cpu_cp0     (clk,reset,mfc0,mtc0,D_PC,inst[15:11],D_Rt,exception,eret,cause,D_CP0,status,exc_addr);
    MULT    cpu_mult    (D_Rs,D_Rt,sign,D_MULT);
    DIV     cpu_div     (D_Rs,D_Rt,sign,D_DIV);
    reg_hilo CPU_HI     (RF_CLK,reset,HI_w,D_HI_in,D_HI_out);
    reg_hilo CPU_LO     (RF_CLK,reset,LO_w,D_LO_in,D_LO_out);
  

endmodule
