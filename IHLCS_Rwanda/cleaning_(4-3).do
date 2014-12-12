clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\roster.dta"

/*****************/
/****section 1****/
/*****************/

rename s1q1 sex
label var sex "=1 if male, =2 if female"
rename s1q2 fam_member
label var fam_member "parental/child status"

gen sHH_head_fem = 1 if fam_member == 1 & sex == 2
replace sHH_head_fem = 0 if fam_member != 1 | sex != 2

sort hhid
by hhid: egen HH_head_fem = max(sHH_head_fem)
replace HH_head_fem = 0 if sHH_head_fem == . & fam_member != 1 & fam_member != .
drop sHH_head_fem
label var HH_head_fem "=1 if HH head is a woman"


gen age = s1q3y
replace age = s1q3y + (s1q3m / 12) if s1q3m != .
label var age "age in years"

global ages AD00_04 AD05_09 AD10_14 AD15_19 AD20_24 AD25_29 AD30_34 ///
AD35_39 AD40_44 AD45_49 AD50_54 AD55_59 AD60_64 AD65_69 AD70_74 AD75p

sort hhid

by hhid: egen sAD00_04 = count(age) if age <=4
by hhid: egen smAD00_04 = count(age) if age <=4 & sex == 1
by hhid: egen sfAD00_04 = count(age) if age <=4 & sex == 2
by hhid: egen AD00_04 = max(sAD00_04)
by hhid: egen mAD00_04 = max(smAD00_04)
by hhid: egen fAD00_04 = max(sfAD00_04)
replace AD00_04 = 0 if AD00_04 == . & age != .
replace mAD00_04 = 0 if mAD00_04 == . & age != .
replace fAD00_04 = 0 if fAD00_04 == . & age != .

by hhid: egen sAD05_09 = count(age) if age >= 5 & age <= 9
by hhid: egen smAD05_09 = count(age) if age >= 5 & age <= 9 & sex == 1
by hhid: egen sfAD05_09 = count(age) if age >= 5 & age <= 9 & sex == 2
by hhid: egen AD05_09 = max(sAD05_09)
by hhid: egen mAD05_09 = max(smAD05_09)
by hhid: egen fAD05_09 = max(sfAD05_09)
replace AD05_09 = 0 if AD05_09 == . & age != .
replace mAD05_09 = 0 if mAD05_09 == . & age != .
replace fAD05_09 = 0 if fAD05_09 == . & age != .

by hhid: egen sAD10_14 = count(age) if age >= 10 & age <= 14
by hhid: egen smAD10_14 = count(age) if age >= 10 & age <= 14 & sex == 1
by hhid: egen sfAD10_14 = count(age) if age >= 10 & age <= 14 & sex == 2
by hhid: egen AD10_14 = max(sAD10_14)
by hhid: egen mAD10_14 = max(smAD10_14)
by hhid: egen fAD10_14 = max(sfAD10_14)
replace AD10_14 = 0 if AD10_14 == . & age != .
replace mAD10_14 = 0 if mAD10_14 == . & age != .
replace fAD10_14 = 0 if fAD10_14 == . & age != .

by hhid: egen sAD15_19 = count(age) if age >= 15 & age <= 19
by hhid: egen smAD15_19 = count(age) if age >= 15 & age <= 19 & sex == 1
by hhid: egen sfAD15_19 = count(age) if age >= 15 & age <= 19 & sex == 2
by hhid: egen AD15_19 = max(sAD15_19)
by hhid: egen mAD15_19 = max(smAD15_19)
by hhid: egen fAD15_19 = max(sfAD15_19)
replace AD15_19 = 0 if AD15_19 == . & age != .
replace mAD15_19 = 0 if mAD15_19 == . & age != .
replace fAD15_19 = 0 if fAD15_19 == . & age != .

by hhid: egen sAD20_24 = count(age) if age >= 20 & age <= 24
by hhid: egen smAD20_24 = count(age) if age >= 20 & age <= 24 & sex == 1
by hhid: egen sfAD20_24 = count(age) if age >= 20 & age <= 24 & sex == 2
by hhid: egen mAD20_24 = max(smAD20_24)
by hhid: egen fAD20_24 = max(sfAD20_24)
by hhid: egen AD20_24 = max(sAD20_24)
replace AD20_24 = 0 if AD20_24 == . & age != .
replace mAD20_24 = 0 if mAD20_24 == . & age != .
replace fAD20_24 = 0 if fAD20_24 == . & age != .

by hhid: egen sAD25_29 = count(age) if age >= 25 & age <= 29
by hhid: egen smAD25_29 = count(age) if age >= 25 & age <= 29 & sex == 1
by hhid: egen sfAD25_29 = count(age) if age >= 25 & age <= 29 & sex == 2
by hhid: egen AD25_29 = max(sAD25_29)
by hhid: egen mAD25_29 = max(smAD25_29)
by hhid: egen fAD25_29 = max(sfAD25_29)
replace AD25_29 = 0 if AD25_29 == . & age != .
replace mAD25_29 = 0 if mAD25_29 == . & age != .
replace fAD25_29 = 0 if fAD25_29 == . & age != .

