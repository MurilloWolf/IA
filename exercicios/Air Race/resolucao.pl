piloto(lamb).
piloto(besenyei).
piloto(chambliss).
piloto(maclean).
piloto(mangold).
piloto(jones).
piloto(bonhomme).

redbull(besenyei).
redbull(chambliss).

racing(maclean).

breitling(lamb).

cobra(mangold).

matador(bonhomme).
matador(jones).


equipes(redbull).
equipes(racing).
equipes(cobra).
equipes(matador).
equipes(breitling).

gates(porto,5).
gates(budapest,6).
gates(istambul,9).

cidade(porto).
cidade(budapest).
cidade(istambul).

venceu(jones,porto).
venceu(mangold,budapest).
venceu(mangold,istambul).

aviao(mx2).
aviao(edge540).

pilotam(mx2, lamb).
pilotam(edge540 , besenyei).
pilotam(edge540 , chambliss).
pilotam(edge540 , maclean).
pilotam(edge540 , mangold).
pilotam(edge540 , jones).
pilotam(edge540 , bonhomme).

//A) Equipe vencedora da corrida 
equipe_vencedora(EV)  :- piloto(P), cidade(C), equipe(EV), (equipe(EV),venceu(P,C)).
?-equipe_vencedoa(porto).


//C) Quais pilotos venceram mais de um circuito
?- piloto(P) :- piloto(P), length( findall(VT , ( cidade(C), venceu(VT,C) ), unknow_param ) ) >= 2.

//D) Qual circuito tem mais de 8 gates
?- cidade(C) :- gates(C,GATES), GATES > 8.

//E) Quem nao pilota um Edge540
? piloto(P) :- piloto(P), not pilotam(edge540,P).