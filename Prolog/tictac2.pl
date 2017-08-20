
win(Player, [[Z1, Z2, Z3],[_,_,_],[_,_,_]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[_,_,_],[Z1, Z2, Z3],[_,_,_]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[_,_,_],[_,_,_],[Z1, Z2, Z3]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[Z1,_,_],[Z2,_,_],[Z3,_,_]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[_,Z1,_],[_,Z2,_],[_,Z3,_]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[_,_,Z1],[_,_,Z2],[_,_,Z3]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[Z1,_,_],[_,Z2,_],[_,_,Z3]]) :- Z1==Player, Z2==Player, Z3==Player.
win(Player, [[_,_,Z1],[_,Z2,_],[Z3,_,_]]) :- Z1==Player, Z2==Player, Z3==Player.