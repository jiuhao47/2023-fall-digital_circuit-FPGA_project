# clock 50MHz
# 50MHz 时钟 clk
set_property -dict { PACKAGE_PIN Y18    IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 20 -waveform {0 5} [get_ports {clk}];

# reset, active low
# 低有效Reset按钮 rstn
set_property -dict { PACKAGE_PIN F20    IOSTANDARD LVCMOS33 } [get_ports { rstn }];

# user key
# 用户按键 根据开发手册，其也应该为低有效，key[i] 
set_property -dict { PACKAGE_PIN M13    IOSTANDARD LVCMOS33 } [get_ports { key[0] }];
set_property -dict { PACKAGE_PIN K14    IOSTANDARD LVCMOS33 } [get_ports { key[1] }];
set_property -dict { PACKAGE_PIN K13    IOSTANDARD LVCMOS33 } [get_ports { key[2] }];
set_property -dict { PACKAGE_PIN L13    IOSTANDARD LVCMOS33 } [get_ports { key[3] }];

# led 
# 用户LED灯，根据开发手册，低有效亮起
set_property -dict { PACKAGE_PIN F19    IOSTANDARD LVCMOS33 } [get_ports { led[0] }];
set_property -dict { PACKAGE_PIN E21    IOSTANDARD LVCMOS33 } [get_ports { led[1] }];
set_property -dict { PACKAGE_PIN D20    IOSTANDARD LVCMOS33 } [get_ports { led[2] }];
set_property -dict { PACKAGE_PIN C20    IOSTANDARD LVCMOS33 } [get_ports { led[3] }];

# 7Segment LED
# 6位八段数码管，控制引脚，低电平有效使右数第i个数码管亮起，seg_sel[i]
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { seg_sel[0] }];
set_property -dict { PACKAGE_PIN N4    IOSTANDARD LVCMOS33 } [get_ports { seg_sel[1] }];
set_property -dict { PACKAGE_PIN L5    IOSTANDARD LVCMOS33 } [get_ports { seg_sel[2] }];
set_property -dict { PACKAGE_PIN L4    IOSTANDARD LVCMOS33 } [get_ports { seg_sel[3] }];
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { seg_sel[4] }];
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { seg_sel[5] }];


# 6位八段数码管，单个数码管数据输入，共八个位置，对应关系图见'ShareLog.md'，（高电平有效，大概，2023.12.6） seg_dig[i]
set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[0] }];# A
set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[1] }];# B
set_property -dict { PACKAGE_PIN J6    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[2] }];# C
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[3] }];# D
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[4] }];# E
set_property -dict { PACKAGE_PIN K6    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[5] }];# F
set_property -dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[6] }];# G
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { seg_dig[7] }];# DP

# 以下为额外定义端口


# DDR3 片上静态内存
set_property -dict { PACKAGE_PIN Y3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_LDQS_P }];
set_property -dict { PACKAGE_PIN AA3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_LDQS_N }];
# LDQS和LDQS#是数据选通引脚，对应低字节DQ0~DQ7，读的时候是输出，写的时候为输入

set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_UDQS_P }];
set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_UDQS_N }];
# UDQS和UDQS#是数据选通引脚，对应高字节DQ8~DQ15，读的时候是输出，写的时候为输入

set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[0] }];
set_property -dict { PACKAGE_PIN AB2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[1] }];
set_property -dict { PACKAGE_PIN AB3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[2] }];
set_property -dict { PACKAGE_PIN AA1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[3] }];
set_property -dict { PACKAGE_PIN AA5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[4] }];
set_property -dict { PACKAGE_PIN Y4    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[5] }];
set_property -dict { PACKAGE_PIN AB5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[6] }];
set_property -dict { PACKAGE_PIN AA4    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[7] }];
set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[8] }];
set_property -dict { PACKAGE_PIN Y1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[9] }];
set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[10] }];
set_property -dict { PACKAGE_PIN Y2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[11] }];
set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[12] }];
set_property -dict { PACKAGE_PIN W1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[13] }];
set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[14] }];
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_DQ[15] }];
# DQ0~DQ15为16根数据线，因此该DDR3L的宽度为16位

set_property -dict { PACKAGE_PIN AB1    IOSTANDARD LVCMOS33 } [get_ports { DDR3_LDM }]; 
set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { DDR3_UDM }];
# 写数据输入屏蔽引脚

set_property -dict { PACKAGE_PIN AA8    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[0] }];
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[1] }];
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[2] }];
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[3] }];
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[4] }];
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[5] }];
set_property -dict { PACKAGE_PIN U6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[6] }];
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[7] }];
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[8] }];
set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[9] }];
set_property -dict { PACKAGE_PIN AA6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[10] }];
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[11] }];
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[12] }];
set_property -dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_A[13] }];
# A0~A13为15根地址线，有1根行地址线A0~A14和10根列地址线A0~A9
# 行地址线和列地址线进行复用

set_property -dict { PACKAGE_PIN AB8    IOSTANDARD LVCMOS33 } [get_ports { DDR3_BA[0] }];
set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { DDR3_BA[1] }];
set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { DDR3_BA[2] }];
# BA[2:0]：BA0~BA2为Bank的选择线，由2^3=8，因此可以总共有8个Bank。

set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { DDR3_S0 }];
# 

set_property -dict { PACKAGE_PIN AB7    IOSTANDARD LVCMOS33 } [get_ports { DDR3_RAS }];
# 行地址选通信号

set_property -dict { PACKAGE_PIN T4    IOSTANDARD LVCMOS33 } [get_ports { DDR3_CAS }];
# 列地址选通信号

set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_WE }];
# 写使能信号

set_property -dict { PACKAGE_PIN AB6    IOSTANDARD LVCMOS33 } [get_ports { DDR3_ODT }];
# 片上终端使能，ODT使能和禁止片内终端电阻

set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { DDR3_RESET }];
# 芯片复位引脚，低电平有效

set_property -dict { PACKAGE_PIN V9    IOSTANDARD LVCMOS33 } [get_ports { DDR3_CLK_P }];
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { DDR3_CLK_N }];
# 时钟信号线，DDR3的时钟线是差分时钟线，所以的控制信号和地址信号都会在CK的上升沿和CK#的下降沿交叉处采集

set_property -dict { PACKAGE_PIN R4    IOSTANDARD LVCMOS33 } [get_ports { DDR3_CKE }];
# 时钟使能引脚




