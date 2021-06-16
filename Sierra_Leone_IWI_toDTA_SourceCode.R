## Shiza Farid 
## Household Wealth Index for Sierra Leone MICS 2010 and 2017 
## June 17, 2019 

######################################################################################

## Where ever in the code, you see --> cd "C:/Users/..." --> make sure both the household
## and women's individual file are saved.

######################################################################################


######################################### 2017 MICS ###################################

setwd("C:/Users/...")

data <-  read.spss("hh.sav", to.data.frame= TRUE)
df.data <- as.data.frame(attr(data, "variable.labels"))

## Has TV
table(data$HC9A)
data$tv= ifelse(data$HC9A=="YES", 1, 0)
table(data$tv)

## Has fridge
table(data$HC9B)
data$fridge= ifelse(data$HC9B=="YES", 1, 0)
table(data$fridge)


## Has phone
View(table(data$HC7A, data$HC12))
data$phone= ifelse(data$HC7A=="YES" | data$HC12=="YES", 1, 0)
table(data$phone)

## Has car 
table(data$HC10E)
data$car= ifelse(data$HC10E=="YES", 1, 0)
table(data$car)

## Has bicycle
table(data$HC10B)
data$bicycle= ifelse(data$HC10B=="YES", 1, 0)
table(data$bicycle)

## Access to electricty
table(data$HC8)
data$electr= ifelse(data$HC8=="YES, INTERCONNECTED GRID" | 
                      data$HC8=="YES, OFF-GRID (GENERATOR/ISOLATED SYSTEM)", 1, 0)
table(data$electr)

## Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
table(data$HC3)
data$sleep1 <- ifelse(data$HC3==1, 1, 0)
data$sleep2 <- ifelse(data$HC3==2, 1, 0)
data$sleep3 <- ifelse(data$HC3==3 |data$HC3==4 | data$HC3==5 | data$HC3==6 | data$HC3==7 |data$HC3==8 | data$HC3==9 & (data$HC3!=33 | data$HC3!=34 | data$HC3!=9 | data$HC3!="NO RESPONSE"), 1, 0)

## Has cheap utensil- radio
table(data$HC7B)
data$cheaputen= ifelse(data$HC7B=="YES", 1, 0)
table(data$cheaputen)

## Has expensive utensil- motorcycle
table(data$HC10C)
data$exputen= ifelse(data$HC10C=="YES", 1, 0)
table(data$exputen)

## Has materials for the floor 
## 3 - CARPET, CERAMIC TILES, PARQUET OR POLISHED WOOD, VINLY OR ASPHALT STRIPS
## 2 - CEMENT, PALM / BAMBOO, WOOD PLANKS
## 1 - EARTH / SAND, OTHER, DUNG

table(data$HC4)
data$floor3 <- ifelse(data$HC4=="CARPET" |data$HC4=="CERAMIC TILES" |data$HC4=="PARQUET OR POLISHED WOOD" |
                        data$HC4=="VINYL OR ASPHALT STRIPS",  1, 0)

data$floor2 <- ifelse(data$HC4=="CEMENT" |data$HC4=="WOOD PLANKS" |data$HC4=="PALM / BAMBOO" ,  1, 0)

data$floor1 <- ifelse(data$HC4=="EARTH / SAND" |data$HC4=="OTHER"|data$HC4=="DUNG" ,  1, 0)

## Recode of Toilet
##FLUSH / POUR FLUSH: FLUSH TO PIPED SEWER SYSTEM (3)
##FLUSH / POUR FLUSH: FLUSH TO SEPTIC TANK (3)
##FLUSH / POUR FLUSH: FLUSH TO PIT LATRINE (3)
##FLUSH / POUR FLUSH: FLUSH TO OPEN DRAIN (3)
##FLUSH / POUR FLUSH: FLUSH TO DK WHERE  (3) 
##PIT LATRINE: VENTILATED IMPROVED PIT LATRINE (2)
##PIT LATRINE: PIT LATRINE WITH SLAB (2)
##PIT LATRINE: PIT LATRINE WITHOUT SLAB / OPEN PIT (1)
##COMPOSTING TOILET (2)
##BUCKET (1)
##HANGING TOILET / HANGING LATRINE (1)
##NO FACILITY / BUSH / FIELD (1)
##OTHER (1)
##NO RESPONSE

