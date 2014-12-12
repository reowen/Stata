log using "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 3\hwset3.log"
use "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 3\subway+study+aej+data.dta", clear

/********question: 2********/
/******PART A*****/
ttest totalcal, by(calinfo_experiment)

/*****PART B*****/

sdtest totalcal, by(calinfo_experiment)


/*****PART C*****/

reg totalcal calinfo_experiment

corr totalcal calinfo_experiment
di r(rho)^2

/*the r-squared statistic is the square of the correlation, so -0.1241^2=.01540357 which is the same as our R-squared statistic
above.*/

/*****PART D*****/
reg bmi calinfo_experiment
sum bmi
reg female calinfo_experiment


/*****PART E*****/
/*since i determined that the study did a good job at randomizing their sample, i would not modify how i interpreted the coefficient on
calinfo_experiment for part (c).*/


log close
