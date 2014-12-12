

tab VCF0104
replace VCF0104=. if VCF0104==0

tab VCF0104 if VCF0104!=0

/* != means "not equal to */

set more off /*turns off the "more" feature when viewing lists of data*/

/*how to recode it? = replace option*/

/*summarize VCF0104 accd to their "feelings thermometer" (VCF0220)*/
tab VCF0104, sum(VCF0220) /*but the values for 98 and 99 are either N/A or they weren't surveyed, so we need to get rid of these values*/
/*there are 2 ways to do this*/
/*(1)recode*/
replace VCF0220=. if VCF0220==98 | VCF0220==99

/*(2) ignore certain observations..this one's better*/
tab VCF0104 if VCF0220<98, sum(VCF0220)

tab VCF0104 if VCF0834!=0 & VCF0834!=9, sum(VCF0834)
tab VCF0104 if 0<VCF0834<9, sum(VCF0834) /*don't do this.EVER*/
tab VCF0104 if 0<VCF0834 & VCF0834<9, sum(VCF0834)


/*VCF0834 is about whether women should work outside the home.."what were the average scores for men and women in 1972?*/
tab VCF0104 if VCF0834!=0 & VCF0834!=9 & VCF0004==1972, sum(VCF0834)


/*time to add the weight variables...both the variable.  in the NES, higher variable/weight #s take priority
use the "a" version*/

tab VCF0104 if VCF0834!=0 & VCF0834!=9 [weight=VCF0009a], sum(VCF0834)

/*different weights b/c the sample data "more" representative of the population...lower weights count the sample data less...
higher weights count the sample data more */


/*to graph..copy results from stata and put them into excel to make a graph...right click "copy table"*/


