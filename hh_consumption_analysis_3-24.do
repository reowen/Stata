clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Empirical Exercise 1\PPS608_empex2_HHcons.dta"

set more off

log using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Empirical Exercise 1\Work\RussellOwen_EmpEx1_output.txt", replace text

global demogs AD00_04 AD05_09 AD10_14 AD15_19 AD20_24 AD25_29 AD30_34 AD35_39 AD40_44 AD45_49 AD50_54 AD55_59 AD60_64 AD65_pl
global splines lc02_spline1 lc02_spline2 lc02_spline3 lc02_spline4 lc02_spline5

cd "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Empirical Exercise 1\Work\tables\raw\HH"
/*Part 1*/

/*EQ 1*/
reg Smeat_dairy02 lc02 $demogs
outreg2 using HH_initial_regressions.xls, excel replace

/*EQ 2*/
reg Smeat_dairy02 $splines $demogs
outreg2 using HH_initial_regressions.xls, excel append
reg Tmeatmlk02 $splines $demogs FLAG_freq02

/*EQ 3*/
areg Smeat_dairy02 $splines $demogs, absorb(locID)
outreg2 using HH_initial_regressions.xls, excel append

areg Tmeatmlk02 $splines $demogs, absorb(locID)
outreg2 using HH_initial_regressions.xls, excel append

/***************************************/
/*******Part 1: HH-level analysis*******/
/***************************************/

global goods Scoke02 Sfish_chx02 Smeat_dairy02 Sfrt_veg02 Smale02 Sfems02

gen fAD00_04 = AD00_04 - mAD00_04
gen fAD05_09 = AD05_09 - mAD05_09
gen fAD10_14 = AD10_14 - mAD10_14
gen fAD15_19 = AD15_19 - mAD15_19
gen fAD20_24 = AD20_24 - mAD20_24
gen fAD25_29 = AD25_29 - mAD25_29
gen fAD30_34 = AD30_34 - mAD30_34
gen fAD35_39 = AD35_39 - mAD35_39
gen fAD40_44 = AD40_44 - mAD40_44
gen fAD45_49 = AD45_49 - mAD45_49
gen fAD50_54 = AD50_54 - mAD50_54
gen fAD55_59 = AD55_59 - mAD55_59
gen fAD60_64 = AD60_64 - mAD60_64
gen fAD65_pl = AD65_pl - mAD65_pl

/*question 1*/
global Mdemogs mAD00_04 mAD05_09 mAD10_14 mAD15_19 mAD20_24 mAD25_29 mAD30_34 mAD35_39 mAD40_44 mAD45_49 mAD50_54 mAD55_59 mAD60_64 mAD65_pl
global Fdemogs fAD00_04 fAD05_09 fAD10_14 fAD15_19 fAD20_24 fAD25_29 fAD30_34 fAD35_39 fAD40_44 fAD45_49 fAD50_54 fAD55_59 fAD60_64 fAD65_pl
foreach y in $goods {
areg `y' $Mdemogs $splines FLAG_freq02, absorb(locID)
if `y' == Scoke02{
outreg2 using HH_tables_demogs.xls, excel replace
}
else{
outreg2 using HH_tables_demogs.xls, excel append
}
areg `y' $Fdemogs $splines FLAG_freq02, absorb(locID)
outreg2 using HH_tables_demogs.xls, excel append
}

/*question 2*/
global educs fED00_00 fED01_03 fED04_06 fED07_09 fED10_15 fED16_pl mED00_00 mED01_03 mED04_06 mED07_09 mED10_15 mED16_pl
foreach y in $goods {
areg `y' $educs $splines $demogs FLAG_freq02 cohabit, absorb(locID)
if `y' == Scoke02{
outreg2 using HH_tables_educs.xls, excel replace
}
else{
outreg2 using HH_tables_educs.xls, excel append
}
}

/*question 3*/

gen fEDUC_10 = .
replace fEDUC_10 = 1 if fEDUCyrs >= 10
replace fEDUC_10 = 0 if fEDUCyrs < 10

gen mEDUC_10 = .
replace mEDUC_10 = 1 if mEDUCyrs >= 10
replace mEDUC_10 = 0 if mEDUCyrs < 10

areg Sfrt_veg02 fEDUC_10 mEDUC_10 $splines $demogs FLAG_freq02 cohabit, absorb(locID)
outreg2 using women_educated_fruitsandveggies.xls, excel replace

/*question 4*/
foreach y in $goods{
areg `y' fDECIDEself fEDUCyrs mEDUCyrs $splines $demogs FLAG_freq02, absorb(locID)
if `y' == Scoke02{
outreg2 using HH_tables_bargaining.xls, excel replace
}
else{
outreg2 using HH_tables_bargaining.xls, excel append
}
areg `y' fDECIDEself mDECIDEsps mDECIDEself fDECIDEsps fEDUCyrs mEDUCyrs $splines $demogs FLAG_freq02, absorb(locID)
outreg2 using HH_tables_bargaining.xls, excel append
}

