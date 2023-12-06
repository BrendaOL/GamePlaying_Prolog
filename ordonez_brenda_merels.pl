% ----------Ordonez Lujan Brenda merels.pl----------------
:- use_module([library(lists), io]).

%representacion/3 (Point,Merel,Representation). Representation on board.
representation(a,'Y',ya).
representation(b,'Y',yb).
representation(c,'Y',yc).
representation(d,'Y',yd).
representation(e,'Y',ye).
representation(f,'Y',yf).
representation(g,'Y',yg).
representation(h,'Y',yh).
representation(i,'Y',yi).
representation(j,'Y',yj).
representation(k,'Y',yk).
representation(l,'Y',yl).
representation(m,'Y',ym).
representation(n,'Y',yn).
representation(o,'Y',yo).
representation(p,'Y',yp).
representation(q,'Y',yq).
representation(r,'Y',yr).
representation(s,'Y',ys).
representation(t,'Y',yt).
representation(u,'Y',yu).
representation(v,'Y',yv).
representation(w,'Y',yw).
representation(x,'Y',yx).
representation(a,'Z',za).
representation(b,'Z',zb).
representation(c,'Z',zc).
representation(d,'Z',zd).
representation(e,'Z',ze).
representation(f,'Z',zf).
representation(g,'Z',zg).
representation(h,'Z',zh).
representation(i,'Z',zi).
representation(j,'Z',zj).
representation(k,'Z',zk).
representation(l,'Z',zl).
representation(m,'Z',zm).
representation(n,'Z',zn).
representation(o,'Z',zo).
representation(p,'Z',zp).
representation(q,'Z',zq).
representation(r,'Z',zr).
representation(s,'Z',zs).
representation(t,'Z',zt).
representation(u,'Z',zu).
representation(v,'Z',zv).
representation(w,'Z',zw).
representation(x,'Z',zx).

%is_point/1 (Point). Validate to be between a - x
is_point(Point):-
    member(Point,[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x]).

%is_player1/1 (Player). Player1 is represented by 'Y'
is_player1('Y').

%is_player2/1 (Player). Player2 is represented by 'Z'
is_player2('Z').

% is_merel/1 (Merel). Merels of the players are represented by 'Y' or
% 'Z' to match with the player
is_merel('Y').
is_merel('Z').

% other_player/2 (Player1,Player2). validate both players to be only 'Y'
% or 'Z'
other_player(Player1, Player2) :-
    is_player1(Player1), is_player2(Player2).
other_player(Player1, Player2) :-
    is_player1(Player2), is_player2(Player1).

% pair/3 (Pair,Point,Merel). Return the representation of a point and
% the merel on the board.
pair(Rep, Point, Merel) :-
    is_merel(Merel),
    is_point(Point),
    representation(Point,Merel,Rep).

%merel_on_board/2 (Pair,Board). Board always instantiated
% Board has a list of the pairs,merels and points that has taken.
merel_on_board(Pair,Board):-
    member(Pair,Board).

%is_row/3 (Point,Point,Point). Points that form a row in order.
is_row(a, b, c).
is_row(a, j, v).
is_row(b, e, h).
is_row(q, t, w).
is_row(d, e, f).
is_row(d, k, s).
is_row(g, h, i).
is_row(g, l, p).
is_row(p, q, r).
is_row(s, t, u).
is_row(v, w, x).
is_row(i, m, r).
is_row(f, n, u).
is_row(c, o, x).
is_row(m, n, o).
is_row(j, k, l).

% row/3 (Point,Point,Point): are all the possibilities to make a mill,
% where the first Point is the min_member, and the last Point is the
% max_member.
row(Point,Point2,Point3):-
    List = [Point,Point2,Point3],
    max_member(Max,List),
    min_member(Min,List),
    delete(List,Max,NewList),
    delete(NewList,Min,NewList2),
    member(Middle,NewList2),
    is_row(Min,Middle,Max).

