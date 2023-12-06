# GamePlaying_Prolog
This practical game called Merels is a formally assessed exercise for MSc students on the Declarative Programming (2021-2022) course at the Vrije Universiteit Brussels under the supervision of Prof. Geraint Wiggins.
The game is implemented in SWI-Prolog and the code contains the instructions to start the game.

How to play the game?

Starting with nine men (merels) each, you place alternately one at a time on to any vacant point on the board. Each time you manage to form a [straight] row of three merels, creating a mill, you may remove any one of your opponent’s merels, though not one which is in a mill. When all the merels have been entered on to the board, you continue taking turns by moving one merel to an adjacent point along a line, with the object of making a mill. You win the game if you manage to block your opponents merels so they cannot be moved, or if you reduce him/her to only two merels. You may make or break the same mill any number of times, capturing one of your opponents merels each time you make a mill. If you are left with only three merels on the board forming a mill and it is your turn, you must [still] move and break the mill.

_There are the rules of Merels, taken from Past Times’ compendium of “Cloister Games”._
