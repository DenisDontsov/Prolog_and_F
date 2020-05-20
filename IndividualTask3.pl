launch:-
    see('input.txt'),
    tell('output.txt'),
    launcher.

launcher:-
    fileReader(Flag),
    stringOrFileEnd(Flag).

fileReader(Flag):-
    get0(X),
    characterStoreToPrint(X,[],Flag).

stringOrFileEnd(-1):-!.
stringOrFileEnd(10):-
    fileReader(Flag),
    stringOrFileEnd(Flag).

characterStoreToPrint(10,A,10):-
    characterPrinterToOutputFile(A),
    put(32),
    nl,
    !.
characterStoreToPrint(47,A,Flag):-
    get0(X1),
    leftBorderIdentificator(X1,A,Flag),
    !.
characterStoreToPrint(-1,A,-1):-
    characterPrinterToOutputFile(A),
    seen,
    told,
    !.
characterStoreToPrint(X,B,Flag):-
    append(B,[X],B1),
    get0(X1),
    characterStoreToPrint(X1,B1,Flag).

leftBorderIdentificator(42,A,Flag):-
    get0(X1),
    ignoranceOfCharactersInsideCommentary(X1,A,Flag).
leftBorderIdentificator(10,A,Flag):-
    get0(X1),
    leftBorderIdentificator(X1,A,Flag).
leftBorderIdentificator(-1,A,-1):-
    characterStoreToPrint(-1,A,-1),
    !.
leftBorderIdentificator(B,A,Flag):-
    append(A,[47],A1),
    append(A1,[B],B1),
    get0(X1),
    characterStoreToPrint(X1,B1,Flag).

ignoranceOfCharactersInsideCommentary(42,A,Flag):-
    get0(X1),
    rightBorderIdentificator(X1,A,Flag).
ignoranceOfCharactersInsideCommentary(_,A,_):-
    get0(X1),
    ignoranceOfCharactersInsideCommentary(X1,A,_).

rightBorderIdentificator(47,A,Flag):-
    get0(X1),
    append(A,[32],A1),
    characterStoreToPrint(X1, A1, Flag),
    !.
rightBorderIdentificator(B,A,_):-
    ignoranceOfCharactersInsideCommentary(B,A,_).
rightBorderIdentificator(10,A,_):-
    get0(X1),
    rightBorderIdentificator(X1,A,_).
rightBorderIdentificator(-1,A,-1):-
    characterStoreToPrint(-1,A,-1),
    !.

characterPrinterToOutputFile([]):-!.
characterPrinterToOutputFile([Head|Tail]):-
    put(Head),
    characterPrinterToOutputFile(Tail),
    !.
