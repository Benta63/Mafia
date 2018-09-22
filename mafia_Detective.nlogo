extensions [ bitmap ]
globals [alive-alls soon-alive-specials alive-specials alive-citizens alive-mafias names known-mafia alive-angels alive-zombies soon-alive-zombies alive-detectives detective-known]
;dead so citizens can die || specials and zombies have to do with the angels
;; alive-alls are citizens and angels
breed [mafias mafia]
breed [angels angel]
breed [citizens citizen]
breed [saveds saved]
breed [zombies zombie]
breed [specials special]
breed [detectives detective]
directed-link-breed [accusations accusation]
directed-link-breed [link-votes link-vote]
; to help turtles accuse eachother for lynch2
directed-link-breed [angel-saves angel-save]

directed-link-breed [knowledges knowledge]
turtles-own [name special charisma alive? not-linked isMafia isCitizen isAngel]
accusations-own [stamina tally]
link-votes-own [tally]
angel-saves-own [saving last-saved]
detectives-own [active] ;Only the detective has access to these links

to clear
  clear-all
end

to setup
  ;DON'T CHANGE THE COLOR OF THE TURTLES
  clear-all
  set detective-known false

  set known-mafia no-turtles
  ask patches [
     set pcolor white
  ]
  create-ordered-turtles (num-citizens + num-mafia) [
    set alive? true
    set charisma random 100
    set not-linked false
    ;charisma affects voting
    set isCitizen true
    set isAngel false
    set isMafia false
  ]
  ask n-of num-citizens turtles [
    set breed citizens
    set color sky
    ]
  ;sets up the citizens after the num-citizens slider
  ask turtles with [breed != citizens] [
    set breed mafias
    set color black
;  sets up the mafia after the slider num-mafia
  ]
  ask turtles [
    fd max-pycor
    ;to make a circle
  ]
  create-turtles (1) [
    ifelse With-Angel[
      set alive? true
      set color green
    ]
    [
      set alive? false
      set color white
    ]
    ;These are just for record keeping if the switch is off.
    set breed angels
    set charisma random 100

  ]
  create-turtles (1) [
    ifelse With-Detective[
      set alive? true
      set color brown
    ]
    [
      set alive? false
      set color white
    ]

    set breed detectives
    set charisma random 300
    set active false
    ;When the detective unmasks himself, he will get a higher charisma
    ;The detective thinks that everyone is a citizen to begin with
    fd 1
  ]

  reset-ticks

end

to go
  set alive-mafias (mafias with [alive?])
  set alive-citizens (citizens with [alive?])
  set alive-angels (angels with [alive?])
  set alive-detectives (detectives with [alive?])
  ;  agents don't die they set alive to false
  if (not any? alive-mafias)[
    ;Cool graphics (Not really)
    citizen-win
    stop
  ]
  if(count alive-mafias >= (count alive-citizens + count alive-angels + count alive-detectives)) [
    ;More cool graphics!
    mafia-win
    stop
  ]
  if (count alive-angels = 1)[
    ;So the angel is alive.
    angeles
  ]
  set alive-zombies (zombies)
  set alive-specials (specials)
  mafia-strikes
  if (count alive-detectives = 1)[
    detect
  ]
    ;  calls procedure mafia-strikes
  set alive-mafias (mafias with [alive?])
  set alive-citizens (citizens with [alive?])
  set alive-detectives (detectives with [alive?])
  set alive-angels (angels with [alive?])
  set soon-alive-zombies (zombies with [alive? = false])
  set soon-alive-specials (specials with [alive? = false])

  ;The sets have to be set again after mafia-strikes

  angeleria
   ;And then, perhaps, brought back to life
   ;If angeles isn't called, than this does nothing.
  ;story
  ; story procedure not quite finished

   lynch2

    ;  calls procedure lynch2 in order to complete the day cycle
 ; file-close-all
  ; for the story procedure (see comments on story in mafia-strikes)
  tick
end


