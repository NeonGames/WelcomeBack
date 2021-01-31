VAR isDresserChecked = false
VAR isWardrobeChecked = false

VAR checkTimeDresser = 0
VAR checkTimeWardrobe = 0

VAR check1 = 0
VAR check2 = 0
===ParentRoom===
{
- isDresserChecked && isWardrobeChecked:
爸妈的卧室已经没有什么可看的了。
->leaveParentRoom
}

+   {not isDresserChecked} [梳妆台]
    ~isDresserChecked = true
    ->checkDresser
+   {not isWardrobeChecked} [衣柜]
    ~isWardrobeChecked = true
    ->checkWardrobe
+   [离开卧室] 
    ->leaveParentRoom 

= checkDresser
{check2:
- 0: 你仔细观察了梳妆台，梳妆台十分整齐，镜子也很干净。
    ~check2 += 1
    ->ParentRoom
- 1: 你仔细观察了梳妆台，它依旧干净整洁，但太过于干净了。
    ~check2 += 1
    ->ParentRoom
- 2: 你发现梳妆台有移动过的痕迹。你把梳妆台移开，发现在梳妆台后面有一份关于眼角膜移植的文件。
    ~check2 += 1
    ~ Qeye = true
    ->ParentRoom
- 3: 梳妆台已经没有什么可以查看的了。
    ->ParentRoom
}

=checkWardrobe
{check1:
- 0: 你打开衣柜，里面都是爸妈平时穿的衣物。
    ~check1 += 1
    ->ParentRoom
- 1: 你打开衣柜，里面都是爸妈平时穿的衣物，但衣物里缺了一些东西。
    ~check1 += 1
    ->ParentRoom
- 2: 你打开衣柜，里面都是爸妈平时穿的衣物，爸爸的衣服很少。有一条厚厚的围巾夹在衣服中，分不出是爸爸的还是妈妈的。
    ~check1 += 1
    ->ParentRoom
- 3:#IMAGE: Resource/book.jpg 
    你把围巾从衣柜中取出，你看到围巾下面放着妈妈的记账本，最新的一次记录是在医院花了一大笔钱。
    ~check1 += 1
    ->ParentRoom
- 4: 衣柜里已经没有什么可以查看的了
    ->ParentRoom
}

= leaveParentRoom
    {isDresserChecked && checkTimeDresser < 5:
        ~uIsDresserChecked = true
    }
    {isWardrobeChecked && checkTimeWardrobe < 5:
        ~uIsWardrobeChecked = true
    }

    你离开了父母的卧室。
    +[回到客厅]
    #CLEAR
    ->LivingRoom
