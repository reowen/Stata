clear 
set more off
cd "C:\Users\Owner\Documents\Duke\Fall 2013\Stats"
use "PS 1\PS1_pctile.dta"

log using "PS 1\work\PS1_output.txt", replace text


/****Question 1****/

/*creating the variables*/
gen lunch=.
replace lunch=1 if gkfreelu==1
replace lunch=0 if gkfreelu==2
label var lunch "=1 if student receives a free lunch"

gen missing_lunch=0
replace missing_lunch=1 if lunch==.

gen white_asian=0
replace white_asian=1 if race==1 | race==3
replace white_asian=. if race==.
label var white_asian "=1 if student is white or asian"

gen slash = "/"
egen birthdays = concat(birthmon slash birthday slash birthyea)
gen vdate= date(birthdays, "MDY", 1985)
gen sepday = "09/01/1985"
gen sdate = date(sepday, "MDY", 1985)
gen agedays= sdate-vdate

gen age1985=agedays/365
label var age1985 "age in 1985"

drop birthdays vdate sepday sdate agedays

gen attritor=0
replace attritor=1 if flagsgk==1 & flagsg1==0
replace attritor=1 if flagsgk==1 & flagsg2==0
replace attritor=1 if flagsgk==1 & flagsg3==0
labe var attritor "=1 if the student attrited in any year"


gen csize_small=gkclasss if gkclasst==1
replace csize_small=. if gkclasst!=1
gen csize_reg=gkclasss if gkclasst==2
replace csize_reg=. if gkclasst!=2
gen csize_regaid=gkclasss if gkclasst==3
replace csize_regaid=. if gkclasst!=3


/*for generation of pctile_score, see attached .do file*/

/*operations*/

mvtest means lunch, by(gkclasst)
tab gkclasst, sum(lunch)

mvtest means missing_lunch, by(gkclasst)
tab gkclasst, sum(missing_lunch)

mvtest means white_asian, by(gkclasst)
tab gkclasst, sum(white_asian)

mvtest means age1985, by(gkclasst)
tab gkclasst, sum(age1985)

mvtest means attritor, by(gkclasst)
tab gkclasst, sum(attritor)

mvtest means gkclasss, by(gkclasst)
tab gkclasst, sum(gkclasss)

mvtest means pctile_score, by(gkclasst)
tab gkclasst, sum(pctile_score)



/****Question 2****/

/*prep work*/

gen small=.
replace small=1 if gkclasst==1
replace small=0 if gkclasst==2 | gkclasst==3
label var small "=1 if it's a small class"

gen reg_aide=.
replace reg_aide=1 if gkclasst==3
replace reg_aide=0 if gkclasst==1 | gkclasst==2
label var reg_aide "=1 for regular classes w/ aide"

gen girl=.
replace girl=1 if gender==2
replace girl=0 if gender==1
label var girl "=1 if student is a girl"

gen whiteteacher=.
replace whiteteacher=1 if gktrace==1
replace whiteteacher=0 if gktrace==2
label var whiteteacher "=1 if teacher is white"

gen teachexp=gktyears

gen master=.
replace master=1 if gkthighd==3 | gkthighd==4
replace master=0 if gkthighd==2 | gkthighd==5
label var master "=1 if teacher holds a master's degree or higher"

/*operations*/

foreach x in gktreads gktmaths gktlists gkwordsk {

reg `x' small reg_aide , cluster(gktchid)
outreg2 using q2_`x'.xls, excel replace

areg `x' small reg_aide, absorb(gkschid) cluster(gktchid) 
outreg2 using q2_`x'.xls, excel append

areg `x' small reg_aide white_asian girl lunch, absorb(gkschid) cluster(gktchid)
outreg2 using q2_`x'.xls, excel append

areg `x' small reg_aide white_asian girl lunch whiteteacher teachexp master, absorb(gkschid) cluster(gktchid)
outreg2 using q2_`x'.xls, excel append
}


/****Question 3****/

/*3A*/

areg g8tmaths small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid)

/*3B*/

gen g8math=g8tmaths
quietly areg g8tmaths small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid)
predict y_hat if g8math==.

replace g8math=y_hat if g8math==.

gen imputed=0
replace imputed=1 if g8math==y_hat & g8math!=.
replace imputed=. if g8math==.
drop y_hat

areg g8math small reg_aide white_asian girl lunch imputed, absorb(gkschid) cluster(gktchid)

/*3C*/

gen math3c=g8tmaths

quietly sum gktmaths, detail
scalar medk=r(p50)

quietly sum g8tmaths, detail
scalar min8=r(min)
scalar max8=r(max)

replace math3c=min8 if gktmaths<medk & math3c==. & gktmaths!=.
replace math3c=max8 if gktmaths>medk & math3c==. & gktmaths!=.

sum g8tmaths, detail
sum math3c, detail

areg math3c small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid)

/*3D*/

/****reading****/

/*regular*/
areg g8treads small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid) 

/*imputing via regression*/

gen g8read=g8treads
quietly areg g8treads small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid) 
predict y_hat if g8read==.

replace g8read=y_hat if g8read==.

gen imputed2=0
replace imputed2=1 if g8read==y_hat & g8read!=.
replace imputed2=. if g8read==.
drop y_hat

areg g8read small reg_aide white_asian girl lunch imputed2, absorb(gkschid) cluster(gktchid)

/*imputing a la 3C*/

gen read3c=g8treads

quietly sum gktreads, detail
scalar medk=r(p50)

quietly sum g8treads, detail
scalar min8=r(min)
scalar max8=r(max)

replace read3c=min8 if gktreads<medk & read3c==. & gktreads!=.
replace read3c=max8 if gktreads>medk & read3c==. & gktreads!=.

sum g8treads, detail
sum read3c, detail

areg read3c small reg_aide white_asian girl lunch imputed2, absorb(gkschid) cluster(gktchid)


/****science****/

/*regular*/
areg g8scienc small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid) 

/*imputing via regression*/

gen g8sci=g8scienc
quietly areg g8scienc small reg_aide white_asian girl lunch, absorb (gkschid) cluster(gktchid) 
predict y_hat if g8sci==.

replace g8sci=y_hat if g8sci==.

gen imputed3=0
replace imputed3=1 if g8sci==y_hat & g8sci!=.
replace imputed3=. if g8sci==.
drop y_hat

areg g8sci small reg_aide white_asian girl lunch imputed3, absorb(gkschid) cluster(gktchid)

/****social science****/

/*regular*/
areg g8social small reg_aide white_asian girl lunch, absorb(gkschid) cluster(gktchid) 

/*imputing via regression*/

gen g8soc=g8social
quietly areg g8social small reg_aide white_asian girl lunch, absorb(gkschid) cluster(gktchid) 
predict y_hat if g8soc==.

replace g8soc=y_hat if g8soc==. 

gen imputed4=0
replace imputed4=1 if g8soc==y_hat & g8soc!=.
replace imputed4=. if g8soc==.
drop y_hat

areg g8soc small reg_aide white_asian girl lunch imputed4, absorb(gkschid) cluster(gktchid)

/****Question 4****/

foreach x in teachexp whiteteacher master { 
xi: reg `x' i.gkclasst i.gkschid, cluster(gktchid)
test _Igkclasst_2 _Igkclasst_3
}




log close


