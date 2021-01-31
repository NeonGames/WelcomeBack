INCLUDE Misc.ink
INCLUDE BedRoom.ink
INCLUDE LivingRoom.ink
INCLUDE ParentRoom.ink
INCLUDE DiningRoom.ink
INCLUDE Question.ink

VAR exposureIdentity = true

VAR tip1 = false
VAR tip2 = false
#IMAGE: Resource/accident.jpg

2017年1月31日，一场车祸使副驾驶座上的你受伤致盲，失去了视力，失去了光明。

提示：接下来你会进入一个故事中扮演主角，请找出故事中隐藏的真相。请注意，开场白也提供了关键信息，揭露了部分真相。

+ [开始故事吧！]
    # CLEAR
    -> Awake

=== Awake ===

某一天，你从昏睡中醒来，被光刺痛了双眼。

你抬起手挡住了光。

你突然想到，失明多年的你不可能感受到光亮。

+除非[……]你恢复了视力！
-

你兴奋地大吼大叫，这是多么值得高兴的事。

你迫切地想把这个好消息告诉爸妈。

然而，因为早已习惯黑暗的世界，光亮使你难以睁开双眼。

+[一段时间过后]
-

#CLEAR

你花了一段时间适应了这个光明的世界。

睁开眼睛后，你看到每一处色彩，它们既熟悉又陌生。

逐渐地，你辨认出整个房间。

+[查看房间]
#CLEAR
-> BedRoom

=== LoopReset ===
# CLEAR

~isClockChecked = false
~isFamilyPhotoChecked = false
~isWindowChecked = false
~isRopeChecked = false
~isRoomChecked = false
~keepStay = false
~isBoxChecked = false
~isGlassesChecked = false

    ~isDresserChecked = false
    ~isWardrobeChecked = false

~loopCount += 1
在沉睡中，你听见了时钟的滴答声，响了{loopCount} 次。

{
-exposureIdentity && not wantToEscapeHome && not tip1:
“不要让人发现你恢复了视力。”
你仿佛听见有人在对你说话。
~tip1 = true
}

{
-wantToEscapeHome && not exposureIdentity && not tip2:
“不要离开屋子，真相就在屋子内。”
你仿佛听见有人在对你说话。
~tip2 = true
}

~bedRoomFirstEnter = true
~exposureIdentity = true //等穿戴上盲人用具后才会不暴露身份

{
- uIsDresserChecked &&  uIsWardrobeChecked:
    ~checkTimeDresser += 1
    ~uIsDresserChecked = false
    ~checkTimeWardrobe += 1
    ~uIsWardrobeChecked = false
    ~clueCount = clueCount + 1
    
- uIsDresserChecked==false && uIsWardrobeChecked==false:
  
- else:
    ~clueCount +=1
}

{uIsFamilyPhotoChecked == true:
    ~checkTimeFamilyPhoto += 1
    ~clueCount += 1
    ~uIsFamilyPhotoChecked = false
}

~destination = 0
~hungry = true
~numInLivingRoom = 0
~watchTV = 0
+[醒来...]
->AwakeBedRoom
+[潜意识空间]
->QSpace


=== AwakeBedRoom===
#CLEAR
去找出不合理的地方吧......
+[醒来......]
-
#CLEAR
去找出真相......
+[醒来！]
-
#CLEAR
你从沉睡中醒来。

{
-loopCount==1:
你躺在卧室的床上。
你感觉到一丝异样。
-loopCount==2:
你躺在卧室的床上。
你觉得自己陷入了某种奇怪的循环。
}

-> BedRoom

=== WakeUp ===
#CLEAR
2021年1月31日下午6：00。

你从医院的病床上醒来。

你刚做完眼角膜移植手术。

虽然还不能拆开绷带看一看光明的世界。

但你听见了妈妈高兴地在和护士交流。

不久后你就能恢复视力。

但更值得高兴的是，你找回了某些更重要的东西。

欢迎回来。

+{Qtv}[彩蛋]-> egg

+[结束]-> END

=== egg ===
恭喜你收集到潜意识空间的关键要素！

+[另一个结局]
-> AnotherEnd

=AnotherEnd
#CLEAR
2021年1月31日下午6：00。

你从医院的病床上醒来。

你找回了失去爸爸的记忆，逃离了梦魇。

然而，你确定你回到了现实吗？
-> END