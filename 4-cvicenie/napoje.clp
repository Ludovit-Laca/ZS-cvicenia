(deffacts napoje
    (vino furmint lipovina)
    (pivo staiger topvar corgon)
    (vino veltlin muler rulandske)
    (liehovina rum vodka)
    (liehovina borovicka slivovica hruskovica drienkovica) 
)

(defrule zmaz_tvrdy_alkohol
    ?tvrdy_alk <- (liehovina $?alkohol)
=>
    (retract ?tvrdy_alk)
    (printout t "-----------" crlf)
    (printout t "Alkohol vymazany" crlf)
)