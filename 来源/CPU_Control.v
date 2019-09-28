`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/18 17:52:27
// Design Name: 
// Module Name: CPU_Control
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


module CPU_Control(
    input clk,
    input if_equal,
    input if_large,
    input [5:0] ins,
    output PC_CLK,
    output IM_R,
    output RF_W,
    output RF_CLK,
    output DM_r,
    output DM_w,
    output DM_CS,
    output [1:0] DM_bit,
    output CP0_w,
    output CP0_r,
    output HI_w,
    output LO_w,
    output sign,
    //选择器控制
    output [2:0] MUX_PC,
    output MUX_Add,
    output [1:0] MUX_Rdc,
    output [3:0] MUX_Rd, 
    output [1:0] MUX_HI,
    output [1:0] MUX_LO,
    output MUX_Ext5,
    output MUX_Ext16,
    output MUX_A,
    output [1:0] MUX_B,
    output [3:0] ALU,
    output mfc0,
    output mtc0,
    output exception,
    output eret,
    output [4:0] cause   
    );
    
    assign PC_CLK=clk;
    assign IM_R=1;
    assign RF_W=~(ins==16||ins==20||ins==21||ins==23||ins==26||ins==27
                ||ins==28||ins==40||ins==41||ins==42||ins==43||ins==44||ins==45
                ||ins==48||ins==50||ins==51||ins==52||ins==53);
    assign RF_CLK=clk;
    assign DM_r=(ins==35||ins==36||ins==37||ins==38||ins==39);
    assign DM_w=(ins==40||ins==41||ins==42);
    assign DM_CS=(ins==35||ins==36||ins==37||ins==38||ins==39||ins==40||ins==41||ins==42);
    assign DM_bit[0]=(ins==40||ins==42);
    assign DM_bit[1]=(ins==40);
    assign CP0_w=(ins==23||ins==50||ins==51||ins==52||ins==53);
    assign CP0_r=(ins==22||ins==50||ins==51||ins==52||ins==53);
    assign HI_w=(ins==20||ins==25||ins==26||ins==27||ins==28);
    assign LO_w=(ins==21||ins==25||ins==26||ins==27||ins==28);
    assign sign=(ins==25||ins==27);

    assign mfc0=(ins==22);
    assign mtc0=(ins==23);
    assign exception=(ins==50||ins==51||ins==52||(ins==53&&if_equal));
    assign eret=(ins==52);
    assign cause=(ins==50) ? 5'b01001 : ((ins==51) ? 5'b01000 : ((ins==53) ? 5'b01101 : 5'bz));

    //选择器
    assign MUX_PC[0]=(ins==16||ins==17||ins==48||ins==49);
    assign MUX_PC[1]=((ins==43&&if_equal)||(ins==44&&~if_equal)||(ins==45&&if_large)||ins==48||ins==49);
    assign MUX_PC[2]=(ins==50||ins==51||ins==52||ins==53);

    assign MUX_Add=(ins==17||ins==49);

    assign MUX_Rdc[0]=(ins==22||ins==29||ins==30||ins==31||ins==32||ins==33||ins==34||ins==35||
            ins==36||ins==37||ins==38||ins==39||ins==46||ins==47);
    assign MUX_Rdc[1]=(ins==49);

    assign MUX_Rd[0]=(ins==17||ins==19||ins==34||ins==35||ins==36||ins==38||ins==49);        
    assign MUX_Rd[1]=(ins==18||ins==19||ins==24||ins==34||ins==36||ins==39);
    assign MUX_Rd[2]=(ins==22||ins==24||ins==25||ins==35||ins==36);
    assign MUX_Rd[3]=(ins==25||ins==34||ins==37||ins==38||ins==39);

    assign MUX_HI[0]=(ins==25||ins==26);
    assign MUX_HI[1]=(ins==27||ins==28);
    assign MUX_LO[0]=(ins==25||ins==26);
    assign MUX_LO[1]=(ins==27||ins==28);

    assign MUX_Ext5=(ins==13||ins==14||ins==15);
    assign MUX_Ext16=(ins==39);

    assign MUX_A=(ins==10||ins==11||ins==12||ins==13||ins==14||ins==15);
    assign MUX_B[0]=(ins==29||ins==30||ins==35||ins==36||ins==37||ins==38||
            ins==39||ins==40||ins==41||ins==42||ins==45||ins==46||ins==47);
    assign MUX_B[1]=(ins==31||ins==32||ins==33||ins==45);

    assign ALU[0]=(ins==2||ins==3||ins==5||ins==7||ins==8||ins==11||
            ins==14||ins==32||ins==43||ins==44||ins==45||ins==46||ins==53);
    assign ALU[1]=(ins==1||ins==3||ins==6||ins==7||ins==8||ins==9||ins==10||ins==13||ins==29||
            ins==33||ins==43||ins==44||ins==45||ins==46||ins==47||ins==53);
    assign ALU[2]=(ins==4||ins==5||ins==6||ins==7||ins==10||ins==11||ins==12||
            ins==13||ins==14||ins==15||ins==31||ins==32||ins==33);
    assign ALU[3]=(ins==8||ins==9||ins==10||ins==11||ins==12||ins==13||
            ins==14||ins==15||ins==46||ins==47);
endmodule
