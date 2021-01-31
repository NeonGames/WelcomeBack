VAR isDresserChecked = false
VAR isWardrobeChecked = false

VAR checkTimeDresser = 0
VAR checkTimeWardrobe = 0

VAR check1 = 0
VAR check2 = 0
===ParentRoom===
{
- isDresserChecked && isWardrobeChecked:
No more things could be found in parents bedroom.
->leaveParentRoom
}

+   {not isDresserChecked} [Dresser]
    ~isDresserChecked = true
    ->checkDresser
+   {not isWardrobeChecked} [Wardrobe]
    ~isWardrobeChecked = true
    ->checkWardrobe
+   [Leave] 
    ->leaveParentRoom 

= checkDresser
{check2:
- 0:
    You found the dresser is clean and the mirror on it is shinny.
    ~check2 += 1
    ->ParentRoom
- 1: 
    You found the dresser is too clean, and it makes you feel strange.
    ~check2 += 1
    ->ParentRoom
- 2: 
    You found the dresser has been moved before.
    You move the dresser and found a surgery doc of corneal transplantation.  
    ~check2 += 1
    ~ Qeye = true
    ->ParentRoom
- 3: No more things could be found in dresser.
    ->ParentRoom
}

=checkWardrobe
{check1:
- 0: 
    You open the wardrobe, your parents cloth in it.
    ~check1 += 1
    ->ParentRoom
- 1: You open the wardrobe, your parents cloth in it.
     But you feel a bit of strange, but not sure what wrong it is. 
    ~check1 += 1
    ->ParentRoom
- 2: You open the wardrobe, and you notice little of the cloth of your dad in it. There is a scarf among in cloth and you not sure it belogs to whom.
    ~check1 += 1
    ->ParentRoom
- 3:#IMAGE: Resource/book.jpg 
    You open the wardrobe and get the scarf. You found there is a account book is hidden by it.
    The latest record is spend a bunch of money in one hospital.
    ~check1 += 1
    ->ParentRoom
- 4: No more things could be found in wardrobe.
    ->ParentRoom
}

= leaveParentRoom
    {isDresserChecked && checkTimeDresser < 5:
        ~uIsDresserChecked = true
    }
    {isWardrobeChecked && checkTimeWardrobe < 5:
        ~uIsWardrobeChecked = true
    }

    You leave parents bedroom.
    +[Back to living room]
    #CLEAR
    ->LivingRoom
