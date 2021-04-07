Lists.pl

For Lists.pl, we wrote the following prolog programs that would accomplish specified functions on lists.  Lists.pl was created with the assumption of input lists being integer lists.

append(L1, L2,L3). % concatenates list L1and L2 into L3
member(X, L). % X is an integer in list L
last(X, L). % X is the last integer in list L
reverse(L1, L2). % L2 ontains the same integers in L1 but in reverses the order 
delete(X, L). %deletes the first instance (from the head) of integer X from list L
subset(S, L). % S is a subset of list L
double(L1, L2). % L2 contains integers that are twice the value of those in L1
intersection(L1, L2, I). % I contains integers that are present in L1 and L2
union(L1, L2, U).  %U contains all integers present in L1 and L2 without duplicates 

LeakExpert.pl

For this project we had to write a simple expert system that takes in user input to determine what facts can be derived based on user input.This project is based on the leak finding expert scenario discussed in our Expert System class. The expert system is supposed to derive facts based on the following rules:

if hall_wet and kitchen_dry then leak_in_bathroom.
if hall_wet and bathroom_dry then problem_in_kitchen.
if window_closed or no_rain then no_water_from_outside.
if problem_in_kitchen and no_water_from_outside then leak_in_kitchen.

To complete this project, we had to 

1) define the following operators : if, then, and, or
b) be able to consult the rules presented below using the defined operators 
c) list the derived facts (with confidence indicators true or maybe)based on user input. 