% connected/2 (Point, Point): are all the possibilities to be connected
% on the board by a line
connected(a, b).
connected(b, a).
connected(b, c).
connected(c, b).
connected(d, e).
connected(e, d).
connected(e, f).
connected(f, e).
connected(g, h).
connected(h, g).
connected(h, i).
connected(i, h).
connected(j, k).
connected(k, j).
connected(k, l).
connected(l, k).
connected(m, n).
connected(n, m).
connected(n, o).
connected(o, n).
connected(p, q).
connected(q, p).
connected(q, r).
connected(r, q).
connected(s, t).
connected(t, s).
connected(t, u).
connected(u, t).
connected(v, w).
connected(w, v).
connected(w, x).
connected(x, w).
connected(a, j).
connected(j, a).
connected(j, v).
connected(v, j).
connected(d, k).
connected(k, d).
connected(k, s).
connected(s, k).
connected(g, l).
connected(l, g).
connected(l, p).
connected(p, l).
connected(b, e).
connected(e, b).
connected(e, h).
connected(h, e).
connected(q, t).
connected(t, q).
connected(t, w).
connected(w, t).
connected(i, m).
connected(m, i).
connected(m, r).
connected(r, m).
connected(f, n).
connected(n, f).
connected(n, u).
connected(u, n).
connected(c, o).
connected(o, c).
connected(o, x).
connected(x, o).

%initial_board/1 (Board). Empty list represent initial board.
initial_board([]).

% merels_on_board/3 (Board,Player,Merels_on_board). To know how
% many merels are on board.
merels_on_board([],_,0).
merels_on_board([BH|BT],Player,Merels) :-
    pair(BH,_,Player),
    merels_on_board(BT,Player,MerelsOnBoard),Merels is MerelsOnBoard + 1.
merels_on_board([_|BT],Player,Merels) :-
    merels_on_board(BT,Player,Merels).

% possible_moves/4 (Board,Board,Player,Counter). To Know how many
% posible moves has a player.
posible_moves([],[_|_],_,0).
posible_moves([BH|BT],Board,Player,Counter) :-
    pair(BH,Point,Player),
    connected(Point,PointR),
    \+(member(PointR,Board)),
    posible_moves(BT,Board,Player,Counter2),Counter is Counter2 + 1.
posible_moves([_|BT],Board,Player,Counter) :-
    posible_moves(BT,Board,Player,Counter).

% loser/2(Board,Player). To see if a player is a looser on board, where
% a loser does not have 3 merels on board or he doesn't have any
% possible moves on board.
loser(Board,Player) :-
    \+(posible_moves(Board,Board,Player,1));
    \+(merels_on_board(Board,Player,3)).

% and_the_winner_is/2(Board,Player). Finds a winner, if the game
% doesn't have a loser then the game is not finished.
and_the_winner_is(Board,Player):-
    is_merel(Player),
    \+(loser(Board,Player)),
    other_player(Player,Player2),
    loser(Board,Player2).

% find_mill/3 (Point,Player,Board).To find if there is a row
% connected from the Point given and check if that row belongs to the
% same player.

%to find a mill starting from the sides
find_mill(Point,Player,Board):-
    connected(Point,Point2),
    connected(Point2,Point3),
    row(Point,Point2,Point3),
    pair(Pair2,Point2,Player),
    merel_on_board(Pair2,Board),
    pair(Pair3,Point3,Player),
    merel_on_board(Pair3,Board).
%to find a mill starting from the middle point
find_mill(Point,Player,Board):-
    connected(Point,Point2),
    connected(Point,Point3),
    row(Point,Point2,Point3),
    pair(Pair2,Point2,Player),
    merel_on_board(Pair2,Board),
    pair(Pair3,Point3,Player),
    merel_on_board(Pair3,Board).

% chose_remove_point/4(Board,Player,Point,NewBoard). Keep asking
% to remove a point if the point chosen represent a mill, because a mill
% can't be remove by the opponent.
chose_remove_point(Board,Player,Point,NewBoard):-
    ground(Point),
    other_player(Player,Player2),
    \+(find_mill(Point,Player2,Board)),
    delete(Board,Point,Board2),
    pair(PairPlayer2,Point,Player2),
    delete(Board2,PairPlayer2,NewBoard),
    report_remove(Player,Point).
chose_remove_point(Board,Player,_,NewBoard) :-
    format('Be careful not to pick a point where there is a mill.'),
    get_remove_point(Player,Point,Board),
    chose_remove_point(Board,Player,Point,NewBoard).

