mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).
sibling(X, Y) :- setof((X,Y), Z^(parent(Z, X), parent(Z, Y), X\=Y), L),
    				member((X,Y), L).
brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y) :- sibling(X, Y), female(X).
uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y) :- sister(X, Z), parent(Z, Y).
grandfather(X,Y) :- parent(X, Z), parent(Z, Y), male(X).
grandmother(X,Y) :- parent(X, Z), parent(Z, Y), female(X).
ancestor(X,Y) :- parent(X, Y).
ancestor(X,Y) :- parent(X, Z), ancestor(Z, Y).
descendant(X,Y) :- parent(Y, X).
descendant(X,Y) :- parent(Y, Z), descendant(X,Z).