table(data$WS11)
data$toilet3 <-ifelse(data$WS11=="FLUSH / POUR FLUSH: FLUSH TO PIPED SEWER SYSTEM"|
                        data$WS11=="FLUSH / POUR FLUSH: FLUSH TO SEPTIC TANK"|
                        data$WS11=="FLUSH / POUR FLUSH: FLUSH TO PIT LATRINE"|
                        data$WS11=="FLUSH / POUR FLUSH: FLUSH TO OPEN DRAIN"|
                        data$WS11=="FLUSH / POUR FLUSH: FLUSH TO DK WHERE", 1, 0)

data$toilet2 <- ifelse(data$WS11=="PIT LATRINE: VENTILATED IMPROVED PIT LATRINE"|
                         data$WS11=="PIT LATRINE: PIT LATRINE WITH SLAB"| 
                         data$WS11=="COMPOSTING TOILET", 1, 0)

data$toilet1 <- ifelse(data$WS11=="PIT LATRINE: PIT LATRINE WITHOUT SLAB / OPEN PIT" |
                         data$WS11=="BUCKET" |
                         data$WS11=="HANGING TOILET / HANGING LATRINE" |
                         data$WS11=="NO FACILITY / BUSH / FIELD", 1, 0)


## Recode for water supply
##PIPED WATER : PIPED INTO DWELLING
##PIPED WATER: PIPED TO YARD / PLOT
##PIPED WATER: PIPED TO NEIGHBOUR
##PIPED WATER: PUBLIC TAP / STANDPIPE
##TUBE WELL / BOREHOLE
##DUG WELL: PROTECTED WELL
##DUG WELL: UNPROTECTED WELL
##SPRING: PROTECTED SPRING
##SPRING: UNPROTECTED SPRING
##RAINWATER
##TANKER-TRUCK
##CART WITH SMALL TANK
##WATER KIOSK
##SURFACE WATER (RIVER, DAM, LAKE, POND, STREAM, CANAL, IRRIGATION CHANNEL)
##PACKAGED WATER: BOTTLED WATER
##PACKAGED WATER: SACHET WATER
##OTHER
##NO RESPONSE
table(data$WS1)
data$water3 <-ifelse(data$WS1=="PIPED WATER : PIPED INTO DWELLING" |
                       data$WS1=="PIPED WATER: PIPED TO YARD / PLOT" |
                       data$WS1=="PIPED WATER: PIPED TO NEIGHBOUR" |
                       data$WS1=="PIPED WATER: PUBLIC TAP / STANDPIPE" |
                       data$WS1=="PACKAGED WATER: BOTTLED WATER" |
                       data$WS1=="PACKAGED WATER: SACHET WATER", 1, 0)

data$water2 <- ifelse(data$WS1=="TUBE WELL / BOREHOLE" |
                        data$WS1=="DUG WELL: PROTECTED WELL" |
                        data$WS1=="SPRING: PROTECTED SPRING" |
                        data$WS1=="TANKER-TRUCK", 1, 0)

data$water1 <- ifelse(data$WS1=="DUG WELL: UNPROTECTED WELL" |
                        data$WS1=="SPRING: UNPROTECTED SPRING" |
                        data$WS1=="RAINWATER" |
                        data$WS1=="CART WITH SMALL TANK" |
                        data$WS1=="WATER KIOSK" |
                        data$WS1=="SURFACE WATER (RIVER, DAM, LAKE, POND, STREAM, CANAL, IRRIGATION CHANNEL)" |
                        data$WS1=="OTHER" |
                        data$WS1=="NO RESPONSE", 1, 0)


attach(data)
## IWI -- mothing missing
data$iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ 
  8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ 
  7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- 
  3.699681*sleep1+0.38405*sleep2+3.445009*sleep3

data$iwi[data$iwi<.00000000000001] =0

summary(data$iwi)

women <- read.spss("wm.sav", to.data.frame= TRUE)
total <- merge(data,women,by=c("HH1","HH2"))