% check_mill/4 (Point,Player,Board,NewBoard). If the player made a
% mill then he can remove a merel from the other player.Point must be
% instantiated because from that Point we look for a mill.
check_mill(Point,Player,Board,NewBoard):-
    \+(find_mill(Point,Player,Board)),
    NewBoard = Board.
check_mill(Point,Player,Board,NewBoard):-
    find_mill(Point,Player,Board),
    chose_remove_point(Board,Player,_,NewBoard).

% check_legal_place/3 (Player,Point,Board). *I'm implementing this to
% keep asking for a legal place if a Point is taken, I know
% get_legal_place/3 is supposed to check it but with the representation
% I've chosen for pair it's not working, I couldn't find a
% representation that fits the legal_place predicate so I decided to
% continue with my representation but adjusting this predicate. This
% is used for the third possibility of play/3 (2 human players).
check_legal_place(Player,Point,Board,NewBoard2):-
    ground(Point),
    \+(member(Point,Board)),
    pair(Pair,Point,Player),
    append(Board,[Pair,Point],NewBoard),
    report_move(Player,Point),
    check_mill(Point,Player,NewBoard,NewBoard2).
check_legal_place(Player,_,Board,NewBoard):-
    format( '\nPlease Choose a point available.\n'),
    get_legal_place(Player,Point,Board),
    check_legal_place(Player,Point,Board,NewBoard).

% check_legal_move/5 (Player,OldPoint,NewPoint,Board,NewBoard). Keep
% asking for legal moves if a player has chosen a point with no possible
% moves.
check_legal_move(Player,OldPoint,NewPoint,Board,NewBoard2):-
    ground(NewPoint),
    \+(member(NewPoint,Board)),
    pair(Pair,NewPoint,Player),
    append(Board,[Pair,NewPoint],NewBoard),
    pair(OldPair,OldPoint,Player),
    report_move(Player,OldPoint,NewPoint),
    delete(NewBoard,OldPair,Board2),
    delete(Board2,OldPoint,Board3),
    check_mill(NewPoint,Player,Board3,NewBoard2).
check_legal_move(Player,_,_,Board,NewBoard):-
    format( '\nPlease Choose a point with posible moves.\n'),
    get_legal_move(Player,OldPoint,NewPoint,Board),
    check_legal_move(Player,OldPoint,NewPoint,Board,NewBoard).

%-------------Implementing heuristics------------------
% choose_place/3 (Player,Point,Board). Choose a point that can
% become a mill first, if it's not possible then choose a Point to
% block a possible mill of the other player, otherwise choose a random
% Point.
choose_place(Player,Point,Board):-
    connected(Point, _ ),
    \+ (member(Point,Board)),
    find_mill(Point,Player,Board).
choose_place(Player,Point,Board):-
    other_player(Player,Player2),
    connected(Point, _ ),
    \+ (member(Point,Board)),
    find_mill(Point,Player2,Board).
choose_place(_Player,Point,Board):-
    connected(Point, _ ),
    \+ (member(Point,Board)).

% choose_move/4 (Player,OldPoint,NewPoint,Board). Moves pieces together,
% to become a mill again.
choose_move(Player,OldPoint,NewPoint,Board):-
    pair(Pair,OldPoint,Player),
    merel_on_board(Pair,Board),
    connected(OldPoint,NewPoint),
    \+(member(NewPoint,Board)),
    delete(Board,OldPoint,Board2),
    delete(Board2,Pair,Board3),
    find_mill(NewPoint,Player,Board3).
choose_move(Player,OldPoint,NewPoint,Board):-
    pair(Pair,OldPoint,Player),
    merel_on_board(Pair,Board),
    connected(OldPoint,NewPoint),
    \+(member(NewPoint,Board)).

% choose_remove/4 (Player,Point,Board). Choose a relevant Point that
% can lead to a mill.
choose_remove(Player,Point,Board):-
    pair(Pair,Point,Player),
    merel_on_board(Pair,Board),
    connected(Point,Point2),
    find_mill(Point2,Player,Board).
choose_remove(Player,Point,Board):-
    pair(Pair,Point,Player),
    merel_on_board(Pair,Board).

% check_legal_place2/4. If it's player 2, then it's a computer. So
% the moves for a computer are implemented here. Otherwise we call
% check_legal_place/4 which is for human player.
check_legal_place2(Player,Point,Board,NewBoard):-
    is_player1(Player),
    check_legal_place(Player,Point,Board,NewBoard).

