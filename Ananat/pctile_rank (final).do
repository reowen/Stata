clear 
set more off
cd "C:\Users\Owner\Documents\Duke\Fall 2013\Stats"
use "PS 1\PS1.dta"

gen mathsm=gktmaths
replace mathsm=. if gkclasst==2 | gkclasst==3
gen mathreg=gktmaths
replace mathreg=. if gkclasst==1 

gen readsm=gktreads
replace readsm=. if gkclasst==2 | gkclasst==3
gen readreg=gktreads
replace readreg=. if gkclasst==1

gen listsm=gktlists
replace listsm=. if gkclasst==2 | gkclasst==3
gen listreg=gktlists
replace listreg=. if gkclasst==1

gen wordsm=gkwordsk
replace wordsm=. if gkclasst==2 | gkclasst==3
gen wordreg=gkwordsk
replace wordreg=. if gkclasst==1

gen pctile_wordsm=.
gen pctile_listsm=.
gen pctile_mathsm=.
gen pctile_readsm=.

forvalues num=10000/21600 {

/*reading*/

quietly gen read_dist_`num'=readreg
quietly replace read_dist_`num'=gktreads if stdntid==`num'

quietly egen n = count(read_dist_`num') 
quietly egen i = rank(read_dist_`num')
quietly gen X = (i - 0.5) / n
quietly gen pctile_read_`num'=X*100
quietly drop X n i

quietly replace pctile_readsm=pctile_read_`num' if stdntid==`num'
quietly drop read_dist_`num' pctile_read_`num'

/*math*/

quietly gen math_dist_`num'=mathreg
quietly replace math_dist_`num'=gktmaths if stdntid==`num'

quietly egen n = count(math_dist_`num') 
quietly egen i = rank(math_dist_`num')
quietly gen X = (i - 0.5) / n
quietly gen pctile_math_`num'=X*100
quietly drop X n i

quietly replace pctile_mathsm=pctile_math_`num' if stdntid==`num'
quietly drop math_dist_`num' pctile_math_`num'

/*listening*/

quietly gen list_dist_`num'=listreg
quietly replace list_dist_`num'=gktlists if stdntid==`num'

quietly egen n = count(list_dist_`num') 
quietly egen i = rank(list_dist_`num')
quietly gen X = (i - 0.5) / n
quietly gen pctile_list_`num'=X*100
quietly drop X n i

quietly replace pctile_listsm=pctile_list_`num' if stdntid==`num'
quietly drop list_dist_`num' pctile_list_`num'

/*word study skillz*/

quietly gen word_dist_`num'=wordreg
quietly replace word_dist_`num'=gkwordsk if stdntid==`num'

quietly egen n = count(word_dist_`num') 
quietly egen i = rank(word_dist_`num')
quietly gen X = (i - 0.5) / n
quietly gen pctile_word_`num'=X*100
quietly drop X n i

quietly replace pctile_wordsm=pctile_word_`num' if stdntid==`num'
quietly drop word_dist_`num' pctile_word_`num'

}


/*math*/

egen n = count(gktmaths) if gkclasst==2 | gkclasst==3
egen i = rank(gktmaths) if gkclasst==2 | gkclasst==3
gen X = (i - 0.5) / n
gen pctile_mathreg=X*100 
drop n i X

gen pctile_math=pctile_mathreg
replace pctile_math=pctile_mathsm if pctile_mathsm!=.

/*read*/

egen n = count(gktreads) if gkclasst==2 | gkclasst==3
egen i = rank(gktreads) if gkclasst==2 | gkclasst==3
gen X = (i - 0.5) / n
gen pctile_readreg=X*100
drop X n i

gen pctile_read=pctile_readreg
replace pctile_read=pctile_readsm if pctile_readsm!=.

/*listening*/

egen n = count(gktlists) if gkclasst==2 | gkclasst==3
egen i = rank(gktlists) if gkclasst==2 | gkclasst==3
gen X = (i - 0.5) / n
gen pctile_listreg=X*100
drop X n i

gen pctile_list=pctile_listreg
replace pctile_list=pctile_listsm if pctile_listsm!=.

/*word study skillz*/

egen n = count(gkwordsk) if gkclasst==2 | gkclasst==3
egen i = rank(gkwordsk) if gkclasst==2 | gkclasst==3
gen X = (i - 0.5) / n
gen pctile_wordreg=X*100
drop X n i

gen pctile_word=pctile_wordreg
replace pctile_word=pctile_wordsm if pctile_wordsm!=.

/*total percentile score*/

gen pctile_score=pctile_math+pctile_list+pctile_read+pctile_word
replace pctile_score=pctile_score/4



save "PS 1\PS1_pctile.dta"


