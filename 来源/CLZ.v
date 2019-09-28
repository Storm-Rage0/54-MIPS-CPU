`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/21 22:34:20
// Design Name: 
// Module Name: CLZ
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


module CLZ(data_in,count);      
       input [31:0]data_in;
       output [31:0]count;
       assign count=(data_in[31]==1)?0:(data_in[30]==1)?1:(data_in[29]==1)?2:(data_in[28]==1)?3:(data_in[27]==1)?4:(data_in[26]==1)?5:(data_in[25]==1)?6:(data_in[24]==1)?7:(data_in[23]==1)
       ?8:(data_in[22]==1)?9:(data_in[21]==1)?10:(data_in[20]==1)?11:(data_in[19]==1)?12:(data_in[18]==1)?13:(data_in[17]==1)?14:(data_in[16]==1)?15:(data_in[15]==1)
       ?16:(data_in[14]==1)?17:(data_in[13]==1)?18:(data_in[12]==1)?19:(data_in[11]==1)?20:(data_in[10]==1)?21:(data_in[9]==1)?22:(data_in[8]==1)?23:(data_in[7]==1)
       ?24:(data_in[6]==1)?25:(data_in[5]==1)?26:(data_in[4]==1)?27:(data_in[3]==1)?28:(data_in[2]==1)?29:(data_in[1]==1)?30:(data_in[0]==1)?31:32;
endmodule