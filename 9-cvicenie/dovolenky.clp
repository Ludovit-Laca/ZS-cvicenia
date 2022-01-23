(deftemplate dovolenka
	(slot krajina (type SYMBOL))
	(slot strava (type SYMBOL))
	(slot doprava (type SYMBOL))
	(slot cena (type INTEGER) (range 1 5000)))

(deffacts dovolenky
  (dovolenka (krajina Chorvatsko) (strava polpenzia) (doprava letecky) (cena 349))
  (dovolenka (krajina Chorvatsko) (strava polpenzia) (doprava autobus) (cena 249))
  (dovolenka (krajina Chorvatsko) (strava ranajky) (doprava letecky) (cena 310))
  (dovolenka (krajina Taliansko) (strava polpenzia) (doprava auto) (cena 1939))
  (dovolenka (krajina Taliansko) (strava bez_stravy) (doprava auto) (cena 1230))
  (dovolenka (krajina Francuzsko) (strava ranajky) (doprava letecky) (cena 557))
  (dovolenka (krajina Kuba) (strava bez_stravy) (doprava letecky) (cena 1453))
  (dovolenka (krajina Kuba) (strava bez_stravy) (doprava auto) (cena 1899))
  (dovolenka (krajina Spanielsko) (strava polpenzia) (doprava letecky) (cena 1200))
  (dovolenka (krajina Spanielsko) (strava polpenzia) (doprava autobus) (cena 1050))	
)

(deffacts pomocne_fakty
	(menu))

(defrule zobraz_menu
?prec<-(menu)
=>
	(retract ?prec)
	(printout t "-----------<MENU>-----------" crlf)
    (printout t "Vyhladaj auto .............A" crlf)
	(printout t "Vyhladaj krajinu ..........V" crlf)
    (printout t "Vyhladaj lacnejsiu ........L" crlf)
    (printout t "Vyhladaj letecku ......,,..M" crlf)
    (printout t "Vyhladaj bez stravy .......S" crlf)
	(printout t "Koniec programu ...........K" crlf)
	(printout t "----------------------------" crlf)
	(printout t " " crlf)
	(printout t "Zadajte vasu volbu:")
	(assert (moja_volba (read))))
    
;-------------------K - KONIEC PROGRAMU--------------------------
(defrule koniec
	(moja_volba K)
=>
	(printout t "Koniec programu!" crlf))

;zrus volbu
(defrule zrus_volbu
    (declare (salience -11))
    ?prec1<-(moja_volba ?v)
=>
    (retract ?prec1)
    (assert (menu))
)

;-------------------V - VYHLADAVANIE PODLA KRAJINY---------------
(defrule podla_krajiny
    (moja_volba V)
=>
    (printout t "Zadajte názov krajiny: " crlf)
    (bind ?x (read))
    (assert (nazov_krajiny ?x))
)

;vyhlada krajinu 
(defrule vyhladaj_krajinu
    (nazov_krajiny ?x)
    (dovolenka (krajina ?x) (strava ?s) (doprava ?d) (cena ?c))
=>
    (printout t "Dovolenka: " ?x ", strava: " ?s ", doprava: " ?d ", cena: " ?c crlf)
)

;nenasiel krajinu 
(defrule nenasiel_krajinu
    (nazov_krajiny ?x)
    (not(dovolenka (krajina ?x)))
=>
    (printout t "Dovolenku do zadanej krajiny som nenasiel" crlf)
)

;zrusi volbu vyhladavania krajiny a zobrazi nove menu
(defrule zrus_vsetko
    (declare (salience -10))
    ?prec1<-(moja_volba ?v)
    ?prec2<-(nazov_krajiny ?x)
=>
    (retract ?prec1 ?prec2)
    (assert (menu))
)

;-------------------------- L - lacnejsie ako 1000 EUR ---------------
(defrule vyhladaj_lacnejsie
    (moja_volba L)
    (dovolenka (krajina ?x) (strava ?s) (doprava ?d) (cena ?c))
    (test (< ?c 1000))
=>
    (printout t "Dovolenka: " ?x ", strava: " ?s ", doprava: " ?d ", cena: " ?c crlf)
)

;-------------------------- M - letecka doprava -----------------------
(defrule vyhladaj_letecku_dopravu
    (moja_volba M)
    (dovolenka (krajina ?x) (strava ?s) (doprava letecky) (cena ?c))
=>
    (printout t "Dovolenka: " ?x ", strava: " ?s ", doprava: letecky, cena: " ?c crlf)
)

;-------------------------- A - auto -----------------------------------
(defrule vyhladaj_auto
    (moja_volba A)
    (dovolenka (krajina ?x) (strava ?s) (doprava auto) (cena ?c))
=>
    (printout t "Dovolenka: " ?x ", strava: " ?s ", doprava: auto, cena: " ?c crlf)
)

;-------------------------- S - bez stravy ------------------------------
(defrule vyhladaj_strava
    (moja_volba S)
    (dovolenka (krajina ?x) (strava bez_stravy) (doprava ?d) (cena ?c))
=>
    (printout t "Dovolenka: " ?x ", strava: bez_stravy, doprava: " ?d ", cena: " ?c crlf)
)