
clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta"

log using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\Russell_Owen_log.txt", text replace

set more off

//restrict to Kigali
drop if province != 1

//total (and share of) expenditures on food
egen food_exp = rowtotal(TgrainWK TflourWK TpastaWK TbreadWK TmeatWK TpoulWK TfishWK ///
TdairyWK ToilsWK TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK)

//total (and share of) adult expenditures
egen adult_exp = rowtotal(TleisM TmCareM TwCareM TCareM TtobM TcommM sh_TalchWK_m)

gen sh_adult = adult_exp / total_exp
replace sh_adult = . if sh_school_exp_HH == 1

gen sh_food = food_exp / total_exp
replace sh_food = . if sh_school_exp_HH == 1

//HH_size, per-capita exp

egen HH_size = rowtotal(AD75p AD70_74 AD65_69 AD60_64 AD55_59 AD50_54 AD45_49 AD40_44 ///
AD35_39 AD30_34 AD25_29 AD20_24 AD15_19 AD10_14 AD05_09 AD00_04)
gen lnHH_size = ln(HH_size)

gen percap_exp = total_exp / HH_size
replace percap_exp = . if sh_school_exp_HH == 1
gen ln_exp = ln(percap_exp)

egen adults = rowtotal(AD75p AD70_74 AD65_69 AD60_64 AD55_59 AD50_54 AD45_49 AD40_44 ///
AD35_39 AD30_34 AD25_29 AD20_24)

egen highschool = rowtotal(AD20_24 AD15_19)

egen primary = rowtotal(AD10_14 AD05_09)

gen child = AD00_04

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH_Kigali.dta", replace

/*************************************************************************************/
/********************************Food Share (Engel Method)****************************/
/*************************************************************************************/

cd "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\tables\raw"

areg sh_food ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using engel_regs.xls, excel replace

//equivalence scale: one young child
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(1 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))


/******************************************************************************/
/********************************ROTHBARTH METHOD******************************/
/******************************************************************************/

//SHARE OF TOTAL ADULT
areg sh_adult ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using engel_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(1 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

/**************************************************************************/
/********************ALCOHOL AND TOBACCO ONLY******************************/
/**************************************************************************/

//Alcohol and tobacco together
gen sh_alctob = (TalchWK + TtobM) / total_exp
areg sh_alctob ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using engel_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(1 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//Alcohol
areg sh_TalchWK_m ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using engel_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(1 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

/*************************/
/******LEISURE ONLY*******/
/*************************/

//LEISURE
areg sh_TleisM_m ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using engel_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(1 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[child] / _b[ln_exp])*(0 - 0) + (_b[primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

/***************************/
/****TESTING ADULT GOODS****/
/***************************/

areg sh_alctob ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using adult_goods.xls, excel replace

foreach y in sh_TleisM_m sh_TmCareM_m sh_TwCareM_m sh_TCareM_m{
areg `y' ln_exp lnHH_size adults highschool primary child MOMeduc DADeduc, absorb(district)
outreg2 using adult_goods.xls, excel append
}

/**********************************************************/
/**********DISAGREGATE THE SCALES BY SEX*******************/
/**********************************************************/

egen f_adult = rowtotal(fAD25_29 fAD30_34 fAD35_39 fAD40_44 fAD45_49 fAD50_54 fAD55_59 ///
fAD60_64 fAD65_69 fAD70_74 fAD75p)

egen m_adult = rowtotal(mAD75p mAD25_29 mAD30_34 mAD35_39 mAD40_44 mAD45_49 mAD50_54 ///
mAD55_59 mAD60_64 mAD65_69 mAD70_74)

gen m_child = mAD00_04 
gen f_child = fAD00_04 

egen m_primary = rowtotal(mAD05_09 mAD10_14) 
egen f_primary = rowtotal(fAD05_09 fAD10_14)

egen m_highschool = rowtotal(mAD15_19 mAD20_24)  
egen f_highschool = rowtotal(fAD15_19 fAD20_24)

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH_Kigali.dta", replace

/*************************************************************************************/
/********************************Food Share (Engel Method)****************************/
/*************************************************************************************/

areg sh_food ln_exp lnHH_size adults m_highschool m_primary m_child MOMeduc DADeduc, absorb(district)
outreg2 using engel_disag_regs.xls, excel replace

//equivalence scale: one young child
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(1 - 0) + (_b[m_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(0 - 0) + (_b[m_primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(0 - 0) + (_b[m_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

areg sh_food ln_exp lnHH_size adults f_highschool f_primary f_child MOMeduc DADeduc, absorb(district)
outreg2 using engel_disag_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(1 - 0) + (_b[f_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(0 - 0) + (_b[f_primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(0 - 0) + (_b[f_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

/******************************************************************************/
/********************************ROTHBARTH METHOD******************************/
/******************************************************************************/

//SHARE OF TOTAL ADULT
areg sh_adult ln_exp lnHH_size adults m_highschool m_primary m_child MOMeduc DADeduc, absorb(district)
outreg2 using engel_disag_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(1 - 0) + (_b[m_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(0 - 0) + (_b[m_primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[m_child] / _b[ln_exp])*(0 - 0) + (_b[m_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[m_highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

areg sh_adult ln_exp lnHH_size adults f_highschool f_primary f_child MOMeduc DADeduc, absorb(district)
outreg2 using engel_disag_regs.xls, excel append

//equivalence scale: one young child
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(1 - 0) + (_b[f_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one primary school
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(0 - 0) + (_b[f_primary] / _b[ln_exp])*(1 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(0 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

//one high school
di (3 / 2)*exp((_b[f_child] / _b[ln_exp])*(0 - 0) + (_b[f_primary] / _b[ln_exp])*(0 - 0) ///
+ (_b[f_highschool] / _b[ln_exp])*(1 - 0) + (_b[adults] / _b[ln_exp])*(2 - 2))

/*********************************/
tab district, sum(HH_size)
tab district, sum(percap_exp)
tab district, sum(sh_food)
tab district, sum(sh_adult)
tab district, sum(sh_alctob)

/*********************************/


/****GENDER ANALYSIS****/

//NONFOOD REGRESSIONS
areg HH_hrs_hwork adults m_highschool m_primary m_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_male_nonfood.xls, excel replace
foreach y in sh_school_exp_HH_m sh_ThealthM_m{
areg `y' adults m_highschool m_primary m_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_male_nonfood.xls, excel append
}

areg HH_hrs_hwork adults f_highschool f_primary f_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_female_nonfood.xls, excel replace
foreach y in sh_school_exp_HH_m sh_ThealthM_m{
areg `y' adults f_highschool f_primary f_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_female_nonfood.xls, excel append
}

//FOOD REGRESSIONS
areg sh_TmeatWK_m adults m_highschool m_primary m_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_male_food.xls, excel replace
foreach y in sh_TdairyWK_m sh_TfruitWK_m sh_TvegWK_m sh_TsugWK_m sh_TcandyWK_m sh_TbabyWK_m sh_TsodaWK_m{
areg `y' adults m_highschool m_primary m_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_male_food.xls, excel append
} 

areg sh_TmeatWK_m adults f_highschool f_primary f_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_female_food.xls, excel replace
foreach y in sh_TdairyWK_m sh_TfruitWK_m sh_TvegWK_m sh_TsugWK_m sh_TcandyWK_m sh_TbabyWK_m sh_TsodaWK_m{
areg `y' adults f_highschool f_primary f_child MOMeduc DADeduc quintile ln_exp lnHH_size, absorb(district)
outreg2 using gender_female_food.xls, excel append
}

log close