by hhid: egen sAD30_34 = count(age) if age >= 30 & age <= 34
by hhid: egen smAD30_34 = count(age) if age >= 30 & age <= 34 & sex == 1
by hhid: egen sfAD30_34 = count(age) if age >= 30 & age <= 34 & sex == 2
by hhid: egen AD30_34 = max(sAD30_34)
by hhid: egen mAD30_34 = max(smAD30_34)
by hhid: egen fAD30_34 = max(sfAD30_34)
replace AD30_34 = 0 if AD30_34 == . & age != .
replace mAD30_34 = 0 if mAD30_34 == . & age != .
replace fAD30_34 = 0 if fAD30_34 == . & age != .

by hhid: egen sAD35_39 = count(age) if age >= 35 & age <= 39
by hhid: egen smAD35_39 = count(age) if age >= 35 & age <= 39 & sex == 1
by hhid: egen sfAD35_39 = count(age) if age >= 35 & age <= 39 & sex == 2
by hhid: egen AD35_39 = max(sAD35_39)
by hhid: egen mAD35_39 = max(smAD35_39)
by hhid: egen fAD35_39 = max(sfAD35_39)
replace AD35_39 = 0 if AD35_39 == . & age != .
replace mAD35_39 = 0 if mAD35_39 == . & age != .
replace fAD35_39 = 0 if fAD35_39 == . & age != .

by hhid: egen sAD40_44 = count(age) if age >= 40 & age <= 44
by hhid: egen smAD40_44 = count(age) if age >= 40 & age <= 44 & sex == 1
by hhid: egen sfAD40_44 = count(age) if age >= 40 & age <= 44 & sex == 2
by hhid: egen AD40_44 = max(sAD40_44)
by hhid: egen mAD40_44 = max(smAD40_44)
by hhid: egen fAD40_44 = max(sfAD40_44)
replace AD40_44 = 0 if AD40_44 == . & age != .
replace mAD40_44 = 0 if mAD40_44 == . & age != .
replace fAD40_44 = 0 if fAD40_44 == . & age != .

by hhid: egen sAD45_49 = count(age) if age >= 45 & age <= 49
by hhid: egen smAD45_49 = count(age) if age >= 45 & age <= 49 & sex == 1
by hhid: egen sfAD45_49 = count(age) if age >= 45 & age <= 49 & sex == 2
by hhid: egen AD45_49 = max(sAD45_49)
by hhid: egen mAD45_49 = max(smAD45_49)
by hhid: egen fAD45_49 = max(sfAD45_49)
replace AD45_49 = 0 if AD45_49 == . & age != .
replace mAD45_49 = 0 if mAD45_49 == . & age != .
replace fAD45_49 = 0 if fAD45_49 == . & age != .

by hhid: egen sAD50_54 = count(age) if age >= 50 & age <= 54
by hhid: egen smAD50_54 = count(age) if age >= 50 & age <= 54 & sex == 1
by hhid: egen sfAD50_54 = count(age) if age >= 50 & age <= 54 & sex == 2
by hhid: egen AD50_54 = max(sAD50_54)
by hhid: egen mAD50_54 = max(smAD50_54)
by hhid: egen fAD50_54 = max(sfAD50_54)
replace AD50_54 = 0 if AD50_54 == . & age != .
replace mAD50_54 = 0 if mAD50_54 == . & age != .
replace fAD50_54 = 0 if fAD50_54 == . & age != .

by hhid: egen sAD55_59 = count(age) if age >= 55 & age <= 59
by hhid: egen smAD55_59 = count(age) if age >= 55 & age <= 59 & sex == 1
by hhid: egen sfAD55_59 = count(age) if age >= 55 & age <= 59 & sex == 2
by hhid: egen AD55_59 = max(sAD55_59)
by hhid: egen mAD55_59 = max(smAD55_59)
by hhid: egen fAD55_59 = max(sfAD55_59)
replace AD55_59 = 0 if AD55_59 == . & age != .
replace mAD55_59 = 0 if mAD55_59 == . & age != .
replace fAD55_59 = 0 if fAD55_59 == . & age != .

by hhid: egen sAD60_64 = count(age) if age >= 60 & age <= 64
by hhid: egen smAD60_64 = count(age) if age >= 60 & age <= 64 & sex == 1
by hhid: egen sfAD60_64 = count(age) if age >= 60 & age <= 64 & sex == 2
by hhid: egen AD60_64 = max(sAD60_64)
by hhid: egen mAD60_64 = max(smAD60_64)
by hhid: egen fAD60_64 = max(sfAD60_64)
replace AD60_64 = 0 if AD60_64 == . & age != .
replace mAD60_64 = 0 if mAD60_64 == . & age != .
replace fAD60_64 = 0 if fAD60_64 == . & age != .

by hhid: egen sAD65_69 = count(age) if age >= 65 & age <= 69
by hhid: egen smAD65_69 = count(age) if age >= 65 & age <= 69 & sex == 1
by hhid: egen sfAD65_69 = count(age) if age >= 65 & age <= 69 & sex == 2
by hhid: egen AD65_69 = max(sAD65_69)
by hhid: egen mAD65_69 = max(smAD65_69)
by hhid: egen fAD65_69 = max(sfAD65_69)
replace AD65_69 = 0 if AD65_69 == . & age != .
replace mAD65_69 = 0 if mAD65_69 == . & age != .
replace fAD65_69 = 0 if fAD65_69 == . & age != .