/*question 5*/

/*a*/ 
sum oport02
tab oport02 urbanity, sum(oport02M) nost
tabout oport02 urbanity using progressa_enrollment, replace
tabout oport02M urbanity using progressa_enrollment_male, replace

/*b*/
areg oport02 $splines $demogs cohabit, absorb(locID)
outreg2 using progressa_prediction.xls, excel replace

/*c*/
foreach y in $goods{
areg `y' oport02 $educs $splines $demogs FLAG_freq02, absorb(locID)
if `y' == Scoke02{
outreg2 using progressa_consumption.xls, excel replace
}
else{
outreg2 using progressa_consumption.xls, excel append
}
}

/******************************************************/
/*******Part 2: Analyzing Marriage and Fertility*******/
/******************************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Empirical Exercise 1\PPS608_empex2_INchar.dta"

set more off

cd "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Empirical Exercise 1\Work\tables\raw\Indiv"

/*EQ 1*/

reg age05 S05age05
outreg2 using initial_indiv_regs.xls, excel replace

/*EQ 2*/

/*(men only) husband's age against wife's*/ reg age05 S05age05 if male == 1
outreg2 using initial_indiv_regs.xls, excel append
/*(men only) wife's age against husband's*/ reg S05age05 age05 if male == 1
outreg2 using initial_indiv_regs.xls, excel append
/*(women only) wife's age against husband's*/ reg age05 S05age05 if male == 0
outreg2 using initial_indiv_regs.xls, excel append

/*EQ 3*/

mkspline YOA1 22 YOA2 35 YOA3 40 YOA4 65 YOA5 = age05 if age05>=15
mkspline sYOA1 22 sYOA2 35 sYOA3 40 sYOA4 65 sYOA5 = S05age05 if age05>=15

global splines YOA1 YOA2 YOA3 YOA4 YOA5 sYOA1 sYOA2 sYOA3 sYOA4 sYOA5

reg EDUCyrs05 S05EDUCyrs05 $splines
outreg2 using initial_educ_regs.xls, excel replace

/*question 1*/
quietly gen tallMAN = .
quietly sum height if male == 1, detail
quietly replace tallMAN = 1 if height > r(p75) & male == 1
quietly replace tallMAN = 0 if height <= r(p75) & male == 1

quietly gen tallWOMAN = .
quietly sum height if male == 0, detail
quietly replace tallWOMAN = 1 if height > r(p75) & male == 0
quietly replace tallWOMAN = 0 if height <= r(p75) & male == 0

quietly gen tallWIFE = .
quietly sum S05height if male == 1, detail
quietly replace tallWIFE = 1 if S05height > r(p75) & male == 1
quietly replace tallWIFE = 0 if S05height <= r(p75) & male == 1

quietly gen tallHUSB = .
quietly sum S05height if male == 0, detail
quietly replace tallHUSB = 1 if S05height > r(p75) & male == 0
quietly replace tallHUSB = 0 if S05height <= r(p75) & male == 0


tab tallMAN, sum(tallWIFE)
reg tallWIFE tallMAN
outreg2 using height_diagnostics.xls, excel replace

