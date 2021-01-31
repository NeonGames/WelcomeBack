
VAR tellParent = 0

VAR watchTV = 0


VAR talkFlag = false
VAR lookMom = false
VAR lookFather = false

VAR tvCount = 0

=== LivingRoom ===
You are in the living room.
{ 
-numInLivingRoom ==0:
+[Look around]-> ObserveLivingRoom
-else:
+{not hungry}[Watch TC]->WatchTV
+{not hungry}[Back to your bedroom]
You stay in here for a while and back to your bedroom.
->BedRoom
+{not hungry}[Go to parents bedroom]
    ->ParentRoom
}

= ObserveLivingRoom
    ~numInLivingRoom += 1
    {loopCount:
    - 0: 
        A small apartment, not spacious, looks like normal, but it is warming. There is a sofa in the center of living room. It's placed in here for years and without moving. A TV on the front of sofa. Two bedrooms are in one side of the living room and the dining room and kitchen are on the right upper corner.
    - 1: 
    You walk round in living room and watch carefully. The place is so clean and tidy. 
    - else: Same as before, no changes is in living room.
    }

    Ocassionally, your mom and dad is back to home.
{
- not talkFlag:->TalkToParent
- else: 
    You pretend you still could not see anything.
    ->TalkToParent
}

=TalkToParent
    +[Tell them your eyes could see things again]
    ~ exposureIdentity = true
    ~ QtellParent = true
    {
        -tellParent == 0:  
        You tell parents you could see the things but they don't say much about it.
        The response of them is not what you want.
            ~tellParent +=1
        -else:    
        You still let they know you are already recovered, and they react is not change, same as the first time you told them about this. 
    }
    +[Pretend you still could not see anything]
    You pretend you still not recovered and just having some common talks.
    {
        -equiped:
            ~talkFlag = true
    }
-
    ~ temp yourWords = false    
{
-not lookMom || not lookFather:
You take a glimpse to your parent.
+  {not lookMom}[Mom]
    {yourWords:You notice mom's face become heavy when you said "Oh, you are back!" }
    Mom seems being older then you expect.
    ~ lookMom = true
    ~QlookMom = true
     ->wantToEat
+  {not lookFather} [Dad]
    You notice dad looks younger than mom, but you remember dad is older than mom.
    ~ lookFather = true
    ~QlookFather = true
    ->wantToEat
-else:
    ->wantToEat
}

= wantToEat
+   {hungry}[Feel hungry]
#CLEAR
You walk to the sofa and memtion you're hungry and wanna having dinner.
->DiningRoom

=WatchTV
    +{watchTV >= 1}[You feel tired and bored with TV]
        ++[Back to your bedroom]->BedRoom
        ++[Go to parents bedroom] ->ParentRoom
    + {watchTV < 1}[Open TV]
        You grabe TV remoter and open TV directly and you feel mom's face being more heavy than before.
        ~QwatchTV = true
        Suddenly, you feel a bit of dizzy and lost your Consciousness gradually.
        ++[Continue]
        ->LoopReset
    +{watchTV < 1} [Ask parents to open the TV]
    You ask dad to open the TV
    -
    ~watchTV += 1
    {
    -tvCount == 0:
        ~tvCount = 1
        Seems no TV signal today, only can see the snow on TV. 
        ++[Back to your bedroom]->BedRoom
        ++[Go to parents bedroom] ->ParentRoom
    -tvCount == 1:
        ~tvCount = 2
        The TV signal is not good today, the sound is so ambiguous and the pic is hardly to recognize what it is.
        But it seems play a TV news.
        ~ Qtv = true
        ++[Back to your bedroom]->BedRoom
        ++[Go to parents bedroom] ->ParentRoom
    - tvCount == 2: 
        The TV signal is not good today, the sound is so ambiguous and the pic is hardly to recognize what it is.
        But it seems play a TV news. You hear a part of it. "...latest news...accident...Driver died...need to be identified."
        You suddenly realise something in your bedroom might be the key of the problem.
        ~getSecondClueOfBox = true
        ~getFistClueInBox = true
        +[Back to your bedroom]
        ~isBoxChecked = false
        ->BedRoom
    }