check_legal_place2(Player,Point,Board,NewBoard):-
    is_player2(Player),
    choose_place(_Player,Point,Board),
    pair(Pair,Point,Player),
    append(Board,[Pair,Point],Board2),
    report_move(Player,Point),
    check_mill2(Point,Player,Board2,NewBoard).

% check_legal_move/5. If it's player 2, then it's a computer. So
% the moves for a computer are implemented here. Otherwise we call
% check_legal_move/5 which is for human player.
check_legal_move2(Player,OldPoint,NewPoint,Board,NewBoard):-
    is_player1(Player),
    check_legal_move(Player,OldPoint,NewPoint,Board,NewBoard).
check_legal_move2(Player,_,_,Board,NewBoard):-
    choose_move(Player,OldPoint,NewPoint,Board),
    pair(Pair,NewPoint,Player),
    append(Board,[Pair,NewPoint],Board2),
    pair(OldPair,OldPoint,Player),
    report_move(Player,OldPoint,NewPoint),
    delete(Board2,OldPair,Board3),
    delete(Board3,OldPoint,Board4),
    check_mill2(NewPoint,Player,Board4,NewBoard).

% check_mill2/4 (Point,Player,Board,NewBoard). Check mill for a
% computer only. If the computer made a mill then he can remove a merel
% from the other player.
check_mill2(Point,Player,Board,NewBoard):-
    is_player2(Player),
    \+(find_mill(Point,Player,Board)),
    NewBoard = Board.
check_mill2(Point,Player,Board,NewBoard):-
    is_player2(Player),
    find_mill(Point,Player,Board),
    other_player(Player,Player2),
    choose_remove(Player2,PointPlayer2,Board),
    \+(find_mill(PointPlayer2,Player2,Board)),
    delete(Board,PointPlayer2,Board2),
    pair(PairPlayer2,PointPlayer2,Player2),
    delete(Board2,PairPlayer2,NewBoard),
    report_remove(Player,PointPlayer2).

%--------------------Running a game--------------------------
%play/0
play :-
    welcome,
    initial_board(Board),
    display_board(Board),
    is_player1(Player),
    play(18, Player, Board).

%play/3 (Merels not placed, a player, board state).
% First possibility: All Merels have been placed then we call a
% winner
play(MerelsNotPlaced,_,Board):-
    MerelsNotPlaced == 0,
    and_the_winner_is(Board,Player),
    display_board(Board),
    report_winner(Player).

%------------------------code for section 3.6------------------------
%2 human player

% Second possibility: All Merels have been placed but a player has a
% legal move
play(MerelsNotPlaced,Player,Board):-
    MerelsNotPlaced == 0,
    check_legal_move(Player,_,_,Board,NewBoard2),
    display_board(NewBoard2),
    other_player(Player, Player2),
    play(MerelsNotPlaced,Player2,NewBoard2).

% Third possibility: Merels are not completely placed, a player has a
% legal place
play(MerelsNotPlaced,Player,Board):-
    check_legal_place(Player,_,Board,NewBoard),
    display_board(NewBoard),
    other_player(Player,Player2),
    Merels is MerelsNotPlaced - 1,
    play(Merels,Player2,NewBoard).
%-------------------------end section 3.6----------------------------

/*
%uncomment this section to play with a computer and comment section 3.6
%------------------------code for section 4------------------------

%Play with the computer

% Second possibility: All Merels have been placed but a player has a
% legal move
play(MerelsNotPlaced,Player,Board):-
    MerelsNotPlaced == 0,
    check_legal_move2(Player,_,_,Board,NewBoard2),
    display_board(NewBoard2),
    other_player(Player, Player2),
    play(MerelsNotPlaced,Player2,NewBoard2).

% Third possibility: Merels are not completely placed, a player has a
% legal place
play(MerelsNotPlaced,Player,Board):-
    check_legal_place2(Player,_,Board,NewBoard),
    display_board(NewBoard),
    other_player(Player,Player2),
    Merels is MerelsNotPlaced - 1,
    play(Merels,Player2,NewBoard).

%-------------------------end section 4----------------------------
*/















