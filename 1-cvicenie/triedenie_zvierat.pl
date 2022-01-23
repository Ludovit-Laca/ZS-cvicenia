zviera_je(lev):-
    vlastnost(ma_hrivu),
    druh(dravec),
    vlastnost(ma_pieskovu_farbu),
    !.
zviera_je(tiger):-
    vlastnost(ma_pieskovu_farbu),
    druh(dravec),
    vlastnost(ma_cierne_pruhy),
    !.
zviera_je(nezname).

druh(dravec):-
    druh(cicavec),
    vlastnost(zere_maso).
druh(cicavec):-
    vlastnost(ma_srst);
    vlastnost(pije_mlieko).

vlastnost(Otazka):-
    repeat,
    nl, write('Je pravda, že zviera'),
    write(Otazka), write('?'),
    read(Odpoved),
    (Odpoved = a, !; Odpoved = n, !,fail).
