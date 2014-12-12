log using "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\hwset4.log"

/******QUESTION #1******/
clear
set obs 100
set seed 123456
gen E1=rnormal(0,1)
gen E2=rnormal(0,1)
gen U=rnormal(0,1)
gen X1=E1+U
gen X2=E2+U

sum X1, detail
sum X2, detail
corr X1 X2

gen E=rnormal(0,1)
gen Y=(1*X1)+(2*X2)+E

/******Part A******/
reg Y X2
predict yhat
gen ehat=Y-yhat

reg X1 X2
predict X1hat
gen e2hat=X1-X1hat

reg ehat e2hat
reg Y e2hat
reg Y X1 X2

/******Part B******/

di 0.0806803^2 /*the variance of Beta 1*/
di 0.0802676^2 /*the variance of delta 1*/

di 0.0806803^2 /*the variance of Beta 1*/
di 0.289766^2 /*the variance of delta 2*/


/******Part C******/

/*"explain why the variance of delta 1 is greater than the variance of Beta 1"*/



/******QUESTION #2******/
clear
use "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\ps4.dta", clear

/***Part A***/
graph twoway (lfit iss_exper_cat educ) (scatter iss_exper_cat educ)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphA1.tif", replace
graph twoway (lfit iss_exper_cat cyear) (scatter iss_exper_cat cyear)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphA2.tif", replace

graph twoway (lfit iss_exper_cat cyear) (scatter iss_exper_cat cyear), by(educ)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphA3.tif", replace
/*largest rise in immigrant share was the 0-8 age group*/

/***Part B***/

reg lwage iss_exper_cat /*we conclude that as the immigrant share goes up by 1&, the avg log wage decreases by -1.684771 */

/***Part C***/
twoway (scatter lwage iss_exper_cat) (lfit lwage iss_exper_cat)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphC1.tif", replace
twoway scatter lwage iss_exper_cat, mlabel(educ)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphC2.tif", replace

/*what do the outliers represent?*/

/***Part D***/

xi: reg lwage i.cyear i.educ

/***Part E***/

/***Part F***/
/*intercept coefficient=average log wage for people with 0-8 years of education in the year 1960*/

/***Part G***/

xi: reg lwage iss_exper_cat i.educ i.cyear
avplot iss_exper_cat, mlabel(educ)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 4\graphG1.tif", replace
/*now, which observations are driving the regression coefficient on iss_exper_cat?*/

/***Part H***/
xi: reg lwage i.educ i.cyear
test _Icyear_1970 _Icyear_1980 _Icyear_1990 _Icyear_2000


log close
