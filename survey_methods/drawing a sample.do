clear
set more off
use "C:\Users\Owner\Documents\Duke\Spring 2013\Frankenburg\data\z27705ex1.dta" 
log using "C:\Users\Owner\Documents\Duke\Spring 2013\Frankenburg\data\samplelog", replace 

gen incstrat=0
replace incstrat=1 if income<=35000
replace incstrat=2 if income>35000

keep if incstrat==1

preserve

  set seed 123456
  sort id_du
  forvalues i=1(1)2 {                          
          generate double u = runiform()       
          sort u                               
          keep in 1/2                          
          list geogrp                           
          drop u                               
          restore, preserve                                
}                                              

clear

use "C:\Users\Owner\Documents\Duke\Spring 2013\Frankenburg\data\z27705ex1.dta" 

gen incstrat=0
replace incstrat=1 if income<=35000
replace incstrat=2 if income>35000

keep if incstrat==2

preserve
  
  set seed 123456
  sort id_du
  forvalues i=1(1)3 {                          
          generate double u = runiform()       
          sort u                               
          keep in 1/2                          
          list geogrp                           
          drop u                               
          restore, preserve                                
}                                    
  
  clear
  log close


