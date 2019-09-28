`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 14:02:48
// Design Name: 
// Module Name: sccomp_dataflow_tb
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


module sccomp_dataflow_tb();
    reg clk_in,reset;
    
    wire [31:0] inst;
    wire [31:0] pc;


    sccomp_dataflow uut(clk_in,reset,inst,pc);

    integer file_output;
    //integer counter=0;

    initial begin

        //file_output=$fopen("result_pre.txt");

        clk_in=0;
        reset=1;
        
        #10;
        reset=0;
    end
    initial forever #20 clk_in=~clk_in;

    /*always@(posedge clk_in) begin
        $fdisplay(file_output, "pc: %h", pc);
        $fdisplay(file_output, "instr: %h", inst);
        
        //$fdisplay(file_output, "cp0_reg12: %h", sccomp_dataflow_tb.uut.sccpu.cpu_cp0.CP0_array[12]);
        //$fdisplay(file_output, "cp0_reg13: %h", sccomp_dataflow_tb.uut.sccpu.cpu_cp0.CP0_array[13]);
        //$fdisplay(file_output, "cp0_reg14: %h", sccomp_dataflow_tb.uut.sccpu.cpu_cp0.CP0_array[14]);
        $fdisplay(file_output, "regfile0: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[0]);
        $fdisplay(file_output, "regfile1: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[1]);
        $fdisplay(file_output, "regfile2: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[2]);
        $fdisplay(file_output, "regfile3: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[3]);
        $fdisplay(file_output, "regfile4: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[4]);
        $fdisplay(file_output, "regfile5: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[5]);
        $fdisplay(file_output, "regfile6: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[6]);
        $fdisplay(file_output, "regfile7: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[7]);
        $fdisplay(file_output, "regfile8: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[8]);
        $fdisplay(file_output, "regfile9: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[9]);
        $fdisplay(file_output, "regfile10: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[10]);
        $fdisplay(file_output, "regfile11: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[11]);
        $fdisplay(file_output, "regfile12: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[12]);
        $fdisplay(file_output, "regfile13: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[13]);
        $fdisplay(file_output, "regfile14: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[14]);
        $fdisplay(file_output, "regfile15: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[15]);
        $fdisplay(file_output, "regfile16: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[16]);
        $fdisplay(file_output, "regfile17: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[17]);
        $fdisplay(file_output, "regfile18: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[18]);
        $fdisplay(file_output, "regfile19: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[19]);
        $fdisplay(file_output, "regfile20: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[20]);
        $fdisplay(file_output, "regfile21: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[21]);
        $fdisplay(file_output, "regfile22: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[22]);
        $fdisplay(file_output, "regfile23: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[23]);
        $fdisplay(file_output, "regfile24: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[24]);
        $fdisplay(file_output, "regfile25: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[25]);
        $fdisplay(file_output, "regfile26: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[26]);
        $fdisplay(file_output, "regfile27: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[27]);
        $fdisplay(file_output, "regfile28: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[28]);
        $fdisplay(file_output, "regfile29: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[29]);
        $fdisplay(file_output, "regfile30: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[30]);
        $fdisplay(file_output, "regfile31: %h", sccomp_dataflow_tb.uut.sccpu.cpu_ref.array_reg[31]);
    end*/

endmodule