total$iwi_qt=NA
total$iwi_qt[total$iwi<=19] =1
total$iwi_qt[total$iwi>=20 & total$iwi <=39]=2
total$iwi_qt[total$iwi>=40 & total$iwi <=59]=3
total$iwi_qt[total$iwi>=60 & total$iwi <=79]=4
total$iwi_qt[total$iwi>=80 & total$iwi <=100]=5

#only completed and married women 
total <- filter(total, total$WM17=="COMPLETED") 


total$CP4A<- ifelse(is.na(total$CP4A) , "", total$CP4A)
total$CP4B<- ifelse(is.na(total$CP4B) , "", total$CP4B)
total$CP4C<- ifelse(is.na(total$CP4C) , "", total$CP4C)
total$CP4D<- ifelse(is.na(total$CP4D) , "", total$CP4D)
total$CP4E<- ifelse(is.na(total$CP4E) , "", total$CP4E)
total$CP4F<- ifelse(is.na(total$CP4F) , "", total$CP4F)
total$CP4G<- ifelse(is.na(total$CP4G) , "", total$CP4G)
total$CP4H<- ifelse(is.na(total$CP4H) , "", total$CP4H)
total$CP4I<- ifelse(is.na(total$CP4I) , "", total$CP4I)
total$CP4J<- ifelse(is.na(total$CP4J) , "", total$CP4J)
total$CP4K<- ifelse(is.na(total$CP4K) , "", total$CP4K)
total$CP4L<- ifelse(is.na(total$CP4L) , "", total$CP4L)
total$CP4M<- ifelse(is.na(total$CP4M) , "", total$CP4M)
total$CP4X<- ifelse(is.na(total$CP4X) , "", total$CP4X)

## factoring the variables for method 
levels(as.factor(total$CP4A))
levels(as.factor(total$CP4B))
levels(as.factor(total$CP4C))
levels(as.factor(total$CP4D))
levels(as.factor(total$CP4E))
levels(as.factor(total$CP4F))
levels(as.factor(total$CP4G))
levels(as.factor(total$CP4H))
levels(as.factor(total$CP4I))
levels(as.factor(total$CP4J))
levels(as.factor(total$CP4K))
levels(as.factor(total$CP4L))
levels(as.factor(total$CP4M))
levels(as.factor(total$CP4X))

total$method <-ifelse(total$CP4A=="2", "FS", 
                      ifelse(total$CP4B=="2", "MS",
                             ifelse(total$CP4C=="2", "IUD",
                                    ifelse(total$CP4D=="2", "Injectable",
                                           ifelse(total$CP4E=="2", "Implant",
                                                  ifelse(total$CP4F=="2", "Pill",
                                                         ifelse(total$CP4G=="2", "M_Condom",
                                                                ifelse(total$CP4H=="2", "F_Condom",
                                                                       ifelse(total$CP4I=="2", "Diaphragm",
                                                                              ifelse(total$CP4J=="2", "Foam/Jelly",
                                                                                     ifelse(total$CP4K=="3", "Missing",
                                                                                            ifelse(total$CP4L=="2", "Periodic Abstinence/Rhythm",
                                                                                                   ifelse(total$CP4M=="2", "Withdrawal",
                                                                                                          ifelse(total$CP4X=="2", "Other", "None"))))))))))))))



total$missing <- ifelse(total$CP4K==3, 1, 0)#missing is added to the any_method prevalence to get overall prevalence? according to MICS report

table(total$method)
prop.table(wtd.table(total$method, weight=total$wmweight))*100
total$modern <- ifelse(total$method=="FS" | 
                         total$method=="MS" |
                         total$method=="IUD" |
                         total$method=="Injectable" |
                         total$method=="Implant" |
                         total$method=="Pill" |
                         total$method=="M_Condom" |
                         total$method=="F_Condom" |
                         total$method=="Diaphragm" |
                         total$method=="Foam/Jelly", 1, 
                       ifelse(total$method=="Periodic Abstinence/Rhythm" |
                                total$method=="Withdrawal" |
                                total$method=="Other" |
                                total$method=="Missing" |
                                total$method=="None", 0, NA))

