# UCAS-Digital_Circuits-Final work

## Introduction

Verilog files for group sharing.

## Developing Logs

- 2023.11.23 建库，拿到开发板，添加模板文件`top.sv`

- 2023.11.24 协作邀请完毕

- 2023.12.7 完成了总体布局与任务分发第一步，研究了`SRAM`片上内存，对库文件做了细化：

  - 总体布局与任务分发：
    1. `Edgedetect.v`-刘镇豪
    2. `KillShake.v`-刘镇豪
    3. `FIFO.v`-吴尚哲
    4. `LED_display.v`-吴尚哲
    5. `32bit_to_6bitLED.v`规划中
  - `SRAM`片上内存
    1. 完成了`.xdc`管脚协议的补充（后证实不需要）
    2. 研究了`SRAM`的结构与原理
  - 库文件细化
    1. 建立了参考文献集`Reference.txt`
    2. 建立了重要信息共享文档`ShareLog.md`
    3. 建立了样本数据集`datadic.txt`
    4. 整理了库文件结构

- 2023.12.9

  - 关于`AX7035`开发板，找到了一份完备的教程。

  - 关于`DDR3`：建立了`ddr3`的功能及驱动模块

  - 关于`.xdc`文件

    1. 恢复了原`.xdc`样式，并对修改做了备份。

  - 关于`top.sv`

    1. 仿照样例撰写了`led7seg_decode.v`，本质为`0-9`二进制数到8端数码管数据译码器。

    2. 写了一些注释：其中下面一段代码存疑

       ```verilog
       genvar i;
       generate for(i=0; i<6; i=i+1) begin
       led7seg_decode d(cnt[i*4 +: 4], 1'b1, seg[i*8 +: 8]);//+是做什么的？
       end
       endgenerate
       ```

    3. 

  