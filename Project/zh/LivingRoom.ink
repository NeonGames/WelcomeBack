
VAR tellParent = 0

VAR watchTV = 0


VAR talkFlag = false
VAR lookMom = false
VAR lookFather = false

VAR tvCount = 0

=== LivingRoom ===
你来到了客厅。
{ 
-numInLivingRoom ==0:
+[观察客厅]-> ObserveLivingRoom
-else:
+{not hungry}[看电视]->WatchTV
+{not hungry}[回到自己的卧室]
你在客厅待了一会儿，起身回到自己的卧室。
->BedRoom
+{not hungry}[去爸妈的卧室]
    ->ParentRoom
}

= ObserveLivingRoom
    ~numInLivingRoom += 1
    {loopCount:
    - 0: 客厅和普通人家无太大差别。客厅的中央摆着一张大沙发，但沙发的面料已经有些破旧。沙发的对面，一台老式黑白电视机。整个屋子是一个简单的二居一室一厅。沙发的背后就是出去的房门。爸妈和自己的卧室在客厅的一侧，厨房和吃饭的地方在沙发的斜对面。
    - 1: 你仔细地观察了一下客厅，客厅被打扫得十分的整洁。
    - else: 客厅和之前相比没有任何变化。
    }

    这时，爸妈正好开门回来。
   
{
- not talkFlag:->TalkToParent
- else: 
    你装作自己仍然看不见。爸妈并没有看出异常。
    ->TalkToParent
}

=TalkToParent
    +[告诉他们你恢复了视力]
    ~ exposureIdentity = true
    ~ QtellParent = true
    {
        -tellParent == 0:  你手舞足蹈地告诉他们你恢复了视力，但他们却沉默了好几秒。
            ~tellParent +=1
        -else:    你告诉他们你恢复了视力，他们的样子像是第一次知道这件事。
    }
    +[假装自己看不见东西]
    你装作什么事也没发生，只是说了一句你们回来了。
    {
        -equiped:
            ~talkFlag = true
    }
-
    ~ temp yourWords = false    
{
-not lookMom || not lookFather:
你偷偷打量爸妈的神色。
+  {not lookMom}[观察妈妈]
    {yourWords:妈妈听了你说的“你们回来了”，脸色突然变得阴沉。}
    妈妈的脸上比记忆中的样子多了很多皱纹。
    ~ lookMom = true
    ~QlookMom = true
     ->wantToEat
+  {not lookFather} [观察爸爸]
    你发现爸爸比妈妈显得要年轻一些。
    你记得爸爸比妈妈岁数大。
    ~ lookFather = true
    ~QlookFather = true
    ->wantToEat
-else:
    ->wantToEat
}

= wantToEat
+   {hungry}[肚子很饿]
#CLEAR
你一边走向沙发，一边和他们说肚子很饿，想早点吃晚饭。
->DiningRoom

=WatchTV
    +{watchTV >= 1}[你已经很困了，没什么看电视的兴致。]
        ++[回到自己的卧室]->BedRoom
        ++[去爸妈的卧室] ->ParentRoom
    + {watchTV < 1}[直接拿起遥控器]
        你直接拿起了遥控器打开了电视。
        妈妈看到后脸色一变，但没说什么。
        看着看着，你觉得有点晕。
        ~QwatchTV = true
        不久后你晕倒在沙发上。
        ++[继续]
        ->LoopReset
    +{watchTV < 1} [让爸妈帮你打开电视]
    你让爸妈帮你打开了电视。
    -
    ~watchTV += 1
    {
    -tvCount == 0:
        ~tvCount = 1
        电视机传来沙沙的声音，只有满屏的雪花，似乎今天的信号不是很好。
        ++[回到自己的卧室]->BedRoom
        ++[去爸妈的卧室] ->ParentRoom
    -tvCount == 1:
        ~tvCount = 2
        电视机传来沙沙的声音，虽然信号依然不是很好，画面非常的不清晰，但是你能看到正在播放的是新闻节目。
        ~ Qtv = true
        ++[回到自己的卧室]->BedRoom
        ++[去爸妈的卧室] ->ParentRoom
    - tvCount == 2: 电视机传来沙沙的声音，画面依然很不清晰，但是你能模模糊糊地听到新闻的一些内容。“本台报道……一人死亡，一人重伤……身份尚未确认。”你似乎想起了什么，起身回到自己的卧室。
        ~getSecondClueOfBox = true
        ~getFistClueInBox = true
        +[回到卧室寻找某件东西]
        ~isBoxChecked = false
        ->BedRoom
    }
