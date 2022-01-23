;******************************************;
;					   ;
;	   	DATABAZE ZVIRAT	           ;	
;		   (MH 2004)		   ;
;				           ;
;******************************************;
;Zadani:
;A.	vypsat celou databazi zvírat i s kontinentem (nejprve nazev kontinentu a k nemu zvírata, ktera ho mohou obyvat)
;B.	nacist nazev kontinentu a zjistit, jaka zvírata jej obyvaji
;H.	Ukoncit program
;C.	nacist druh zvírete a zjistit, kde zije
;D.	vlozit do databaze nove zvire (na konec prislusneho seznamu)
;E.	vlozit do databaze cely novy zaznam (napr. pro Australii)
;F.	zjistit, na kterem kontinente zije kolik druhu zvirat
;G.	zjistit, na kterem kontinente zije nejvetsi pocet zvirecich druhu


;Poznamky: ke kazdemu pravidlu je mimo poznamek a oznaceni ulohy i cislo
;cislo oznacuje poradi, kdy bude pravidlo vykonano (pokud mame menu, tak to hlavne zavisi
;na poradi pozadavku uzivatele 
;v tomto pripade bude objasneno poradi vykonavani pravidel jen pro jeden ukol (treba uloha A), ke kteremu
;se vaze nekolik pravidel
;A2. zn. ze toto pravidlo je soucasti ulohy A a bude vykonano jako druhe v poradi
;program neresi zadani chybnych faktu pr. (chci_kontinent asoa)


(deffacts databaze
	(zvirata afrika slon zebra zirafa opice antilopa pes)
	(zvirata asie tygr slon opice panda pes)
	(zvirata evropa pes zajic jelen kocka medved rys)

	(nactena_volba)) ;tento fakt by mohl byt soucasti nove struktury deffacts, ale i tato varianta je OK


;Pravidlo, ktere nam zobrazi volby pro operace s databazi
;je zde nulova priorita

;1.
(defrule zobraz_menu
?x <- (nactena_volba)
;tato podminka je zde velmi dulezita !!!
;chceme zobrazit menu (mit zobrazene ruzne volby) po nejake akci
;napr. po spusteni programu, po zobrazeni cele databaze atd.
;musime ale zabezpecit, aby se nam menu nezobrazovalo v dobe kdy nechceme napr.
;aby se nam nezobrazovalo jen menu a my bychom si po zobrazeni menu nemohli obsah databaze zobrazit
;podminkova cast: za podminky, ze v bazi faktu je fakt nactena_volba, pak mi zobraz menu
;aby se pri druhem kroku menu nezobrazovalo, tak tento fakt z baze retractem vymazeme
;tim jiz nebude splnena podminkova cast tohoto pravidla (pravidlo se neprovede)
=>
	(retract ?x)
	(printout t "-----------------<NABIDKA>------------------" crlf)
	(printout t "Zobrazeni cele databaze ... a" crlf)
	(printout t "Zadani kontinentu a zobrazeni zvirat ... b" crlf)
	(printout t "Zjisti o zvireti, kde zije ... c" crlf)
	(printout t "Zadej nove zvire do seznamu ... d" crlf)
	(printout t "Vytvor novy-prazdny seznam ... e" crlf)
	(printout t "Zjisti pocet druhu na kontinente ...f" crlf)
	(printout t "Nejvetsi pocet zvirecich druhu ... g" crlf)
	(printout t "Konec programu ... k" crlf)
	(printout t "============================================" crlf)
	
	(printout t "Zadejte svoji volbu:")
	;zadame uzivatele aby zadal jednu z voleb a nebo b ...
	(bind ?volba (read))
	(assert (moje_volba ?volba)))
	;tuto volbu ukladame do baze faktu, abychom tuto informaci mohli uzit dale 
	;v jinem pravidle



;A2.
(defrule vypis_vsechny_seznamy	
	(declare(salience 10))
	;urcite se ptate proc se nejprve nevykona toto pravidlo, kdyz je zde uvedena
	;priorita 10 (v pravidle zobraz_menu je priorita 0 - vlastne vubec neni priorita deklarovana)
	;je to proto, ze aby mohlo byt pravidlo vykonano museji byt splneny vsechny podminky v podminkove
	;casti pravidla a pro vykonani tohoto pravidla je treba faktu moje_volba (druha podminka tohoto pravidla)
	;tento fakt moje_volba bude v bazi az po vykonani pravidla zobraz_menu, kde ho vkladame assertem do baze faktu
	;a tedy pak muze byt toto pravidlo vykonano (v bazi jiz je moje_volba (program tedy uz vi, co uzivatel zada))

	(moje_volba a)
	(zvirata $?vse)
=>
	(printout t "Cela databaze obsahuje tyto udaje:" crlf)
	(printout t ?vse crlf))


;A3.
(defrule zrus_volbu_a
?x <-   (moje_volba a)
=>
	(retract ?x)
	(assert(nactena_volba)))

;Toto posledni pravidlo ulohy A je take velmi dulezite a asi nebude jednoduche ho objasnit ale pokusim se
;je jasne ze po vypisu databaze (volba a) budete chtit, aby se Vam menu opet zobrazilo a uzivatel zvolil z menu neco jineho
;jinymi slovy: chcete, aby se nam pravidlo vypis_vsechny_seznamy nevykonavalo neustale
;tedy musime docilit toho, aby podminkova cast pravidla vypis_vsechny_seznamy nebyla splnena (pravidlo se nevykonalo)
;toho docilime tak, ze fakt (moje_volba a) z baze faktu odstranime (vlastne uzivatel jiz nebude chtit treba zobrazit
;znovu celou databazi (to je volba a)), to nevime predem co bude chtit udelat a tak zrusime jeho volbu a ocekavame volbu novou
;jakobychom uklizeli neporadek - to stare co ted nepotrebujeme, abychom to mohli nekdy pouzit znovu
;tim take nebude splnena podminkova cast pravidla vypis_vsechny_seznamy, ktera predpoklada existenci faktu (moje_volba a)
;fakt (moje_volba a) je zrusen, ale to nestaci, preci chceme hned po vypisu zobrazit menu 
;a jaky fakt k tomu potrebujeme ???
;potrebujeme fakt (nactena_volba), ktery je vyzadovan pravidlem zobraz_menu, aby se pravidlo mohlo provest



;B1.
(defrule zadej_kontinent
	(moje_volba b)
	;jestlize uzivatel zadal volbu b pak (pravidlo bude vykonano jako prvni) po nem chceme, aby zadal kontinent, ktery
	;bude nasledne ulozen do baze faktu
=>
	(printout t "Zadejte nazev kontinentu:" crlf)
	(bind ?nejaky (read))
	(assert (chci_kontinent ?nejaky)))


;B2.
(defrule vypis_zvirata_pro_muj_kontinent
        (chci_kontinent ?k)
        ;kontinent zadan

	(zvirata ?k $?zvirata)
	;predpokladame predem, ze program ma nejaka fakta o zviratech predem
	
=>
	(printout t "Nalezena zvirata:" ?zvirata crlf))	


;B3.
(defrule zrus_volbu_b+kontinent
	(declare(salience -1)) 
	;je zde i jina moznost zruseni jiz nepouzitelnych faktu nez u prikladu A
	;potom co budou vypsana zvirata pro dany kontinent tak az pak
	;zrusime vse potrebne - volbu a kontinent (proto je zde priorita -1
	
?x <- (moje_volba b)
?y <- (chci_kontinent ?nejaky)

=>
	(retract ?x ?y)
	(assert (nactena_volba))) ;opet chceme nacist menu



;C1.
(defrule zadej_zvire
	(moje_volba c)
=>
	(printout t "Zadejte druh zvirete:" crlf)
	(bind ?zvire (read))
	(assert (chci_zvire ?zvire)))

;C2.
(defrule vypis_kontinent_pro_moje_zvire
	(chci_zvire ?x)
	;uzivatel zadal sve zvire, ktere chce najit

	(zvirata ?kontinent $?zvirata)
	;pritom budeme vyhledavat v seznamu $?zvirata

	(chci_zvire ?x&:(member$ ?x $?zvirata))
	;ale chceme, aby nase zvire ?x bylo prvkem tohoto seznamu ($?zvirata)
=>
	(printout t ?x "-" ?kontinent crlf))


;C3.
(defrule zrus_volbu_c_a_moje_zvire
	(declare (salience -10))
?x <- (moje_volba c)
?y <- (chci_zvire ?nejake) 
	
=>
	(retract ?x)
	(retract ?y)
	(assert (nactena_volba)))

;vse nepotrebne k uloze C smazeme z baze faktu
;otazka: Proc zde musi byt deklarovana priorita s -10 a proc ma byt vubec deklarovana?
;kdybychom prioritu vubec nedeklarovali pak by hrozilo riziko, ze bychom sice zadali volbu c a nase zvire, ale
;k vypsani kontinentu by jiz nedoslo, protoze by se mohlo vykonat drive pravidlo zrus_volbu_c ... a tedy
;data, ktera zadal uzivatel, by byla pryc - aby toto bylo realizovano pozdeji je treba deklarovat nizsi prioritu nez
;ma pravidlo vypis_kontinent_pro_moje_zvire



;D1.
(defrule zadej_kontinent_pro_nove_zvire
	(moje_volba d)
=>
	(printout t "Zadejte nazev kontinentu kam vase zvire patri:" crlf)
	;nejprve potrebujeme zvire nekam zaradit a pak ho do seznamu X vlozit
	(bind ?k (read))
	(assert (nove_zvire_kontinent ?k)))

;D2.
(defrule zadej_zvire_pro_seznamX
	(nove_zvire_kontinent ?k)
	;kontinent zadan
=>
	(printout t "Zadejte nove zvire:" crlf)
	;definujeme konkretni zvire, ktere ma byt soucasti seznamu X

	(bind ?x (read))
	(assert (pridej_zvire ?x)))


;D3.
(defrule pridej_zvire_do_seznamu
?a <- (nove_zvire_kontinent ?zeme)
?b <- (pridej_zvire ?x)

?staryseznam <- (zvirata ?zeme $?zvirata)
;rusime jen ten seznam, do ktereho chceme vlozit nove zvire
;tedy ten seznam z baze faktu, jehoz jmeno se shoduje s jmenem
;zadanym uzivatelem (vsimnete si promennych ?zeme v podm. casti pravidla)

;abychom mohli nejaky prvek vlozit do seznamu
;nejprve ho cely zrusime - ale pritom jsou v promennych ?zeme $?zvirata
;puvodni stare informace o seznamu "ulozena"

=>
	(retract ?a ?b ?staryseznam)
	(assert(zvirata ?zeme ?zvirata ?x))
	;na konec seznamu dame nase zviratko ?x
	

	(printout t "Zvire bylo pridano do seznamu !" crlf))


;D4.
(defrule zrus_volbu_d_zvire_kontinent
	(declare (salience -10))
?c <- (moje_volba d) 

=>
	(retract ?c)
	(assert (nactena_volba)))


;E1.
(defrule pojmenuj_novy_seznam
	(moje_volba e)
=>
	(printout t "Zadejte nazev noveho seznamu/nazev kontinentu:" crlf)
	(bind ?novy (read))
	(assert (novy_seznam ?novy)))
	;novy nazev ulozen do baze faktu


;E2.
(defrule vytvor_novy_seznam
?x<-(novy_seznam ?novy)
;seznam jiz pojmenovan

?y <- (moje_volba e)
	
=>
	(assert(zvirata ?novy))
	;vlozeni noveho seznamu do baze faktu s danym pojmenovanim

	(retract ?x ?y)
	(assert (nactena_volba))
	(printout t "Seznam byl vytvoren !" crlf))

;je zbytecne vytvaret nove pravidlo pro ruseni prebytecnych faktu



;F1.
(defrule kontinent_a_pocet_zvirat1
	(moje_volba f)
=>
	(printout t "Zadejte nazev kontinentu:"crlf)
	;musime vedet, pro ktery kontinent bude pocitan pocet

	(bind ?k (read))
	(assert (chci_kontinent ?k)))


;F2.
(defrule kontinent_a_pocet_zvirat2
?smazvolbu <- (moje_volba f)
?smazk <-(chci_kontinent ?k)
;vime o kontinentu jehoz pocet budeme urcovat

	(zvirata ?k $?zvirata)
	;k tomuto kontinentu existuje nejaky seznam s x polozkami
	;vsimnete si promennych ?k
=>
	(bind ?x (length$ ?zvirata))
	;zjistime delku vsech seznamu (pocet zvirat)

	(printout t "Na kontinente-" ?k "je:" ?x "-zvirat" crlf)
	(retract ?smazk ?smazvolbu)
	
	(assert (nactena_volba))) 
	;a zobrazime menu


;G1.
(defrule nejdelsi_seznam
	(moje_volba g)
	(zvirata ?kontinent1 $?zvirata1)
	(not (zvirata ?kontinent2 $?zvirata2&: (>(length$ $?zvirata2)(length$ $?zvirata1)))) 
	;porovnavame dva seznamy, pricemz rikame: za podminky ze neexistuje seznam druhy takovy, pro ktery plati:
	;ze jeho delka je vetsi nez delka prvniho seznamu
=>
	(printout t "Nejvetsi pocet zvirat je v kontinente:" ?kontinent1 crlf))

;pravidlo nejdelsi_seznam se realizuje nekolikrat (porovnavame mezi sebou ruzne seznamy a to nelze udelat jen v jednom kroku)
;proto je nutne zrusit fakt (moje_volba g) az v novem pravidle


;G2.
(defrule zrus_volbu_g
  (declare (salience -10))
?x <- (moje_volba g)
=>
      (retract ?x)
      (assert (nactena_volba))) 



;H1.
(defrule ukonci_program
	(moje_volba k)
=>
	(printout t "Konec programu !" crlf))
;neni potreba odstranovat fakt moje_volba k
;program stejne skonci a po jeho opetovnem spusteni
;je vse ciste

