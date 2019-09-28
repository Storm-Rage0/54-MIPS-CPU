module The_Top(
    input clk_in,
    input reset,
    input key_clk,
    input key_data,
    output [7:0] o_seg,
    output [7:0] o_sel
    );
    wire clk;
    wire key_state;
    wire [7:0] key_ascii;
    wire [31:0] final_num;
    Divider #(800) divider(clk_in,reset,clk);
    Keyboard_PS2 keyboard(clk,reset,key_clk,key_data,key_state,key_ascii);
    Input_Num inputnum(reset,key_state,key_ascii,final_num);
    seg7x16(clk_in,reset,1,final_num,o_seg,o_sel);
    

endmodule
/*set_property IOSTANDARD LVCMOS33 [get_ports {input_num[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {input_num[0]}]
set_property PACKAGE_PIN J15 [get_ports {input_num[0]}]
set_property PACKAGE_PIN L16 [get_ports {input_num[1]}]
set_property PACKAGE_PIN M13 [get_ports {input_num[2]}]
set_property PACKAGE_PIN R15 [get_ports {input_num[3]}]
set_property PACKAGE_PIN R17 [get_ports {input_num[4]}]
set_property PACKAGE_PIN T18 [get_ports {input_num[5]}]
set_property PACKAGE_PIN U18 [get_ports {input_num[6]}]
set_property PACKAGE_PIN R13 [get_ports {input_num[7]}]
set_property PACKAGE_PIN T8 [get_ports {input_num[8]}]
set_property PACKAGE_PIN U8 [get_ports {input_num[9]}]
set_property PACKAGE_PIN R16 [get_ports {input_num[10]}]
set_property PACKAGE_PIN T13 [get_ports {input_num[11]}]
set_property PACKAGE_PIN H6 [get_ports {input_num[12]}]
set_property PACKAGE_PIN U12 [get_ports {input_num[13]}]
set_property PACKAGE_PIN U11 [get_ports {input_num[14]}]
set_property PACKAGE_PIN V10 [get_ports {input_num[15]}]*/