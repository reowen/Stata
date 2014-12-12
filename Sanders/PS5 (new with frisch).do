clear
log using "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 5\hwset5.log"

use http://data.princeton.edu/wws509/datasets/fpe, clear

/****PART A****/

graph twoway (lfit change setting) (scatter change setting)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 5\graphA1.tif", replace
graph twoway scatter change setting, mlabel(country)
graph export "C:\Users\Owner\Documents\Fall 2012\Stats\Problem Sets\Problem Set 5\graphA2.tif", replace


/****PART B****/

lowess change setting, mlabel(setting)


/****PART C****/

mkspline setting_1 75 setting_2 = setting
reg change setting_1 setting_2

/****PART D****/

test setting_1=setting_2


/****PART E****/

gen setting_sq=setting^2
gen setting_cub=setting^3

reg change setting setting_sq setting_cub
/*the t-score on setting_cub's coefficient is 0.32, so it's not statistically significant...drop it.*/

reg change setting setting_sq
/*the t-score on setting_sq's coefficient is 1.13, so it's not statistically significant...drop it, too*/

/*the t-tests conclude that the linear function is a good estimator...*/

reg change setting setting_sq setting_cub
test setting_sq setting_cub
/*an F-test also fails to reject that the linear model is a better fit!*/

/****PART F****/
quietly reg change effort setting_sq setting
predict change_hat_cubic
gen e_hat_cubic=change-change_hat_cubic

quietly reg setting_cub effort setting_sq setting
predict setting_cub_hat
gen trident_hat_cubic=setting_cub-setting_cub_hat

reg e_hat_cubic trident_hat_cubic
/*the t-score on trident_hat_cubic is -0.02..so the cubic function is not significant..let's test quadratic*/
reg change effort setting setting_sq setting_cub /*just so you can compare the numbers*/

quietly reg change effort setting
predict change_hat_quad
gen e_hat_quad=change-change_hat_quad

quietly reg setting_sq effort setting
predict setting_quad_hat
gen trident_hat_quad=setting_sq-setting_quad_hat

reg e_hat_quad trident_hat_quad
/*the t-score on trident_hat_quad is 0.74, so it's not significant...therefore the function is still linear*/
reg change effort setting setting_sq /*just so you can compare the numbers*/


/*that's the Frisch...now let's let STATA do it*/

reg change effort setting setting_sq setting_cub
test setting_sq setting_cub
/*even after controlling for "effort," we cannot reject that the effect of social setting on CBR is linear*/

reg change effort setting_1 setting_2
test setting_1=setting_2
/*with the splines, we also fail to reject that the restricted model is a better fit, after controlling for the
level of effort!  the relationship would be linear after we've controlled for "effort"*/

reg change effort setting
/*the t-score on a linear "setting" is significant*/


/****PART G****/

sum effort, detail
di r(p50)

gen high_effort=0
replace high_effort=1 if effort>8
gen setting_high_effort=high_effort*setting

reg change setting high_effort setting_high_effort
test high_effort setting_high_effort

log close