to mafia-win
  print "Mafia Win!"
  ask patches[
    set pcolor black
  ]
  ask turtles[
    set color white
  ]
  ask angels [set color black]
  ask detectives [set color black]

  ; The M
  ask patch -15 15 [set pcolor gray]
  ask patch -15 14 [set pcolor gray]
  ask patch -15 13 [set pcolor gray]
  ask patch -15 12 [set pcolor gray]
  ask patch -15 11 [set pcolor gray]
  ask patch -14 14 [set pcolor gray]
  ask patch -13 13 [set pcolor gray]
  ask patch -12 14 [set pcolor gray]
  ask patch -11 15 [set pcolor gray]
  ask patch -11 14 [set pcolor gray]
  ask patch -11 13 [set pcolor gray]
  ask patch -11 12 [set pcolor gray]
  ask patch -11 11 [set pcolor gray]

  ;The A
  ask patch -8 11 [set pcolor gray]
  ask patch -8 12 [set pcolor gray]
  ask patch -8 13 [set pcolor gray]
  ask patch -8 14 [set pcolor gray]
  ask patch -7 15 [set pcolor gray]
  ask patch -6 14 [set pcolor gray]
  ask patch -6 13 [set pcolor gray]
  ask patch -7 13 [set pcolor gray]
  ask patch -6 12 [set pcolor gray]
  ask patch -6 11 [set pcolor gray]

  ;The F
  ask patch -3 15 [set pcolor gray]
  ask patch -3 14 [set pcolor gray]
  ask patch -3 13 [set pcolor gray]
  ask patch -3 12 [set pcolor gray]
  ask patch -3 11 [set pcolor gray]
  ask patch -2 15 [set pcolor gray]
  ask patch -1 15 [set pcolor gray]
  ask patch 0 15  [set pcolor gray]

  ask patch -2 13 [set pcolor gray]
  ask patch -1 13 [set pcolor gray]

  ask patch 3 15  [set pcolor gray]
  ask patch 4 15  [set pcolor gray]
  ask patch 5 15  [set pcolor gray]
  ask patch 6 15  [set pcolor gray]
  ask patch 7 15  [set pcolor gray]
  ask patch 5 14  [set pcolor gray]
  ask patch 5 13  [set pcolor gray]
  ask patch 5 12  [set pcolor gray]
  ask patch 5 11  [set pcolor gray]
  ask patch 3 11  [set pcolor gray]
  ask patch 4 11  [set pcolor gray]
  ask patch 6 11  [set pcolor gray]
  ask patch 7 11  [set pcolor gray]

  ;The other A
  ask patch 10 11 [set pcolor gray]
  ask patch 10 12 [set pcolor gray]
  ask patch 10 13 [set pcolor gray]
  ask patch 10 14 [set pcolor gray]
  ask patch 11 15 [set pcolor gray]
  ask patch 12 14 [set pcolor gray]
  ask patch 12 13 [set pcolor gray]
  ask patch 11 13 [set pcolor gray]
  ask patch 12 12 [set pcolor gray]
  ask patch 12 11 [set pcolor gray]

  ;The W
  ask patch -15 8 [set pcolor gray]
  ask patch -14 7 [set pcolor gray]
  ask patch -13 6 [set pcolor gray]
  ask patch -12 5 [set pcolor gray]
  ask patch -11 6 [set pcolor gray]
  ask patch -10 7 [set pcolor gray]
  ask patch -9 8  [set pcolor gray]
  ask patch -8 7  [set pcolor gray]
  ask patch -7 6  [set pcolor gray]
  ask patch -6 5  [set pcolor gray]
  ask patch -5 6  [set pcolor gray]
  ask patch -4 7  [set pcolor gray]
  ask patch -3 8  [set pcolor gray]

  ;The other I
  ask patch -2 2  [set pcolor gray]
  ask patch -1 2  [set pcolor gray]
  ask patch 0 2   [set pcolor gray]
  ask patch 1 2   [set pcolor gray]
  ask patch 2 2   [set pcolor gray]
  ask patch 3 2   [set pcolor gray]
  ask patch 4 2   [set pcolor gray]
  ask patch 5 2   [set pcolor gray]
  ask patch 1 1   [set pcolor gray]
  ask patch 2 1   [set pcolor gray]
  ask patch 1 0   [set pcolor gray]
  ask patch 2 0   [set pcolor gray]
  ask patch 1 -1  [set pcolor gray]
  ask patch 2 -1  [set pcolor gray]
  ask patch 1 -2  [set pcolor gray]
  ask patch 2 -2  [set pcolor gray]
  ask patch 1 -3  [set pcolor gray]
  ask patch 2 -3  [set pcolor gray]
  ask patch 0 -3  [set pcolor gray]
  ask patch -1 -3 [set pcolor gray]
  ask patch -2 -3 [set pcolor gray]
  ask patch 3 -3  [set pcolor gray]
  ask patch 4 -3  [set pcolor gray]
  ask patch 5 -3  [set pcolor gray]

  ;The N
  ask patch 5 -6   [set pcolor gray]
  ask patch 5 -7   [set pcolor gray]
  ask patch 5 -8   [set pcolor gray]
  ask patch 5 -9   [set pcolor gray]
  ask patch 5 -10  [set pcolor gray]
  ask patch 5 -11  [set pcolor gray]
  ask patch 6 -7   [set pcolor gray]
  ask patch 7 -8   [set pcolor gray]
  ask patch 8 -9   [set pcolor gray]
  ask patch 9 -10  [set pcolor gray]
  ask patch 10 -11 [set pcolor gray]
  ask patch 10 -10 [set pcolor gray]
  ask patch 10 -9  [set pcolor gray]
  ask patch 10 -8  [set pcolor gray]
  ask patch 10 -7  [set pcolor gray]
  ask patch 10 -6  [set pcolor gray]

