:- dynamic f1/2,f2/2,f3/2,f4/2,f5/2.

launch:-
    see('it7database.txt'),
    readCharacter,
    seen,
    q1(A1),
    q2(A2),
    q3(A3),
    q4(A4),
    q5(A5),
    check(A1,A2,A3,A4,A5),!.

readCharacter:-
    readln(Character), /*trace,*/
    Character \= [],/*nodebug,*/
    readln(Digits), /*trace,*/
    assert1(Character, Digits), /*nodebug,*/
    readCharacter.
readCharacter:- !.

assert1(_, []):- !.
assert1(Character, [H|T]):- asserta(f1(Character, H)), assert2(Character, T).

assert2(_, []):- !.
assert2(Character, [H|T]):- asserta(f2(Character, H)), assert3(Character, T).

assert3(_, []):- !.
assert3(Character, [H|T]):- asserta(f3(Character, H)), assert4(Character, T).

assert4(_, []):- !.
assert4(Character, [H|T]):- asserta(f4(Character, H)), assert5(Character, T).

assert5(_, []):- !.
assert5(Character, [H|T]):- asserta(f5(Character, H)).

q1(Answer):-
    write('К какой принадлежит персонаж?'), nl,
    write('0. Team Sonic'), nl,
    write('1. Team Dark'), nl,
    write('2. Team Rose'), nl,
    write('3. Team Chaotix'),nl,
    write('4. Ни к какой из'),nl,
    read(Answer).

q2(Answer):-
    write('Какая у него характеристика?'), nl,
    write('0. Положительный'), nl,
    write('1. Отрицательный'), nl,
    write('2. Неитральный'), nl,
    read(Answer).

q3(Answer):-
    write(''), nl,
    write('Какого типа персонаж?'),nl,
    write('0. Speed'), nl,
    write('1. Flight'), nl,
    write('2. Power'), nl,
    write('3. Ни к какой из'),nl,
    read(Answer).

q4(Answer):-
    write(''), nl,
    write('Был ли похищен?'),nl,
    write('0. Нет'), nl,
    write('1. Да'), nl,
    read(Answer).

q5(Answer):-
    write(''), nl,
    write('Впервые в серии появился в этой игре?'),nl,
    write('0. Нет'), nl,
    write('1. Да'), nl,
    read(Answer).

check(A1,A2,A3,A4,A5):-
    f1(C,A1),f2(C,A2),f3(C,A3),f4(C,A4),f5(C,A5),
    write('Вы загадали '),write_str(C),
    deleteFacts,!.
check(A1,A2,A3,A4,A5):-
    write('Ваш персонаж не был найден в базе данных. Хотите добавить его?\n0. Да\n1. Нет\n'),
    read(Answer),
    checkUsersAnswer(Answer,[A1,A2,A3,A4,A5]),
    deleteFacts.

checkUsersAnswer(0,List):-
    write('Введите имя персонажа: '),
    read_str(CharName),
    name(Character, CharName),
    addCharacter(Character, List), !.
checkUsersAnswer(1,_):- !.

deleteFacts:- d1, d2, d3, d4, d5.
d1:-repeat, (f1(X,Y) -> retract(f1(X,Y)), fail; X = nil,Y = nil,!).
d2:-repeat, (f2(X,Y) -> retract(f2(X,Y)), fail; X = nil,Y = nil,!).
d3:-repeat, (f3(X,Y) -> retract(f3(X,Y)), fail; X = nil,Y = nil,!).
d4:-repeat, (f4(X,Y) -> retract(f4(X,Y)), fail; X = nil,Y = nil,!).
d5:-repeat, (f5(X,Y) -> retract(f5(X,Y)), fail; X = nil,Y = nil,!).

addCharacter(CharName, List):-
    append('it7database.txt'),
    nl, write(CharName), nl,
    write_list(List), told.

write_list([]):-!.
write_list([H|T]):- write(H), write(" "), write_list(T).

write_str([]):-!.
write_str([H|T]):- write(H), write_str(T).

read_str(A):-get0(X),get0(X1),r_str(X1,A,[]).
r_str(10,A,A):-!.
r_str(X,A,B):-append(B,[X],B1),get0(X1),r_str(X1,A,B1).
