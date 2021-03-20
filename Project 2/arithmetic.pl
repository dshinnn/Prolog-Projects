predecessor(X,Y) :- X=s(Y), X\=z.
successor(X,Y) :- Y=s(X).

numeral(z, 0).
numeral(s(X),Y) :- numeral(X,Z), Y is +(Z,1).

addition(z,Y,Y).
addition(s(X),Y,s(Z)) :- addition(X,Y,Z).

subtraction(X,z,X).
subtraction(s(X),s(Y),Z) :- subtraction(X,Y,Z).

multiplication(X,Y,Z) :- numeral(X,A), numeral(Y,B), T is A*B, numeral(Z,T), !.

factorial(z,s(z)).
factorial(X,Z) :- predecessor(X,P), factorial(P,Y), multiplication(X,Y,Z). 

equal(X,Y) :- X=Y.
greater(X,Y) :- numeral(X,Z), numeral(Y,V), Z > V.
less(X,Y) :- numeral(X,Z), numeral(Y,V), Z < V.