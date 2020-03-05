%Vetor Inicial [3,3,0,0,e].
%Vetor Final [0,0,3,3,d].
%Disposição no vetor 
[
    ContCanibais_Esquerda, ContPadres_Esquerda,
    ContCanibais_Direita, ContPadres_Direita,
    Pos_Barco
]

inc(Numero, Incrementado): - Incrementado is Numero + 1. 
dec(Numero, Incrementado): - Incrementado is Numero - 1. 
oposto(d,e).
oposto(e,d).


%Transporta 1 padre e 1 canibal para o outro lado 
pode_ir([CCE, CPE, CCD,CPD, B ],[NCCE, NCPE, NCCD, NCPD, NB]):-
    dec(CCE,NCCE), dec(CPE,NCPE), inc(CCD,NCCD), inc(CPD, NCPD), oposto(B,NB)

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
pode_ir([CCE, CPE, CCD,CPD, B ],[CCE, CPE, NCCD, CPD, NB]):-
    dec(CCE,NCCE), inc(CCD, NCCD), oposto(B,NB).

permitido([CCD,CPE, CCD, CPD, B]):- CCD <= CPD, CCE <=CPE.
