
leer(Mapa) :-
	read_string( user_input, "\n", " ", _End, Filename),
	open(Filename,read,File), 
	read(File,Mapa),
	close(File).

main:- 
	leer(Mapa).