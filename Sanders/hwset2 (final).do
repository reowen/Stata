log using "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 2\hwset2.log"
use "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 2\subway+study+aej+data.dta", clear
/***********Problem set 2: Question 1a****************/

tab calinfo_experiment, sum(totalcal)

/*so, the mean for people who didn't receive calinfo=815.9477 with SD=245.6632*/
/*mean for people who received it=755.136 with SD=241.0757*/

/****************question 1C*****************/
ttest totalcal, by(calinfo_experiment)

/*ttest by hand was 3.15, on STATA it's 3.1519*/

/****************question 1D*****************/

ttest totalcal if bmi>25 & bmi!=., by(calinfo_experiment) unpaired

/*since t=0.9981, we fail to reject the hypothesis that it did not change calorie
consumption.  so, we'll say that providing the info to obese people did not change
their calorie consumption*/

/****************question 2A*****************************/
clear
set obs 40
set seed 123456

gen E0=rnormal(0,1)
gen E1=rnormal(0,1)
gen U=rnormal(0,sqrt(0.1))
gen X0=U+E0
gen X1=0.5+U+E1


sum X0
sum X1

/************question 2: part B ************/
ttest X0==X1, unpaired

/************question 2: part C ************/
ttest X0==X1

/* C and B are not similar because one is a paired ttest while the other is not, that is: in the paired
test in part (C), the "natural" variation of the population has been removed and we're only seeing the "tested" or "observed"
variation in the sample data...this lower variation allows us to detect smaller differences in the data between
X0 and X1.. */

/*************question 2: part D ***********/
clear
set obs 40
set seed 123456

gen E0=rnormal(0,1)
gen E1=rnormal(0,1)
gen U=rnormal(0,sqrt(3))
gen X0=U+E0
gen X1=0.5+U+E1

sum X0
sum X1

ttest X1==X0, unpaired
ttest X1==X0

/*our answer to B changes, but our answer to C does not change..this is because it's the variance in "U" that
is creating the noise in our data (i.e. the extra variation in the population's natural variation.  in part D 
the variance for U got bigger, so that distorted the results of the t-test
more.. the paired test, however, removes U's variance, so we did not see a change in our t-test value*/

log close
