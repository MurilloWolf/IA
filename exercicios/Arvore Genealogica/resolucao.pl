//Declaracao
pessoa(ana).
pessoa(luisa).
pessoa(maria).
pessoa(sueli).
pessoa(joao).
pessoa(joaquim).
pessoa(luis).
pessoa(flavio).
pessoa(marcos).
pessoa(samuel).

mulher(ana).
mulher(luisa).
mulher(maria).
mulher(sueli).

homem(joao).
homem(joaquim).
homem(luis).
homem(flavio).
homem(marcos).
homem(samuel).

//Fatos
progenitor(joaquim) :- homem(joao), mulher(ana).
progenitor(luis) :- homem(joaquim), mulher(maria).
progenitor(luisa) :- homem(joao).
progenitor(samuel) :- mulher(luisa), homem(marcos).
progenitor(sueli) :- mulher(luisa), homem(marcos).

//Regras 


    avô(P) :- pessoa(P), progenitor(progenitor(progenitor(P))), homem(P).
    avó(P) :- pessoa(P), progenitor(progenitor(progenitor(P))), mulher(P).
    
    irmao(I,P) :- pessoa(P), pessoa(I), progenitor(P) = progenitor(I), homem(I).

   
    tio(P) :- pessoa(P), pessoa(X),  irmao(X,progenitor(P)) ,  homem(X).
    tia(P) :- pessoa(P), pessoa(X),  irmao(X,progenitor(P)) ,  mulher(X).


    primo(PR) :- pessoa(P), pessoa(PR), tio(P) = progenitor(PR), homem(PR).
    prima(PR) :- pessoa(P), pessoa(PR), tio(P) = progenitor(PR), mulher(PR).



