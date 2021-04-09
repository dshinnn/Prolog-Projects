:- dynamic(fact/2).
:- op(500, xfy, and).
:- op(600, xfy, or).
:- op(700, fx, if).
:- op(800, xfy, then).

start:-abolish(fact/2), enter_facts, forward.

enter_facts:-
    write('Is the hall wet? t/f/m:'), read(X),  assert(fact(X, hall_wet)),
    write('Is the kitchen dry? t/f/m:'), read(X1), assert(fact(X1, kitchen_dry)),
    write('Is the bathroom dry? t/f/m:'), read(X2), assert(fact(X2, bathroom_dry)),
    write('Is the window closed? t/f/m:'), read(X3), assert(fact(X3, window_closed)),
    write('It is not raining? t/f/m:'), read(X4), assert(fact(X4, no_rain)).


forward :- 
	derived_fact(fact(m,P)), !,
	write('Derived-'), write(P),
	write(':'), write('\t'), write('maybe'),
	nl, assert(fact(m,P)), forward.

forward :- 
	derived_fact(fact(t,P)), !,
	write('Derived-'), write(P),
	write(':'), write('\t'), write('true'),
	nl, assert(fact(t,P)), forward;
	write('No more facts').

derived_fact(fact(m, CONCL)) :- 
	if COND then CONCL,
	not(fact(m,CONCL)), composed_fact(fact(m,COND)).

derived_fact(fact(t, CONCL)) :- 
	if COND then CONCL,
	not(fact(t,CONCL)), composed_fact(fact(t,COND)).

composed_fact(fact(t,COND)) :- fact(t,COND).

composed_fact(fact(t,COND1 and COND2)) :-
	composed_fact(fact(t,COND1)),
	composed_fact(fact(t,COND2)).

composed_fact(fact(t,COND1 or COND2)) :-
	composed_fact(fact(t,COND1));
	composed_fact(fact(t,COND2)).

composed_fact(fact(m,COND)) :- fact(m,COND).

composed_fact(fact(m,COND1 and COND2)) :-
	composed_fact(fact(m,COND1)),
	composed_fact(fact(m,COND2)).

composed_fact(fact(m,COND1 and COND2)) :-
	composed_fact(fact(t,COND1)),
	composed_fact(fact(m,COND2)).

composed_fact(fact(m,COND1 and COND2)) :-
	composed_fact(fact(m,COND1)),
	composed_fact(fact(t,COND2)).

composed_fact(fact(m,COND1 or COND2)) :-
	composed_fact(fact(m,COND1));
	composed_fact(fact(f,COND2)).

composed_fact(fact(m,COND1 or COND2)) :-
	composed_fact(fact(f,COND1));
	composed_fact(fact(m,COND2)).

composed_fact(fact(m,COND1 or COND2)) :-
	composed_fact(fact(m,COND1));
	composed_fact(fact(m,COND2)).

and(X,Y) :- X,Y.
or(X,Y) :- X;Y.
if(X) :- X.
then(X) :- X.

if hall_wet and kitchen_dry then leak_in_bathroom.
if hall_wet and bathroom_dry then problem_in_kitchen.
if window_closed or no_rain then no_water_from_outside.
if problem_in_kitchen and no_water_from_outside then leak_in_kitchen.