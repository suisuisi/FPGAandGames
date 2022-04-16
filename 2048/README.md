# 陪你度过深夜的2048小游戏，我们用FPGA实现它

这周末调试《车牌识别算法》遇到点问题，“无聊”中用FPGA搞个2048小游戏玩玩。

![](https://files.mdnice.com/user/17442/c6413430-b9c6-48db-8f2c-61135783d5e8.gif)

2048这个游戏大家应该不陌生了，该游戏是2014年Gabriele Cirulli利用周末的时间写的这个游戏的程序，仅仅只是好玩而已。他想用一种不同的视觉展现效果和更快速的动画来创造属于自己的游戏版本。

# 游戏介绍

这里就不介绍了，很经典的游戏。

# 软硬件环境

## FPGA板卡

ZEDBOARD（纯逻辑设计，没使用ARM） 其他板卡也可以


![](https://files.mdnice.com/user/17442/e0991695-9fce-441f-b99e-647c1369bd9b.png)

## VGA显示器或1.3寸 OLED（二选一）


![](https://files.mdnice.com/user/17442/b4dc5b88-708a-41f1-8b3b-8e074786c459.png)


## PMOD_GAMEPAD

游戏需要4(上下左右移动)+RESET（游戏GG，重新开始）

为了方便使用，这里制作了一个游戏按键手柄（以前做PONG游戏做的），主要也是按键（按键比较大）。


![](https://files.mdnice.com/user/17442/c580010b-efbe-4cf9-a9f9-095d9cc93efe.jpg)


## Vivado

Vivado 2018.3及更高版本

## 连接

![](https://github.com/suisuisi/FPGAandGames/blob/main/2048/images/%E5%AE%9E%E7%89%A9%E8%BF%9E%E6%8E%A5.JPG?raw=true)

# 源码简介

整个项目框图如下所示：


![](https://files.mdnice.com/user/17442/377d5386-98ec-4f13-b5d9-5167aa833893.png)

每个模块的源码上都有简介，其中主模块（game.v）主要涉及将各个模块连接和主状态机控制，状态机代码也比较简单（主要控制，初始状态，胜利及失败三个状态，详见代码）。


# 开源链接

> https://github.com/suisuisi/FPGAandGames/tree/main/2048

下载后可以直接进行综合（综合结果见下），使用JTAG下载到FPGA中，就能看到OLED及VGA显示画面如下：

![](https://github.com/suisuisi/FPGAandGames/blob/main/2048/images/%E7%BB%BC%E5%90%88%E7%BB%93%E6%9E%9C.png?raw=true)

![](https://github.com/suisuisi/FPGAandGames/blob/main/2048/images/VGA.JPG?raw=true)

![](https://github.com/suisuisi/FPGAandGames/blob/main/2048/images/OLED.JPG?raw=true)
# 视频演示

[![陪你度过深夜的2048小游戏，我们用FPGA实现它](https://github.com/suisuisi/FPGAandGames/blob/main/2048/images/%E5%B0%81%E9%9D%A2.png?raw=true)](https://www.bilibili.com/video/BV12q4y1w7Xo/)