tab tallWOMAN, sum(tallHUSB)
reg tallHUSB tallWOMAN
outreg2 using height_diagnostics.xls, excel append

/*question 2*/
gen marry_after_2002 = .
replace marry_after_2002 = 0 if marry02 == 5
replace marry_after_2002 = 1 if marry02 != 5 & marry05 == 5

areg EDUCyrs05 S05EDUCyrs05 proxy05 $splines if marry_after_2002 == 1 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel replace
areg EDUCyrs05 S05EDUCyrs05 proxy05 $splines if marry_after_2002 == 1 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel append
areg EDUCyrs05 S05EDUCyrs05 proxy05 $splines if marry_after_2002 == 0 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel replace
areg EDUCyrs05 S05EDUCyrs05 proxy05 $splines if marry_after_2002 == 0 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel append

areg age05 S05age05 if marry_after_2002 == 1 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel append
areg age05 S05age05 if marry_after_2002 == 1 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel append
areg age05 S05age05 if marry_after_2002 == 0 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel append
areg age05 S05age05 if marry_after_2002 == 0 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel append

areg height S05height if marry_after_2002 == 1 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel append
areg height S05height if marry_after_2002 == 1 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_after_2002.xls, excel append
areg height S05height if marry_after_2002 == 0 & male == 1, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel append
areg height S05height if marry_after_2002 == 0 & male == 0, absorb(hhid05)
outreg2 using educ_marriage_before_2002.xls, excel append

/*******************************************************/
/*Fertility, Child Health, and Parents' Characteristics*/
/*******************************************************/

/*question 1*/
global educ ED09p_05 ED12p_05

foreach y in FERTaddl CNTRcuruse CNTR_any{
areg `y' EDUCyrs05 CEB_TOTAL proxy05 $splines if male == 0, absorb(hhid05)
if `y' == FERTaddl{
outreg2 using fertility_regs.xls, excel replace
}
else{
outreg2 using fertility_regs.xls, excel append
}
areg `y' $educ CEB_TOTAL proxy05 $splines if male == 0, absorb(hhid05)
outreg2 using fertility_regs.xls, excel append
areg `y' EDUCyrs05 S05EDUCyrs05 CEB_TOTAL $splines if male == 0, absorb(hhid05)
outreg2 using fertility_regs.xls, excel append
}

/*question 2*/
areg CEB_TOTAL EDUCyrs05 S05EDUCyrs05 proxy05 $splines if male == 0, absorb(hhid05)
outreg2 using total_children_regs.xls, excel replace
areg CEB_TOTAL $educ S05EDUCyrs05 proxy05 $splines if male == 0, absorb(hhid05)
outreg2 using total_children_regs.xls, excel append

/*question 3*/
reg haz MOMheight DADheight
outreg2 using haz_regs.xls, excel replace

/*question 4*/
gen married = 1 if marry05 == 5
replace married = 0 if marry05 != 5

foreach y in haz laz whz wlz{
areg `y' MOMheight DADheight MOMEDUCyrs05 MOMage05, absorb(hhid05)
if `y' == haz{
outreg2 using Q4_regs.xls, excel replace
}
else{
outreg2 using Q4_regs.xls, excel append
}
}

/*question 5*/
foreach y in haz laz whz wlz{
areg `y' DADIDd MOMheight DADheight DADage05 DADEDUCyrs05, absorb(hhid05)
if `y' == haz{
outreg2 using Q5_regs.xls, excel replace
}
else{
outreg2 using Q5_regs.xls, excel append
}
}

foreach y in haz laz whz wlz{
areg `y' DADIDd, absorb(hhid05)
if `y' == haz{
outreg2 using new_Q5_regs.xls, excel replace
}
else{
outreg2 using new_Q5_regs.xls, excel append
}
}

foreach y in haz laz whz wlz{
areg `y' MOMheight DADheight MOMEDUCyrs05 DADEDUCyrs05 MOMage05 DADage05, absorb(hhid05)
if `y' == haz{
outreg2 using newer_Q5_regs.xls, excel replace
}
else{
outreg2 using newer_Q5_regs.xls, excel append
}
}


log close
