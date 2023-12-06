# Share Log

> 这里是共享日志，这里记录了开发过程中的一些重要知识or Anything

- DDR3 片上内存，说明文档[AX7035_UG.pdf (alinx.com)](https://www.alinx.com/public/upload/file/AX7035_UG.pdf)的第10页

  > AX7035 板上配有一个 Micron(美光）的 2Gbit（256MB）的 DDR3 芯片,型号为 MT41J128M16HA-125。DDR 的总线宽度共为 16bit。DDR3 SDRAM 的最高运行时 钟速度可达 400MHz(数据速率 800Mbps)。该 DDR3 存储系统直接连接到了 FPGA 的 BANK 34 的存储器接口上。DDR3 SDRAM 的具体配置如下表 6-1 所示。 
  >
  > DDR3 的硬件设计需要严格考虑信号完整性，我们在电路设计和 PCB 设计的时候 已经充分考虑了匹配电阻/终端电阻,走线阻抗控制，走线等长控制， 保证 DDR3 的高 速稳定的工作。

- 八段数码管，说明文档[AX7035_UG.pdf (alinx.com)](https://www.alinx.com/public/upload/file/AX7035_UG.pdf)的第27页

  > AX7035 开发板上有 6 位数码管，用来显示数字信息。我们采用的数码管为 6 位一 体的八段数码管，一位数码管的段结构图 15.1 所示
  >
  > 我们使用的是共阳极数码管，**当某一字段对应的引脚为低电平时，相应字段就点亮， 当某一字段对应的引脚为高电平时，相应字段就不亮。**
  >
  > 六位一体数码管是属于动态显示，由于人的视觉暂留现象及发光二极管的余辉效应，尽管实际上各位数码管并非同时点亮，**但只要扫描的速度足够快，给人的印象就是 一组稳定的显示数据，不会有闪烁感。**
  >
  > 

  ![7SegmentLED](E:\VSCODE\UCAS-Digitial_Circuits-Finalwork\pic\7SegmentLED.png)