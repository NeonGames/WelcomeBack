INCLUDE Misc.ink
INCLUDE BedRoom-en.ink
INCLUDE LivingRoom-en.ink
INCLUDE ParentRoom-en.ink
INCLUDE DiningRoom-en.ink
INCLUDE Question-en

VAR exposureIdentity = true

VAR tip1 = false
VAR tip2 = false
#IMAGE: Resource/accident.jpg

January 31, 2017, you got a car accident. In this accident, you got an damage on your brain and be blind from then. 

Tip: Find out the truth of the story and be careful, the truth is in everywhere.

+ [Enter]
    # CLEAR
    -> Awake

=== Awake ===

You wake up from the nap in the afternoon and get stung in the eye by the light.

You raised your hand to block the light.

Suddenly, you realise your could not feel the light since you blind.

+Unless[……] you recoverd.
-

What a wonderful thing!

You are eager to tell your parents the good news.

But you need to take some time to get used of it.

+[A few minutes later]
-

#CLEAR

How beautiful thing!

Back to the normal life is make you so exciting.

You notice your bedroom still not change too much since you blind.

+[Look Around]
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
In your sleepy, you heard clock tick-tock and you count its number. Tick {loopCount} times.
{
-exposureIdentity && not wantToEscapeHome && not tip1:

"Don't let people know you cuuld see things", a strange voice speak in your brain.
~tip1 = true
}

{
-wantToEscapeHome && not exposureIdentity && not tip2:
"Find the truth, truth is in everywhere." A stange voice mentioned. 
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
+[Hey...]
->AwakeBedRoom
+[Mental Space]
->QSpace


=== AwakeBedRoom===
#CLEAR
+[Hey......]
-
#CLEAR
+[Hey! Wake up !]
-
#CLEAR
You get your Consciousness back.

{
-loopCount==1:

You find you are in bedroom and notice something is strang. 
-loopCount==2:

You found everytime you reattain your Consciousness,you are in bedroom.
You guess you might be stucked in a infinity loop at one strange time point.
}

-> BedRoom

=== WakeUp ===
#CLEAR

January 31, 2021 6:00 PM.

The surgery of corneal transplantation is done.

You woke up at the hospital. The nurse saw you awake and let the doc come.

"You gonna see the world again soon, welcome back to the normal life." Said by doc.

Welcome Back!

+{Qtv}[Bonus]-> egg

+[End]-> END

=== egg ===
"Congratulation, all the key clues be collected." A strange voice speak in my mind.
Seems I finally beak the loop ring.

+[Final End]
-> AnotherEnd

=AnotherEnd
#CLEAR
"But, are you sure?"
-> END