by hhid: egen sAD70_74 = count(age) if age >= 70 & age <= 74
by hhid: egen smAD70_74 = count(age) if age >= 70 & age <= 74 & sex == 1
by hhid: egen sfAD70_74 = count(age) if age >= 70 & age <= 74 & sex == 2
by hhid: egen AD70_74 = max(sAD70_74)
by hhid: egen mAD70_74 = max(smAD70_74)
by hhid: egen fAD70_74 = max(sfAD70_74)
replace AD70_74 = 0 if AD70_74 == . & age != .
replace mAD70_74 = 0 if mAD70_74 == . & age != .
replace fAD70_74 = 0 if fAD70_74 == . & age != .

by hhid: egen sAD75p = count(age) if age >= 75
by hhid: egen smAD75p = count(age) if age >= 75 & sex == 1
by hhid: egen sfAD75p = count(age) if age >= 75 & sex == 2
by hhid: egen AD75p = max(sAD75p)
by hhid: egen mAD75p = max(smAD75p)
by hhid: egen fAD75p = max(sfAD75p)
replace AD75p = 0 if AD75p == . & age != .
replace mAD75p = 0 if mAD75p == . & age != .
replace fAD75p = 0 if fAD75p == . & age != .

drop sAD00_04 sAD05_09 sAD10_14 sAD15_19 sAD20_24 sAD25_29 sAD30_34 ///
sAD35_39 sAD40_44 sAD45_49 sAD50_54 sAD55_59 sAD60_64 sAD65_69 sAD70_74 ///
sAD75p smAD00_04 sfAD00_04 smAD05_09 sfAD05_09 smAD10_14 sfAD10_14 ///
smAD15_19 sfAD15_19 smAD20_24 sfAD20_24 smAD25_29 sfAD25_29 smAD30_34 ///
sfAD30_34 smAD35_39 sfAD35_39 smAD40_44 sfAD40_44 smAD45_49 sfAD45_49 ///
smAD50_54 sfAD50_54 smAD55_59 sfAD55_59 smAD60_64 sfAD60_64 smAD65_69 ///
sfAD65_69 smAD70_74 sfAD70_74 smAD75p sfAD75p

rename s1q4 marital_status
label var marital_status "marital status of HH member"

gen away = .
replace away = 1 if s1q7 == 1
replace away = 0 if s1q7 == 2
label var away "=1 if person had left home over last 12 months"

gen dead_parent = .
replace dead_parent = 1 if s1q13 == 3 | s1q14 == 3
label var dead_parent "=1 if a parent has died"

gen orphan = 1 if s1q13 == 3 & s1q14 == 3
replace orphan = 0 if s1q13 != 3 | s1q14 != 3
label var orphan "=1 if orphaned"

drop s1q3y s1q3m s1q5 s1q6 s1q7 s1q8 s1q9 s1q10 s1q11 s1q12 s1q13 s1q14

/*****************/
/****section 2****/
/*****************/

gen no_school = .
replace no_school = 1 if s2aq2 == 2
replace no_school = 0 if s2aq2 ==1
label var no_school "=1 if respondent never been to school"

gen in_school = .
replace in_school = 1 if s2aq3 == 1
replace in_school = 0 if s2aq3 == 2
label var in_school "=1 if person currently in school"

rename s2aq8 cause_of_school_absence

gen educ = 0 if no_school == 1
replace educ = (s2aq4 - 1) if s2aq4 > 1 & s2aq4 <= 12
replace educ = (s2cq3 - 2) if s2cq3 > 1 & s2cq3 <= 12
replace educ = (s2cq3 - 3) if s2cq3 >= 10 & s2cq3 <= 15
replace educ = (s2aq4 - 7) if s2aq4 >= 14 & s2aq4 <= 19
replace educ = (s2cq3 - 10) if s2cq3 >= 17 & s2cq3 <= 22
replace educ = (s2cq3 - 11) if s2cq3 >= 24 & s2cq3 <= 30
replace educ = (s2aq4 - 7) if s2aq4 >= 14 & s2aq4 <= 26
label var educ "years of education"

/*mother's education*/
sort hhid

gen sMOMeduc = educ if fam_member == 1 & sex == 2
replace sMOMeduc = educ if fam_member == 2 & sex == 2
by hhid: egen MOMeduc = max(sMOMeduc)

/*father's education*/
gen sDADeduc = educ if fam_member == 1 & sex == 1
replace sDADeduc = educ if fam_member == 2 & sex == 1
by hhid: egen DADeduc = max(sDADeduc)

drop sMOMeduc sDADeduc

/*onward and upward*/

rename s2aq9a time_to_school
label var time_to_school "minutes it takes to get to school"

gen school_exp = s2aq12a + s2aq12b + s2aq12c + s2aq12d + s2aq12e + s2aq12f + s2aq12g
label var school_exp "total expenditures on schooling"

gen p_school_exp = s2aq12a + s2aq12b + s2aq12c + s2aq12d + s2aq12e + s2aq12f + s2aq12g
sort hhid
by hhid: egen school_exp_HH = sum(p_school_exp)
drop p_school_exp
replace school_exp_HH = school_exp_HH / 52
label var school_exp_HH "weekly total expenditures on schooling"

