* Sierra Leone
* April 16, 2020 

// Change your working directory to where all your Sierra Leone .DTA files are saved 
// after running the R code. 


cd "C:\Users\sfarid\...\datasets"

**Sierra Leone 2016
clear
use "AW_SL2016.dta"

svyset HH1 [pweight=wmweight], strata(HH6)
svy: tab cprGroup iwi_qt, col ci
svy: tab cprGroup WAGE, col ci

gen edu=.
replace edu=1 if welevel==1 | welevel==2
replace edu=2 if welevel==3
replace edu=3 if welevel==4 | welevel==5

label define education 1 "None or Pre-Primary" 2 "Primary" 3 "Secondary or Higher"
label values edu education 

 svy: tab cprGroup edu, col ci
 svy: tab cprGroup HH6, col ci
 
 
*Education 
 		tabout edu if mar_group=="Married" [iweight=wmweight] using SL2016_EDU_MW_APRIL2020.xls, ///
		f(1 1) cell(cell lb ub)  svy stats(chi2) ///
		npos(lab) percent append

		tabout cprGroup edu if mar_group=="Married" [iweight=wmweight] using SL2016_EDU_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append

*Residence
		tabout cprGroup HH6 if mar_group=="Married" [iweight=wmweight] using SL2016_RES_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
		
*Wealth 
		tabout cprGroup iwi_qt if mar_group=="Married" [iweight=wmweight] using SL2016_WEALTH_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
		
*Age
		tabout cprGroup WAGE if mar_group=="Married" [iweight=wmweight] using SL2016_AGE_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
		
*Unmarried Sexaully Active
		tabout cprGroup mar_group [iweight=wmweight] using SL2016_UMSA_mCPR_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append 

 
**Sierra Leone 2010
clear
use "AW_SL2010.dta"

svyset HH1 [pweight=wmweight], strata(HH6)
svy: tab cprGroup iwi_qt, col ci
svy: tab cprGroup WAGE, col ci

gen edu=.
replace edu=1 if welevel==1 | welevel==2
replace edu=2 if welevel==3
replace edu=3 if welevel==4 | welevel==5

label define education 1 "None or Pre-Primary" 2 "Primary" 3 "Secondary or Higher"
label values edu education 

svy: tab cprGroup edu, col ci 

*Education 
 		tabout edu if mar_group=="Married" [iweight=wmweight] using SL2010_EDU_MW_APRIL2020.xls, ///
		f(1 1) cell(cell lb ub)  svy stats(chi2) ///
		npos(lab) percent append

		tabout cprGroup edu if mar_group=="Married" [iweight=wmweight] using SL2010_EDU_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append

*Residence
		tabout cprGroup HH6 if mar_group=="Married" [iweight=wmweight] using SL2010_RES_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
		
*Wealth 
		tabout cprGroup iwi_qt if mar_group=="Married" [iweight=wmweight] using SL2010_WEALTH_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
		
*Age
		tabout cprGroup WAGE if mar_group=="Married" [iweight=wmweight] using SL2010_AGE_mCPR_MW_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
		
*Unmarried Sexaully Active
		tabout cprGroup mar_group [iweight=wmweight] using SL2010_UMSA_mCPR_APRIL2020_.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append 
