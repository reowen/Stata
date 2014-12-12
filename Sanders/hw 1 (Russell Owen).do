/*start the log file*/
log using "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\hwset1.log"

/*set my parameters*/
set obs 10000
set seed 123456

/* generate each of the variables according to part b */

gen E1=rnormal(0,1)
gen E2=rnormal(0,1)
gen U=rnormal(0,1)
gen X1=U+E1
gen X2=U+E2

/*find the correlation between the two variables, just to check*/

corr X1 X2


/*generate the variable (X1 + X2) to show that var(x1 + x2) = var(X1) + var(X2)+etc... */

gen SUMX=(X1+X2)

/*now, show that the var(SUMX) satisfies the equation*/

sum X1, detail
scalar VarX1=r(Var)
scalar sdX1=r(sd)
sum X2, detail
scalar VarX2=r(Var)
scalar sdX2=r(sd)
corr X1 X2
scalar rho=r(rho)

di VarX1+VarX2+2*sdX1*sdX2*rho


sum SUMX, detail
/*so, the value of the equation was 6.0575036 and the var(SUMX) was 6.057504..*/


/*begin part C...make sure b corresponds to the answer we got from (a)...in stata, the b is the std dev
and not the variance...that's why you see a sqrt(3) in place of a "1"*/
clear
set obs 10000
set seed 123456

gen E1=rnormal(0,1)
gen E2=rnormal(0,1)
gen U=rnormal(0,sqrt(3))
gen X1=U+E1
gen X2=U+E2

/*BOOM! check out that correlation*/

corr X1 X2

/*now that equation again*/

gen SUMX=(X1+X2)
sum X1, detail
scalar VarX1=r(Var)
scalar sdX1=r(sd)
sum X2, detail
scalar VarX2=r(Var)
scalar sdX2=r(sd)
corr X1 X2
scalar rho=r(rho)

di VarX1+VarX2+2*sdX1*sdX2*rho


sum SUMX, detail
/*so, the value of the equation=14.137875 and the var(SUMX)=14.13788*/
/*close that log*/
log close
