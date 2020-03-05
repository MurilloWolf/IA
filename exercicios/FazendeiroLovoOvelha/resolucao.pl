%Disposicao no vetor [Fazendeiro,  Carneiro, Lobo, Repolho]
%Estado inicial [e,e,e,e]
%Estado final [d,d,d,d]

%se o primeiro parametro for 'd', ele retorna e para a variavel 
%livre no segundo parametro e vice versa.
oposto(d,e). 
oposto(e,d).

%Mapeando as possiveis ações do jogo
%Fazendeiro E => Fazendeiro D
pode_ir([F,C,L,R], [NF,C,L,R]): oposto(F,NF).

%Fazendeiro E + Cordeiro E => Fazendeiro D + Cordeiro D 
poder_ir([F,C,L,R],[NF,NC,L,R]):- oposto(F,NF), oposto(C,NC).

%Fazendeiro E + Lobo E => Fazendeiro D + Lobo D
pode_ir([F,C,L,R],[NF,C,NL,R]):- oposto(F,NF), oposto(L,NL).

%Fazendeiro E + Repolho E => Fazendeiro D + Repolho D
poder_ir([F,C,L,R],[NF,L,C,NR]):- oposto(F,NF), oposto(R,NR).

%Ações permitidas no jogo
permitido([FC,FC,_,_]).
permitido([X,C,X,X]):- oposto(X,C).
%??? Certo , porque também é permitido que todos estejam no mesmo lado ao mesmo tempo????
permitido([X,X,X,X]).

%Busca em Profundidade Alterada
resolve(Origem, Destino, Caminho):- rota(Origem, Destino, [Origem],Caminho).

%Condição de parada
%Quando o Destino for igual a Origem e quando o Caminho atual for igual o caminho final.
rota(X,X,Caminho,Caminho).

%Ele pode ir do Vizinho para o Destino , se esse Vizinho já não esta na lista dos caminhos vizitados e faz 
%a chamada recursiva
rota(Origem, Vizinho, [Vizinho|CaminhoAUX], Caminho ):- pode_ir(Origem,Vizinho), not(member(Vizinho,CaminhoAUX)),
    permitido(Vizinho),
    rota(Vizinho, Destino,[Vizinho | CaminhoAUX], Caminho).