total$traditional <- ifelse(total$method=="FS" | 
                              total$method=="MS" |
                              total$method=="IUD" |
                              total$method=="Injectable" |
                              total$method=="Implant" |
                              total$method=="Pill" |
                              total$method=="M_Condom" |
                              total$method=="F_Condom" |
                              total$method=="Diaphragm" |
                              total$method=="None" |
                              total$method=="Missing" |
                              total$method=="Foam/Jelly", 0, 
                            ifelse(total$method=="Periodic Abstinence/Rhythm" |
                                     total$method=="Withdrawal" |
                                     total$method=="Other", 1, NA))

total$any_method <-ifelse(total$traditional==1 | 
                            total$modern==1 |
                            total$method=="Missing", 1, 0)

total$cprGroup <-ifelse(total$modern==1, "Modern", 
                        ifelse(total$traditional==1, "Traditional",
                               ifelse(total$missing==1, "Missing", 
                                      ifelse(total$any_method==0 & total$missing!=1, "None", NA))))

total$cprGroup <-ifelse(total$modern==1, "Modern", 
                        ifelse(total$traditional==1, "Traditional",
                               ifelse(total$any_method==0, "None", NA)))

prop.table(wtd.table(total$modern, weights = total$wmweight), 1)

prop.table(wtd.table(total$iwi_qt, total$cprGroup, weights = total$wmweight), 1)

prop.table(wtd.table(total$iwi_qt, total$any_method, weights = total$wmweight), 1)

########################
#UMSA
########################

total$cur_mar <- ifelse(total$MSTATUS=="Currently married/in union", 1, 0)
total$form_mar <- ifelse(total$MSTATUS=="Formerly married/in union" , 1, 0)
total$never_mar <- ifelse(total$MSTATUS=="Never married/in union", 1, 0)

table(total$SB1)
total$sex_active <- ifelse(total$SB1=="NEVER HAD INTERCOURSE", 0,
                          ifelse(total$SB2U=="NO RESPONSE"| total$SB2U=="YEARS AGO"| total$SB2U=="MONTHS AGO", 0,
                                 ifelse(total$SB2N=="NO RESPONSE",0, 
                                        ifelse(total$SB2U=="DAYS AGO", 1, 
                                               ifelse(total$SB2U=="WEEKS AGO", 1, 0)))))

total$never_sex<- ifelse(total$SB1=="NEVER HAD INTERCOURSE",1,0)
table(total$never_sex)
table(total$sex_active)

total$nm_sex_active <- ifelse(total$never_mar==1 & total$sex_active==1,1,0) #never married and sexually active
total$nm_sex_active <-ifelse(total$never_mar==0, NA, total$nm_sex_active) 
total$nm_nosex_lastyr <- ifelse(total$never_mar==1 & total$sex_active==0 & total$never_sex==0,1,0) #never married and NOT sexually active 
total$nm_nosex_lastyr<-ifelse(total$never_mar==0, NA, total$nm_nosex_lastyr)
total$nm_never_sex <- ifelse(total$never_mar==1 & total$never_sex==1,1,0) #never married and never had sex 
total$nm_never_sex <-ifelse(total$never_mar==0, NA, total$nm_never_sex)

total$test <- total$nm_sex_active + total$nm_nosex30 + total$nm_never_sex

total$nomar_group <- ifelse(total$nm_sex_active==1,1,
                           ifelse(total$nm_nosex_lastyr==1,2,
                                  ifelse(total$nm_never_sex==1,3, NA)))

total$nomar_group <- ifelse(is.na(total$nomar_group) & total$form_mar==1, 4, total$nomar_group) #form_married 

table(total$nomar_group)
table(total$MSTATUS, total$nomar_group)

total$mar_group <- total$nomar_group 
total$mar_group[total$MSTATUS=="Currently married/in union"]=5 #married 
table(total$mar_group)

total$mar_group = ifelse(total$mar_group==1, "Never Married and Sexually Active (30 Days)", 
                         ifelse(total$mar_group==2, "Never Married and NOT Sexually Active (30 Days)",
                                ifelse(total$mar_group==3, "Never Married and Never Had Sex", 
                                       ifelse(total$mar_group==4, "Formerly Married",
                                              ifelse(total$mar_group==5, "Married", "No")))))

