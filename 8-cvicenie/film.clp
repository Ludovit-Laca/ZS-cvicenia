
;SABLONA film

(deftemplate film
  (slot nazov (type SYMBOL))
  (slot rok (type INTEGER) (range 1924 2005)) 
  (slot rezia (type SYMBOL))
  (slot zaner (default sci-fi))
  (multislot herci (type SYMBOL))
)

;FAKTY ZALOZENE NA SABLONE film

(deffacts moje_filmy
  (film (nazov Votrelec) (rok 1979) (rezia Ridley_Scott) (herci Sigourney_Weaver John_Hurt Ian_Holm))
  (film (nazov Votrelci) (rok 1986) (rezia James_Cameron) (herci Sigourney_Weaver Lance_Henriksen Michael_Biehn Paul_Reiser))
  (film (nazov Cervena_planeta) (rok 2000) (rezia Anthony_Hoffman) (herci Carrie_Anne_Moss Val_Kilmer Tom_Sizemore))
  (film (nazov Umela_inteligencia) (rok 2001) (rezia Steven_Spielberg) (herci Haley_Joel_Osment Jude_Law))
  (film (nazov Metropolis) (rok 1925)(rezia Fritz_Lang) (herci Brigitte_Helm Alfred_Abel Gustav_Frolich Fritz_Rasp))
)

;PRAVDIDLO STARSIE AKO 1980

(defrule starsie_1980
  (declare (salience -5))
  (film (nazov ?naz_filmu) (rok ?r))
  (test (< ?r 1980))
=>
  (printout t " " crlf)
  (printout t ?naz_filmu " z roku:" ?r crlf)
)

;PRAVIDLO OBSAHUJE HERCA SSigourney_Weaver

(defrule obsahuje_herca
  (declare (salience -4))
  (film (nazov ?naz_filmu) (herci $?zoznam_hercov))
  (test (member$ Sigourney_Weaver $?zoznam_hercov))
=>
  (printout t " " crlf)
  (printout t "Sigourney_Weaver hrala vo filme " ?naz_filmu crlf)
)

;PRAVIDLO NEOBSAHUJE HERCA Lance_Henriksen

(defrule neobsahuje_herca
  (film (nazov ?naz_filmu) (herci $?zoznam_hercov))
  (test (not(member$ Lance_Henriksen $?zoznam_hercov)))
=>
  (printout t " " crlf)
  (printout t "Lance_Henriksen nehral vo filme " ?naz_filmu crlf)
)