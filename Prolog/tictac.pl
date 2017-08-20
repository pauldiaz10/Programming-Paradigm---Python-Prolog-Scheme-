
% Paul Diaz
% CS 152
% HW 6 Prolog TicTacToe winner

win(Player, Grid) :- Grid = [[Player,Player,Player],[_,_,_],[_,_,_]];
                     Grid = [[_,_,_],[Player,Player,Player],[_,_,_]];
		     Grid = [[_,_,_],[_,_,_],[Player,Player,Player]];
		     Grid = [[Player,_,_],[Player,_,_],[Player,_,_]];
                     Grid = [[_,Player,_],[_,Player,_],[_,Player,_]];
		     Grid = [[_,_,Player],[_,_,Player],[_,_,Player]];
		     Grid = [[Player,_,_],[_,Player,_],[_,_,Player]];
		     Grid = [[_,_,Player],[_,Player,_],[Player,_,_]].
