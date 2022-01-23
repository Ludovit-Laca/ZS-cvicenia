
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

(defrule vypis_vsetko
  (film (nazov ?n) (zaner ?z) (herci ?h))
=>
  (printout t "Mam evidovany film: " ?n " ( " ?z " ), s hercami: " ?h crlf)
)
