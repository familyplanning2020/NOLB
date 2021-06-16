**** No One Left Behind Manucript ****
**** Code written by Shiza Farid ****
**** June 2021 ****

***********************************************************************
					**** Working Directory ****
	// This is the location on your computer where you saved all the datasets 
	// and remaned as "country initial" "year of survey" "IRHR" - ex: "BU2012IRHR.DTA" 
	// This data should include variables for marital status, sexual activity, age, 
	// wealth, residence, and education
					
	cd "C:\Users\...\datasets"
	
************************************************************************

***********************************************************************

	**** Modern Contraceptive Prevalence by Residence ****

***********************************************************************

	clear
	clear matrix
	clear mata 
	set maxvar 10000
	foreach c in  BD2011 BD2014 ///
	BU2012 BU2016 ///
	ET2011 ET2016 ///
	HT2012 HT2016 ///
	MW2010 MW2015 ///
	NP2011 NP2016 ///
	PK2012 PK2017 ///
	SN2012 SN2016 ///
	ZW2010 ZW2016 { 
		use "`c'IRHR.DTA", clear
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		tabout v025 v313 [iweight=wgt] using RESIDENCE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
		
			}
			
// For Uganda 
clear 
use "UG2011IRHR.DTA"
egen strata = group(v024 v025)
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		svy: tab v025 v313, ci
		
		tabout v025 v313 [iweight=wgt] using RESIDENCE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
		
		
clear 
use "UG20116IRHR.DTA"
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		svy: tab v025 v313, ci	
		
		tabout v025 v313 [iweight=wgt] using RESIDENCE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append

***********************************************************************

	**** Modern Contraceptive Prevalence by Education ****

***********************************************************************
clear
	clear matrix
	clear mata 
	set maxvar 10000
	foreach c in  BD2011 BD2014 ///
	BU2012 BU2016 ///
	ET2011 ET2016 ///
	HT2012 HT2016 ///
	MW2010 MW2015 ///
	NP2011 NP2016 ///
	PK2012 PK2017 ///
	SN2012 SN2016 ///
	ZW2010 ZW2016 { 
	use "`c'IRHR.DTA", clear
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  

		tabout v313 v106 [iweight=wgt] using EDU_mCPR_MW.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
			}
	
// For Uganda 
clear 
use "UG2011IRHR.DTA"
egen strata = group(v024 v025)
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		svy: tab v190 v313, row ci
		tabout v313 v106 [iweight=wgt] using UG_EDU_mCPR_MW.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append
		
		
clear 
use "C:\Users\sfarid\Desktop\Analysis\No One Left Behind\wealth datasets\UG2016IRHR.DTA"
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		svy: tab v190 v313, row ci
		tabout v313 v106 [iweight=wgt] using UG_EDU_mCPR_MW.xls, ///
		f(1 1)  cell(col ci)  svy stats(chi2) ///
		npos(lab) percent append

***********************************************************************

	**** Modern Contraceptive Prevalence by Wealth Groups ****

***********************************************************************	
	
	clear
	clear matrix
	clear mata 
	set maxvar 10000
	foreach c in  BD2011 BD2014 ///
	BU2012 BU2016 ///
	ET2011 ET2016 ///
	HT2012 HT2016 ///
	MW2010 MW2015 ///
	NP2011 NP2016 ///
	PK2012 PK2017 ///
	SN2012 SN2016 ///
	ZW2010 ZW2016 { 
	use "`c'IRHR.DTA", clear
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		tabout iwi_qt v313 [iweight=wgt] using WEALTH_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
			}
	
// For Uganda 
clear 
use "UG2011IRHR.DTA"
egen strata = group(v024 v025)
		gen wgt=v005/1e6
		keep if v502==1  
		svy: tab v190 v313, row ci
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		tabout iwi_qt v313 [iweight=wgt] using UG2011_WEALTH_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append
		
clear 
use "UG2016IRHR.DTA"
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		svy: tab v190 v313, row ci
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		tabout iwi_qt v313 [iweight=wgt] using UG2016_WEALTH_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent append

***********************************************************************

	**** Modern Contraceptive Prevalence by Age Groups ****

***********************************************************************	

clear
	clear matrix
	clear mata 
	set maxvar 10000
	foreach c in  BD2011 BD2014 ///
	BU2012 BU2016 ///
	ET2011 ET2016 ///
	HT2012 HT2016 ///
	MW2010 MW2015 ///
	NP2011 NP2016 ///
	PK2012 PK2017 ///
	SN2012 SN2016 ///
	ZW2010 ZW2016 { 
		use "`c'IRHR.DTA", clear
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		keep if v502==1  
		tabout v013 v313 [iweight=wgt] using `c'_AGE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent replace

			}

// For Uganda 
clear 
use "UG2011IRHR.DTA"
egen strata = group(v024 v025)
		gen wgt=v005/1e6
		keep if v502==1  
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		tabout v013 v313 [iweight=wgt] using UG2011_AGE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent replace
		
clear 
use "UG2016IRHR.DTA"
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		keep if v502==1  
		tabout v013 v313 [iweight=wgt] using UG2016_AGE_mCPR_MW.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent replace

***********************************************************************

**** Modern Contraceptive Prevalence by Unmarried Sexual Activity Status ****

***********************************************************************	
clear
	clear matrix
	clear mata 
	set maxvar 10000
	foreach c in  BD2011 BD2014 ///
	BU2012 BU2016 ///
	ET2011 ET2016 ///
	HT2012 HT2016 ///
	MW2010 MW2015 ///
	NP2011 NP2016 ///
	PK2012 PK2017 ///
	SN2012 SN2016 ///
	ZW2010 ZW2016 {  
		use "`c'IRHR.DTA", clear
		gen wgt=v005/1e6
		svyset v021 [pw=wgt], strata(v022) singleunit(centered)
		g sexact=1 if v528>=0 & v528<=30
		gen umsa=0 if v502!=1
		replace umsa=1 if sexact==1 & v502!=1
		label define sex 0 "Not,UMSA" 1" Yes, UMSA"
		label values sex umsa 
		tabout umsa v313 [iweight=wgt] using `c'_UMSA_mCPR.xls, ///
		f(1 1) c(ci) svy stats(chi2) ///
		npos(lab) percent replace	
			}

// For Uganda 
clear 
use "UG2011IRHR.DTA"
egen strata = group(v024 v025)
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(strata) 
		g sexact=1 if v528>=0 & v528<=30
		gen umsa=0 if v502!=1
		replace umsa=1 if sexact==1 & v502!=1
		label define sex 0 "Not,UMSA" 1" Yes, UMSA"
		label values sex umsa 
		tabout umsa v313 [iweight=wgt] using UG2011_UMSA_mCPR.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent replace
		
clear 
use "UG2016IRHR.DTA"
		gen wgt=v005/1e6
		svyset v021 [pweight=wgt], strata(v022) 
		g sexact=1 if v528>=0 & v528<=30
		gen umsa=0 if v502!=1
		replace umsa=1 if sexact==1 & v502!=1
		label define sex 0 "Not,UMSA" 1" Yes, UMSA"
		label values sex umsa 
		tabout umsa v313 [iweight=wgt] using UG2016_UMSA_mCPR.xls, ///
		f(1 1)  cell(row lb ub) ci2col cibnone cisep(0)  svy stats(chi2) ///
		npos(lab) percent replace
	