end

to citizen-win
  print "Citizen's Win!"
    ask patches[
      set pcolor sky
    ]
    ask turtles [set color black]
    ask angels [set color sky]
    ask detectives [set color sky]
    ;displaying "Citizen's Win
    ;C"
    ask patch -15 15[set pcolor white]
    ask patch -14 15[set pcolor white]
    ask patch -13 15[set pcolor white]
    ask patch -15 14[set pcolor white]
    ask patch -15 13[set pcolor white]
    ask patch -15 12[set pcolor white]
    ask patch -14 12[set pcolor white]
    ask patch -13 12[set pcolor white]
    ;I
    ask patch -11 15[set pcolor white]
    ask patch -11 13[set pcolor white]
    ask patch -11 12[set pcolor white]
    ;T
    ask patch -8 15[set pcolor white]
    ask patch -7 14[set pcolor white]
    ask patch -8 14[set pcolor white]
    ask patch -9 14[set pcolor white]
    ask patch -8 13[set pcolor white]
    ask patch -8 12[set pcolor white]
    ;I
    ask patch -5 12[set pcolor white]
    ask patch -5 13[set pcolor white]
    ask patch -5 15[set pcolor white]
    ;Z
    ask patch -3 15 [set pcolor white]
    ask patch -2 15 [set pcolor white]
    ask patch -2 14 [set pcolor white]
    ask patch -3 13 [set pcolor white]
    ask patch -3 12 [set pcolor white]
    ask patch -2 12 [set pcolor white]
    ;E
    ask patch 2 12 [set pcolor white]
    ask patch 1 12 [set pcolor white]
    ask patch 0 13 [set pcolor white]
    ask patch 0 14 [set pcolor white]
    ask patch 1 15 [set pcolor white]
    ask patch 2 14 [set pcolor white]
    ;N
    ask patch 4 12  [set pcolor white]
    ask patch 4 13  [set pcolor white]
    ask patch 4 14  [set pcolor white]
    ask patch 4 15  [set pcolor white]
    ask patch 5 15  [set pcolor white]
    ask patch 6 15  [set pcolor white]
    ask patch 6 14  [set pcolor white]
    ask patch 6 13  [set pcolor white]
    ask patch 6 12  [set pcolor white]
    ;S
    ask patch 8 12  [set pcolor white]
    ask patch 9 12  [set pcolor white]
    ask patch 9 13  [set pcolor white]
    ask patch 8 14  [set pcolor white]
    ask patch 8 15  [set pcolor white]
    ask patch 9 15  [set pcolor white]

    ;W
    ask patch -9 9  [set pcolor white]
    ask patch -8 8  [set pcolor white]
    ask patch -7 7  [set pcolor white]
    ask patch -6 6  [set pcolor white]
    ask patch -5 7  [set pcolor white]
    ask patch -4 8  [set pcolor white]
    ask patch -3 9  [set pcolor white]
    ask patch -2 8  [set pcolor white]
    ask patch -1 7  [set pcolor white]
    ask patch  0 6  [set pcolor white]
    ask patch  1 7  [set pcolor white]
    ask patch  2 8  [set pcolor white]
    ask patch  3 9  [set pcolor white]

    ;I
    ask patch -3 4  [set pcolor white]
    ask patch -2 4  [set pcolor white]
    ask patch -1 4  [set pcolor white]
    ask patch  0 4  [set pcolor white]
    ask patch -4 4  [set pcolor white]
    ask patch -5 4  [set pcolor white]
    ask patch -6 4  [set pcolor white]
    ask patch -3 3  [set pcolor white]
    ask patch -3 2  [set pcolor white]
    ask patch -3 1  [set pcolor white]
    ask patch -3 0  [set pcolor white]
    ask patch -2 -1 [set pcolor white]
    ask patch -1 -1 [set pcolor white]
    ask patch 0 -1  [set pcolor white]
    ask patch -2 -1 [set pcolor white]
    ask patch -1 -1 [set pcolor white]
    ask patch -4 -1 [set pcolor white]
    ask patch -5 -1 [set pcolor white]
    ask patch -3 -1 [set pcolor white]
    ask patch -6 -1 [set pcolor white]

    ;N
    ask patch 0 -3  [set pcolor white]
    ask patch 0 -4  [set pcolor white]
    ask patch -1 -4 [set pcolor white]
    ask patch -1 -5 [set pcolor white]
    ask patch -1 -6 [set pcolor white]
    ask patch -2 -7 [set pcolor white]
    ask patch -3 -6 [set pcolor white]
    ask patch -3 -4 [set pcolor white]
    ask patch -3 -5 [set pcolor white]
    ask patch -4 -4 [set pcolor white]
    ask patch -4 -3 [set pcolor white]
    ask patch -5 -5 [set pcolor white]
    ask patch -5 -6 [set pcolor white]
    ask patch -6 -7 [set pcolor white]
    ask patch -5 -4 [set pcolor white]
    ask patch -5 -7 [set pcolor white]

