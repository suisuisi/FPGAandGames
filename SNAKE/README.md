# FPGA实现贪吃蛇小游戏

手机游戏时代始于 1997 年，当时诺基亚在 6110 机型上发布了第一款名为〈贪吃蛇〉的手机游戏。这可能是有史以来最受欢迎的手机游戏之一，全球有超过 3.5 亿部手机提供这款游戏。


![](https://files.mdnice.com/user/17442/963aa131-df46-48f6-8b8e-31d448d46b49.png)


所以，对于大部分80后90后来说，该游戏不会感到陌生，该游戏是1997年Armanto 芬兰软件工程师（1995年在诺基亚任职），经过市场调研及选择，将该游戏带到了诺基亚6110手机上。

![](https://files.mdnice.com/user/17442/c5a1053b-586e-4d42-9367-56aa8e900859.png)

# 游戏介绍

![](https://files.mdnice.com/user/17442/8c2f1276-2dfe-4e16-bb58-987472ac88d4.png)

这里就不介绍了，很经典的游戏。

# 软硬件环境

## FPGA板卡

ZEDBOARD（纯逻辑设计，没使用ARM） 其他板卡也可以


![](https://files.mdnice.com/user/17442/e0991695-9fce-441f-b99e-647c1369bd9b.png)

## VGA显示器




## PMOD_GAMEPAD

游戏需要4(上下左右移动)+RESET（游戏GG，重新开始）

为了方便使用，这里制作了一个游戏按键手柄（以前做PONG游戏做的），主要也是按键（按键比较大）。

> https://gitee.com/openfpga/FPGAandGames/tree/main/2048/hardware/PMOD_GAMEPAD

![](https://files.mdnice.com/user/17442/c580010b-efbe-4cf9-a9f9-095d9cc93efe.jpg)



## Vivado

Vivado 2018.3及更高版本

## 连接


![](https://github.com/suisuisi/FPGAandGames/blob/main/SNAKE/DOC/%E6%9E%B6%E6%9E%84%E5%9B%BE.png?raw=true)


# 源码简介

整个核心FSM如下所示：



![](https://github.com/suisuisi/FPGAandGames/blob/main/SNAKE/DOC/FSM.jpg?raw=true)


每个模块的源码上都有简介，状态机代码也比较简单（主要控制，初始状态，失败三个状态，详见代码）。


# 开源链接

> https://gitee.com/openfpga/FPGAandGames/tree/main/SNAKE

下载后可以直接进行综合，使用JTAG下载到FPGA中，就能看到VGA显示画面如下：

![](https://github.com/suisuisi/FPGAandGames/blob/main/SNAKE/DOC/%E8%BF%90%E8%A1%8C%E5%9B%BE.JPG?raw=true)


![](https://github.com/suisuisi/FPGAandGames/blob/main/SNAKE/DOC/gameover.JPG?raw=true)




# 视频演示

[![FPGA实现贪吃蛇小游戏](https://github.com/suisuisi/FPGAandGames/blob/main/SNAKE/DOC/%E6%9E%B6%E6%9E%84%E5%9B%BE.png?raw=true)](https://www.bilibili.com/video/bv1hR4y1N739)



