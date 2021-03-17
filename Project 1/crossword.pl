word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

crossword(V1, V2, V3, H1, H2, H3) :- 
    word(V1, _, R1, _, R4, _, R7, _),
    word(V2, _, R2, _, R5, _, R8, _),
    word(V3, _, R3, _, R6, _, R9, _),
    word(H1, _, R1, _, R2, _, R3, _),
    word(H2, _, R4, _, R5, _, R6, _),
    word(H3, _, R7, _, R8, _, R9, _),
    H1 \= V1.