rename s2aq13 pays_school
label var pays_school "who pays the school fees"

drop s2aq1 s2aq2 s2aq3 s2aq4 s2aq5a s2aq5b s2aq6 s2aq7 s2aq9b s2aq10 s2aq11 ///
s2aq12a s2aq12b s2aq12c s2aq12d s2aq12e s2aq12f s2aq12g s2aq12h s2aq14 ///
s2aq15 s2aq16 s2b1q1 s2b1q2 s2b1q3 s2b1q4 s2b1q5 s2b1q6 s2b1q7 s2b1q8 ///
s2b1q9 s2b1q10 s2b1q11 s2b1q12 s2b1q13 s2b2q14 s2b2q15 s2b2q16 s2b2q17 ///
s2b2q18 s2b2q19 s2b2q20 s2b2q21 s2b2q22 s2b2q23 s2cq1m s2cq1y s2cq2 ///
s2cq4 s2cq5 s2cq6 s2cq7 s2cq8 s2cq9 s2dq1 s2dq2 s2dq3 s2dq4 s2dq5 s2dq6 ///
s2dq7 s2dq8 s2dq9 s2dq10 s2dq11 s2dq12 s2dq13 s2dq14 s2dq15 s2cq3

/*****************/
/****Section 3****/
/*****************/

drop s3aq1 s3aq2 s3aq3y s3aq3m s3aq4 s3aq5 s3aq6 s3aq7y s3aq7m s3aq8 ///
s3aq9 s3aq10 s3aq11 s3aq12 s3aq13 s3aq14 s3aq15 s3aq16 s3aq17 s3aq18 ///
s3aq19 s3aq20 s3aq21 s3aq22 s3aq23 s3aq24 s3aq25 s3aq26 s3aq27 s3aq28 ///
s3aq29 s3bq1 s3bq2 s3bq3 s3bq4a s3bq4b s3bq4c s3bq4d s3bq5a s3bq5b s3bq5c ///
s3bq5d s3bq6 s3bq7 s3bq8

/*****************/
/****Section 4****/
/*****************/

drop s4bq10 s4bq9h s4bq9g s4bq9f s4bq9e s4bq9d s4bq9c s4bq9b s4bq9a s4bq8 ///
s4bq7 s4bq6 s4bq5 s4bq4 s4bq3c s4bq3b s4bq3a s4bq2 s4bq1 s4aq8 s4aq7 s4aq6 ///
s4aq5 s4aq4 s4aq3m s4aq3y s4aq2 s4aq1

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec_1-4.dta", replace

keep hhid province district urb2002 quintile poverty cluster HH_head_fem ///
AD00_04 mAD00_04 fAD00_04 AD05_09 mAD05_09 fAD05_09 AD10_14 mAD10_14 fAD10_14 ///
AD15_19 mAD15_19 fAD15_19 mAD20_24 fAD20_24 AD20_24 AD25_29 mAD25_29 fAD25_29 ///
AD30_34 mAD30_34 fAD30_34 AD35_39 mAD35_39 fAD35_39 AD40_44 mAD40_44 fAD40_44 ///
AD45_49 mAD45_49 fAD45_49 AD50_54 mAD50_54 fAD50_54 AD55_59 mAD55_59 fAD55_59 ///
AD60_64 mAD60_64 fAD60_64 AD65_69 mAD65_69 fAD65_69 AD70_74 mAD70_74 fAD70_74 ///
AD75p mAD75p fAD75p MOMeduc DADeduc school_exp_HH

duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec_1-4_HH.dta", replace

