cd "C:\Users\juanf\OneDrive\Documents\_01_ParisSE\_10_Cultural_Evolution\Assignment 2\data"

use		"ours.dta", clear

rename	(Numéro_d_inventaire) (nid)

replace Titre = Titre_attribué if Titre == ""
drop	Titre_attribué

gen ours = strpos(Titre, "Ours") > 0
replace ours = 1 if strpos(Dénomination, "Ours") > 0
replace ours = 1 if strpos(Sujet_représenté, "Ours") > 0
replace ours = 1 if strpos(Titre, "ours") > 0
replace ours = 1 if strpos(Expositions, "ours") > 0
replace ours = 1 if strpos(Titre, "Panda") > 0
replace ours = 1 if strpos(Dénomination, "Panda") > 0

keep	if ours == 1

label	var nid "Numéro d'inventaire"

preserve
keep	nid Création
split	Création, p(",")
drop	Création

reshape long Création, i(nid) j(n)
replace Création = ustrtrim(Création)

gen		disney = strpos(Création, "Disney") > 0

replace Création = "" if nid == "988.525" & n == 2
replace Création = "1940/1950" if nid == "48426.A" & n == 2
replace Création = "" if nid == "48426.A" & n == 3
replace Création = "1940/1950" if nid == "48426.B" & n == 2
replace Création = "" if nid == "48426.B" & n == 3
replace Création = "Allemagne/France" if nid == "992.36.1" & n == 1
replace Création = Création[_n+1] if nid == "992.36.1" & n == 2
replace Création = "" if nid == "992.36.1" & n == 3
replace Création = "Allemagne/France" if nid == "992.36.2" & n == 1
replace Création = Création[_n+1] if nid == "992.36.2" & n == 2
replace Création = "" if nid == "992.36.2" & n == 3
replace Création = "Allemagne/Grande-Bretagne" if nid == "993.157.2" & n == 1
replace Création = Création[_n+1] if nid == "993.157.2" & n == 2
replace Création = "" if nid == "993.157.2" & n == 3
replace Création = "France/Angleterre" if nid == "994.72.3" & n == 1
replace Création = Création[_n+1] if nid == "994.72.3" & n == 2
replace Création = "" if nid == "994.72.3" & n == 3
replace Création = Création[_n+1] if nid == "996.13.3" & n == 2
replace Création = "" if nid == "996.13.3" & n == 3
replace Création = "France" if nid == "993.133.1" & n == 3
replace Création = "1992" if nid == "993.133.1" & n == 4

replace Création = "France/Chine" if nid == "2008.35.2.1-8" & n == 3
replace Création = Création[_n+1] if nid == "2008.35.2.1-8" & n == 4

replace Création = "Corée/Etats-Unis" if nid == "988.1120.1" & n == 3
replace Création = Création[_n+1] if nid == "988.1120.1" & n == 4

replace Création = "Corée/Etats-Unis" if nid == "989.7" & n == 3
replace Création = Création[_n+1] if nid == "989.7" & n == 4

replace Création = "Corée/Etats-Unis" if nid == "991.385.1" & n == 3
replace Création = Création[_n+1] if nid == "991.385.1" & n == 4

replace Création = "Corée/Etats-Unis" if nid == "991.385.2" & n == 3
replace Création = Création[_n+1] if nid == "991.385.2" & n == 4

replace Création = "Chine/Etats-Unis" if nid == "993.116.3" & n == 3
replace Création = Création[_n+1] if nid == "993.116.3" & n == 4

replace Création = "Chine/Etats-Unis" if nid == "994.68" & n == 3
replace Création = Création[_n+1] if nid == "994.68" & n == 4

replace Création = "Allemagne/France" if nid == "988.1161" & n == 3
replace Création = Création[_n+1] if nid == "988.1161" & n == 4

replace Création = "Bearly There Inc." if nid == "992.385.1" & n == 1
replace Création = Création[_n+1] if nid == "992.385.1" & n > 1 & n < 5

replace Création = "1955/1960" if Création == "1955/1960 Noé"

