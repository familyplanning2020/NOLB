**** Syntax No One Left Behind Analysis - FP2020 
**** Shiza Farid, FP 2020/FP2030 
**** May 29, 2019 

***************************************************************************************************************************************************************************					**** NOTE ****
	**** NOTE **** 
	// Where ever in the code, you see --> cd "C:\Users\..." -->  
	// change this to the location on your computer where you saved all the datasets. 
	// All dataset can be downloaded from the DHS or MICS websites. 
					
***************************************************************************************************************************************************************************	

***************************************************************************************************************************************************************************

**** Following variables will be needed. If one of more missing, look at IWI_General_sps file. 

*   WATER           Quality of water supply with three categories, coded: 1 low quality, 2 intermediate quality, 3 high quality, -9 Missing.
*   TOILET          Quality of toilet facility with three categories, coded: 1 low quality, 2 intermediate quality, 3 high quality, -9 Missing.
*   FLOOR           Quality of floor material with three categories, coded: 1 low quality, 2 intermediate quality, 3 high quality, -9 Missing.
*   SROOM           Number of sleeping rooms with three categories, coded: 1 zero or one sleeping room, 2 two sleeping rooms, 3 three or more sleeping rooms, -9 Missing.
*   TV              Household or one of its members owns a tv, coded: 0 Not, 1 Yes, -9 Missing.
*   FRIDGE          Household or one of its members owns a fridge, coded: 0 Not, 1 Yes, -9 Missing.
*   PHONE           Household or one of its members owns a phone, coded: 0 Not, 1 Yes, -9 Missing.
*   CAR             Household or one of its members owns a car, coded: 0 Not, 1 Yes, -9 Missing.
*   BICYCLE         Household or one of its members owns a bicycle, coded: 0 Not, 1 Yes, -9 Missing.
*   CHEAPUTEN  	    Household or one of its members owns a radio, coded: 0 Not, 1 Yes, -9 Missing.
*   EXPUTEN         Household or one of its members owns a tv, coded: 0 Not, 1 Yes, -9 Missing.
*   ELECTR          Household has access to electricity, coded: 0 Not, 1 Yes, -9 Missing.

***************************************************************************************************************************************************************************

**** Bangladesh 2011 ****

* water, same in 2011 and 2014 
* toilet, add ==96 in category 1 for 2014 DHS 
* floor, add==99 in category for 2011 DHS 
cd "C:\Users\..."

clear
use "BDHR61FL.DTA"

	***bangladesh 2011
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)
	
	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*has car 
	*2011 DHS did not as about car so ignoring question in 2014 as well 
	
	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)
	
	*cheaputen
	*using radio for all six surveys
	gen cheaputen=0
	replace cheaputen=1 if hv207==1
		
	*exputen
	*using almirah for all six surveys
	gen exputen=0
	replace exputen=1 if sh110g==1
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	
	recode hv213 (31  33 35 = 3) (21 22  34=2) ///
		(11 96 99=1), gen(floor)
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet	
	ta hv205
	ta hv205, m nol
	recode hv205 (23 31 42 43 99=1) (21 22 41=2) ///
		(10/15 =3), gen(toilet)
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		
		recode hv201 (32 42 43 51 62 96 99=1) ///
					(13 21 31 41 61 = 2) ///
					(11 12 71 = 3), gen(water)
		ta hv201 water, m
		ta water, gen(water)
		
	*get rid of non-de jure members
	drop if hv012==0
	
	 //Missing  car 
	gen car=0
	  
	gen iwi=26.334816-6.65873*water1-2.38544*water2+8.357154*water3-7.840124*toilet1-1.130903*toilet2+ ///
	8.564661*toilet3-7.989144*floor1+1.367741*floor2+6.386174*floor3+9.065771*tv+8.775876*fridge+ ///
	7.429358*phone+8.519543*electr+0*car+1.901476*bicycle+4.322058*cheaputen+6.791118*exputen- ///
	3.846817*sleep1+0.42927*sleep2+3.551996*sleep3

	replace iwi=0 if iwi<.00000000000001

	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
	
	save "BD2011HRtemp.dta", replace
	