########################
# Saving a DTA File 
########################
total <- subset(total, total$WM17=="COMPLETED")

new_data <- total[, c("HH1", "HH6.x", "wmweight","MSTATUS", "mar_group", "welevel", "WAGE", "cprGroup", "iwi" , "iwi_qt")]
names(new_data)[2] ="HH6"

write.dta(new_data, "C:/Users/.../AW_SL2016.dta")

# 
# svyby(~I(cprGroup=="Modern"), ~welevel,design=design, svyciprop,vartype="ci",method="beta")
# svyby(~I(cprGroup=="Modern"),~iwi_qt,design=design, svyciprop,vartype="ci",method="beta")
# svyby(~cprGroup, ~iwi_qt, design, svytotal ,ci=TRUE)
# mean <- as.data.frame(svyby(~cprGroup, by= ~iwi_qt,  design,  svymean , na.rm=TRUE))
# ci <- as.data.frame(confint(svyby(~cprGroup, by= ~iwi_qt,  design,  svymean , na.rm=TRUE)))
# 


######################################### 2010 MICS ###################################
setwd("C:/Users/...")

data <-  read.spss("hh.sav", to.data.frame= TRUE)

df.data <- as.data.frame(attr(data, "variable.labels"))

## Has TV
table(data$HC8C)
data$tv= ifelse(data$HC8C=="Yes", 1, 0)
table(data$tv)

## Has fridge
table(data$HC8E)
data$fridge= ifelse(data$HC8E=="Yes", 1, 0)
table(data$fridge)


## Has phone
View(table(data$HC8D, data$HC9B))
data$phone= ifelse(data$HC9B=="Yes" | data$HC8D=="Yes", 1, 0)
table(data$phone)

## Has car 
table(data$HC9F)
data$car= ifelse(data$HC9F=="Yes", 1, 0)
table(data$car)

## Has bicycle
table(data$HC9C)
data$bicycle= ifelse(data$HC9C=="Yes", 1, 0)
table(data$bicycle)

## Access to electricty
table(data$HC8A)
data$electr= ifelse(data$HC8A=="Yes", 1, 0)
table(data$electr)

## Number of rooms (1= 0/1 rooms; 2=2 rooms; 3=3+ rooms)
table(data$HC2)
data$sleep1 <- ifelse(data$HC2==1, 1, 0)
data$sleep2 <- ifelse(data$HC2==2, 1, 0)
data$sleep3 <- ifelse(data$HC2==4 | data$HC2==5 | data$HC2==6 | data$HC2==7 |data$HC2==8 | data$HC2==9 & 
                        (data$HC3!=10 | data$HC3!=11| data$HC3!=12| data$HC3!=13| data$HC3!=14| data$HC3!=15| data$HC3!=16 | data$HC3!=24 | data$HC3!=34 | data$HC3!=9 ), 1, 0)

## Has cheap utensil- radio
table(data$HC8B)
data$cheaputen= ifelse(data$HC8B=="Yes", 1, 0)
table(data$cheaputen)

## Has expensive utensil- motorcycle
table(data$HC9D)
data$exputen= ifelse(data$HC9D=="Yes", 1, 0)
table(data$exputen)

## Has materials for the floor 
## 3 - CARPET, CERAMIC TILES, PARQUET OR POLISHED WOOD, VINLY OR ASPHALT STRIPS
## 2 - CEMENT, PALM / BAMBOO, WOOD PLANKS
## 1 - EARTH / SAND, OTHER, DUNG

table(data$HC3)
data$floor3 <- ifelse(data$HC3=="Carpet" |data$HC3=="Ceramic tiles" |data$HC3=="Parquet or polished wood" |
                        data$HC3=="Vinyl or asphalt strips",  1, 0)

data$floor2 <- ifelse(data$HC3=="Cement" |data$HC3=="Wood Planks"|data$HC3=="Palm / Bamboo" ,  1, 0)

data$floor1 <- ifelse(data$HC3=="Earth / sand" |data$HC3=="Other"|data$HC3=="Dung" ,  1, 0)

