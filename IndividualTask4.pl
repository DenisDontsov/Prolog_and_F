master(petya,Pet):-not(Pet = cat), not(Pet = hamster).
master(tanya,cat).
master(lena,Pet):-not(Pet = cat).

launch:-
    Index is 0,
    ListDimension is 3,
    attachment(Index,ListDimension,[dog,cat,hamster]).

attachment(ListDimension,ListDimension,List):-!.
attachment(Index,ListDimension,List):-
    accessToIndex(Index,List,Pet),
    master(Master,Pet),
    write(Master),
    write(' is a master of '),
    write(Pet),
    nl,
    Index1 is Index+1,
    attachment(Index1,ListDimension,List).

accessToIndex(0,[Elem|_Tail],Elem):-!.
accessToIndex(Index,_List,_Elem):-
    Index < 0, !, fail.
accessToIndex(Index,[Head|Tail],Elem):-
    NextIndex is Index-1,
    accessToIndex(NextIndex,Tail,Elem).
