go :-
  greeting,
  repeat,
  write('> '),
  read(X),
  do(X),
  X == quit.

greeting :-
write('This is the native Prolog shell.'), nl,
write('Enter any of the following commands at the prompt:'), nl, 
write('loadPrologRules'), nl, write('loadEnglishRules'), nl, write('enterRule'), nl, write('solve_WithCertainty_WithHistory'), nl, write('solve_WithCertainty_WithOutHistory'), nl, 
write('solve_WithOutCertainty_WithHistory'), nl, write('solve_WithOutCertainty_WithOutHistory'), nl, write('why(Goal)'), nl, 
write('whynot(Goal)'), nl, write('quit'), nl.

do(enterRule):-nl, write('Write the new rule at the prompt'), nl, write('>'), read(X),!,
(asserta(X),write('rule was asserted'), nl);write('rule was not asserted'), nl.

do(loadPrologRules) :- load_kb, !.

do(loadEnglishRules) :- load_kb, !.

do(solve_WithOutCertainty_WithHistory):-solve(a),!.

do(solve_WithOutCertainty_WithOutHistory):-solve(b),!.

do(solve_WithCertainty_WithHistory):-solve(c),!.

do(solve_WithCertainty_WithOutHistory):-solve(d),!.

do(why(Goal)) :- why(Goal),!. 

do(whynot(Goal)) :- whynot(Goal), !.

do(quit).

do(X) :-
  write(X),
  write(' is not a legal command.'), nl,
  fail.

load_kb :-
  write('Enter file name: '),
  read(F),
  consult(F).
 
display_menu(Menu) :-
  disp_menu(1, Menu), !.

disp_menu(_, []).

disp_menu(N, [Item | Rest]) :-
  write(N), write('   :'), write(Item), nl,
  N1 is (N+1),
  disp_menu(N1, Rest).

pick_menu(N, Val, Menu) :-
  integer(N),
  pic_menu(1, N, Val, Menu), !.

pick_menu(Val, Val, _).

pic_menu(_, _, non_of_the_above, []).

pic_menu(N, N, Item, [Item|_]).

pic_menu(Ctr, N, Val, [ _ | Rest]) :-
  NextCtr is (Ctr + 1),
  pic_menu(NextCtr, N, Val, Rest).

explain([]).

explain([H|T]) :-
  check(H),
  explain(T).

check(H) :-
  prove([H], []),
  write_line([H, succeeds]), !.

check(H) :-
  write_line([H, fails]), fail.

write_list(N, []).

write_list(N, [H|T]) :-nl,
  tab(N), write(H),  nl,
  write_list(N, T).

write_line(L) :-
  flatten(L, LF),
  write_lin(LF).

write_lin([]) :- nl.

write_lin([H|T]) :-
  write(H), tab(1),
  write_lin(T).

flatten([], []) :- !.

flatten([ [] | T], T2) :-
  flatten(T, T2), !.

flatten([ [X|Y] | T], L) :-
  flatten([X | [Y|T] ], L), !.

flatten([H|T], [H|T2]) :-
  flatten(T, T2).

toList(Input, [Input]) :- not(Input=(Head,Tail)).

toList((Head,Tail), [Head|TailList]) :- toList(Tail, TailList).



%%%%%%%%%%%solve_WithoutCertainty_WithOutHistory%%%%%%%%%%%%%%%

solve(b):-
abolish(known, 3), abolish(known, 4), abolish(certainty, 1), abolish(history, 1), asserta(certainty(no)), asserta(history(no)), prove([top_goal(X)]),
  write('The answer is '), write(X), nl.

solve(b):-
write('No answer found for solve_WithoutCertainty_WithOutHistory.'), nl.

prove([]).

prove([true]):- !.

prove([Goal|Rest]):-
prov(Goal),
prove(Rest).

prov(true):-!.

prov(menuask(X, Y, Z)):-menuaskB(X, Y, Z), !.

prov(ask(X, Y)):-askB(X,Y), !.

prov(Goal):-
clause(Goal, BodyOfClause),
toList(BodyOfClause, List),
prove(List).

askB(Attribute, Value) :-
  clause(known(_,_,_),_),
  known(_, Attribute, Value),
  !.

askB(Attribute, Value) :-
  clause(known(_,_,_),_),
  known(_, Attribute, Value),
  !, fail.

askB(Attribute, _) :-
  not(multivalued(Attribute)),
  clause(known(_,_,_),_),
  known(yes, Attribute, _),
  !, fail.

askB(A, V) :-
  write(A :V),
  write('? (yes or no) '),
  get_user(Y),
  asserta(known(Y, A, V)),
  Y = yes.

get_user(X):-
  repeat,
  write('> '), 
  read(X),
  process_ansB(X), !.

process_ansB(why) :-
  write('no history is available'), !, fail.

process_ansB(X).

menuaskB(Attribute, Value, _) :-
  clause(known(_,_,_),_),
  known(yes, Attribute, Value),
  !.

menuaskB(Attribute, _, _) :-
  clause(known(_,_,_),_),
  known(yes, Attribute, _),
  !, fail.

menuaskB(Attribute, AskValue, Menu) :-
  nl, write('What is the value for '),
  write(Attribute), write('?'), nl,
  display_menu(Menu),
  write('Enter the number of choice > '),
  get_user(Num), nl,
  pick_menu(Num, AnswerValue, Menu),
  asserta(known(yes, Attribute, AnswerValue)),
  AskValue = AnswerValue.

why(Goal) :-
 history(no), write('The history feature is disabled'), nl.






