# WHAT IS IT?

###Modeling the logic game known as Mafia; the simulation demonstrates who will win, as well as by how much under different constraints. [Here] (https://www.princeton.edu/~sucharit/~mafia/oldmafia/rules.htm) is a link to the rules of the Mafia game with a few exceptions. One such is that the angel outlined in the link has the role of the Detective. Additionally, everyone reveals themself on death. And finally, the Angel in this model works in accordance to the Doctor variant in the link; disregarding the Sorcerer.

# HOW IT WORKS
One tick goes through both the night and day cycles.
##Night
###Assuming all switches are on, the play goes through with the mafia killing a random citizen (This citizen may be the detective or the angel), the Angel saving a random turtle, and the Detective guessing the identity of a random turtle. If the Detective guesses a Mafia member, the Detective will then announce it during the day.
###If the Detective announced itself the previous day cycle, the play differs slightly. If the Angel is alive, the Mafia members assume that said Angel is protecting the Detective, which it correct. So, they kill a random citizen. If the Angel is dead, they kill the Detective.

##Day
###Three random agents accuse three other random agents. Depending on the charisma of both the accusers, all the turtles vote for members of the accused. The turtle with the most votes is killed.

####The Mafia
###The mafia vote is based on the current votes of the citizens. If there is already a majority vote for a mafia member, the mafia will vote for that mafia member. Otherwise, if the mafia can sway the majority by voting for another citizen, they will do that. If no mafia members are accused, the mafia will vote for a random citizen.
####THe Citizens
###Normally, the citizens vote depending on charisma and randomness. However, if a mafia member is lynched, if a turtle did not vote for that mafia member in the past, they are more likely to be a mafia member, so they are more likely to be voted for.
####The Detective
###All the turtles have a random charisma value out of 100, however, the Detective has a charisma out of 200, so it has a better chance of being believable. If the detective guesses a Mafia member's identity during the night, they then accuse the Mafia member during the day. Additionally, if the Detective knows the identity of the Angel, and it can be avoided, the Detective will not vote for the Angel.

# HOW TO USE IT

## Setup
###The 'Setup' button prepares the simulation by creating the number of citizens, the number of mafia, one angel, and one detective.

##Go
### For each tick in Go, there is a night cycle and a day cycle. During the night cycle, the mafia chooses one citizen while the angel also chooses one citizen (that citizen can be the angel or the detective as well). If the two choices coincide, the citizen is saved. If they don't, the citizen the mafia chose dies. During this same period of time, the detective chooses one turtle. If it is a mafia, then that turtle will be accused during the day. Thus concludes the night cycle. For the day cycle, three turtles are accused (four if the detective is successful) and voted on to be lynched.


##num-citizens
###Changing this slider manipulates the number of citizens. If you absolutely must change the maximum number of citizens, right click the num-citizens slider to adjust the maximum

##num-mafia
###Changing this slider manipulates the number of mafia. The maximum number of mafia members is 1/6 those of the citizens.

##With-Detective
###This switch manipulates whether or not the Detective is in play

##With-Angel
###This switch manipulates whether or not the Angel is in play
One can click Setup and then click the Go key in order to run the simulation until a win condition is met.

# THINGS TO NOTICE
The Mafia, despite a large difference in between the numbers of citizens and the number of mafia, nearly always win.


# THINGS TO TRY
###The user should change the slider in order to manipulate the number of Mafias and citizens. The user can also use the switches to change whether or not the the Angel or Detective is active.

###Commenting out hide-lines from the record-vote function shows all of the votes recorded by the citizens in the form of links. If there are about 40 citizens, concentric circles are visible.

# EXTENDING THE MODEL

###In terms of "intelligence", the Mafia and Citizens lack it. They are acting in reaction to one-another. However, this is how real humans play the game. The Mafia and Citizens turtles are simply mimicking how humans play; if the humans played perfectly. Of course, the model removes the psycology of the game itself and instead replaces it with a random charisma value. And while it is true that the not everyone has an equal charisma, in real life, this model completely ignores any psycology. For example, the Mafia members may kill a citizen if one is vocal against them. Additionally, the citizens may suspect a Mafia member if a citizen was killed after accusing that particular member. As no one can really be vocal in this model, this is replaced by randomness.
###In conclusion, the Mafia and Citizens obey game theory and randomness. And while they may mimic some portion of human cognitive ability, they are by no means intelligent themselves.

# CREDITS AND REFERENCES

Made by Noah Stolz