## Recode of Toilet
##FLUSH / POUR FLUSH: FLUSH TO PIPED SEWER SYSTEM (3)
##FLUSH / POUR FLUSH: FLUSH TO SEPTIC TANK (3)
##FLUSH / POUR FLUSH: FLUSH TO PIT LATRINE (3)
##FLUSH / POUR FLUSH: FLUSH TO OPEN DRAIN (3)
##FLUSH / POUR FLUSH: FLUSH TO DK WHERE  (3) 
##PIT LATRINE: VENTILATED IMPROVED PIT LATRINE (2)
##PIT LATRINE: PIT LATRINE WITH SLAB (2)
##PIT LATRINE: PIT LATRINE WITHOUT SLAB / OPEN PIT (1)
##COMPOSTING TOILET (2)
##BUCKET (1)
##HANGING TOILET / HANGING LATRINE (1)
##NO FACILITY / BUSH / FIELD (1)
##OTHER (1)
##NO RESPONSE

table(data$WS8)
data$toilet3 <-ifelse(data$WS8=="Flush to piped sewer system"|
                        data$WS8=="Flush to septic tank"|
                        data$WS8=="Flush to pit (latrine)"|
                        data$WS8=="Flush to somewhere else"|
                        data$WS8=="Flush to unknown place / Not sure / DK where", 1, 0)

data$toilet2 <- ifelse(data$WS8=="Ventilated Improved Pit latrine (VIP)"|
                         data$WS8=="Pit latrine with slab"| 
                         data$WS8=="Composting toilet", 1, 0)

data$toilet1 <- ifelse(data$WS8=="Bucket"|
                         data$WS8=="Hanging toilet, Hanging latrine"|
                         data$WS8=="No facility, Bush, Field"|
                         data$WS8=="Other"|
                         data$WS8=="Pit latrine without slab / Open pit",1, 0)


## Recode for water supply
##PIPED WATER : PIPED INTO DWELLING
##PIPED WATER: PIPED TO YARD / PLOT
##PIPED WATER: PIPED TO NEIGHBOUR
##PIPED WATER: PUBLIC TAP / STANDPIPE
##TUBE WELL / BOREHOLE
##DUG WELL: PROTECTED WELL
##DUG WELL: UNPROTECTED WELL
##SPRING: PROTECTED SPRING
##SPRING: UNPROTECTED SPRING
##RAINWATER
##TANKER-TRUCK
##CART WITH SMALL TANK
##WATER KIOSK
##SURFACE WATER (RIVER, DAM, LAKE, POND, STREAM, CANAL, IRRIGATION CHANNEL)
##PACKAGED WATER: BOTTLED WATER
##PACKAGED WATER: SACHET WATER
##OTHER
##NO RESPONSE
table(data$WS1)
data$water3 <-ifelse(data$WS1=="Piped into dwelling" |
                       data$WS1=="Piped into compound, yard or plot" |
                       data$WS1=="Bottled water" |
                       data$WS1=="Piped to neighbour", 1, 0)

data$water2 <- ifelse(data$WS1=="Public tap / standpipe" |
                        data$WS1=="Tube well, Borehole" |
                        data$WS1=="Protected well" |
                        data$WS1=="Protected spring" |
                        data$WS1=="Tanker-truck", 1, 0)

data$water1 <- ifelse(data$WS1=="Unprotected well" |
                        data$WS1=="Unprotected spring" |
                        data$WS1=="Rainwater collection" |
                        data$WS1=="Cart with small tank / drum" |
                        data$WS1=="Surface water (river, stream, dam, lake, pond, canal, irrigation channel)" |
                        data$WS1=="Other", 1, 0)

table(data$water1)
table(data$water2)
table(data$water3)

attach(data)
## IWI -- mothing missing
data$iwi=25.00447-6.306477*water1-2.302023*water2+7.952443*water3-7.439841*toilet1-1.090393*toilet2+ 
  8.140637*toilet3-7.558471*floor1+1.227531*floor2+6.107428*floor3+8.612657*tv+8.429076*fridge+ 
  7.127699*phone+8.056664*electr+4.651382*car+1.84686*bicycle+4.118394*cheaputen+6.507283*exputen- 
  3.699681*sleep1+0.38405*sleep2+3.445009*sleep3

data$iwi[data$iwi<.00000000000001] =0

summary(data$iwi)