replace Création = Création[_n+1] if nid == "988.515" & n == 4
replace Création = Création[_n+1] if nid == "988.900" & n == 4
replace Création = Création[_n+1] if nid == "988.901" & n == 4
replace Création = Création[_n+1] if nid == "993.124.1" & n == 4
replace Création = Création[_n+1] if nid == "993.133.2" & n == 4
replace Création = Création[_n+1] if nid == "993.69.3" & n == 4
replace Création = Création[_n+1] if nid == "49346" & n == 4


replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "47853", "49579", "51549", "55407", "55967", "56898", "57825.1", "57825.2", "987.890.1")
replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "988.1119", "988.179", "989.90", "991.409", "992.386.1", "992.439.1", "993.148.3", "993.149.1", "993.85")
replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "994.107.1", "994.119", "994.43", "994.62.2")

replace Création = Création[_n-1] if n == 4 & inlist(nid, "54445.2", "54941.1", "54941.2", "54941.3")
replace Création = "Angleterre" if n == 3 & inlist(nid, "54445.2", "54941.1", "54941.2", "54941.3")

replace Création = "Taïwan/Etats-Unis" if nid == "987.349" & n == 3
replace Création = Création[_n+1] if nid == "987.349" & n == 4

replace Création = "Chine/Etats-Unis" if nid == "991.408" & n == 3
replace Création = Création[_n+1] if nid == "991.408" & n == 4

replace Création = "Indonésie/Etats-Unis" if nid == "993.89.2" & n == 3
replace Création = Création[_n+1] if nid == "993.89.2" & n == 4

replace Création = "The Boyds Collection Ltd." if nid == "993.120.2" & n == 1
replace Création = "Fabricant" if nid == "993.120.2" & n == 2
replace Création = "Chine/Etats-Unis" if nid == "993.120.2" & n == 3
replace Création = "1990/1993" if nid == "993.120.2" & n == 4

replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "54445.2", "54941.1", "54941.2", "54941.3", "987.349", "988.1118", "988.180", "991.408", "993.111.1")

replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "993.131", "993.69.3", "993.84", "993.86", "993.89.2", "994.62.1", "994.81.1" , "43381", "49346")

replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "49697.B", "51363", "51363", "993.110", "993.120.3", "993.147", "994.127.1", "987.886", "988.637")

replace Création = substr(Création, 1, 4) if n == 4 & inlist(nid, "51457.B", "54445.1", "55406", "993.113.2")

replace Création = substr(Création, 1, 4) if n == 2 & inlist(nid, "991.413")
replace Création = "" if n > 2 & inlist(nid, "991.413")


insobs 1
replace nid = "993.150" if _n == _N
replace n = 4 if _n == _N
replace Création = "1994" if _n == _N

insobs 1
replace nid = "993.151.2" if _n == _N
replace n = 4 if _n == _N
replace Création = "1994" if _n == _N


drop	if Création == ""

replace Création = "Auteur" if Création == "Auteur ?"
replace Création = "1900 (vers)" if Création == "20e siècle (début)"

sort	nid n

gen		versp = strpos(Création, "(vers)") > 0
replace	versp = strpos(Création, "?") > 0
bys nid: egen vers = max(vers)
replace Création = subinstr(Création,"(vers)","",.)
replace Création = subinstr(Création,"?","",.)
replace Création = ustrtrim(Création)
drop versp

bys nid: egen m = max(n)

gen		année = ""
replace	année = Création if m == 1
replace année = Création if m == 2 & n == 2
replace année = Création if inlist(m, 4, 5, 6, 7, 8, 9, 10) & n == 4

gen		pays = ""
replace pays = Création if m == 2 & n == 1
replace pays = Création if inlist(m, 4, 5, 6, 7, 8, 9, 10) & n == 3

gen		créateur = ""
replace	créateur = Création if inlist(m, 4, 5, 6, 7, 8, 9, 10) & n == 1

gen		type = ""
replace type = Création if inlist(m, 4, 5, 6, 7, 8, 9, 10) & n == 2

foreach v in année pays créateur type {
gsort	nid -`v'
bys nid: replace `v' = `v'[_n-1] if _n != 1
}
keep	if n == 1
keep	nid année pays créateur type

save	to_merge, replace
restore

merge	1:1 nid using to_merge, nogen

drop	index Photographie Droits_auteur Personne_représentée Création
save	data_ours, replace