/*********************/
/****Section 9: A1****/
/*********************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\A1nonfood.dta"

sort hhid
by hhid: egen Tnonfood = sum(s9a1q3)
label var Tnonfood "yearly expenditures on all nonfood items"

//men's clothing: 1, 4, 7, 10, 13, 16
sort hhid
by hhid: egen sTmCloth = sum(s9a1q3) if item == 1 | item == 4 | item == 7 ///
| item == 10 | item == 13 | item == 16
by hhid: egen TmCloth = max(sTmCloth)
drop sTmCloth
label var TmCloth "yearly expenditures on men's clothing"

//Women's Clothing: 2, 5, 8, 14, 17
sort hhid
by hhid: egen sTwCloth = sum(s9a1q3) if item == 2 | item == 5 | item == 8 ///
| item == 14 | item == 17
by hhid: egen TwCloth = max(sTwCloth)
drop sTwCloth
label var TwCloth "yearly expenditures on women's clothing"

//Children's Clothing: 6, 9, 12, 15
sort hhid
by hhid: egen sTcCloth = sum(s9a1q3) if item == 6 | item == 9 | item == 12 ///
| item == 15
by hhid: egen TcCloth = max(sTcCloth)
drop sTcCloth
label var TcCloth "yearly expenditures on children's clothing"

//Jewelry: 19
sort hhid
by hhid: egen sTjewel = sum(s9a1q3) if item == 19
by hhid: egen Tjewel = max(sTjewel)
drop sTjewel
label var Tjewel "yearly expenditures on jewelry"

//Hand Bags: 25
sort hhid
by hhid: egen sThbag = sum(s9a1q3) if item == 25
by hhid: egen Thbag = max(sThbag)
drop sThbag
label var Thbag "yearly expenditures on handbags"

//Furniture: 30 - 60
sort hhid
by hhid: egen sTfurn = sum(s9a1q3) if item >= 30 & item <= 60
by hhid: egen Tfurn = max(sTfurn)
drop sTfurn
label var Tfurn "yearly expenditures on HH furnishings, etc"

//Transport: 61 - 64
sort hhid
by hhid: egen sTtrans = sum(s9a1q3) if item >= 61 & item <= 64
by hhid: egen Ttrans = max(sTtrans)
drop sTtrans
label var Ttrans "yearly expenditures on transport"


//Leisure: 65 - 71
sort hhid
by hhid: egen sTleis = sum(s9a1q3) if item >= 65 & item <= 71
by hhid: egen Tleis = max(sTleis)
drop sTleis
label var Tleis "yearly expenditures on leisure"


//Health: 72 - 87
sort hhid
by hhid: egen sThealth = sum(s9a1q3) if item >= 65 & item <= 71
by hhid: egen Thealth = max(sThealth)
drop sThealth
label var Thealth "yearly expenditures on healthcare"

drop s9a1q2 s9a1q3 s9a1q4

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\rough\sec9_A1.dta", replace

drop item
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A1_HH.dta", replace


/*********************/
/****Section 9: A2****/
/*********************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\A2nonfood.dta"

/*monthly expenditure data*/

//Domestic Cleaning Products: 1 - 8
sort hhid
by hhid: egen sTcleanM = sum(s9a2q3) if item >= 1 & item <= 8
by hhid: egen TcleanM = max(sTcleanM)
drop sTcleanM
label var TcleanM "monthly expenditures on HH cleaning, etc"

//Leisure and Culture: 13 - 23
sort hhid
by hhid: egen sTleisM = sum(s9a2q3) if item >= 13 & item <= 23
by hhid: egen TleisM = max(sTleisM)
drop sTleisM
label var TleisM "monthly expenditures on leisure goods"

//Personal Care - Haircuts and Shaving (men): 24, 27
sort hhid
by hhid: egen sTmCareM = sum(s9a2q3) if item == 24 | item == 27
by hhid: egen TmCareM = max(sTmCareM)
drop sTmCareM
label var TmCareM "monthly expenditures on men's haircuts and shaving"

//Personal Care (women): 25, 26, 31, 32
sort hhid
by hhid: egen sTwCareM = sum(s9a2q3) if item == 25 | item == 26 | item == 31 ///
| item == 32
by hhid: egen TwCareM = max(sTwCareM)
drop sTwCareM
label var TwCareM "monthly expenditures on women's personal care"

//Personal Care (total): 24 - 34
sort hhid
by hhid: egen sTCareM = sum(s9a2q3) if item >= 24 & item <= 34
by hhid: egen TCareM = max(sTCareM)
drop sTCareM
label var TCareM "monthly expenditures on total HH personal care"


//Health: 41 - 47
sort hhid
by hhid: egen sThealthM = sum(s9a2q3) if item >= 41 & item <= 47
by hhid: egen ThealthM = max(sThealthM)
drop sThealthM
label var ThealthM "monthly expenditures on total HH health care"

//Contraception: 46
sort hhid
by hhid: egen sTcontM = sum(s9a2q3) if item == 46
by hhid: egen TcontM = max(sTcontM)
drop sTcontM
label var TcontM "monthly expenditures on contraception"

drop s9a2q2 s9a2q3 s9a2q4

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\rough\sec9_A2.dta", replace

drop item
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A2_HH.dta", replace

