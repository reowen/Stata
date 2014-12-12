clear
set more off
log using "C:\Users\Owner\Documents\duke\Fall 2012\Stats\Problem Sets\Problem Set 6\hwset6.log"

use "C:\Users\Owner\Documents\Duke\Fall 2012\Stats\Problem Sets\Problem Set 6\Angrist_Kruger1991.dta" 

/****QUESTION 1****/

replace YOB=YOB+1900 if YOB<1900
collapse EDUC, by(YOB QOB)
gen yearQOB=YOB*10+QOB

/*Quarter 4 data points are marked by squares*/
twoway (scatter EDUC yearQOB if QOB!=4 & YOB>=1930, sort msymbol(circle)) (scatter EDUC yearQOB if QOB==4 & YOB>=1930, sort msymbol(square)) (line EDUC yearQOB if YOB>=1930)
graph export "C:\Users\Owner\Documents\duke\Fall 2012\Stats\Problem Sets\Problem Set 6\graph1.pdf", replace

/****QUESTION 2****/
clear
use "C:\Users\Owner\Documents\Duke\Fall 2012\Stats\Problem Sets\Problem Set 6\Angrist_Kruger1991.dta" 
gen QOB_first=0
replace QOB_first=1 if QOB==1

tab QOB_first if YOB>=30 & YOB<=39, sum(LWKLYWGE)
tab QOB_first if YOB>=30 & YOB<=39, sum(EDUC)

/*difference in means and t-tests, using regressions*/
reg EDUC QOB_first if YOB>=30 & YOB<=39
/*men born in the first quarter between 1930-1940 have, on average, 0.1088 less years of education than men born in later quarters*/
/*the t-test on this coefficient (|-8.22|>1.96) shows that the difference is statistically significant..that is, we reject that the difference in education should be "zero"*/

reg LWKLYWGE QOB_first if YOB>=30 & YOB<=39
/*people born in the first quarter between 1930-1940 earn, on average, 1.1% less per week than men born in later quarters*/
/*the t-test on this coefficient (|-4.05|>1.96) shows that the difference is statistically significant...that is, we reject that the difference in earnings should be "zero"*/

/*WALD*/
di (-.0110989 )/(-.1088179 )
ivregress 2sls LWKLYWGE (EDUC = QOB_first) if YOB>=30 & YOB<=39 

/*OLS*/
reg LWKLYWGE EDUC if YOB>=30 & YOB<=39
/*the estimate in Table III was 0.0709 with SE of 0.0003*/


/****QUESTION 3****/

xi: reg LWKLYWGE EDUC i.YOB if YOB>=30 & YOB<=39
/*column (1) estimated a coefficient of 0.0711 with a SE of 0.0003*/
xi: ivregress 2sls LWKLYWGE i.YOB (EDUC = i.QOB*i.YOB) if YOB>=30 & YOB<=39
/*column (2) estimated a coefficient of 0.0891 with a SE of 0.0161*/

/*chi-squared statistic*/
predict Z, resid
xi: reg Z i.YOB i.QOB*i.YOB if YOB>=30 & YOB<=39 
di e(r2)*e(N)

/*This statistics is calculated as the sample size times the R squared from a regression of the residuals from the TSLS equation on the 
exogenous variables and instruments.*/

/****QUESTION 4****/
/*This is stage one of the 2SLS regression from Question #3*/
xi: reg EDUC i.YOB i.YOB*i.QOB if YOB>=30 & YOB<=39


/****QUESTION 5****/

gen HSgrad=0
replace HSgrad=1 if EDUC>=12

reg HSgrad QOB_first if YOB>=30 & YOB<=39
/*from this regression, we can see that men born in the 1st quarter between 1930-1940 were 1.2% less likely to graduate high school*/

/*OLS*/
reg LWKLYWGE HSgrad if YOB>=30 & YOB<=39
/*this says that high school graduates earned 39.5% more per week than high school dropouts*/

/*2SLS*/
ivregress 2sls LWKLYWGE (HSgrad = QOB_first) if YOB>=30 & YOB<=39



log close
