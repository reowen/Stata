clear
cd "C:\Users\Owner\Documents\Duke\Fall 2013\Stats\PS 3"
use "Assn3_NC%2BSchools.dta"
log using "work\RussellOwen_PS3_output.txt", replace text
set more off


/****Question 1****/
gen pos_grwth=1 if avgrow05>0
replace pos_grwth=0 if avgrow05<=0

tab pos_grwth expgrow, chi2

/****Question 2****/

bootstrap: rd avgrow06 expgrow avgrow05
outreg2 using "work\Q2_rd.xls", excel replace


/****Question 3****/

/*A*/

rd expgrow avgrow05, gr
graph export 3A_graph.tif, name(expgrow) replace

/*B*/

rd avgrow06 avgrow05, gr
graph export 3B_graph1.tif, name(avgrow06) replace
graph export 3B_graph2.tif, name(avgrow0650) replace
graph export 3B_graph3.tif, name(avgrow06200) replace

/*C*/

foreach x in enroll pblack phisp pfrl{
rd `x' avgrow05, gr
graph export 3C_graph_`x'.tif, name(`x') replace
}


/****Question 4****/

global pretreat pblack phisp pfrl enroll elemschl midschl highschl

reg avgrow06 expgrow c.avgrow05#c.avgrow05#c.avgrow05 c.avgrow05#c.avgrow05 avgrow05 $pretreat, cluster(leaname)
outreg2 using "work\Q4_reg.xls", excel replace


/****Question 5****/

/*A*/ reg avgrow06 expgrow c.avgrow05#c.avgrow05#c.avgrow05 c.avgrow05#c.avgrow05 avgrow05, cluster(leaname)
outreg2 using "work\Q5_reg.xls", excel replace
/*B*/ reg avgrow06 expgrow c.avgrow05#c.avgrow05 avgrow05 $pretreat, cluster(leaname)
outreg2 using "work\Q5_reg.xls", excel append
/*C*/ reg avgrow06 expgrow c.avgrow05#c.avgrow05#c.avgrow05#c.avgrow05 c.avgrow05#c.avgrow05#c.avgrow05 c.avgrow05#c.avgrow05 avgrow05 $pretreat, cluster(leaname)
outreg2 using "work\Q5_reg.xls", excel append
/*D*/ reg avgrow06 expgrow c.avgrow05#c.avgrow05#c.avgrow05 c.avgrow05#c.avgrow05 avgrow05 $pretreat if elemschl==1, cluster(leaname)
outreg2 using "work\Q5_reg.xls", excel append

log close

