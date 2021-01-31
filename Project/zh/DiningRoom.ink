VAR DiningFlag1 = false
VAR DiningFlag3 = false

=== DiningRoom ===

晚饭很快就做好了，你来到餐桌坐下。

{
-DiningFlag1 && DiningFlag3:
    你很快就吃完了饭。
    -> AfterEating
}


晚饭有道菜颜色特别好看。

{not equiped: 妈妈突然问了一句:“你怎么不带墨镜了？你平时不是很在意这件事吗？” 你回答：“哦，我觉得不带它也没事。”}

+ [夸赞晚餐]
    ~ exposureIdentity = true
    你提到今晚有道菜特别好吃，颜色很好看。
    妈妈听到后，妈妈皱着眉头，盯着你的眼睛。
    ~QmomWord = true
+ {not DiningFlag1}[沉默不语]
    你什么也没说，默默吃饭。母亲像往常一样帮你夹了菜。
    ~DiningFlag1 = true

+ {not DiningFlag3}[餐具]
    #IMAGE: Resource/bowl.jpg
    餐桌上有两副碗筷，爸爸似乎还不饿，温柔地看着你和妈妈吃饭。
    ~Qfather =true
    ~DiningFlag3 = true
- 

+[吃完饭] -> AfterEating

=AfterEating
吃完饭后，母亲给你端了一杯水。
你把水喝完了。
{
    - exposureIdentity:
        你突然感觉到一阵眩晕。不久后，你晕倒在餐桌上。
        +[继续]
        -> LoopReset
    - else:
            +{not wantToEscapeHome}[出门看看外面的街道]
                #CLEAR
                你想要出门看看，但爸爸突然拦在大门前不让你出去。
                爸爸告诉你外面很危险，不要在晚上出门。
                是不是有其他方式可以出去呢？
                ~Qfather = true
                ~hungry = false
                ~wantToEscapeHome = true
                ++[去客厅]
                #CLEAR
                -> LivingRoom
                ++[去爸妈的卧室]
                #CLEAR
                -> ParentRoom
            +[去客厅]
                ~hungry = false
                你想去客厅坐坐。
                ->LivingRoom
            +[去爸妈的卧室]
                ~hungry = false
                -> ParentRoom
}