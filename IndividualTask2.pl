subSet([],[]).
subSet([H|SubSet],[H|Set]):-subSet(SubSet,Set).
subSet(SubSet,[H|Set]):-subSet(SubSet,Set).

readList(A,N):-readList(A,N,0,[]).
readList(A,N,N,A):-!.
readList(A,N,K,B):-read(X),append(B,[X],B1),K1 is K+1,readList(A,N,K1,B1).

launch:-
    write("¬ведите размерность списка"),nl, read(N),
    write("¬ведите список"),nl, readList(A,N),
    write("¬ведите число V"),nl, read(V),
    subSet(B,A),sumList(B,V).

sumList([],0):-!.
sumList([Head|Tail],S):-sumList(Tail,S1),S is S1+Head.