**************************************************************************************************
* Bangaldesh 2014 

clear
use "BDHR72FL.DTA"

**** Bangladesh 2014 ****

	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*has car
	*2011 DHS did not as about car so ignoring question in 2014 as well 

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)
	
	*cheaputen
	*using radio for all six surveys
	gen cheaputen=0
	replace cheaputen=1 if hv207==1
		
	*exputen
	*using almirah for all six surveys
	gen exputen=0
	replace exputen=1 if sh110h==1
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	
	recode hv213 (31 33 35 = 3) (21 22 34=2) ///
		(11 96=1), gen(floor)
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	ta hv205
	ta hv205, m nol
	recode hv205 (23 31 42 43 96=1) (21 22 41=2) ///
		(11/15  =3), gen(toilet)
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
		
	*water supply
		ta hv201
		ta hv201, nol m
		
		recode hv201 (32 42 43  51 62  96 99=1) ///
					(13 21 31 41 61 = 2) ///
					(11 12 71 = 3), gen(water)
		ta hv201 water, m
		ta water, gen(water)
		
	*get rid of non-de jure members
	drop if hv012==0
		
	 //Missing  car 
	gen car=0
	  
	gen iwi=26.334816-6.65873*water1-2.38544*water2+8.357154*water3-7.840124*toilet1-1.130903*toilet2+ ///
	8.564661*toilet3-7.989144*floor1+1.367741*floor2+6.386174*floor3+9.065771*tv+8.775876*fridge+ ///
	7.429358*phone+8.519543*electr+0*car+1.901476*bicycle+4.322058*cheaputen+6.791118*exputen- ///
	3.846817*sleep1+0.42927*sleep2+3.551996*sleep3

	replace iwi=0 if iwi<.00000000000001

	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
	
	save "BD2014HRtemp.dta", replace
	
clear
foreach c in  	BD2011 ///	
	BD2014 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*

**************************************************************************************************
*Burundi 2012

*water, ==13 is category 2 in 2012 DHS and ==13 is category 3 in 2016 DHS
*       ==14 is category 2 in 2016 DHS 
*       ==51 is category 1 in 2016 DHS 
*toilet, 
*      ==14 is category 3 in 2016 DHS
* 	   ==42 is catogory 1 in 2016 DHS
*      ==96 and ==99 not in 2016 DHS 
*floor
*      ==99 is only in 2012 DHS 
*      ==22 is category 2 in 2016 DHS 

cd "C:\Users\..."

	u "BU2012HR.dta", clear
	
		*********Burundi 2012**********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96 99 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 99 43 .=1) (21 22 41 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 62 96. =1) ///
					(13 21 31 41 61 = 2) ///
					(11 12 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)	
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "BU2012HRtemp.dta", replace
		
