%Vetor Inicial [3,3,0,0,e].
%Vetor Final [0,0,3,3,d].
%Disposição no vetor
%[
%    ContCanibais_Esquerda, ContPadres_Esquerda,
%    ContCanibais_Direita, ContPadres_Direita,
%    Pos_Barco
%]

inc(Numero, Incrementado):- Incrementado is Numero + 1.
dec(Numero, Incrementado):- Incrementado is Numero - 1.
oposto(d,e).
oposto(e,d).


%Transporta 1 padre e 1 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, NCPE, NCCD, NCPD, NB]):-
    dec(CCE,NCCE), dec(CPE,NCPE), inc(CCD,NCCD), inc(CPD, NCPD), oposto(B,NB).

%Transporta 0 padre e 2 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, CPE, NCCD, CPD, NB]):-
    dec(CCE,CCEAux), dec(CCEAux, NCCE), inc(CCD, CCDAux), inc(CCDAux, NCCD), oposto(B,NB).

%Transporta 0 padre e 2 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[CCE, NCPE, CCD, NCPD, NB]):-
    dec(CPE,CPEAux), dec(CPEAux, NCPE), inc(CPD, CPDAux), inc(CPDAux, NCPD), oposto(B,NB).

%Transporta 1 padre
pode_ir([CCE, CPE, CCD,CPD, B ],[CCE, NCPE, CCD, NCPD, NB]):-
    dec(CPE,NCPE), inc(CPD, NCPD), oposto(B,NB).

%Transporta 1 canibal
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, CPE, NCCD, CPD, NB]):-
    dec(CCE,NCCE), inc(CCD, NCCD), oposto(B,NB).

permitido([CCE,CPE, CCD, CPD, B]):- (CCD =< CPD ; CPD = 0 ) ,  (CCE =< CPE ; CPE = 0).


%%BUSCA EM PROFUNDIDADE
rota(Origem, Destino, Cam):-
	 rota(Origem, Destino, [Origem], Cam).

rota(Destino, Destino, Cam, Cam).

rota(Origem, Destino, CamAux, Cam):-
	 pode_ir(Origem, Vizinha),
	 permitido(Vizinha),
	 not(pertence(Vizinha,CamAux)),
	 rota(Vizinha, Destino, [Vizinha|CamAux], Cam).

pertence(Elem,[Elem|_]):-!.
pertence(Elem,[_|Cauda]):- pertence(Elem, Cauda).

resolve(EstIni, EstFinal):- rota(EstIni, EstFinal, Cam), imprime2(Cam).

imprime2([]).
imprime2([_]).
imprime2([C1,C2|Cauda]):- imprime2([C2|Cauda]),
			  nl, mostra(C1,C2).

mostra([CCE,CPE,CCD,CPD, B],[NCCE,NCPE,NCCD,NCPE, NB]):-write('Foram um padre e um canibal da'), ext(B,Texto1),
			write(Texto1), write(' para a'), ext(NB,Texto2),
			write(Texto2).

mostra([CCE,CPE,CCD,CPD, B],[NCCE,CPE,NCCD,CPD, NB]):-write('Foram'), quantidade(CCD,NCCD,Qtd), NCCE = CCE - Qtd , write(Qtd) , write(' canibal(is) da'), ext(B,Texto1),
			write(Texto1), write(' para a'), ext(NB,Texto2),
			write(Texto2).

mostra([CCE,CPE,CCD,CPD, B],[CCE,NCPE,CCD,NCPD, NB]):-write('Foram'), quantidade(CPD,NCPD,Qtd), NCPE = CPE - Qtd,  write(Qtd),  write(' padre(s) da'), ext(B,Texto1),
			write(Texto1), write(' para a'), ext(NB,Texto2),
			write(Texto2).


quantidade(C1, C2 , qtd):- (C1 > C2, qtd = C1-C2 ) ; qtd = C2 - C1.
ext(e,esquerda).
ext(d,direita).