women <- read.spss("2010.wm.sav", to.data.frame= TRUE)
total <- merge(data,women,by=c("HH1","HH2"))

total$iwi_qt=NA
total$iwi_qt[total$iwi<=19] =1
total$iwi_qt[total$iwi>=20 & total$iwi <=39]=2
total$iwi_qt[total$iwi>=40 & total$iwi <=59]=3
total$iwi_qt[total$iwi>=60 & total$iwi <=79]=4
total$iwi_qt[total$iwi>=80 & total$iwi <=100]=5

#only completed and married women 
total <- filter(total, total$WM7=="Completed") 


total$CP3A<- ifelse(is.na(total$CP3A) , "", total$CP3A)
total$CP3B<- ifelse(is.na(total$CP3B) , "", total$CP3B)
total$CP3C<- ifelse(is.na(total$CP3C) , "", total$CP3C)
total$CP3D<- ifelse(is.na(total$CP3D) , "", total$CP3D)
total$CP3E<- ifelse(is.na(total$CP3E) , "", total$CP3E)
total$CP3F<- ifelse(is.na(total$CP3F) , "", total$CP3F)
total$CP3G<- ifelse(is.na(total$CP3G) , "", total$CP3G)
total$CP3H<- ifelse(is.na(total$CP3H) , "", total$CP3H)
total$CP3I<- ifelse(is.na(total$CP3I) , "", total$CP3I)
total$CP3J<- ifelse(is.na(total$CP3J) , "", total$CP3J)
total$CP3K<- ifelse(is.na(total$CP3K) , "", total$CP3K)
total$CP3L<- ifelse(is.na(total$CP3L) , "", total$CP3L)
total$CP3M<- ifelse(is.na(total$CP3M) , "", total$CP3M)
total$CP3X<- ifelse(is.na(total$CP3X) , "", total$CP3X)

## factoring the variables for method 
levels(as.factor(total$CP3A))
levels(as.factor(total$CP3B))
levels(as.factor(total$CP3C))
levels(as.factor(total$CP3D))
levels(as.factor(total$CP3E))
levels(as.factor(total$CP3F))
levels(as.factor(total$CP3G))
levels(as.factor(total$CP3H))
levels(as.factor(total$CP3I))
levels(as.factor(total$CP3J))
levels(as.factor(total$CP3K))
levels(as.factor(total$CP3L))
levels(as.factor(total$CP3M))
levels(as.factor(total$CP3X))


total$method <-ifelse(total$CP3A==3, "FS", 
                      ifelse(total$CP3B==3, "MS",
                             ifelse(total$CP3C==3, "IUD",
                                    ifelse(total$CP3D==3, "Injectable",
                                           ifelse(total$CP3E==3, "Implant",
                                                  ifelse(total$CP3F==3, "Pill",
                                                         ifelse(total$CP3G==3, "M_Condom",
                                                                ifelse(total$CP3H==3, "F_Condom",
                                                                       ifelse(total$CP3I==3, "Diaphragm",
                                                                              ifelse(total$CP3J==3, "Foam/Jelly",
                                                                                     ifelse(total$CP3L==3, "Periodic Abstinence/Rhythm",
                                                                                            ifelse(total$CP3K==3, "LAM",
                                                                                                   ifelse(total$CP3M==3, "Withdrawal",
                                                                                                          ifelse(total$CP3X==3, "Other", "None"))))))))))))))




total$modern <- ifelse(total$method=="FS" | 
                         total$method=="MS" |
                         total$method=="IUD" |
                         total$method=="Injectable" |
                         total$method=="Implant" |
                         total$method=="Pill" |
                         total$method=="M_Condom" |
                         total$method=="F_Condom" |
                         total$method=="Diaphragm" |
                         total$method=="Foam/Jelly" |
                         total$method=="LAM",1, 
                       ifelse(total$method=="Periodic Abstinence/Rhythm" |
                                total$method=="Withdrawal" |
                                total$method=="Other" |
                                total$method=="None", 0, NA))


