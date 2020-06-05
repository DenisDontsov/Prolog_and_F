pred1:- % Запуск программы.
    A is -1000, B is -1000,
    OldA is 0, OldB is 0, OldN is 0,
    pred2(A,B,OldA,OldB,OldN).

% Какие a и b подаются на ввод и вывод произведения a и b
pred2(1000,1000,OldA,OldB,OldN):- Answer is OldA * OldB, write(Answer),!.
pred2(A,1000,OldA,OldB,OldN):- B1 is 0, A1 is A + 1, pred2(A1,B1,OldA,OldB,OldN).
pred2(A,B,OldA,OldB,OldN):- B1 is B + 1, pred3(A,B1,OldA,OldB,OldN).

% Сколько при заданных a и b многочлен генерирует простых чисел
pred3(A,B,OldA,OldB,OldN):- N is 0, pred3(A,B,N,OldA,OldB,OldN).
pred3(A,B,N,OldA,OldB,OldN):- X is N*N + A*N + B, isPrime(X), N1 is N + 1, pred3(A,B,N1,OldA,OldB,OldN),!.
pred3(A,B,N,OldA,OldB,OldN):- N1 is N-1, pred4(A,B,N1,OldA,OldB,OldN),!.

% Проверка, больше ли простых чисел генерирует многочлен с этими коэффициентами, чем с предыдущими
pred4(A,B,N,OldA,OldB,OldN):- N > OldN, NewN is N, NewA is A, NewB is B, pred2(A,B,NewA,NewB,NewN),!.
pred4(A,B,N,OldA,OldB,OldN):- pred2(A,B,OldA,OldB,OldN),!.

% Проверка на простоту числа
isPrime(X):-
    X >= 0,
    XNotChetnoe is X mod 2,
    XNotChetnoe = 1,
    XSqrt is sqrt(X) + 1,
    XSqrtSuperInt is round(float_integer_part(XSqrt)) + 1,
    isPrime_(X, XSqrtSuperInt, 3), !.

isPrime_(_, XSqrt, CurrentX) :-CurrentX >= XSqrt.

isPrime_(X, XSqrt, CurrentX) :-
    CurrentX < XSqrt,
    SomeTempValue is X mod CurrentX,
    not(SomeTempValue = 0),
    NextX is CurrentX + 2,
    isPrime_(X, XSqrt, NextX).

isPrime_(X, XSqrt, CurrentX) :-
    CurrentX < XSqrt,
    SomeTempValue is X mod CurrentX,
    SomeTempValue = 0, fail, !.
