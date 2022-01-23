;***********************************************
;
;     POUZIT� PRIKAZU member + ruzne pristupy
;
;		     (MH 2005)
;***********************************************

;Poznamka: budeme zjistovat, jestli existuje nejake zvire (fakt zvire = obecny seznam zvirat), ktere
;se nachazi v seznamu oblibenych zvirat (fakt oblibene_zvire)
;pri vypisu - hvezdicky oznacuji zpusob hledani prvku v seznamu


(deffacts zvirata
  (zvire pes)
  (zvire kocka)
  (zvire kohout)
  (zvire orangutan)
  (zvire papousek)
  (oblibene_zvire mys simpanz pes loskutak potkan papousek) )
  
;-----------------------------------------------



;Toto pravidlo pouziva pristupu: provazani pomoci promennych, nikoliv prikazu member

(defrule hledej_stejne_zpusob_1
  (zvire ?obecne_zvire)
  (oblibene_zvire $?zacatek ?obecne_zvire $?konec)
  ;at se obecne zvire nachazi kdekoliv v seznamu oblibenych zvirat, pak ho vypis

=>
  (printout t "*" crlf)
  (printout t "Z obecnych seznamu zvirat se v oblibenych zviratech nachazi:" ?obecne_zvire crlf) )




;Pravidlo s vyuzitim prikazu test a member

(defrule hledej_stejne_zpusob_2
  (zvire ?obecne_zvire)
  (oblibene_zvire $?oblibene_zvire)
  (test (member$ ?obecne_zvire $?oblibene_zvire))
  ;otestuj, jestli obecne zvire je prvkem seznamu s oblibenymi zviraty

=>
  (printout t "**" crlf)
  (printout t "Z obecnych seznamu zvirat se v oblibenych zviratech nachazi:" ?obecne_zvire crlf) )




;Slozitejsi podoba vyhledavani polozky v seznamu s prikazem member

(defrule hledej_stejne_zpusob_3
  (oblibene_zvire $?oblibene_zvire)
  (zvire ?obecne_zvire&:(member$ ?obecne_zvire $?oblibene_zvire))
  ;touto podminkou rikame: pro fakt s nazvem zvire m� platit: 
  ;ze toto obecne zvire ma byt prvkem seznamu oblibenych zvirat
  ;jestlize tato i ostatni podminky jsou splneny, pak tato obecna zvirata vypis

=>
  (printout t "***" crlf)
  (printout t "Z obecnych seznamu zvirat se v oblibenych zviratech nachazi:" ?obecne_zvire crlf) )