end

;(If Angeleria is successful, different file than if it is not. Also, call random line from the file. This is for story, if it ever works)
to detect
  ask detectives[
     create-knowledge-to one-of turtles with [not-linked = false][
       hide-link
       ask other-end[
         set not-linked true
         if breed = mafias[
           set isCitizen false
           set isMafia true
         ]
         if breed = angels[
           set isAngel true
           set isCitizen false
           set active true
         ]
         ;The detective doesn't really care about regular citizens, unless its for its own vote. It doesn't want to draw attention to itself
       ]
     ]
     if isMafia = true[
       set active true
     ]
  ]

end

to detective-knows
   ;This happens during the voting
   if any? detectives with [active = true][
     ask detectives[

       ;What if the detective is super unbelievable?

       if any? mafias with[not-linked = true][
         set detective-known true
         create-accusation-to one-of mafias with[not-linked = true][
           set tally 1
           set stamina [charisma] of myself
         ]
       ]
     ]
   ]

end



to mafia-strikes
    ; pretty much any turtle but the mafia
    if detective-known = true and not any? turtles with [breed = angels and alive?][
      ask one-of turtles with [breed = detectives][
        set alive? false
        set color color - 3
      ]
    ]

    if detective-known = true and any? turtles with [breed = angels and alive?] or detective-known = false[
      ask one-of turtles with [color != black and breed != detectives][
        set alive? false
        set color color - 3
      ]
    ]
 ; story
 ;still a work in progress
   ;  If the story procedure is called, one has to, one has to uncomment the lines inside the story procedure in addition to making a file called "johnny_dies.txt" and filling out
   ;  each line with a different story of how the mafia killed someone each night.
end
;to story
  ;file-open "johnny_dies.txt"
 ; print file-read-line
;end

to angeles
  if alive-angels = 1 [
    if detective-known = true[
      ask one-of turtles with[breed = detectives][
        set breed zombies
      ]
    ]
    if detective-known = false[
      ask one-of turtles with ([alive?]) [
        if breed = angels [
          set breed specials
          ; so they don't get turned into citizens later
        ]
        if breed = citizens[
          set breed zombies
        ]
        if breed = detectives[
          set breed zombies
        ]
        ;if they die, they'll come back to life in angeleria
        ;If they are mafias, they don't need to be saved
      ]
    ]
  ]
end

