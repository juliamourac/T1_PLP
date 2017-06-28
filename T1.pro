/*Concatenação*/
conc([ ], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

/*Apaga todas as ocorrências de um elemento em uma lista*/
rem_todas(_,[],[]):-!.
rem_todas(X, [X|L], L1):- rem_todas(X,L,L1),!.
rem_todas(X, [Y|L], [Y|L1]):- rem_todas(X,L,L1).


/*Desparentizar elementos de uma lista*/
desparentize([], []):-!.
desparentize([X|Y], [X|Z]) :- atomic(X), desparentize(Y,Z), !.
desparentize([X|Y], Z) :- desparentize(X, X1), desparentize(Y, Y1), conc(X1, Y1,Z).

/*Intersecção*/
inter([ ], _, [ ]):- !.
inter([X|Y], Z, [X|W]) :- member(X,Z), inter(Y,Z,W), !.
inter([X|Y], Z, W):- inter(Y,Z,W).

/*Cria uma lista só com repetições*/
tira_nao_comuns([],[],[]) :- !.
tira_nao_comuns(L1,L2,Lout) :- inter(L1,L2,La), inter(L2,L1,Lb), conc(La,Lb,Lout).

/*Conta as ocorrências de um elemento em uma lista*/
conta(Elem,[],1 ) :- !.
conta(Elem,[X|Y], N) :- X=Elem, conta(Elem, Y, Ne) , N is Ne + 1, !.
conta(Elem,[X|Y], N) :- conta(Elem,Y,N).

/*Dada uma lista Lin, retorna o elemento e quantas vezes ele aparece*/
monta_pares([],[]):-!.
monta_pares([X|Y], [[X,N]|Lout]) :- conta(X, Y, N), rem_todas(X, Y, Ls), monta_pares(Ls,Lout).

/*Conta atomos: mostra quantas vezes elementos atômicos
(átomos + lista vazia) aparecem,
somente se repetidas nas duas listas*/
conta_atomos([],[],[]) :- !.
/*Nesta ordem: L1 é "desparentizado, L2 é desparentizado;
é feita a junção das duas listas resultantes do processo anterior, e, depois,
a lista de pares é criada*/
conta_atomos(L1,L2,Lout) :- desparentize(L1,L1desp), desparentize(L2,L2desp),
    tira_nao_comuns(L1desp,L2desp,Lj),monta_pares(Lj,Lout).
