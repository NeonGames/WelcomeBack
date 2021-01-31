VAR bedRoomFirstEnter = true

VAR isClockChecked = false
VAR isFamilyPhotoChecked = false
VAR isWindowChecked = false
VAR isRopeChecked = false
VAR isGlassesChecked = false
VAR hasRopeIdea = false
VAR isRoomChecked = false
VAR isBoxChecked = false
VAR isTryEscape = false

VAR prepareToWakeup = 0
VAR keepStay = false
VAR clockCount =0

VAR boxCount = 0
=== BedRoom ===
{
 - bedRoomFirstEnter:
    这是你的卧室, 你起身在房间里四处观察。
    ~bedRoomFirstEnter = false
}

+  {not hungry}[睡觉]
    你在半睡半醒中闻到一股奇怪的味道，昏迷了过去。
    ~Qsleep = true
    ++[继续]
    ->LoopReset

+ {not isClockChecked}[检查电子时钟]
    ~isClockChecked = true
    #CLEAR
    #IMAGE: Resource/clock.jpg
    桌子上有一个精致的电子时钟，它正常地运行着。
    你看到现在的时间是2021年1月31日，下午6点整。
    {
        -clockCount==0:
        -clockCount==1: 
        你觉得很奇怪，自己上次看到的似乎也是这个时间点。难道是自己记错了？
        ~Qclock = true
        -else: 你很明确地意识到，自己每次醒来看到的都是同一个时间。
    }
    ~clockCount+=1
    -> BedRoom
    
+ {not isFamilyPhotoChecked}[检查桌上的相框]
    ~isFamilyPhotoChecked = true
    ~uIsFamilyPhotoChecked = true
    #CLEAR
    -> FamilyPhoto

+ {not equiped && not isGlassesChecked}[检查墨镜和盲杖]
    #CLEAR
    #IMAGE: Resource/stick.jpg
    #IMAGE: Resource/glasses.jpg
    桌上有一副墨镜，床边有一根盲杖。你不喜欢别人看到你的眼睛，所以即使在家里你都会戴上墨镜。这是你的习惯。
    ++ {not equiped}[带上它们]你把桌上的墨镜戴上并把门口的盲杖拿在手里。
        ~ exposureIdentity = false
        ~ equiped = true
        ~ Qequiped = true
        -> BedRoom
    ++ {not equiped}[忽视它们]你不需要它们。
        ~ equiped = false
        ~ isGlassesChecked = true
        -> BedRoom

+ {not isRopeChecked && not isTryEscape}[检查绳子]
    ~ isRopeChecked = true
    #CLEAR
    #IMAGE: Resource/rope.jpg
    房间里有一条十米长左右的绳子。
    ~hasRopeIdea = true
    ~Qrope = true
    -> BedRoom

+ {not isWindowChecked && not isTryEscape}[检查窗户]
    ~isWindowChecked = true
    #CLEAR
    {
        -wantToEscapeHome && hasRopeIdea && not isTryEscape:
            #IMAGE: Resource/window2.jpg
            +[从窗户逃走]
            ~destination = 2
            -> LeaveBedRoom
            +[看看风景]
            你看向窗，走到窗边看风景。
            -> BedRoom
        -else:
            #IMAGE: Resource/window.jpg
            你看向窗，走到窗边看风景。
            你家住在三层楼，能看到不错的远景。
            ~Qwindow = true
            -> BedRoom
    }
    
+ [检查卧室门]
    #CLEAR
    {
        -not isRoomChecked:
        你发现卧室门开着。卧室门是无法锁住的。
        ~isRoomChecked=true
    }
   ++  [再在卧室待一会儿]
        ~keepStay = true
        {
        -not keepStay:
        你决定再在卧室待一会儿。
        }
        -> BedRoom
    ++  [走出卧室]
        走出卧室，你来到客厅。
        ~destination = 1
        -> LeaveBedRoom
 + {tvCount == 2 && not isBoxChecked}[铁盒]
    #CLEAR
    ~isBoxChecked = true
    ->IronBox
    
=LeaveBedRoom
{destination:
- 1: 
    #CLEAR
    {equiped && loopCount > 0:你习惯性地带上了盲杖和墨镜。}
    ~exposureIdentity = false
    ->LivingRoom 
- 2:
    ->EscapeFromWindow
}

#CLEAR
{equiped && loopCount > 0 :你习惯性地带上了盲杖和墨镜。}
~exposureIdentity = false
-> LivingRoom

=IronBox
{
- boxCount ==0:
    ~ boxCount = 1
    #IMAGE: Resource/box3.jpg
    你把床底的铁盒拿了出来，这个铁盒是你小时候用来装自己的“宝贝”的。你打开铁盒，里面什么都没有。
    ->BedRoom
-  boxCount ==1: 
    ~ boxCount = 2
    #IMAGE: Resource/box2.jpg
    你再次打开铁盒，铁盒里装着一块手表。
    ->BedRoom
-  boxCount == 2: 
    #IMAGE: Resource/box.jpg
    你颤抖着打开了铁盒，里面是一块手表，还有一张照片。
    -> TruthInBox 
}    

=FamilyPhoto

~uIsFamilyPhotoChecked = true

{checkTimeFamilyPhoto:
- 0:#IMAGE: Resource/picture3.jpg 
    桌子上有一个精致的相框，相框中有一张老旧的照片。
    这是你和妈妈还有爸爸的合照。爸爸的手上戴着一块手表。
    ->BedRoom
- 1:  #IMAGE: Resource/picture3.jpg
    桌子上有一个精致的相框，相框中有一张老旧的照片。
    这是你和妈妈还有爸爸的合照。爸爸的身影似乎有些模糊。
    ->BedRoom
- 2: #IMAGE: Resource/picture3.jpg 
    桌子上有一个精致的相框，相框中有一张老旧的照片。
    这是你和妈妈还有爸爸的合照。爸爸的面容模糊看不清了。
    ~Qmemory =true
    ->BedRoom
- else:#IMAGE: Resource/picture2.jpg 
    桌子上有一个精致的相框，相框中有一张老旧的照片。
    这是你和妈妈的合照。你想起了，某一天妈妈将所有爸爸的照片收了起来。
    ->BedRoom
}

=EscapeFromWindow

你回忆起爸爸之前阻止你离开屋子的情景，突然感到一股寒意。

你决定不择手段也要离开屋子。

你想起了那条十米长的绳子，可以利用它从窗户爬出去。

所幸家在三楼，并不高。

当你把手搭上长绳，准备爬上窗台的时候，你突然感到一阵眩晕。

你晕倒在地。
~isTryEscape = true

+ [继续]
-> LoopReset

= TruthInBox

你突然感觉到头痛。

你回忆起了邻居们的窃窃私语。他们说你疯了，说你总是自言自语。

只有你的妈妈知道，你是在对幻想出来的爸爸说话。

->TruthInBoxOptions

= TruthInBoxOptions

*[查看相片]你忍住头痛，看到相片里爸爸的身影，相片上的时间是2017年1月。
    #IMAGE: Resource/picture.jpg
    ~prepareToWakeup += 1
    ->TruthInBoxOptions

*[查看手表]你忍住头痛，看着手表想起了过去，2017年1月31日，爸爸在车祸中丧生，只留下这块手表。
    ~prepareToWakeup += 1
    ->TruthInBoxOptions

*{prepareToWakeup == 2}[头痛]你头痛异常，晕了过去。
    -> WakeUp