to angeleria
  if any? soon-alive-zombies with [breed = citizens] [;citizens
    ask soon-alive-zombies [
      set breed citizens
      set color (sky)
      set alive? true
    ]
  ]
  if any? soon-alive-zombies with [breed = detectives][;detective
    ask soon-alive-zombies[
      set alive? true
      set breed detectives
      set color brown
    ]
  ]
  if any? soon-alive-specials [
      ask soon-alive-specials [
    set alive? true
    set breed angels
    set color (green)
    ;if the angel saves itself
  ]
  ]
enD

to lynch2
  ask accusations [
    die
    ;clearing things up
  ]
  ;If a mafia member is known to the detective
  detective-knows
  let num-accusers min (list 3 floor (count turtles with [alive?] / 2))
  ;adds accusers. The number of accusers is 3, up until there aren't enough turtles left. Then it is less.
  let accusers (n-of num-accusers turtles with [alive?])

  ask accusers [
    ifelse breed = mafias [
      let target one-of other turtles with [breed != mafias]
      ;the mafia know who is of the mafia and don't want to target themselves.
      create-accusation-to target [
        ;problem above, check original
        set tally 1
        set stamina [charisma] of myself
      ]
      ;chooses three people to accuse. The higher the accusers charisma, the more likely people are to vote for that particular person
      record-vote target
    ]
    [
      let target nobody
      ifelse any? known-mafia [
        ;The known-mafia are people who didn't vote for the mafia members in the past.
        set target (citizen-accuse)
      ]
      [
        set target (one-of other turtles with [alive?])
      ]
      create-accusation-to target [
        set tally 1
        set stamina [charisma] of myself
      ]
      record-vote target
    ]
  ]

  ask accusations [
    let matching-accusations (other accusations with [end2 = [end2] of myself])
    if any? matching-accusations [
      ask one-of matching-accusations [
        set tally (tally + 1)
        set stamina (stamina + ([stamina] of myself))
      ]
      ;if two people make accusations to the same turtle, their charisma's are added together
      die
    ]
  ]
  ask alive-citizens with [not member? self accusers] [
    let vote citizen-vote
    if is-link? vote [
      ask vote [
        set tally (tally + 1)
      ]
      ;  citizens vote for people. more likely if the person that accused them has a higher charisma
      record-vote [end2] of vote
    ]
  ]
  ask alive-angels with [not member? self accusers] [
    let vote citizen-vote
    if is-link? vote [
      ask vote [
        set tally (tally + 1)
      ]
    ]
  ]
  ;angel votes
  ask alive-detectives with [not member? self accusers][
    let vote detective-vote
    if is-link? vote[
      ask vote[
        set tally tally + 1
      ]
    ]
  ]
  ;Detective votes

  ;for mafias voting:
  ask alive-mafias with [not member? self accusers] [
    let cit-maf-maj (accusations with [([breed] of end2 = mafias)
      and (tally > count turtles with [alive?] / 2)
        and (end2 != myself)])
    ifelse (any? cit-maf-maj) [
      let target one-of cit-maf-maj
      ask target [
        set tally (tally + 1)
      ]
      ;  if there is a majority on a mafia member, the mafia will vote for that mafia
      ;  if the mafia can make a majority to protect another mafia member, they will
      ;  otherwise, they will vote for random citizen
      record-vote [end2] of target
    ]
    [
      let citizen-cit (accusations with [([breed] of end2 = citizens)])
      if any? citizen-cit [
        let target one-of citizen-cit
        ask target [
          set tally (tally + 1)
        ]
        record-vote [end2] of target
        ;the citizens remember who they the everyone votes for
      ]
    ]
  ]
  let success-accusations (accusations with [tally > (count turtles with [alive?] / 2)])
  ifelse any? success-accusations [
    ask [end2] of one-of success-accusations [
      set alive? false
      ;if an accusation gets at least a majority on a certain member, they die
      set color color - 3
    ]
  ]
  [
    lynch2
    ;  if not, the procedure runs again
  ]
end

to-report citizen-vote
  let candidates accusations with [end2 != myself]
  ifelse any? candidates [
    let total-charisma sum [stamina] of candidates
    let selector random-float total-charisma
    foreach [self] of candidates [
      let current-charisma [stamina] of ?
      if selector <= current-charisma [
        report ?
      ]
      set selector (selector - current-charisma)
    ]
  ]
  [
    report nobody
  ]
end

