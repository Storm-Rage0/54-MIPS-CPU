`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 19:00:52
// Design Name: 
// Module Name: alu
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

module ALU(
	input [31:0] a,
	input [31:0] b,
	input [3:0] aluc,
	output [31:0] r,
	output zero,
	output carry,
	output negative,
	output overflow
    );
   
    reg [32:0] result;
    wire signed [31:0] sa=a;
	wire signed [31:0] sb=b;
  
    always@(*)begin
        casex(aluc)
            4'b0000: begin	//addu
                result=a+b;   				       
            end
            4'b0010: begin	//add
                result=sa+sb;				
            end
			4'b0001: begin	//subu
                result=a-b;   				            
            end            
            4'b0011: begin	//sub
                result=sa-sb;				
            end
            4'b0100: begin	//and
                result=a&b;
            end
            4'b0101: begin	//or
                result=a|b;
            end
            4'b0110: begin	//xor
                result=a^b;
            end
            4'b0111: begin	//nor
                result=~(a|b);
            end
			4'b100x: begin	//lui
				result = {b[15:0], 16'b0};
			end
			4'b1011: begin	//slt
                result=sa<sb?1:0;
            end
			4'b1010: begin	//sltu
                result=a<b?1:0;
            end
			4'b1100: begin	//sra
                if(a==0) {result[31:0],result[32]}={b,1'b0};
                else {result[31:0],result[32]}=sb>>>(a-1);
            end
			4'b111x: begin	//sll,sla
                result=b<<a;
            end
            4'b1101: begin	//srl
                if(a==0) {result[31:0],result[32]}={b,1'b0};
                else {result[31:0],result[32]}=b>>(a-1);
            end
           default:
                result=32'b0;
        endcase
    end
    
    assign r=result[31:0];
    assign carry = (aluc==4'b0000|aluc==4'b0001|aluc==4'b1010|aluc==4'b1100|aluc==4'b1101|aluc==4'b1110|aluc==4'b1111)?result[32]:1'bz; 
    assign zero=(r==32'b0)?1:0;
    assign negative=result[31];
    assign overflow=(aluc==4'b0010|aluc==4'b0011)?result[32]:1'bz;
	endmodule
