%Vetor Inicial [3,3,0,0,e].
%Vetor Final [0,0,3,3,d].
%Disposição no vetor
%[
%    ContCanibais_Esquerda, ContPadres_Esquerda,
%    ContCanibais_Direita, ContPadres_Direita,
%    Pos_Barco
%]

inc(Numero, Qtd_de_Incremento, Retorno):- Retorno is Numero + Qtd_de_Incremento.
dec(Numero, Qtd_de_Decremento, Retorno):- Retorno is Numero - Qtd_de_Decremento.
oposto(d,e).
oposto(e,d).


%Transporta 1 padre e 1 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, NCPE, NCCD, NCPD, NB]):-
	%Vai fazer isso se o barco estiver na esquerda
    ((dec(CCE, 1 , NCCE), dec(CPE, 1,NCPE), inc(CCD, 1,NCCD), inc(CPD,1 , NCPD), oposto(B,NB)), B = e);
	(dec(CCD, 1 , NCCD), dec(CPD, 1,NCPD), inc(CCE, 1,NCCE), inc(CPE,1 , NCPE), oposto(B,NB)).

%Transporta 0 padre e 2 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, CPE, NCCD, CPD, NB]):-
    ((dec(CCE, 2, NCCE), inc(CCD, 2, NCCD), oposto(B,NB)),B = e );
	(dec(CCD, 2, NCCD), inc(CCE, 2, NCCE), oposto(B,NB)).

%Transporta 0 padre e 2 canibal para o outro lado
pode_ir([CCE, CPE, CCD,CPD, B ],[CCE, NCPE, CCD, NCPD, NB]):-
    ((dec(CPE,2, NCPE), inc(CPD, 2, NCPD), oposto(B,NB)), B = e );
	((dec(CPD,2, NCPD), inc(CPE, 2, NCPE), oposto(B,NB))).

%Transporta 1 padre
pode_ir([CCE, CPE, CCD,CPD, B ],[CCE, NCPE, CCD, NCPD, NB]):-
    ((dec(CPE,1 ,NCPE), inc(CPD, 1, NCPD), oposto(B,NB)), B = e );
	((dec(CPD,1 ,NCPD), inc(CPE, 1, NCPE), oposto(B,NB))).

%Transporta 1 canibal
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, CPE, NCCD, CPD, NB]):-
    ((dec(CCE, 1 , NCCE), inc(CCD,1 , NCCD), oposto(B,NB)), B = e);
	((dec(CCD, 1 , NCCD), inc(CCE,1 , NCCE), oposto(B,NB))).

permitido([CCE,CPE, CCD, CPD, _]):- (CCD =< CPD ; CPD = 0 ) ,  (CCE =< CPE ; CPE = 0).


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

mostra([CE,PE, CD,PD , B], [CE,PE, CD,PD , NB]):- quantidade(CE,CD,qtd), qtd = 2 , quantidade(PE,PD,Nqtd) , Nqtd = 2, write('foram 1 padre e 1 canibal da'), ext(B,barco), write(barco),
	write('para a '), ext(NB,barco2), write(barco2).

mostra([CE,PE, CD,PD , B], [CE,PE, CD,PD , NB]):- quantidade(CE,CD,qtd), qtd = 1 ,  write('foram '), write(qtd), write('canibai(s) da'), ext(B,barco), write(barco),
	write('para a '), ext(NB,barco2), write(barco2).

mostra([CE,PE, CD,PD , B], [CE,PE, CD,PD , NB]):- quantidade(PE,PD,qtd), qtd = 1 ,  write('foram '), write(qtd), write('Padres(s) da'), ext(B,barco), write(barco),
	write('para a '), ext(NB,barco2), write(barco2).

quantidade(C1, C2 , qtd):- (C1 > C2, qtd = C1-C2 ) ; qtd = C2 - C1.
ext(e,esquerda).
ext(d,direita).