to-report detective-vote
  let candidates accusations with [end2 != myself]
  ifelse any? candidates[
    let total-charisma sum [stamina] of candidates
    let selector random-float total-charisma
    foreach [self] of candidates[
      let current-charisma [stamina] of ?
      ifelse isMafia = true[
        report ?
      ]    [
        if selector <= current-charisma[        report ?        ]
      ]
      set selector (selector - current-charisma)
    ]
  ]
  [
    report nobody
  ]

end

to-report citizen-accuse
  let mafia-vote-tally ([ifelse-value (any? my-out-link-votes with [member? end2 known-mafia])
      [sum [tally] of my-out-link-votes with [member? end2 known-mafia]]
      [0]] of other turtles with [alive?])
  let max-tally max mafia-vote-tally
  let weights map [max-tally + 1 - ?] mafia-vote-tally
  let total-weight sum weights
  let selector random-float total-weight
  foreach [self] of other turtles with [alive?] [
    let current-weight ([max-tally + 1 - sum [tally] of my-out-link-votes with [member? end2 known-mafia]] of ?)
    if selector < current-weight [
      report ?
    ]
    set selector (selector - current-weight)
    ;   for voting purposes of the citizens
  ]
end

to record-vote [against]
  ifelse member? against out-link-vote-neighbors [
    let existing-link out-link-vote-to against
    ask existing-link [
      set tally (tally + 1)
    ]
  ]
  [
    create-link-vote-to against [
      set tally 1
      hide-link

      ; makes links of every vote. When a mafia dies, whoever has voted for that particular mafia member is less likely to be accused and voted on
   ;if hide link is out, makes it interesting
    ]
  ]
end

@#$#@#$#@
GRAPHICS-WINDOW
217
10
637
451
20
20
10.0
1
10
1
1
1
0
0
0
1
-20
20
-20
20
1
1
1
ticks
30.0

SLIDER
15
35
187
68
num-citizens
num-citizens
6
100
100
1
1
NIL
HORIZONTAL

BUTTON
25
187
95
220
Setup
setup
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

MONITOR
700
15
764
68
Citizens
count citizens with [alive?]
17
1
13

MONITOR
703
162
760
215
Mafia
count mafias with [alive?]
17
1
13

TEXTBOX
687
79
837
123
The number of \nalive citizens
13
0.0
1

TEXTBOX
679
221
829
253
The number of alive Mafia
13
0.0
1

TEXTBOX
21
70
171
150
Changing the number of citizens.
13
0.0
1

TEXTBOX
28
140
178
174
Changes the number of Mafia
13
0.0
1

SLIDER
19
104
190
137
num-mafia
num-mafia
1
num-citizens / 6
16
1
1
NIL
HORIZONTAL

BUTTON
123
187
186
220
Go
go
T
1
T
OBSERVER
NIL
S
NIL
NIL
1

TEXTBOX
28
233
96
286
Sets up the procedure
13
0.0
1

TEXTBOX
122
233
201
287
Undertakes the procedure
13
0.0
1

TEXTBOX
33
301
183
477
In the diagram to the right, the Mafia are depicted by gray, while the citizens are depicted in sky blue. In addition, the angel is green and the detective is brown. As the turtles are killed or lynched, their color grows fainter (The mafias turn pink).
13
0.0
1

MONITOR
853
142
922
187
The Angel
count angels with [alive?]
17
1
11

TEXTBOX
830
195
980
237
If the Angel is alive, it will display 1. If not, it will display 0.
11
0.0
1

MONITOR
853
29
925
74
Detectives
count detectives with [alive?]
17
1
11

TEXTBOX
818
81
968
123
If the Detective is alive, it will display a 1. If not, it will display a 0.
11
0.0
1

SWITCH
1006
144
1123
177
With-Angel
With-Angel
0
1
-1000

SWITCH
1003
27
1142
60
With-Detective
With-Detective
0
1
-1000

TEXTBOX
1003
191
1153
219
If the switch is off, the Angel is removed from the game.
11
0.0
1

TEXTBOX
1003
70
1153
112
If the switch is off, the Detective is removed from the game.
11
0.0
1

@#$#@#$#@
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
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="1000" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count mafias with [alive?]</metric>
    <enumeratedValueSet variable="num-mafia">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-citizens">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count mafias</metric>
    <metric>count citizens + angels + detectives</metric>
    <enumeratedValueSet variable="num-mafia">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-citizens">
      <value value="100"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
