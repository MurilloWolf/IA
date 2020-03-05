liga(a,b).
liga(a,c).
liga(a,d).
liga(b,d).
liga(b,e).
liga(c,e).
liga(d,f).
liga(e,g).
liga(f,g).

%Isso garante um grafo ao invés de um digrafo
pode_ir(X,Y):-liga(X,Y);liga(Y,X);

%Algoritimo da busca
resolve(Origem, Destino, Caminho):- rota(Origem, Destino, [Origem],Caminho).

%Condição de parada
%Quando o Destino for igual a Origem e quando o Caminho atual for igual o caminho final.
rota(X,X,Caminho,Caminho).

%Ele pode ir do Vizinho para o Destino , se esse Vizinho já não esta na lista dos caminhos vizitados e faz 
%a chamada recursiva
rota(Vizinho, Destino, [Vizinho|CaminhoAUX], Caminho ):- pode_ir(Origem,Vizinho), not(member(Vizinho,CaminhoAUX)),
    rota(Vizinho, Destino,[Vizinho | CaminhoAUX], Caminho).
