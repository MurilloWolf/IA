homem(norberto).
homem(pierre).
homem(bruno).

mulher(ursula).
mulher(berta).

bonito(ursula).
bonito(norberto).
bonito(pierre).

forte(berta).
forte(pierre).
forte(bruno).

rico(norberto).
rico(berta).

amavel(bruno).

gosta(H,M) :- homem(H), mulher(M), bonito(M).

feliz(H) :- homem(H), rico(H).
feliz(H) :- homem(H), mulher(M), gosta(H,M), gosta(M,H).
feliz(M) :- homem(H), mulher(M), gosta(M,H), gosta(H,M).

//de quem a ursula gosta
?-gosta(M): mulher(ursula), homem(M), gosta(H,M), rico(H), bonito(H), forte(H), amavel(H).