/*********************/
/****Section 9: A3****/
/*********************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\A3nonfood.dta"

//weekly expenditure data

gen avg_exp = (s9a3q4 + s9a3q5 + s9a3q6 + s9a3q7 + s9a3q8 + s9a3q9 ///
+ s9a3q10 + s9a3q11 + s9a3q12 + s9a3q13) / 10

//Leisure: 1 - 5
sort hhid
by hhid: egen sTleisWK = sum(avg_exp) if item >= 1 & item <= 5
by hhid: egen TleisWK = max(sTleisWK)
drop sTleisWK
replace TleisWK = . if TleisWK == 0
label var TleisWK "weekly expenditures on leisure goods"


//Hygiene and Cleaning: 6 - 10
sort hhid
by hhid: egen sThygWK = sum(avg_exp) if item >= 6 & item <= 10
by hhid: egen ThygWK = max(sThygWK)
drop sThygWK
replace ThygWK = . if ThygWK == 0
label var ThygWK "weekly expenditures on hygeine and cleaning products"

//Transport: 11 - 19
sort hhid
by hhid: egen sTtransWK = sum(avg_exp) if item >= 11 & item <= 19
by hhid: egen TtransWK = max(sTtransWK)
drop sTtransWK
replace TtransWK = . if TtransWK == 0
label var TtransWK "weekly expenditures on transportation"

//Energy and Cooking Materials: 20 - 28
sort hhid
by hhid: egen sTcookWK = sum(avg_exp) if item >= 20 & item <= 28
by hhid: egen TcookWK = max(sTcookWK)
drop sTcookWK
replace TcookWK = . if TcookWK == 0
label var TcookWK "weekly expenditures on energy and cooking materials (charcoal, etc)"

//HH Repairs: 29 - 31
sort hhid
by hhid: egen sTrepsWK = sum(avg_exp) if item >= 29 & item <= 31
by hhid: egen TrepsWK = max(sTrepsWK)
drop sTrepsWK
replace TrepsWK = . if TrepsWK == 0
label var TrepsWK "weekly expenditures on HH repairs"

//Communication: 32 - 35
sort hhid
by hhid: egen sTcommWK = sum(avg_exp) if item >= 32 & item <= 35
by hhid: egen TcommWK = max(sTcommWK)
drop sTcommWK
replace TcommWK = . if TcommWK == 0
label var TcommWK "weekly expenditures on communications"


//Tobacco: 36, 37
sort hhid
by hhid: egen sTtobWK = sum(avg_exp) if item == 36 | item == 37
by hhid: egen TtobWK = max(sTtobWK)
drop sTtobWK
replace TtobWK = . if TtobWK == 0
label var TtobWK "weekly expenditures on tobacco"

drop s9a3q2 s9a3q3 s9a3q4 s9a3q5 s9a3q6 s9a3q7 s9a3q8 s9a3q9 s9a3q10 s9a3q11 ///
s9a3q12 s9a3q13 s9a3q14 avg_exp

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\rough\sec9_A3.dta", replace

drop item
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A3_HH.dta", replace

/************************************/
/****Section 6: Economic Activity****/
/************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\job.dta"


rename s6cq4 seasonal_job
replace seasonal_job = 0 if seasonal_job == 2

gen farm = 0
replace farm = 1 if s6cq7 == 1 | s6cq7 == 4 | s6cq7 == 5 | s6cq7 == 7

gen wage = .
replace wage = s6dq8a if s6dq8b == 3
replace wage = s6dq8a * 30 if s6dq8b == 1
replace wage = s6dq8a * 4 if s6dq8b == 2
replace wage = s6dq8a / 12 if s6dq8b == 4
replace wage = wage + s6dq10a if s6dq9 == 1 & s6dq10b == 3
replace wage = wage + (s6dq10a * 30) if s6dq9 == 1 & s6dq10b == 1
replace wage = wage + (s6dq10a * 4) if s6dq9 == 1 & s6dq10b == 2
replace wage = wage + (s6dq10a / 12) if s6dq9 == 1 & s6dq10b == 4

sort hhid
by hhid: egen HHwage = sum(wage)

rename s6dq4 job_sector

drop s6cq3 s6cq5a s6cq5b s6cq5c s6cq5d s6cq5e s6cq5f s6cq6a s6cq6b s6cq6c s6cq6d ///
s6cq6e s6cq6f s6cq6g s6cq7 s6dq3 s6dq5 s6dq6y s6dq6m s6dq7 s6dq8a s6dq8b s6dq9 ///
s6dq10a s6dq10b s6dq11 s6dq12a s6dq12b s6dq13 s6dq14a s6dq14b s6dq15a s6dq15b s6dq15c ///
s6eq3 s6eq4 s6eq5 s6eq6y s6eq6m s6eq7 s6eq8a s6eq8b s6eq9 s6eq10 s6eq11 s6fq3 s6fq4 ///
s6fq5 s6fq6y s6fq6m s6fq7 s6fq8 eid

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec6_job.dta", replace

drop pid wage farm seasonal_job job_sector
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec6_job_HH.dta", replace


/************************************/
/****Section 8: Land Transactions****/
/************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\landtransactions.dta"

rename s8b1q13 sharecrop
replace sharecrop = 0 if sharecrop == 2

keep hhid province district urb2002 quintile poverty hh_wt cluster sharecrop ///

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec8_land_HH.dta", replace

/************************************/
/****Section 6: Occupation***********/
/************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\occupation.dta"

gen unemployed = .
replace unemployed = 1 if s6aq2 == 2 | s6aq3 == 2 | s6aq4 == 2 | s6aq5 == 2 | s6aq6 == 2
replace unemployed = 0 if s6aq2 == 1 | s6aq3 == 1 | s6aq4 == 1 | s6aq5 == 1 | s6aq6 == 1

keep hhid province district urb2002 quintile poverty hh_wt cluster pid unemployed

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec6_occ.dta", replace

/************************************/
/****Section 6: Occupation***********/
/************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\timeuse.dta"

gen hours_housework = .
replace hours_housework = s6gq2 if s6gq1 == 1
replace hours_housework = hours_housework + s6gq4 if s6gq3 == 1
replace hours_housework = hours_housework + s6gq6 if s6gq5 == 1
replace hours_housework = hours_housework + s6gq8 if s6gq7 == 1
replace hours_housework = hours_housework + s6g10 if s6gq9 == 1
replace hours_housework = hours_housework + s6gq12 if s6gq11 == 1

sort hhid
by hhid: egen HH_hrs_hwork = sum(hours_housework)

drop s6gq12 s6gq11 s6g10 s6gq9 s6gq8 s6gq7 s6gq6 s6gq5 s6gq4 s6gq3 s6gq2 s6gq1

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec6_hwk.dta", replace

drop pid hours_housework
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec6_hwk_HH.dta", replace


/******************************************/
/****Section 9: Food Consumption***********/
/******************************************/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\stata_raw\food.dta"


