clear
cd "C:\Users\Owner\Documents\Duke\Fall 2013\Stats\PS 4"
use "Assignment4.dta"

set more off

log using "work\RussellOwen_PS4_output.txt", replace text


/****Question 1****/
replace YOB=YOB+1900 if YOB<1900
sort YOB QOB
by YOB QOB: egen EDUC2 = mean(EDUC)
gen yearQOB=YOB*10+QOB

/*Quarter 4 data points are marked by squares*/
twoway (scatter EDUC2 yearQOB if QOB!=4 & YOB>=1930, sort msymbol(circle)) (scatter EDUC2 yearQOB if QOB==4 & YOB>=1930, sort msymbol(square)) (line EDUC2 yearQOB if YOB>=1930)



/****Question 2****/

xi: reg LWKLYWGE EDUC i.YOB if YOB>=1930 & YOB<=1939
outreg2 using "work\Q2_reg.xls", excel replace

xi: ivregress 2sls LWKLYWGE i.YOB (EDUC = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q2_reg.xls", excel append
estat firststage


/*chi-squared statistic*/
predict Z, resid
xi: reg Z i.YOB i.QOB*i.YOB if YOB>=1930 & YOB<=1939 
di e(r2)*e(N)


/****QUESTION 3****/
/*This is stage one of the 2SLS regression from Question #2*/
xi: reg EDUC i.YOB i.YOB*i.QOB if YOB>=1930 & YOB<=1939
outreg2 using "work\Q3_reg.xls", excel replace


/****Question 4****/

xi: ivregress liml LWKLYWGE i.YOB (EDUC = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q2_reg.xls", excel append //just putting the liml next to the 2sls from Q2 in one table


/****QUESTION 5****/

gen HSgrad=0
replace HSgrad=1 if EDUC>=12

/*OLS*/
xi: reg LWKLYWGE HSgrad i.YOB if YOB>=1930 & YOB<=1939
outreg2 using "work\Q5_reg.xls", excel replace
/*2SLS*/
xi: ivregress 2sls LWKLYWGE i.YOB (HSgrad = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q5_reg.xls", excel append
/*liml*/
xi: ivregress liml LWKLYWGE i.YOB (HSgrad = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q5_reg.xls", excel append

/*F-test on the instruments of our first-stage 2sls regression*/
xi: reg HSgrad i.YOB i.YOB*i.QOB if YOB>=1930 & YOB<=1939
outreg2 using "work\Q5_IVtest.xls", excel replace

/****QUESTION 6****/

gen COLLEGEgrad=0
replace COLLEGEgrad=1 if EDUC>=16 //we're assuming 4 years of college means you've graduated

/*OLS*/
xi: reg LWKLYWGE COLLEGEgrad i.YOB if YOB>=1930 & YOB<=1939
outreg2 using "work\Q6_reg.xls", excel replace
/*2SLS*/
xi: ivregress 2sls LWKLYWGE i.YOB (COLLEGEgrad = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q6_reg.xls", excel append
/*liml*/
xi: ivregress liml LWKLYWGE i.YOB (COLLEGEgrad = i.QOB*i.YOB) if YOB>=1930 & YOB<=1939
outreg2 using "work\Q6_reg.xls", excel append

/*F-test on the instruments of our first-stage 2sls regression*/
xi: reg COLLEGEgrad i.YOB i.YOB*i.QOB if YOB>=1930 & YOB<=1939
xi: test i.YOB*i.QOB
outreg2 using "work\Q6_IVtest.xls", excel replace

log close
