combinacionSegura(regular, encendido).
combinacionSegura(invertido, apagado).

combinacionPeligrosa(regular, apagado).
combinacionPeligrosa(invertido, encendido).

%
% merge/2
% Hace merge cual mergesort de dos listas, unificandolas en una tercera. 
merge([],I,I).
merge(I,[],I).
merge([(X,Xm)|XS], [(Y,Ym)|YS], [(X,Xm)|T]):- X @=< Y, merge(XS, [(Y,Ym)|YS], T).
merge([(X,Xm)|XS], [(Y,Ym)|YS], [(Y,Ym)|T]):- X @> Y, merge([(X,Xm)|XS], YS, T).

% 
% completo/2
% Unifica el segundo argumento con una lista de pares (X,_) donde X es una letra en el mapa
completo(pasillo(X, _), [(X,_)]).
completo(secuencia(SubMapa1, SubMapa2), I):-
	completo(SubMapa1, I1),
	completo(SubMapa2, I2),
	merge(I1,I2,I).
completo(division(SubMapa1, SubMapa2), I):-
	completo(SubMapa1, I1),
	completo(SubMapa2, I2),
	merge(I1,I2,I).

%
% onoff/1
% Se asegura de instanciar los interruptores
onoff([]).
onoff([(_,X)|XS]) :- onoff(XS), (X = encendido; X = apagado).

%
% cruzar/3
% Chequea que los interruptores están completos y usa cruzarAhora/3 para cruzar el mapa
cruzar(M,I,S) :-
	completo(M,I),
		write(user_output,I), nl, flush_output(user_output),
	cruzarAhora(M,I,S),
	onoff(I).

	% Maneja el caso base de pasillo en el mapa
	cruzarAhora(pasillo(X, Modo), Interruptores, seguro) :- 
		combinacionSegura(Modo, M),
		member((X,M), Interruptores).
	cruzarAhora(pasillo(X, Modo), Interruptores, peligroso) :- 
		combinacionPeligrosa(Modo, M),
		write(user_output,M), flush_output(user_output),
		member((X,M), Interruptores).

	% Maneja caso de secuencia en el mapa
	cruzarAhora(secuencia(SubMapa1, SubMapa2), Interruptores, seguro) :- 
		write(user_output, "Secuencia segura...?"), flush_output(user_output),
		cruzarAhora(SubMapa1, Interruptores, seguro),
		write(user_output, "...?"), nl, flush_output(user_output),
		cruzarAhora(SubMapa2, Interruptores, seguro).
	cruzarAhora(secuencia(SubMapa1, SubMapa2), Interruptores, peligroso) :- 
		write(user_output, "Secuencia peligrosa...?"), nl, flush_output(user_output),
		cruzarAhora(SubMapa1, Interruptores, peligroso); cruzarAhora(SubMapa2, Interruptores, peligroso).

	% Maneja caso de división en el mapa
	cruzarAhora(division(SubMapa1, SubMapa2), Interruptores, seguro) :- 
		write(user_output, "Division segura...?"), nl, flush_output(user_output),
		cruzarAhora(SubMapa1, Interruptores, seguro); cruzarAhora(SubMapa2, Interruptores, seguro).
	cruzarAhora(division(SubMapa1, SubMapa2), Interruptores, peligroso) :- 
		write(user_output, "Division peligrosa...?"), nl, flush_output(user_output),
		cruzarAhora(SubMapa1, Interruptores, peligroso),
		cruzarAhora(SubMapa2, Interruptores, peligroso).


%
% siempre_seguro\1
% Indica si se puede cruzar el mapa suministrado sin importar el orden de los interruptores
siempre_seguro(division(pasillo(X, Y), pasillo(X, W))) :- Y \= W.
siempre_seguro(division(SubMapa1, SubMapa2)) :- siempre_seguro(SubMapa1) ; siempre_seguro(SubMapa2).

%
% leer/1
% Leer el nombre del archivo, unifica su contenido con Mapa.
leer(Mapa) :-
	write( user_output, "Nombre de archivo de mapa: " ), flush_output( user_output ),
	read_string( user_input, "\n", " ", _End, Filename),
	open(Filename,read,File), 
	read(File,Mapa),
	close(File).

%
% main/0
% "Función" principal
main:- 
	leer(Mapa),
	cruzar(Mapa, Is, S).
