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
    This is your bedroom, it's clean and cosy.
    ~bedRoomFirstEnter = false
}

+  {not hungry}[Sleep]
    In the midninght, you smell something that makes you so uncomfortable. Then you loose your Consciousness
    ~Qsleep = true
    ++[Continue]
    ->LoopReset

+ {not isClockChecked}[Clock]
    ~isClockChecked = true
    #CLEAR
    #IMAGE: Resource/clock.jpg
    January 31, 2021, 6:00 PM
    {
        -clockCount==0:
        -clockCount==1: 
        You feel a bit of strange. Last time you woke up, the clock seems at this point.
        ~Qclock = true
        -else: 
        You realise every time you wakeup would be at the same time point.
    }
    ~clockCount+=1
    -> BedRoom
    
+ {not isFamilyPhotoChecked}[Photo]
    ~isFamilyPhotoChecked = true
    ~uIsFamilyPhotoChecked = true
    #CLEAR
    -> FamilyPhoto

+ {not equiped && not isGlassesChecked}[Night glasses and walking stick]
    #CLEAR
    #IMAGE: Resource/stick.jpg
    #IMAGE: Resource/glasses.jpg
    A night glasses on the table and a walking stick lies on door of bedroom.
    ++ {not equiped}[Pickup]
    You wear the night glassed and get the stick in your right hand. 
        ~ exposureIdentity = false
        ~ equiped = true
        ~ Qequiped = true
        -> BedRoom
    ++ {not equiped}[Ignore]
    No need to use glasses and stick
        ~ equiped = false
        ~ isGlassesChecked = true
        -> BedRoom

+ {not isRopeChecked && not isTryEscape}[Rope]
    ~ isRopeChecked = true
    #CLEAR
    #IMAGE: Resource/rope.jpg
    Rope, might be 10m long. Maybe it could be useful at some time.
    ~hasRopeIdea = true
    ~Qrope = true
    -> BedRoom

+ {not isWindowChecked && not isTryEscape}[Window]
    ~isWindowChecked = true
    #CLEAR
    {
        -wantToEscapeHome && hasRopeIdea && not isTryEscape:
            #IMAGE: Resource/window2.jpg
            +[Escape from window]
            ~destination = 2
            -> LeaveBedRoom
            +[Watch outside from window]
            It's winter, but not bad. 
            -> BedRoom
        -else:
            #IMAGE: Resource/window.jpg
            It's winter, but not bad. Cause your room is on 3rd floor, You could see the children play outside.
            ~Qwindow = true
            -> BedRoom
    }
    
+ [Door]
    #CLEAR
    {
        -not isRoomChecked:
        Door could be opened but could not be locked.
        ~isRoomChecked=true
    }
   ++  [Stay]
        ~keepStay = true
        {
        -not keepStay:
        You decide to keep staying in the BedRoom a bit more
        }
        -> BedRoom
    ++  [Leave]
        You leave the bedroom and in living room.
        ~destination = 1
        -> LeaveBedRoom
 + {tvCount == 2 && not isBoxChecked}[Iron Box]
    #CLEAR
    ~isBoxChecked = true
    ->IronBox
    
=LeaveBedRoom
{destination:
- 1: 
    #CLEAR
    {equiped && loopCount > 0: You wear the glasse and get the stick when you leave the bedroom.}
    ~exposureIdentity = false
    ->LivingRoom 
- 2:
    ->EscapeFromWindow
}

#CLEAR
{equiped && loopCount > 0 : You wear the glasse and get the stick when you leave the bedroom.}
~exposureIdentity = false
-> LivingRoom

=IronBox
{
- boxCount ==0:
    ~ boxCount = 1
    #IMAGE: Resource/box3.jpg
    A iron box under the bed. 
    You used it to keep you 'precious' when you're a child.
    You get it and there is nothiing in it.
    You put it back under the bed.
    ->BedRoom
-  boxCount ==1: 
    ~ boxCount = 2
    #IMAGE: Resource/box2.jpg
    A watch in the box.
    ->BedRoom
-  boxCount == 2: 
    #IMAGE: Resource/box.jpg
    A watch and a photo in the box
    -> TruthInBox 
}    

=FamilyPhoto

~uIsFamilyPhotoChecked = true

{checkTimeFamilyPhoto:
- 0:#IMAGE: Resource/picture3.jpg 
    A falimy photo with your parents, it is photoed years ago. 
    Your mom wearing a fancy bowler hat and your dad have a watch on his left hand
    ->BedRoom
- 1:  #IMAGE: Resource/picture3.jpg
    A falimy photo with your parents, it is photoed years ago. 
    Dad is not clear like you mom and you in pic, but you could recognize it.
    
    ->BedRoom
- 2: #IMAGE: Resource/picture3.jpg 
    A falimy photo with your parents, it is photoed years ago. 
    Dad is not clear like you mom and you in pic, and it's hardly to recognize.
    ~Qmemory =true
    ->BedRoom
- else:#IMAGE: Resource/picture2.jpg 
    A falimy photo, it is photoed years ago.
    Only you and your mom. You remember that your mom put the photo is related to your dad into box.
    ->BedRoom
}

=EscapeFromWindow

You remember your dad won't let you out of the apartment.

You decide out of the apartment throught the window.

Rope could be use at this moment.

But before you gonna tight the rope well.

You lost your Consciousness.

~isTryEscape = true

+ [Continue]
-> LoopReset

= TruthInBox

Suddenly, you feel headache.

You remember the neighbours said you talk to yourself since you blind.

But only your mom knows you.

->TruthInBoxOptions

= TruthInBoxOptions

*[Photo] A clear family photo. Photoed in January, 2017. 
    #IMAGE: Resource/picture.jpg
    ~prepareToWakeup += 1
    ->TruthInBoxOptions

*[Photo] A watch. You recognize this watch is from your dad. Your dad died in that accident and leave it to you. 
    ~prepareToWakeup += 1
    ->TruthInBoxOptions

*{prepareToWakeup == 2}[Stuggle in headache] The headache is so strong, you could not stand of it and loose your Consciousness gradually. 
    -> WakeUp
