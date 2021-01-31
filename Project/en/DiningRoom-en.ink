VAR DiningFlag1 = false
VAR DiningFlag3 = false

=== DiningRoom ===

Dinner is done quickly. You sit beside table in Dining room.

{
-DiningFlag1 && DiningFlag3:
    Cause you're hungry, you didn't take much time to finish your meal.
    -> AfterEating
}


Dinner seems so big tonight, and you prepare to have your meal.

{not equiped: 
    Your mom asked you why you not wear the glasses and you just simply tell her it's ok you don't wear it.
}

+ [Comment the meal tastes good]
    ~ exposureIdentity = true
    You mention the pasta tastes good and the beaf is so tender and its texture is so beautiful.
    ~QmomWord = true
+ {not DiningFlag1}[Eating without say anything]
    You said nothing just like usual. And Eating your dinner quietly.
    ~DiningFlag1 = true

+ {not DiningFlag3}[Knifes and forks]
    #IMAGE: Resource/bowl.jpg
    You notice there are only two knifes and two forks on the table.
    ~Qfather =true
    ~DiningFlag3 = true
- 

+[After dinner] -> AfterEating

=AfterEating
After dinner, you drink a glass of water which is given by your mom.
{
    - exposureIdentity:
        Suddenly, you feel a bit of dizzy and gradually lost your Consciousness.
        +[Continue]
        -> LoopReset
    - else:
            +{not wantToEscapeHome}[Go outside]
                #CLEAR
                When you wanna to open the doo to go outside, your dad stop you.
                He told you it's not the right time to go outside.
                ~Qfather = true
                ~hungry = false
                ~wantToEscapeHome = true
                ++[Go to living room]
                #CLEAR
                -> LivingRoom
                ++[Go to parents bedroom]
                #CLEAR
                -> ParentRoom
            +[Go to living room]
                ~hungry = false
                You want to take a rest in living room
                ->LivingRoom
            +[Go to parents bedroom]
                ~hungry = false
                -> ParentRoom
}