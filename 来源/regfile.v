`timescale 1ns / 1ns
module regfile(
    input clk, //下降沿写入数据
    input rst, //reset异步复位高有效
    input we, //寄存器读写有效信号，高电平时允许寄存器写入数据
    input [4:0] raddr1, 
    input [4:0] raddr2, 
    input [4:0] waddr, 	//写入地址
    input [31:0] wdata, //写入数据
    output [31:0] rdata1, 
    output [31:0] rdata2,

	input [4:0] input_address,
    input [31:0] input_num,
    output reg_IO_out_ena,
    output [255:0] from_reg   
    );

    reg [31:0] array_reg[31:0];
	integer i;
	initial begin
		for(i = 0; i < 32; i = i +1) begin
			array_reg[i] <= 32'b0;
		end
	end
	
	assign rdata1 = array_reg[raddr1];
	assign rdata2 = array_reg[raddr2];

	assign from_reg={array_reg[10],array_reg[9],array_reg[8],array_reg[7],array_reg[6],array_reg[5],array_reg[4],array_reg[3]};//寄存器内容上传输出
	assign reg_IO_out_ena=(array_reg[31]==0);

	always @(negedge clk or posedge rst) begin
		if(rst) begin
			for(i = 0;i < 32;i = i + 1)
				array_reg[i] <= 0;
			//array_reg[31] <= 32'hffff_ffff;
		end
		else 
		begin
		    if(waddr&&we)
				array_reg[waddr] <= wdata;
			if(input_address && reg_IO_out_ena)
				array_reg[input_address] <= input_num;
		end
	end
	
endmodule