total$traditional <- ifelse(total$method=="FS" | 
                              total$method=="MS" |
                              total$method=="IUD" |
                              total$method=="Injectable" |
                              total$method=="Implant" |
                              total$method=="Pill" |
                              total$method=="M_Condom" |
                              total$method=="F_Condom" |
                              total$method=="Diaphragm" |
                              total$method=="Foam/Jelly" |
                              total$method=="LAM" |
                              total$method=="None" , 0, 
                            ifelse(total$method=="Periodic Abstinence/Rhythm" |
                                     total$method=="Withdrawal" |
                                     total$method=="Other", 1, NA))


total$any_method <-ifelse(total$traditional==1 | 
                            total$modern==1, 1, 0)

total$cprGroup <-ifelse(total$modern==1, "Modern", 
                        ifelse(total$traditional==1, "Traditional",
                               ifelse(total$missing==1, "Missing", 
                                      ifelse(total$any_method==0 & total$missing!=1, "None", NA))))

total$cprGroup <-ifelse(total$modern==1, "Modern", 
                        ifelse(total$traditional==1, "Traditional",
                               ifelse(total$any_method==0, "None", NA)))


prop.table(wtd.table(total$iwi_qt, total$cprGroup, weights = total$wmweight), 1)

prop.table(wtd.table(total$iwi_qt, total$any_method, weights = total$wmweight), 1)


########################
#UMSA
########################

total$cur_mar <- ifelse(total$MSTATUS=="Currently married/in union", 1, 0)
total$form_mar <- ifelse(total$MSTATUS=="Formerly married/in union" , 1, 0)
total$never_mar <- ifelse(total$MSTATUS=="Never married/in union", 1, 0)

table(total$SB1)
total$sex_active <- ifelse(total$SB1=="Never had intercourse", 0,
                           ifelse(total$SB3U=="Special"| total$SB3U=="Year ago"| total$SB3U=="Months ago", 0,
                                  ifelse(total$SB3N=="Missing",0, 
                                         ifelse(total$SB3U=="Days ago", 1, 
                                                ifelse(total$SB3U=="Weeks ago", 1, 0)))))

total$never_sex<- ifelse(total$SB1=="Never had intercourse",1,0)
table(total$never_sex)
table(total$sex_active)

total$nm_sex_active <- ifelse(total$never_mar==1 & total$sex_active==1,1,0) #never married and sexually active
total$nm_sex_active <-ifelse(total$never_mar==0, NA, total$nm_sex_active) 
total$nm_nosex_lastyr <- ifelse(total$never_mar==1 & total$sex_active==0 & total$never_sex==0,1,0) #never married and NOT sexually active 
total$nm_nosex_lastyr<-ifelse(total$never_mar==0, NA, total$nm_nosex_lastyr)
total$nm_never_sex <- ifelse(total$never_mar==1 & total$never_sex==1,1,0) #never married and never had sex 
total$nm_never_sex <-ifelse(total$never_mar==0, NA, total$nm_never_sex)

total$test <- total$nm_sex_active + total$nm_nosex30 + total$nm_never_sex

total$nomar_group <- ifelse(total$nm_sex_active==1,1,
                            ifelse(total$nm_nosex_lastyr==1,2,
                                   ifelse(total$nm_never_sex==1,3, NA)))

total$nomar_group <- ifelse(is.na(total$nomar_group) & total$form_mar==1, 4, total$nomar_group) #form_married 

table(total$nomar_group)
table(total$MSTATUS, total$nomar_group)

total$mar_group <- total$nomar_group 
total$mar_group[total$MSTATUS=="Currently married/in union"]=5 #married 
table(total$mar_group)

total$mar_group = ifelse(total$mar_group==1, "Never Married and Sexually Active (30 Days)", 
                         ifelse(total$mar_group==2, "Never Married and NOT Sexually Active (30 Days)",
                                ifelse(total$mar_group==3, "Never Married and Never Had Sex", 
                                       ifelse(total$mar_group==4, "Formerly Married",
                                              ifelse(total$mar_group==5, "Married", "No")))))


new_data <-  total[, c("HH1", "HH6.x", "wmweight","MSTATUS", "mar_group", "welevel", "WAGE", "cprGroup", "iwi" , "iwi_qt")]
names(new_data)[2] ="HH6"

write.dta(new_data, "C:/Users/.../AW_SL2010.dta")
