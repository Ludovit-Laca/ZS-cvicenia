% Expertny system pracujuci s vonkajsim tvarom bazy znalosti

:- op(800,fx,ak), op(750,xfx,potom), op(600,xfy,a), op(650,xfy,alebo).

:- dynamic zodpovedane/2, odvodene/2, odvodene/3.

go :-
	inicializuj_db,
	koren(X), vysetri(X,[],Vysvetlenie),
	nl, nl, write('Odvodil som, ze objekt '),
	write(X), nl, nl, ako(Vysvetlenie), !.
go :-
	nl, write('Ziadna hypoteza neplati').

inicializuj_db :-
	retractall(zodpovedane(_,_)),
	retractall(odvodene(_,_)),
	retractall(odvodene(_,_,_)).

zac(_).
zac(X) :- assertz(odvodene(X,nie)), !, fail.

kon(Co,Ako) :- assertz(odvodene(Co,ano,Ako)).


vysetri(A a B,Cesta,V1 a V2):-
	!, vysetri(A,Cesta,V1), vysetri(B,Cesta,V2),!.
vysetri(A alebo B,Cesta, V ):-
	!,(vysetri(A,Cesta,V); vysetri(B,Cesta,V)),!.
vysetri(Vlastnost,_,odvodil(Vlastnost,X) ) :-
	odvodene(Vlastnost,ano,X),!.
vysetri(Vlastnost, _ , _ ) :-
	odvodene(Vlastnost,nie),!,fail.
vysetri(Vlastnost, _ , zodpovedal(Vlastnost) ) :-
	zodpovedane(Vlastnost,ano),!.
vysetri(Vlastnost, _ , _ ) :-
	zodpovedane(Vlastnost,nie),!,fail.
vysetri(Vlastnost,Cesta,odvodil(Vlastnost,X)) :-
	ak Predpoklady potom Vlastnost,!,
	zac(Vlastnost),	vysetri(Predpoklady,[Vlastnost|Cesta],X),
	kon(Vlastnost,X), !.
vysetri(Otazka,Cesta,zodpovedal(Otazka)) :-
	list(Otazka),
	repeat,nl, write('Je pravda, �e '),write(Otazka), write(' ? '),
	read(Odp),
	(Odp=a, !, assertz(zodpovedane(Otazka,ano)) ;
	 Odp=n, !, assertz(zodpovedane(Otazka,nie)),fail;
	 Odp=w, nl, nl, why([Otazka|Cesta]),fail ;
	 Odp=i, nl, nl, vypis_odvodene, nl,vypis_zodpovedane, fail).

why([H]) :-
	write(H), nl, !.
why([H|T]) :-
	write(H), write(' >> '), why(T).

ako(How) :-
	ako(How,0).
ako(V1 a V2,N) :-
	ako(V1,N), tab(N), write(a), nl, ako(V2,N).
ako(odvodil(Riesenie,Odvodene_z),N) :-
	tab(N), write(Riesenie), write(' bolo odvodene z '),
	nl, M is N+5, ako(Odvodene_z,M).
ako(zodpovedal(Otazku),N):-
	tab(N), write(Otazku), write(' si zodpovedal kladne'), nl.

vypis_zodpovedane :-
	zodpovedane(X,Y),
	write(zodpovedane(X,Y)), nl,
	fail.
vypis_zodpovedane.

vypis_odvodene :-
	odvodene(Co,Odp,_),write('odvodene('),write(Co),
	write(','), write(Odp), write(')'), nl, fail.
vypis_odvodene :-
	odvodene(X,Y),
	write(odvodene(X,Y)), nl,
	fail.
vypis_odvodene.


% Baza znalosti v externom tvare

ak je_dravec a ma_pieskovu_farbu a ma_tmave_skvrny	potom je_gepard.
ak je_dravec a ma_pieskovu_farbu a ma_cierne_pruhy	potom je_tiger.
ak je_dravec a ma_hrivu a ma_pieskovu_farbu             potom je_lev.
ak je_cicavec a ma_srst a ma_hnedu_farbu a ma_hrivu     potom je_kon.
ak je_cicavec a zere_maso				potom je_dravec.
ak ma_srst alebo dava_mlieko				potom je_cicavec.

koren(je_gepard). koren(je_tiger). koren(je_lev). koren(je_kon).

list(ma_tmave_skvrny). list(ma_pieskovu_farbu).
list(dava_mlieko). list(ma_cierne_pruhy).
list(zere_maso). list(ma_srst).
list(ma_hnedu_farbu). list(ma_hrivu).

