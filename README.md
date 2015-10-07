##Tic Tac Toe##

An exercise in refactoring non-ideal code.

I've been given some code that was originally badly formatted.  The task is to clean it up and improve the functionality.

###To Do###
- X.  Segregeate files & methods into more of an MVC architecture, with runner file.
- X.  Rename some variables 
- X.  Check that the functionality is still present.
- X.  Write some tests.
- X.  Refactor wet code.
-  Refactor logical methods to improve on logical glitches
-  Tackle the sequential glitches.

###Problems###
##### Sequential glitches #####
- The game skips turns on bad user input (the first time).
- The game gets stuck after bad user input (after the first time)---even if user input is ok on the second time.

-  If I choose a place where the computer already has an X, it gets stuck.
-  If I choose a place where the I've already put an O, it gets stuck.


##### Logic glitch(es?) #####
- In its current form, which is supposed to be at a difficulty level of “hard” (meaning the computer cannot be beaten), it actually can be beaten in certain situations. This is more like a “medium” difficulty level.

##### UX desirables #####
- The user messages are unclear. 
- It’s confusing to see the spot that’s selected and the board all on the screen. 
- It’s easy to get lost in what’s happening. 
- It’s weird the way the computer picks its spot without notifying the user.


##### Portability desirable #####
- X Make it less linked to the console ---> MVC architecture

##### Flexibility #####
- X Allow the user to choose how each player marks the board (traditionally it’s “X” and “O”).
- Allow user to choose which player goes first.