**************************************************************************************************
*Burundi 2016-17

	u "BU2016HR.dta", clear
	
		*********Burundi 2016-17**********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (22 34=2) ///
		(11 12  96 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 42 43  .=1) (21 22 41=2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
				
		recode hv201 (32 42 43 51 62 96. =1) ///
					(14 21 31 41 61 = 2) ///
					(11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)	
		
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "BU2016HRtemp.dta", replace

		clear
foreach c in  	BU2012	///	
	BU2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
**************************************************************************************************
*Ethiopia 2011 
*water, ==13 is category 2 in 2012 DHS and ==13 is category 3 in 2016 DHS
*       ==14 is category 2 in 2016 DHS 
*       ==99 is category 1 in 2011 DHS and not in 2016 DHS 
*toilet, 
*       ==99 is category 1 in 2011 DHS and not in 2016 DHS
*floor, 
*       ==99 is category 1 in 2011 DHS and not in 2016 DHS 

cd "C:\Users\..."
	u "ET2011HR.dta", clear
	
		*********Ethiopia 2011 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  mitad
	recode sh110k (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96 99 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 99 42 43  .=1) (21 22 41 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 ( 32 42 43 51 62 96 99 . =1) ///
					(13 21 31 41 61 = 2) ///
					( 11 12 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		*get rid of non-de jure members
		drop if hv012==0
	
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "ET2011HRtemp.dta", replace		
		
**************************************************************************************************
*Ethiopia 2016 

	u "ET2016HR.dta", clear
	
		*********Ethiopia 2016 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  mitad
	recode sh121j (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96.=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 42 43 .=1) (21 22 41=2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96 . =1) ///
					(14 21 31 41 61 = 2) ///
					( 11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		*get rid of non-de jure members
		drop if hv012==0
	
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "ET2016HRtemp.dta", replace		

	clear
	foreach c in  	ET2011	///	
	ET2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
**************************************************************************************************
*Haiti 

*water, ==32 is category 3 in 2012 DHS  and category 2 in 2016 DHS 
*		==72 is category 3 in 2012 DHS and does not exist in 2016 DHS 
* 		==99 does not exist in 2016 DHS 
*toilet
* 		==99 does not exist in 2016 DHS  
*floor 
* 		==99 does not exist in 2016 DHS 


cd "C:\Users\..."
	u "HT2012HR.dta", clear
	
		********* Haiti 2012 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 33 = 3) (21 32 =2) ///
		(11 12 96 99 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 99 42 43 44 45  .=1) (21 22 41 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (33 34 42 43 51 62 96 99 . =1) ///
					(14 31 32 41 61 = 2) ///
					( 11 12 13 71 72 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "HT2012HRtemp.dta", replace	
		
**************************************************************************************************
*Haiti 

	u "HT2016HR.dta", clear
	
		********* Haiti 2016 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 33 = 3) (21 32=2) ///
		(11 12 96.=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 42 43  .=1) (21 22 41=2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96. =1) ///
					(14 31 41 61 = 2) ///
					( 11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "HT2016HRtemp.dta", replace			

		
	clear
	foreach c in  	HT2012	///	
	HT2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
**************************************************************************************************
*Malawi 
*water, ==99 does not exist in 2015 DHS 
*		==13 is category 2 in 2010 DHS and category 3 in 2015 DHS
*toilet,
* 		==99 does not exist in 2015 DHS 
* 		==11/15 all category 3 in 2015 DHS and not included in 2010 DHS 
*floor, 
* 		==99 does not exist in 2015 DHS 

cd "C:\Users\..."
	u "MW2010HR.dta", clear
	
		********* Malawi 2010 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 23 34=2) ///
		(11 12 96 99 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 99 42 43  .=1) (21 22 41 =2)   ///
		(11=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96 99 . =1) ///
					(13 21 31 41 61 = 2) ///
					( 11 12 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "MW2010HRtemp.dta", replace			
		
**************************************************************************************************
*Malawi 2015

	u "MW2015HR.dta", clear
	
		********* Malawi 2015 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 42 43  .=1) (21 22 41=2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96. =1) ///
					(14 21 31 41 61 = 2) ///
					( 11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "MW2015HRtemp.dta", replace
		
	clear
	foreach c in  	MW2010	///	
	MW2015 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
**************************************************************************************************
*Nepal
*water, ==13 is category 2 in 2011 DHS and category 3 in 2016 DHS
*		==14 is category 2 in 2016 DHS 
*toilet, 
* 		==42 not in 2016 DHS but included in 2016 DHS 
*		==43 not in 2011 DHS but included in 2016 DHS 
*floor, 
* 		==99 not in 2016 DHS but included in 2010 DHS 
cd "C:\Users\..."

	u "NP2011HR.dta", clear
	
		********* Nepal 2011 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96 99 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 99 42 .=1) (21 22 41 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 96 99 . =1) ///
					(13 21 31 41 44 61 = 2) ///
					( 11 12 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "NP2011HRtemp.dta", replace			

**************************************************************************************************
*Nepal  

	u "NP2016HR.dta", clear
	
		********* Nepal 2016 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 22 34=2) ///
		(11 12 96 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 96 43  .=1) (21 22 41 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 ( 32 42 43 51 62 96 . =1) ///
					(14 21 31 41 61 = 2) ///
					(11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "NP2016HRtemp.dta", replace			

		clear
foreach c in  	NP2011	///	
	NP2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
		
**************************************************************************************************
*Pakistan
*water, ==99 not in 2017 DHS 
*toilet, ==99 not in 2017 DHS 
*floor, ==99 not in 2017 DHS 

cd "C:\Users\..."
	u "PK2012HR.dta", clear
	
		********* Pakistan 2012-13 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	tab1 hv207 ,m
	gen cheaputen=hv207
	replace cheaputen=0 if hv207==9 | hv207==.
	ta cheaputen
	
	*exputen scooter/motorcyle
	tab1 hv211  , m
	gen exputen=hv211
	replace exputen=0 if hv211==9 | hv211==.
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	la l HV213

	recode hv213 (31 32 33 35/39 = 3) (21 22 34=2) ///
		(11 12 96 99=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	la l HV205
	
	recode hv205 (23 31 42 43 96 99=1) (22 21=2) ///
		(11 12 13 14 15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		la l HV201
		
		
		recode hv201 (32 42 43 51 62 96 99=1) ///
					(13 21 22 31 41 61 63 = 2) ///
					(11 12 71 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
		*IWI - nothing missing 
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	
	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
		
		save "PK2012HRtemp.dta", replace			
		
**************************************************************************************************
*Pakistan

	u "PK2017HR.dta", clear
	
		********* Pakistan 2017 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	tab1 hv207 ,m
	gen cheaputen=hv207
	replace cheaputen=0 if hv207==9 | hv207==.
	ta cheaputen
	
	*exputen scooter/motorcylce
	tab1 hv211  , m
	gen exputen=hv211
	replace exputen=0 if hv211==9 | hv211==.
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	la l HV213

	recode hv213 (31 32 33 35/39 = 3) (21 22 34=2) ///
		(11 12 96=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	la l HV205
	
	recode hv205 (23 31 42 43 96=1) (22 21 41=2) ///
		(11 12 13 14 15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		la l HV201
		
		
		recode hv201 (32 42 43 51 62 96=1) ///
					(14 21 31 41 61 63 = 2) ///
					(11 12 13 71 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
		*IWI - nothing missing 
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	
	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
		
		
		save "PK2017HRtemp.dta", replace	
		
clear
foreach c in  	PK2012	///	
	PK2017 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
**************************************************************************************************
*Senegal 

cd "C:\Users\..."


	u "SN2012HR.dta", clear
	
		********* Senegal 2012  **********
		
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	tab1 hv207 ,m
	gen cheaputen=hv207
	replace cheaputen=0 if hv207==9 | hv207==.
	ta cheaputen
	
	*exputen motorcyle
	tab1 hv211  , m
	gen exputen=hv211
	replace exputen=0 if hv211==9 | hv211==.
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	la l HV213

	recode hv213 (31 32 33 35= 3) (21 22 34=2) ///
		(11 12 96=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	la l HV205
	
	recode hv205 ( 26 31 96=1) (22 21 24=2) ///
		(11 12=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		la l HV201
		
		
		recode hv201 (32 42 43 51 62 96=1) ///
					(13 21 31 41 61 = 2) ///
					(11 12 71 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
		*IWI
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	
	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
		
		
		save "SN2012HRtemp.dta", replace		
		
**************************************************************************************************
*Senegal 

	u "SN2016HR.dta", clear
	
		********* Senegal 2017-18 **********
		
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	tab1 hv207 ,m
	gen cheaputen=hv207
	replace cheaputen=0 if hv207==9 | hv207==.
	ta cheaputen

	*exputen motorcycle
	tab1 hv211  , m
	gen exputen=hv211
	replace exputen=0 if hv211==9 | hv211==.
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	la l HV213

	recode hv213 (31 32 33 35/39 = 3) (21 22 34=2) ///
		(11 12 96=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	la l HV205
	
	recode hv205 (23 31 43 96=1) (22 21 41 =2) ///
		(11 12 13 14 15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		la l HV201
		
		
		recode hv201 (32 42 43 51 62 96=1) ///
					(14 21 31 41 61 = 2) ///
					(11 12 13 71 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
		*IWI
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	
	sum iwi, d
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
		
		
		save "SN2016HRtemp.dta", replace	

		clear
		foreach c in  	SN2012	///	
		SN2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
***********************************************************************
*	Uganda 2011

cd "C:\Users\..."
	u "UG2011HR.dta", clear

	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
		ta hv206
		ta hv206, m nol
		recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen motorcycle
	gen exputen=0
	replace exputen=1 if hv211==1
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	
	recode hv213 (31 33 34 36= 3) (35=2) ///
		(11 12 96 99=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	
	recode hv205 (24 25 31 96 99=1) (21 22 23 41 44=2) ///
		(11 =3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
		
	*water supply
		ta hv201
		ta hv201, nol m
		
		recode hv201 (35 36 44 45 46 51 62 96=1) ///
					(13 22 23 33 34 61 = 2) ///
					(11 12 71 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
	
	*IWI -- nothing missing 
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	sum iwi, d
	
	*get ready to merge with woman's file
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
	
	save "UG2011HRtemp.dta", replace

***********************************************************************
*	Uganda 2016

	u "UG2016HR.dta", clear

	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9=0), gen(tv)

	*has fridge
	ta hv209
	ta hv209, m nol
	recode hv209 (9=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	ta hv243a
	ta hv243a, nol m
	gen phone=0
	replace phone=1 if hv221==1 | hv243a==1
	ta phone
	
	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9=0), gen(bicycle)
	
	*Access to electricty
		ta hv206
		ta hv206, m nol
		recode hv206 (9=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216, nol m
	recode hv216 (0/1 99= 1) (2=2) (else=3), gen(sroom)
	ta hv216 sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen motorcycle
	gen exputen=0
	replace exputen=1 if hv211==1
	
	
	*Main material of floor
	ta hv213
	ta hv213, m nol
	
	recode hv213 (31 33 35 36 37= 3) (21 22 32 34=2) ///
		(11 12 96 99=1), gen(floor) t
		ta hv213 floor, m
		ta floor, gen(floor)
		
	*Toilet
	
	ta hv205
	ta hv205, m nol
	
	recode hv205 (23 31 42 43 96=1) (21/22 41=2) ///
		(11 12 13 14 15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
		
	*water supply
		ta hv201
		ta hv201, nol m
		
		recode hv201 (32 42 43 51 63 96=1) ///
					(14 21 31 41 61 = 2) ///
					(11 12 13 71 72 = 3), gen(water) t
		ta hv201 water, m
		ta water, gen(water)
		
	
	*IWI -- mothing missing
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3
		replace iwi=0 if iwi<.00000000000001
	
	sum iwi, d
	
	*get ready to merge with woman's file
	
	keep hv001 hv002 tv - iwi
	rename hv001 v001
	rename hv002 v002
	sort v001 v002
	
	save "UG2016HRtemp.dta", replace

	clear
	foreach c in  	UG2011	///	
	UG2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
	
***********************************************************************
*	Zimbabwe 2010

cd "C:\Users\..."

	u "ZW2010HR.dta", clear
	
		********* Zimbabwe 2010 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m
	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/22=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen motorcycle
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 34=2) ///
		(11 12 96.=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 42 96.=1) (21 22 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96 . =1) ///
					(13 21 31 41 61 = 2) ///
					( 11 12 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "ZW2010HRtemp.dta", replace			
		
**************************************************************************************************
*Zimbabwe 2016 

	u "ZW2016HR.dta", clear
	
		********* Zimbabwe 2016 **********
	
	*Has TV
	ta hv208
	ta hv208, nol m
	recode hv208 (9 .=0), gen(tv)

	*Has fridge 
	ta hv209 
	ta hv209, nol m
	recode hv209 (9.=0), gen(fridge)

	*has phone
	ta hv221
	ta hv221, nol m

	gen phone= hv221
	replace phone=0 if hv221==. | hv221==9
	ta phone

	*Has Car
	ta hv212
	ta hv212, m nol
	recode hv212 (9 .=0), gen (car)

	*Has bicycle
	ta hv210
	ta hv210, m nol
	recode hv210 (9 .=0), gen(bicycle)
	
	*Access to electricty
	ta hv206
	ta hv206, m nol
	recode hv206 (9 .=0), gen(electr)
	
	*Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
	ta hv216
	ta hv216 , nol m
	recode hv216  (0/1 98 99 .= 1) (2=2) (3/25=3), gen(sroom)
	ta hv216  sroom
	ta sroom, gen(sleep)

	*cheap radio
	gen cheaputen=0
	replace cheaputen=1 if hv207==1

	*exputen  scooter
	recode hv211 (9 .=0), gen(exputen)
		
	*floor
	tab hv213, m
	tab hv213, nol 
	*lablebook hv213
	
	recode hv213 (31 32 33 35 = 3) (21 34=2) ///
		(11 12 96 .=1), gen(floor) 
		ta hv213 floor, m
		ta floor, gen(floor)
	
	*Toilet
	
	ta hv205
	ta hv205, m nol
	*lablebook hv205
	
	recode hv205 (23 31 42 96  .=1) (21 22 =2)   ///
		(11/15=3), gen(toilet) t
		ta hv205 toilet, m
		ta toilet, gen(toilet)
		
	*water supply
		ta hv201
		ta hv201, nol m
		*lablebook hv201
		
		recode hv201 (32 42 43 51 62 96. =1) ///
					(14 21 31 41 61 = 2) ///
					( 11 12 13 71 = 3), gen(water)		
					ta hv201 water, m
		ta water, gen(water)
		
		//nothing missing, so normal iwi
		
	gen iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ ///
	8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ ///
	7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- ///
	3.699681*sleep1+0.38405*sleep2+3.445009*sleep3 
	
		replace iwi=0 if iwi<.00000000000001
		sum iwi, d
	
	
		keep hv001 hv002 tv - iwi
		rename hv001 v001
		rename hv002 v002
		sort v001 v002
		
		save "ZW2016HRtemp.dta", replace
		
clear
foreach c in  	ZW2010	///	
	ZW2016 { 
		use "`c'IR.DTA", clear
		sort v001 v002
		keep v0* v1* v3* v5* v6* v219 v220 v201
		merge m:1 v001 v002 using 	"`c'HRtemp.DTA" 
		keep if _m==3
		save "`c'IRHR.DTA", replace
		gen iwi_qt=1 if iwi<=19
		replace iwi_qt=2 if iwi>=20 & iwi <=39
		replace iwi_qt=3 if iwi>=40 & iwi<=59
		replace iwi_qt=4 if iwi>=60 & iwi<=79
		replace iwi_qt=5 if iwi>=80 & iwi<=100
		label define wealth 1 "Poorest" 2 "Poorer" 3 "Middle" 4 "Richer" 5 "Richest" 
		label values iwi_qt wealth
		gen wgt=v005/1e6
		svyset[pweight=wgt]
		generate iwi_decile=autocode(iwi,10,0,100)
		tabout iwi_qt [iweight=wgt] using `c'_Wealth_Age_Structure.xls, rep c(mean v012)svy sum
		*tabout v313 iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) replace
		*tabout iwi_qt if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(row freq) append
		*tabout iwi_decile if v502==1 [iweight=wgt] using `c'_mCPR.xls, c(col freq) append
		*erase "`c'HRtemp.DTA"
		*erase "`c'HRtemp.DTA"
	}
	*
					
**************************************************************************************************
**************************************************************************************************