gen avg_exp = (s9bq4 + s9bq5 + s9bq6 + s9bq7 + s9bq8 + s9bq9 + s9bq10 + s9bq11 ///
+ s9bq12 + s9bq13) / 10

//Cereals: 1 - 8
sort hhid
by hhid: egen sTgrainWK = sum(avg_exp) if item >= 1 & item <= 8
by hhid: egen TgrainWK = max(sTgrainWK)
drop sTgrainWK
replace TgrainWK = . if TgrainWK == 0
label var TgrainWK "weekly expenditures on grains/cereals"

//Cereal Flours: 9 - 13
sort hhid
by hhid: egen sTflourWK = sum(avg_exp) if item >= 9 & item <= 13
by hhid: egen TflourWK = max(sTflourWK)
drop sTflourWK
replace TflourWK = . if TflourWK == 0
label var TflourWK "weekly expenditures on cereal flours"

//Pasta: 14
sort hhid
by hhid: egen sTpastaWK = sum(avg_exp) if item == 14
by hhid: egen TpastaWK = max(sTpastaWK)
drop sTpastaWK
replace TpastaWK = . if TpastaWK == 0
label var TpastaWK "weekly expenditures on pasta"

//Bread: 15
sort hhid
by hhid: egen sTbreadWK = sum(avg_exp) if item == 15
by hhid: egen TbreadWK = max(sTbreadWK)
drop sTbreadWK
replace TbreadWK = . if TbreadWK == 0
label var TbreadWK "weekly expenditures on bread"

//Pastries/Biscuits: 16, 17
sort hhid
by hhid: egen sTpbiscWK = sum(avg_exp) if item >= 16 & item <= 17
by hhid: egen TpbiscWK = max(sTpbiscWK)
drop sTpbiscWK
replace TpbiscWK = . if TpbiscWK == 0
label var TpbiscWK "weekly expenditures on pastries and biscuits"

//Meat: 18 - 26
sort hhid
by hhid: egen sTmeatWK = sum(avg_exp) if item >= 18 & item <= 26
by hhid: egen TmeatWK = max(sTmeatWK)
drop sTmeatWK
replace TmeatWK = . if TmeatWK == 0
label var TmeatWK "weekly expenditures on meat"

//Poultry: 27 - 30
sort hhid
by hhid: egen sTpoulWK = sum(avg_exp) if item >= 27 & item <= 30
by hhid: egen TpoulWK = max(sTpoulWK)
drop sTpoulWK
replace TpoulWK = . if TpoulWK == 0
label var TpoulWK "weekly expenditures on poultry"


//Fish: 31 - 34
sort hhid
by hhid: egen sTfishWK = sum(avg_exp) if item >= 31 & item <= 34
by hhid: egen TfishWK = max(sTfishWK)
drop sTfishWK
replace TfishWK = . if TfishWK == 0
label var TfishWK "weekly expenditures on fish"

//Dairy: 35 - 43
sort hhid
by hhid: egen sTdairyWK = sum(avg_exp) if item >= 35 & item <= 43
by hhid: egen TdairyWK = max(sTdairyWK)
drop sTdairyWK
replace TdairyWK = . if TdairyWK == 0
label var TdairyWK "weekly expenditures on fish"

//Edible Oils: 44 - 48
sort hhid
by hhid: egen sToilsWK = sum(avg_exp) if item >= 44 & item <= 48
by hhid: egen ToilsWK = max(sToilsWK)
drop sToilsWK
replace ToilsWK = . if ToilsWK == 0
label var ToilsWK "weekly expenditures on edible oils"

//Fruit: 49 - 65
sort hhid
by hhid: egen sTfruitWK = sum(avg_exp) if item >= 49 & item <= 65
by hhid: egen TfruitWK = max(sTfruitWK)
drop sTfruitWK
replace TfruitWK = . if TfruitWK == 0
label var TfruitWK "weekly expenditures on fruit"

//Legumes: 66 - 76
sort hhid
by hhid: egen sTlegWK = sum(avg_exp) if item >= 66 & item <= 76
by hhid: egen TlegWK = max(sTlegWK)
drop sTlegWK
replace TlegWK = . if TlegWK == 0
label var TlegWK "weekly expenditures on legumes"

//Vegetables: 77 - 95
sort hhid
by hhid: egen sTvegWK = sum(avg_exp) if item >= 77 & item <= 95
by hhid: egen TvegWK = max(sTvegWK)
drop sTvegWK
replace TvegWK = . if TvegWK == 0
label var TvegWK "weekly expenditures on vegetables"

//Tubers: 96 - 103
sort hhid
by hhid: egen sTtubeWK = sum(avg_exp) if item >= 96 & item <= 103
by hhid: egen TtubeWK = max(sTtubeWK)
drop sTtubeWK
replace TtubeWK = . if TtubeWK == 0
label var TtubeWK "weekly expenditures on tubers"

