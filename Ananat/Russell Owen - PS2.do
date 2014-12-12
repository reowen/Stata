clear
cd "C:\Users\Owner\Documents\Duke\Fall 2013\Stats\PS 2"
log using "work\PS2_output.txt", replace text
use "Assn2_March%2BCPS%2B05-06.dta"
set more off


/****Question 1****/

sum wkswork earnings unempinc if evacpost==1

/*health status*/

tab health if evacpost==1

/****question 2****/

gen y2006=.
replace y2006=1 if year==2006
replace y2006=0 if year==2005

gen male=.
replace male=1 if sex==1
replace male=0 if sex==2

global controlvars age black male hsgrad someco ba postgrad

foreach x in wkswork earnings unempinc health {
ttest `x' if everevac==1, by(year)
reg `x' y2006 $controlvars if everevac==1, cluster(persid)
}
/*health status*/

tab health y2006, chi2
reg health y2006 $controlvars, cluster(persid)
oprobit health y2006 $controlvars if everevac==1, cluster(persid)


/****Question 3****/

foreach x in wkswork earnings unempinc {
ttest `x' if year==2006, by(evacpost)
reg `x' evacpost $controlvars if year==2006, cluster(persid)
}
/*health status*/
tab health evacpost, chi2
reg health evacpost $controlvars if year==2006, cluster(persid)
oprobit health evacpost $controlvars if year==2006, cluster(persid)


/****Question 4****/

foreach x in wkswork earnings unempinc health {
reg `x' c.everevac#c.y2006 everevac y2006, cluster(persid)
outreg2 using Q4reg_`x'.xls, excel replace 
reg `x' c.everevac#c.y2006 everevac y2006 $controlvars, cluster(persid)
scalar X_`x'=_b[c.everevac#c.y2006]
outreg2 using Q4reg_`x'.xls, excel append
}
/*health status*/

reg health c.everevac#c.y2006 everevac y2006, cluster(persid)
reg health c.everevac#c.y2006 everevac y2006 $controlvars, cluster(persid)


/****Question 5****/

generate noncomp=1 if denier==1 | backhome==1
replace noncomp=0 if denier==0 & backhome==0


/**Part A**/  

foreach x in wkswork earnings unempinc health { 
reg `x' noncomp evacnow y2006 everevac $controlvars, cluster (persid)
outreg2 using Q5A.xls, excel append
}
/**Part B**/

reg evacnow everevac if year==2006 & denier==0
outreg2 using Q5B.xls, excel replace
scalar X_treat=_b[everevac]

/*the TOT effect: the numerator is the ceofficient on the interaction terms in question 4 for the controlled 
OLS regressions.  The denominator is the coefficient on "everevac" in the above regression*/
foreach x in wkswork earnings unempinc health {
di X_`x'/X_treat
}
log close
