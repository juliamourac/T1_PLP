/*Concatenação*/
conc([ ], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

/*Adicionar um elemento no fim da lista*/
add_ultimo(X,[ ],[X]).
add_ultimo(X, [X1|Y],[X1|L]) :- add_ultimo(X,Y,L).

/*Retirar todas as repetições de uma lista*/
retirar_rep([ ],[ ]).
retirar_rep([Elem|Cauda],[Elem|Cauda1]) :- del_todas(Elem,Cauda,Lista),
                                                    retirar_rep(Lista,Cauda1).

/*Adicionar elemento na última posição de uma lista*/
add_ultimo(X,[ ],[X]).
add_ultimo(X, [X1|Y],[X1|L]) :- add_ultimo(X,Y,L).

/*Contar o número de elementos de uma lista*/
conta([ ],0).
conta([ _ | Cauda], N) :- conta(Cauda, N1), N is N1 + 1.

/*Eliminar todas as ocorrências de um elemento de uma lista*/
del_todas(Elem,[ ],[ ]) :- !.
del_todas(Elem, [Elem|Y], Z) :- del_todas(Elem,Y,Z), !.
del_todas(Elem,[Elem1|Y], [Elem1|Z]) :- Elem \== Elem1,
del_todas(Elem,Y,Z).

/*Retirarr todas as repetições de uma lista*/
retirar_rep([ ],[ ]).
retirar_rep([Elem|Cauda],[Elem|Cauda1]) :-
del_todas(Elem,Cauda,Lista),
retirar_rep(Lista,Cauda1).

/*Contar o número de ocorrências de um dado
elemento no primeiro nível de uma lista*/
conta_occor(Elem,[ ],0).
conta_occor(Elem,[Elem|Y],N) :-
conta_ocorr(Elem,Y,N1),
N is N1 + 1.
conta_occor(Elem,[Elem1|Y], N) :-
Elem \== Elem1,
conta_ocorr(Elem,Y,N).

/*Desparentizar elementos de uma lista*/
desparentize([ ], [ ]).
desparentize([X|Y], [X|Z]) :- not(is_list(X)), desparentize(Y,Z), !.
desparentize([X|Y], Z) :- desparentize(X, X1), desparentize(Y, Y1), conc(X1, Y1,Z).

/*Intersecção das listas dadas*/
inter([ ], _, [ ]):- !.
inter([X|Y], Z, [X|W]) :- member(X,Z), inter(Y,Z,W), !.
inter([X|Y], Z, W):- inter(Y,Z,W).

/*Retorna lista que contém elementos que aparecem nas três listas*/
inter_tres(L1, L2, L3, L) :- inter(L1,L2,Linter), inter(Linter,L3, L).
inter([ ], _, [ ]):- !.
inter([X|Y], Z, [X|W]) :- member(X,Z), inter(Y,Z,W), !.
inter([X|Y], Z, W):- inter(Y,Z,W).