//Sugar: 104, 105
sort hhid
by hhid: egen sTsugWK = sum(avg_exp) if item >= 104 & item <= 105
by hhid: egen TsugWK = max(sTsugWK)
drop sTsugWK
replace TsugWK = . if TsugWK == 0
label var TsugWK "weekly expenditures on sugar"

//Sweets: 106 - 111
sort hhid
by hhid: egen sTcandyWK = sum(avg_exp) if item >= 106 & item <= 111
by hhid: egen TcandyWK = max(sTcandyWK)
drop sTcandyWK
replace TcandyWK = . if TcandyWK == 0
label var TcandyWK "weekly expenditures on candy/sweets"

//Baby Food: 119, 128
sort hhid
by hhid: egen sTbabyWK = sum(avg_exp) if item == 119 | item == 128
by hhid: egen TbabyWK = max(sTbabyWK)
drop sTbabyWK
replace TbabyWK = . if TbabyWK == 0
label var TbabyWK "weekly expenditures on baby food"

//Soda: 132
sort hhid
by hhid: egen sTsodaWK = sum(avg_exp) if item == 132
by hhid: egen TsodaWK = max(sTsodaWK)
drop sTsodaWK
replace TsodaWK = . if TsodaWK == 0
label var TsodaWK "weekly expenditures on soda"

//Alchohol: 133 - 141
sort hhid
by hhid: egen sTalchWK = sum(avg_exp) if item >= 133 & item <= 141
by hhid: egen TalchWK = max(sTalchWK)
drop sTalchWK
replace TalchWK = . if TalchWK == 0
label var TalchWK "weekly expenditures on alchohol"

//Restaurant: 142 - 147
sort hhid
by hhid: egen sTrestWK = sum(avg_exp) if item >= 142 & item <= 147
by hhid: egen TrestWK = max(sTrestWK)
drop sTrestWK
replace TrestWK = . if TrestWK == 0
label var TrestWK "weekly expenditures on restaurants"

drop s9bq2 s9bq3 s9bq4 s9bq5 s9bq6 s9bq7 s9bq8 s9bq9 s9bq10 s9bq11 s9bq12 s9bq13 ///
s9bq14 avg_exp

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\rough\sec9_food.dta", replace

drop item
duplicates drop

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_food_HH.dta", replace

/************************************************************************************/
/******************************* MERGE THE DATASETS *********************************/
/************************************************************************************/

//indiv-level data:

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec_1-4.dta"

set more off

merge 1:1 hhid province district urb2002 quintile poverty hh_wt cluster pid using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec6_hwk.dta"
drop _merge

merge 1:1 hhid province district urb2002 quintile poverty hh_wt cluster pid using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\indiv\sec6_occ.dta"
drop _merge

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_ind.dta", replace

//HH-level data:

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec_1-4_HH.dta", replace
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec6_hwk_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec6_job_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec8_land_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A1_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A2_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_A3_HH.dta" 
drop _merge
set more off

merge 1:1 hhid province district urb2002 quintile poverty cluster using "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\cleaning\stata_cleaned\HH\sec9_food_HH.dta" 
drop _merge
set more off

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta", replace


/****SHARE OF EXPENDITURE VARIABLES****/

clear
use "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta"

drop Tnonfood TmCloth TwCloth TcCloth Tjewel Thbag Tfurn Ttrans Tleis Thealth 

egen total_exp = rowtotal(TleisWK ThygWK TtransWK TcookWK TrepsWK TcommWK TtobWK ///
TgrainWK TflourWK TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK ///
TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH) 

egen total_exp_m = rowtotal(TgrainWK TflourWK TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK ///
TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH ///
TcleanM TleisM TmCareM TwCareM TCareM ThealthM TcontM )

foreach i in TleisWK ThygWK TtransWK TcookWK TrepsWK TcommWK TtobWK TgrainWK TflourWK ///
TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK TfruitWK TlegWK ///
TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH{
gen sh_`i' = `i' / total_exp
}

foreach i in TgrainWK TflourWK TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK ///
TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH ///
TcleanM TleisM TmCareM TwCareM TCareM ThealthM TcontM{
gen sh_`i'_m = `i' / total_exp_m
}

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta", replace

gen TtobM = TtobWK * 4
gen TcommM = TcommWK * 4

egen total_exp_m2 = rowtotal(total_exp_m TtobM TcommM)
drop total_exp_m total_exp
rename total_exp_m2 total_exp

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta", replace

foreach i in TgrainWK TflourWK TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK ///
TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH ///
TcleanM TleisM TmCareM TwCareM TCareM ThealthM TcontM{
quietly drop sh_`i'_m
}

foreach i in TgrainWK TflourWK TpastaWK TbreadWK TpbiscWK TmeatWK TpoulWK TfishWK TdairyWK ToilsWK ///
TfruitWK TlegWK TvegWK TtubeWK TsugWK TcandyWK TbabyWK TsodaWK TalchWK TrestWK school_exp_HH ///
TcleanM TleisM TmCareM TwCareM TCareM ThealthM TcontM TtobM TcommM{
gen sh_`i'_m = `i' / total_exp
}

save "C:\Users\Owner\Dropbox\Spring 2014\Hamoudi\Term Paper\data\EICV_HH.dta", replace
