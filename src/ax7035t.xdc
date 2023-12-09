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




