# Surrey-tetrominos-team-repository
Instructions for installing and playing our game.

Installation:
Download both the Tetrisguibase2.m and Tetrisguibase2.fig files into your default matlab folder. 
Open Tetrisguibase2.m on matlab. Select the Editor tab. Press run. This will load up the GUI for the game. You should see a next piece box in the top left, a button which says Begin new game in the top right. In the middle right a Score box which will track your score, and under it a high score box. When you load the game up both should be 0 as default. Click Begin new game to start your game, which will load in the previous high score, if you had a previous high score from another session. 

Controls: Left arrow key, move current block left if possible. Right arrow key, move current block right if possible. down arrow key, move current block down if possible. Up arrow key, rotate current block clockwise if possible.

The objective of the game is the same objective of any tetris game. Fill lines in using tetrominos for them to disapear and gain score. As your score increases, the time you have between each block moving down one line automaticly decreases, making the game more difficult. The game is over when your next block to spawn would spawn overlapping a allready placed block, and thus is incapable of spawning. 

Good Luck!
