clear
set more off
log using Owen_final_project.log, replace
cd "C:\Users\Owner\Dropbox\Spring 2013\Frankenburg\final project"

/*merge the datasets*/
use data\book2_v2.dta
sort geogrp hhnumber pnumber
merge 1:1 geogrp hhnumber pnumber using data\roster_v2.dta
drop _merge
save data\book2_roster_merge.dta, replace
clear

use data\book1_v2.dta
sort geogrp hhnumber
tempfile t1
save `t1'
clear

use data\book2_roster_merge.dta
sort geogrp hhnumber
merge m:1 geogrp hhnumber using `t1'
drop _merge
save data\DurhamYES.dta, replace

/*clean up variables*/

/********************************************************************************************************/

/*question 1*/
clear
set more off
use data\DurhamYES.dta
tab outcome
tab outcome geogrp

clear
set more off
use "C:\Users\Owner\Documents\Duke\Spring 2013\Frankenburg\data\z27705ex1.dta" 
tab geogrp, sum(income)
tab geogrp, sum (propval)

/*question 2*/
clear
set more off
use "C:\Users\Owner\Documents\Duke\Spring 2013\Frankenburg\data\z27705ex1.dta" 
tab geogrp, sum(income)
tab geogrp, sum (propval)

clear
set more off
use data\DurhamYES.dta
tab b3_wk31

/*question 3*/
clear
set more off
use data\DurhamYES_clean.dta


tab dream_attainment /*what do you need for dream job?*/
tab HSgrad
tab dropout_reason /*why do they drop out?*/
tab educ_roadblock /*what do parents see as the problems?*/

reg HSgrad mentor HSwork numHS durham male /*what do the numbers say about grad rates?*/
outreg2 using HSgrad_reg.xls, replace



tab mentor /*how many had mentors?*/
tab mentor_type /*who are the mentors?*/
tab advice /*who do they actually go to for advice?*/

log close
