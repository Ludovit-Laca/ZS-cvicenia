(deffacts linky
	(linka 1 Hl_stanica Tesco Strelnica Lipky Akvarium Nemocnica Heyrovskeho)
	(linka 2 Hl_stanica Gocarova Ulrichove_nam Adal)
	(linka 6 Hl_stanica Gocarova Ulrichove_nam Adal Tesco Urad Gymnazium)
	(linka 13 Hl_stanica Tesco Central Muzeum Aldis Bedrna)
	(menu nacitane))


;ch. Pravidlo zobrazujici menu

(defrule vypis_menu
?prec<- (menu nacitane)
=>
	(retract ?prec)
	(printout t "------------<MENU>------------" crlf)
	(printout t "Zobraz info k linke.....A" crlf)
	(printout t "Zobraz info k zastavke..B" crlf)
	(printout t "Zadajte novu linku.....C" crlf)
	(printout t "Zobrazte vsetky informacie .........D" crlf)
	(printout t "Zrus zastavku ..........E" crlf)
	(printout t "Vyhladej spojenie pre zastavky ... F" crlf)
	(printout t "Koniec programu ....K" crlf)
	(printout t "------------------------------" crlf)
	(printout t "Zadajte svoju volbu:")
	
	(bind ?volba (read))
	(assert (moja_volba ?volba)))

;---------------------------------------------
;b. Zobraz info k zastavke

(defrule zadajte_linku
	(moja_volba A)
=>
	(printout t "Zadajte cislo linky:" crlf)
	(bind ?x (read))
	(assert (chcem_linku ?x)))
	
;b.
(defrule vypis_info_k_linke
	(moja_volba A)
	(chcem_linku ?x)
	(linka ?x $?zoznam)
	

?precV<-(moja_volba A)
?precL<-(chcem_linku ?x)
=>
	(retract ?precV ?precL)
	

	(assert (menu nacitane))
	

	(printout t "Info k linke c." ?x ":" ?zoznam crlf))

;--------------------------------------------

;c. Pravidlo pre zadanie zastavky

(defrule zadejte_zastavku
	(moja_volba B)
=>
	(printout t "Zadejte nazov zastavky:" crlf)
	(bind ?y (read))
	(assert (chcem_zast ?y)))


;c.
(defrule vypis_k_zast_linky
	 (moja_volba B)
	 (linka ?l $?zoznam)
	 (chcem_zast ?y&:(member$ ?y $?zoznam))
=>
	(printout t "K zastavke s nazvom:" ?y "-jazdia tieto linky:" ?l ";" crlf))

;c.
(defrule zrus_volbuB_a_stanicu
	(declare(salience -10))
?precV<-(moja_volba B)
?precS<-(chcem_zast ?x)
=>
	(retract ?precV ?precS)
	(assert(menu nacitane)))

;--------------------------------------------

;d. Pravidlo pre pridanie novej linky

(defrule pridaj_novu_linku
?prec<-(moja_volba C)
=>
	(retract ?prec)
	(printout t "Zadajte cislo linky:" crlf)
	(bind ?linka (read))
	(assert (linka ?linka))
	(printout t "Linka bola pridana" crlf)
	(assert (menu nacitane)))

;--------------------------------------------

;e. Pravidlo pre zadanie nazvu zastavky, ktoru chceme zrusit

(defrule zadej_nazov_zrusenej_zastavky
	(moja_volba E)
=>
	(printout t "Zadajte nazov rusenej zastavky:" crlf)
	(bind ?zastavka (read))
	(assert (rusena_zastavka ?zastavka)))


(defrule zrusenie_zastavky
	(moja_volba E)
	(rusena_zastavka ?zastavka)
?prec<-(linka ?x $?neco1 ?zastavka $?neco2)
=>
	(retract ?prec)
	(assert (linka ?x ?neco1 ?neco2)))
	;do baze faktu je vlozen fakt bez zastavky (?zastavka)


;e. - 
(defrule zrus_volbu_a_zastavku
	(declare(salience -10))
?precV<-(moja_volba E)
?precZ<-(rusena_zastavka ?zastavka)
=>
	(printout t "Zastavka zrusena!" crlf)
	(retract ?precV ?precZ)
	(assert(menu nacitane)))

;-----------------------------------------

;f - 

(defrule zadaj_zaciatok_a_ciel_zastavku
	(moja_volba F)
=>
	(printout t "Zadajte zaciatocnu zastavku:" crlf)
	(bind ?a (read))
	(assert (chcem_zaciatok ?a))
	(printout t "Zadajte cielovu zastavku:" crlf)
	(bind ?b (read))
	(assert(chcem_ciel ?b)))


;f - 

(defrule vyhladaj_spojenie
    (chcem_zaciatok ?zaciatok)
    (chcem_ciel ?koniec)
    (linka ?linka $?pred ?zaciatok $?stred ?koniec $?za)
=>
    (printout t "Hladana linka je: " ?linka crlf)
)

;f - 

(defrule nie_je_spojenie
    (chcem_zaciatok ?zaciatok)
    (chcem_ciel ?koniec)
    (not(linka ?linka $?pred ?zaciatok $?stred ?koniec $?za))
=>
    (printout t "Priamy spoj neexistuje" crlf)
    (assert (priamy_spoj nie))
)

;f

(defrule spoj_s_prestupom
    (moja_volba F)
    (chcem_zaciatok ?zaciatok)
    (chcem_ciel ?koniec)
    (priamy_spoj nie)
    (linka ?linka1 $?pred1 ?zaciatok $?stred1 ?prestup $?za1)
    (linka ?linka2 $?pred2 ?prestup $?stred2 ?koniec $?za2)
=>
    (printout t "Linka " ?linka1 " " ?zaciatok " --> " ?prestup crlf)
    (printout t "Linka " ?linka2 " " ?prestup " --> " ?koniec crlf)
)

;f

(defrule zrus_vsetko_pre_volbuF
	(declare(salience -5))
?precV<-(moja_volba F)
?precP<-(chcem_zaciatok ?a)
?precC<-(chcem_ciel ?b)
?precX<-(priamy_spoj ?x)
=>
	(retract ?precV ?precP ?precC ?precX)
	(assert (menu nacitane)))


;--------------------------------------------
;g. 

(defrule zobraz_vsetko
        (moja_volba D)
	(linka ?nejaka $?stanice)
=>
	(printout t "poznam tieto linky:" ?nejaka ?stanice crlf))


;g.

(defrule zrus_volbuD
	(declare(salience -5))
?prec<-(moja_volba D)
=>
	(retract ?prec)
	(assert(menu nacitane)))


;------------------------------------------
;h.

(defrule koniec_programu
	(moja_volba K)
=>
	(printout t "Koniec programu!" crlf))
