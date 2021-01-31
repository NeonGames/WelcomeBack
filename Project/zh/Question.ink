VAR Qequiped = false

VAR Qrope = false
VAR Qwindow = false
VAR Qfather = false

VAR QtellParent = false

VAR QmomWord = false

VAR QlookMom = false
VAR QlookFather = false

VAR QfatherEating = false
VAR QwatchTV = false

VAR Qclock = false
VAR Qmemory = false
VAR Qsleep = false

VAR Qtv = false
VAR Qeye = false
=== QSpace ===

#CLEAR
欢迎来到潜意识空间！

在你的潜意识中，你能注意到更多细节。

提示：共有12个潜意识收集品，解锁特定成就可以触发结局彩蛋。

->Question

=== Question ===

+{Qequiped}1.习惯
你有带墨镜的习惯。如果你保持平时的样子，可能会回避很多危险。

+{Qtv}2.电视机
电视节目有时候告诉我们真相，有时候告诉我们假象……

+{Qclock}3.一样的时间
你发现你每次醒来的时间，年月日时刻都是一致的。
    ++[时钟坏了]时钟正常运作。所以你很可能陷入了某种奇怪的循环中了。
    ++[陷入了循环]你感觉自己陷入了某种奇怪的循环，这会是真的吗？

+{Qrope && Qwindow && Qfather}4.逃离
你想逃离屋子，但你在家门口被爸爸阻止了。你想怎么逃离呢？
    ++[利用绳子]绳子的长度正好够三层楼的高度呢！
    ++[打败爸爸]爸爸比你健壮多了，或许你可以考虑下绳子的用途。

+{QtellParent}5.反常的爸妈
你告诉爸妈你恢复视力的时候，他们的表现是反常的，他们并不为你感到高兴。
可能你保持沉默会更好些。

+{QmomWord}6.菜的颜色
你夸赞菜的颜色好看，这说明了……你已经恢复了视力！

+{QlookMom && QlookFather}7.逆龄生长
妈妈的苍老皮肤和爸爸的年轻面容并不符合他们的年纪。这是为什么呢？
    ++[爸爸保养得好]你并没有听说过爸爸有保养皮肤的习惯。
    ++[妈妈工作太累了]妈妈工作是很累，但爸爸工作也不轻松。

+{Qfather}8.缺失的餐具
妈妈不给爸爸准备碗筷。这是为什么呢？
    ++[爸爸不用吃饭]如果爸爸并不需要吃饭……想到这里，你感到毛骨悚然。
    ++[妈妈忘了]如果只是妈妈忘了拿餐具，那爸爸应该会提醒她吧。

+{QwatchTV}9.遥控器
你能精准地直接拿起遥控器，这说明了……你已经恢复了视力！

+{Qmemory}10.模糊的面容
你对爸爸的面容模糊不清，感觉你很久没见过他了。

+{Qsleep}11.异香
奇异的香气干扰了你的睡眠，导致你晕厥。幸好是躺在了床上，不至于摔倒！

+{Qeye}12.眼角膜移植手术
眼角膜移植所用的材料来自于他人捐献。

+[醒来...]->AwakeBedRoom

-
->Question