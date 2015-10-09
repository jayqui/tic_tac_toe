(hmm, methinks next time I'll just use Trello even when flying solo...)

###To Do###
- DONE  Segregeate files & methods into more of an MVC architecture, with runner file.
- DONE  Rename some variables 
- DONE  Check that the functionality is still present.
- DONE  Write some tests.
- DONE  Refactor wet code.
- DONE  Tackle the sequential glitches.
-  Refactor logical methods to improve on logical glitches

###Problems###
##### Logic glitch(es?) #####
- In its current form, which is supposed to be at a difficulty level of “hard” (meaning the computer cannot be beaten), it actually can be beaten in certain situations. This is more like a “medium” difficulty level.

##### Flexibility #####
- DONE Allow user to choose which player goes first.
- DONE Allow the user to choose how each player marks the board (traditionally it’s “X” and “O”).
-> Allow the user to choose colors for both players.

##### UX desirables #####
- DONE? The user messages are unclear. 
- DONE? It’s confusing to see the spot that’s selected and the board all on the screen.
- DONE? It’s easy to get lost in what’s happening. 
- DONE  It’s weird the way the computer picks its spot without notifying the user.

##### Sequential glitches #####
- DONE The game skips turns on bad user input (the first time).
- DONE The game gets stuck after bad user input (after the first time)---even if user input is ok on the second time.
- DONE If I choose a place where the computer already has an X, it gets stuck.
- DONE If I choose a place where the I've already put an O, it gets stuck.

##### Portability desirable #####
- DONE Make it less linked to the console ---> MVC architecture