use "C:\Users\erick\OneDrive\Desktop\AMREC\AMREC\AMREC3\stidata-unclean.dta"
**Stage 1:data cleaning
duplicates report idnumber
*because id is an independent variable,we search for any inconviniences eg duplicates
duplicates list idnumber
*identifying the duplicate idnumbers
sort idnumber 
*to arrange the id numbers in assending order to assist in browsing
browse
*checking on the questioneire and correcting the data entry error on the list
drop if idnumber==51 & a1age== 23
*this deletes the wrongly entered id number
********
*checking for some missing values in height
tab idnumber if missing( height )
***finds theres a missing value on idnumber 187,we go back to the questioneir to re-enter the data
***finds no questioneir********
codebook sex
*here we note there is some missing entry on variable sex
list idnumber if sex==""
**notices the 2 idnumbers lacking variable sex entry,we conferm to the questionaire
replace sex="Male" if idnumber==48
replace sex="Female" if idnumber ==213
codebook casestatus
*we notice some inconviniences in casestatus where the values exceeds 2
list idnumber if casestatus==3
*notices the idnumber of the 2 id is case thus replacing the 2 into case=1
replace casestatus = 1 if idnumber==1|idnumber==31
*creating numeric characters for question 1 categories
gen Agecateg="16-34" if (a1age >=16) & (a1age <=34)
replace Agecateg ="35-64" if (a1age>=35) & (a1age <=64)
gen Agecateg_num=1 if Agecateg=="16-34"
replace Agecateg_num=2 if Agecateg=="35-64"


**generating the categories into numerics
 encode sex,gen (sex_num)
 encode a2occupation,gen(occup_num)
 encode a3church,gen(church_num)
 encode a4levelofeducation,gen(highestlevelofeducation_num)
 encode a5maritalstatus,gen(maritalstatus_num)
 encode n13takenalcohol,gen(n13takenalcohol_num)
 
**generating a numeric category for BMI
*we notices theres no weight category.so we merge with dataset set1 1to 1
 sort idnumber
 save genesis,replace
 clear
 ***from the file on menue,we open set1 1_to1 and append the previous data via the location link at the start
 merge using "C:\Users\erick\OneDrive\Desktop\AMREC\genesis.dta"
 *clean data again because set1_1to1 is unclean 
 *question 1
gen BMI= weight/(height/100)*2
format BMI %9.2f 
replace casestatus =2 if idnumber==226
replace casestatus =.0 if casestatus==2 
tab  Agecateg_num 
tab  sex_num 
tab  occup_num 
tab  church_num 
tab  highestlevelofeducation_num 
tab  maritalstatus_num 
codebook height
codebook BMI
***********
*question 2
graph pie,over (casestatus)plabel (_all percent)
*question 3 a

tab casestatus Agecateg_num ,row chi
tab  casestatus sex_num ,row chi
tab casestatus occup_num ,row chi
tab casestatus church_num ,row chi
tab casestatus highestlevelofeducation_num ,row chi
tab casestatus maritalstatus_num ,row chi
**3b social capital
tab casestatus d1burialsociety,row chi
tab casestatus d1religiousgrp,row chi
tab casestatus d1savingsclub,row chi
tab casestatus d1tradersassoc,row chi
tab casestatus d2group1,row chi
tab casestatus d2group2 ,row chi
tab casestatus d3education,row chi			
tab casestatus d3funeralassistance,row chi
tab casestatus d3healthservices,row chi
tab casestatus durationofillness,row chi
***question 3c
**clean use condoms category

codebook n12usecondom
list idnumber if n12usecondom=="2 No"
replace n12usecondom ="2 no" if idnumber==47
codebook n12usecondom
***categorise sexdebut into 2 categories
gen sexdebutcateg ="12-22" if (n2sexdebut>=12) & (n2sexdebut <=22)
replace sexdebutcateg = "23-32" if (n2sexdebut >=23) & (n2sexdebut<=32)
**categorisin how old is into 2 categories
gen howoldiscateg= "16-36" if (n16howoldis>=16)& (n16howoldis<=36)
replace howoldiscateg ="37-57" if (n16howoldis>=37) & (n16howoldis<=57)

tab casestatus n10givereceiveforsex,row chi
tab casestatus n11usedcondom,row chi
tab casestatus n12usecondom,row chi
tab casestatus n13takenalcohol,row chi
tab casestatus n14doyouhave,row chi
tab casestatus  n15livingtogether,row chi
tab casestatus howoldiscateg,row chi
tab casestatus d3receivecredit,row chi
tab casestatus typeofsti,row chi
tab casestatus sexdebutcateg,row chi
tab casestatus n3hadansti,row chi
tab casestatus agefirstsex,row chi
tab casestatus habitationstatus,row chi
tab casestatus unemployed,row chi
tab casestatus education,row chi




*************************************************************************************************************
**question 4&5

logistic casestatus ib2.maritalstatus_num d3funeralassistance n13takenalcohol_num n15livingtogether n3hadansti unemployed




 
