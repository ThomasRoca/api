capture program drop hdrdata
/*==============================================================================================================================
! hdrdata v1.0 Thomas Roca, May 2015. 
This program connects to the Human Development Report API to get feed a dataset 
This program requieres 'insheetjson' & 'libjson' command available on ssc install 
For more information about HDROdata api see: http://hdr.undp.org/en/content/developers-data-api 
===============================================================================================================================*/
program define hdrdata, rclass 
version 9.0
syntax 									///
	[, 									/// options						
	indicator(integer 100000)			/// options						
	year(str)							/// title of the map	 
	country(str) 						/// yes or no
	]
	
quietly {

capture assert _N == 0 // test if dataset is empty
if _rc != 0 {
noisily di " "
noisily di "********Error: you have to start with en empty dataset*********" 
error 134
}

*===============================================================================
*      Set parameters 
*===============================================================================
*Store var1 and var2 one of them is the iso3 coutry code (string) the other is a number
#delimit ;
if `indicator'==36806 local label="Adolescent birth rate (women aged 15-19 years)";	if `indicator'==101406 local label="Adult literacy rate, both sexes";	if `indicator'==27706  local label="Carbon dioxide emissions per capita";	if `indicator'==98106  local label="Change in forest area, 1990/2011";	if `indicator'==105906 local label="Combined gross enrollment in education (both sexes)";	if `indicator'==103706 local label="Education index";	if `indicator'==43106  local label="Employment to population ratio, population 25+";	if `indicator'==123506 local label="Estimated GNI per capita (PPP), female";	if `indicator'==123606 local label="Estimated GNI per capita (PPP), male";	if `indicator'==69706  local label="Expected Years of Schooling (of children)";	if `indicator'==123306 local label="Expected years of schooling, females";	if `indicator'==123406 local label="Expected years of schooling, males";	if `indicator'==38006  local label="Expenditure on education, Public (% of GDP)";	if `indicator'==53906  local label="Expenditure on health, total (% of GDP)";	if `indicator'==136906 local label="Female HDI";	if `indicator'==130006 local label="Female to male ratio, parliamentary seats";	if `indicator'==20206  local label="GDP per capita (2011 PPP $)";	if `indicator'==137906 local label="Gender Development Index (Female to male ratio of HDI)";	if `indicator'==68606  local label="Gender Inequality Index value";	if `indicator'==141706 local label="GNI per capita in PPP terms (constant 2011 international $)";	if `indicator'==38606  local label="Headcount, percentage of population in multidimensional poverty, (revised)";	if `indicator'==72206  local label="Health index";	if `indicator'==137506 local label="Human development index (HDI) value";	if `indicator'==103606 local label="Income index";	if `indicator'==135106 local label="Income quintile ratio";	if `indicator'==71406  local label="Inequality-adjusted education index";	if `indicator'==138806 local label="Inequality-adjusted HDI value";	if `indicator'==71606  local label="Inequality-adjusted income index";	if `indicator'==71506  local label="Inequality-adjusted life expectancy index";	if `indicator'==38506  local label="Intensity of deprivation";	if `indicator'==48906  local label="Labour force participation rate, female-male ratio";	if `indicator'==69206  local label="Life expectancy at birth";	if `indicator'==120606 local label="Life expectancy at birth, female";	if `indicator'==121106 local label="Life expectancy at birth, male";	if `indicator'==71206  local label="Loss due to inequality in education";	if `indicator'==71306  local label="Loss due to inequality in income";	if `indicator'==71106  local label="Loss due to inequality in life expectancy";	if `indicator'==137006 local label="Male HDI";	if `indicator'==89006  local label="Maternal mortality ratio";	if `indicator'==24106  local label="Mean years of schooling (females aged 25 years and above)";	if `indicator'==24206  local label="Mean years of schooling (males aged 25 years and above)";	if `indicator'==103006 local label="Mean years of schooling (of adults)";	if `indicator'==38406  local label="Multidimensional poverty index value";	if `indicator'==142506 local label="Near poor headcount";	if `indicator'==122006 local label="Old-age dependency ratio, ages 65 and older";	if `indicator'==73506  local label="Overall percentage loss";	if `indicator'==135206 local label="Palma ratio (Highest 10% over lowest 40%)";	if `indicator'==101006 local label="Population in severe poverty (headcount)";	if `indicator'==38906  local label="Population living below $1.25 PPP per day";	if `indicator'==44706  local label="Population living on degraded land";	if `indicator'==24806  local label="Population with at least secondary education, female/male ratio";	if `indicator'==68006  local label="Population, female (thousands)";	if `indicator'==68106  local label="Population, male (thousands)";	if `indicator'==306 local label ="Population, total both sexes (thousands)";	if `indicator'==45106  local label="Population, urban (%)";	if `indicator'==46106  local label="Primary school dropout rates";	if `indicator'==45806  local label="Primary school teachers trained to teach";	if `indicator'==57506  local label="Under-five mortality rate";	if `indicator'==121206 local label="Young age dependency ratio, 0-14)";
#delimit cr

local indicator_id="`indicator'"
local countryList="`country'"
local yearList="`year'"


*noisily insheetjson using "`url'", showresponse

gen str45 cname=""				//generate variable to host country name
gen str3 iso3=""						// generate variable to host iso3 code
capture gen year=.						// generate variable to host year
capture gen str120 var1="" 				//generate variable to host the value of the indicator
capture gen str120 indicator=""			// generate variable to host indicator description



*===============================================================================
* if not all the counntry and years requested, the program relies on insheet json
*===============================================================================

if !missing("`year'") | !missing("`country'") {
*setting default option
if missing("`yearList'") local yearList="1980,1985,1990,1995,2000,2005,2006,2007,2008,2009,2010,2011,2012,2013"
if missing("`country'") local countryList="AFG,ALB,DZA,AND,AGO,ATG,ARG,ARM,AUS,AUT,AZE, BHS,BHR,BGD,BRB,BLR,BEL,BLZ,BEN,BTN,BOL,BIH,BWA,BRA,BRN,BGR,BFA,BDI,KHM,CMR,CAN,CPV,CAF,TCD,CHL,CHN,COL,COM,COG,COD,CRI,CIV,HRV,CUB,CYP,CZE,DNK,DJI,DMA,DOM,ECU,EGY,SLV,GNQ,ERI,EST,ETH,FJI,FIN,FRA,GAB,GMB,GEO,DEU,GHA,GRC,GRD,GTM,GIN,GNB,GUY,HTI,HND,HKG,HUN,ISL,IND,IDN,IRN,IRQ,IRL,ISR,ITA,JAM,JPN,JOR,KAZ,KEN,KIR,PRK,KOR,KWT,KGZ,LAO,LVA,LBN,LSO,LBR,LBY,LIE,LTU,LUX,MKD,MDG,MWI,MYS,MDV,MLI,MLT,MHL,MRT,MUS,MEX,FSM,MDA,MCO,MNG,MNE,MAR,MOZ,MMR,NAM,NRU,NPL,NLD,NZL,NIC,NER,NGA,NOR,PSE,OMN,PAK,PLW,PAN,PNG,PRY,PER,PHL,POL,PRT,QAT,ROU,RUS,RWA,KNA,LCA,VCT,WSM,SMR,STP,SAU,SEN,SRB,SYC,SLE,SGP,SVK,SVN,SLB,SOM,ZAF,ESP,LKA,SDN,SUR,SWZ,SWE,CHE,SYR,TJK,TZA,THA,TLS,TGO,TON,TTO,TUN,TUR,TKM,TUV,UGA,UKR,ARE,GBR,USA,URY,UZB,VUT,VEN,VNM,YEM,ZMB,ZWE,SSD"

local countryList=subinstr("`countryList'", ","," ",.)  // country list without ","
local yearList=subinstr("`yearList'", ","," ",.)  // country list without ","

*=====================================================
di "Indicator:`indicator_id'|`countryList'|`yearList'"
*=====================================================

local i=0

foreach iso3 in `countryList' {  //1st loop over country iso3 codes

local url http://ec2-52-1-168-42.compute-1.amazonaws.com/version/1/country_code/`iso3'/indicator_id/`indicator_id'/?structure=icy

foreach Year in `yearList' {
local value="indicator_value:`indicator_id':`iso3':`Year'"
local countryID="country_name:`iso3'"
local indicatorID="indicator_name:`indicator_id'"
insheetjson var1 cname indicator using   "`url'", col("`value'" "`countryID'" "`indicatorID'") offset(`i') 
local ++i
replace year=`Year' in `i'
replace iso3="`iso3'" in `i'
local ii=`i'+1
set obs `ii'
	}
}

local label=indicator[1] // Save indicator label
label var var1 "`label'" // Set indicator label
label var iso3 "County code iso3166"
label var year "Year"
label var cname "Country"


destring var1, replace  // convert results from string to numbers
drop if cname=="" & iso3=="" & var1==. //Get rid of extra obs
replace cname="Côte d'Ivoire" if cname=="C\u00f4te d'" //deals with naming issues
rename var1 v`indicator'
*order cname iso3 year var1
drop indicator

}

}

*===============================================================================
* if all the counntry and years requested, the program use web scrapping  
*===============================================================================

if missing("`yearList'") & missing("`country'") {

quietly {
*Scarp the data from the web 
local url "http://ec2-52-1-168-42.compute-1.amazonaws.com/version/1/indicator_id/`indicator'/?structure=icy"
copy "`url'" "test0.txt", replace

*Clean the resulting file
filefilter test0.txt test1.txt, from(\Q) to(¤) replace //get rid of double quote but preserve their place using ¤
filefilter test1.txt test0.txt, from("{¤indicator_value¤:{¤`indicator'¤:{¤") to("") replace
filefilter test0.txt test1.txt, from("}") to("") replace //get rid of } and {
filefilter test1.txt test0.txt, from("{") to("") replace
filefilter test0.txt test1.txt, from("¤:¤") to(",") replace
filefilter test1.txt test0.txt, from("¤") to(",") replace
filefilter test0.txt data.csv, from(",,") to("") replace //save as csv

import delimited data.csv, varnames(nonames) clear 

sxpose, clear force

capture rename _var1 v1
capture erase  "test1.txt"
capture erase "data.csv" 
capture erase"test0.txt"
**************************

desc v1
local obs `r(N)'

local isolist AGO AFG ALB DZA AND AGO ATG ARG ARM AUS AUT AZE BHS BHR BGD BRB BLR BEL BLZ BEN BTN BOL BIH BWA BRA BRN BGR BFA BDI KHM CMR CAN CPV CAF TCD CHL CHN COL COM COG COD CRI CIV HRV CUB CYP CZE DNK DJI DMA DOM ECU EGY SLV GNQ ERI EST ETH FJI FIN FRA GAB GMB GEO DEU GHA GRC GRD GTM GIN GNB GUY HTI HND HKG HUN ISL IND IDN IRN IRQ IRL ISR ITA JAM JPN JOR KAZ KEN KIR PRK KOR KWT KGZ LAO LVA LBN LSO LBR LBY LIE LTU LUX MKD MDG MWI MYS MDV MLI MLT MHL MRT MUS MEX FSM MDA MCO MNG MNE MAR MOZ MMR NAM NRU NPL NLD NZL NIC NER NGA NOR PSE OMN PAK PLW PAN PNG PRY PER PHL POL PRT QAT ROU RUS RWA KNA LCA VCT WSM SMR STP SAU SEN SRB SYC SLE SGP SVK SVN SLB SOM ZAF ESP LKA SDN SUR SWZ SWE CHE SYR TJK TZA THA TLS TGO TON TTO TUN TUR TKM TUV UGA UKR ARE GBR USA URY UZB VUT VEN VNM YEM ZMB ZWE SSD
*local yearLIST Year_1980 Year_1985 Year_1990 Year_1995 Year_2000 Year_2005 Year_2006 Year_2007 Year_2008 Year_2009 Year_2010 Year_2011 Year_2012 Year_2013
local yearList 1980 1985 1990 1995 2000 2005 2006 2007 2008 2009 2010 2011 2012 2013
****
capture gen v2=v1
capture gen v3=v1
foreach char in `yearList' {
capture replace v1="" if v1=="`char'" 
capture replace v3="" if v3=="`char'" 
}
foreach char in `isolist ' {
capture replace v1="" if v1=="`char'" 
}

replace v3="" if v3==v1
replace v2="" if v2==v1
replace v2="" if v2==v3

*****
gen n=_n
levelsof n if v1=="country_name", local(n)
local N=_N
drop in `n'/`N'
drop n

desc v3
local obs `r(N)'
capture gen iso=""
forval b=0/`obs' {
if `b'==0 replace iso=v3[1] in 1
if `b'>0 { 
local a=`b'-1
if v3[`b']!="" | v3[`b']!="." replace iso=v3[`b'] in `b'
if v3[`b']=="" | v3[`b']=="." replace iso=iso[`a'] in `b'
	}
}

desc v2
local obs `r(N)'
capture gen year=""
forval b=1/`obs' {
if `b'==1 replace year=v2[2] in 2
if `b'>0 { 
local a=`b'-1
if v2[`b']!="" | v2[`b']!="." replace year=v2[`b'] in `b'
if v2[`b']=="" | v2[`b']=="." replace year=year[`a'] in `b'
	}
}
drop v2 v3
drop if v1==""
label var v1 "`label'"
label var iso "County code iso3166"
label var year "Year"

destring v1, replace
format v1 %12.3fc

rename v1 v`indicator'
destring year, replace
ren iso iso3
capture gen cname=""

# delimit ;
capture replace cname="Afghanistan" if iso3=="AFG";	capture replace cname="Albania" if iso3=="ALB";	capture replace cname="Antarctica" if iso3=="ATA";	capture replace cname="Algeria" if iso3=="DZA";	capture replace cname="American Samoa" if iso3=="ASM";	capture replace cname="Andorra" if iso3=="AND";	capture replace cname="Angola" if iso3=="AGO";	capture replace cname="Antigua and Barbuda" if iso3=="ATG";	capture replace cname="Azerbaijan" if iso3=="AZE";	capture replace cname="Argentina" if iso3=="ARG";	capture replace cname="Australia" if iso3=="AUS";	capture replace cname="Austria" if iso3=="AUT";	capture replace cname="Bahamas" if iso3=="BHS";	capture replace cname="Bahrain" if iso3=="BHR";	capture replace cname="Bangladesh" if iso3=="BGD";	capture replace cname="Armenia" if iso3=="ARM";	capture replace cname="Barbados" if iso3=="BRB";	capture replace cname="Belgium" if iso3=="BEL";	capture replace cname="Bermuda" if iso3=="BMU";	capture replace cname="Bhutan" if iso3=="BTN";	capture replace cname="Bolivia, Plurinational State of" if iso3=="BOL";	capture replace cname="Bosnia and Herzegovina" if iso3=="BIH";	capture replace cname="Botswana" if iso3=="BWA";	capture replace cname="Bouvet Island" if iso3=="BVT";	capture replace cname="Brazil" if iso3=="BRA";	capture replace cname="Belize" if iso3=="BLZ";	capture replace cname="British Indian Ocean Territory" if iso3=="IOT";	capture replace cname="Solomon Islands" if iso3=="SLB";	capture replace cname="Virgin Islands, British" if iso3=="VGB";	capture replace cname="Brunei Darussalam" if iso3=="BRN";	capture replace cname="Bulgaria" if iso3=="BGR";	capture replace cname="Myanmar" if iso3=="MMR";	capture replace cname="Burundi" if iso3=="BDI";	capture replace cname="Belarus" if iso3=="BLR";	capture replace cname="Cambodia" if iso3=="KHM";	capture replace cname="Cameroon" if iso3=="CMR";	capture replace cname="Canada" if iso3=="CAN";	capture replace cname="Cape Verde" if iso3=="CPV";	capture replace cname="Cayman Islands" if iso3=="CYM";	capture replace cname="Central African Republic" if iso3=="CAF";	capture replace cname="Sri Lanka" if iso3=="LKA";	capture replace cname="Chad" if iso3=="TCD";	capture replace cname="Chile" if iso3=="CHL";	capture replace cname="China" if iso3=="CHN";	capture replace cname="Taiwan, Province of China" if iso3=="TWN";	capture replace cname="Christmas Island" if iso3=="CXR";	capture replace cname="Cocos (Keeling) Islands" if iso3=="CCK";	capture replace cname="Colombia" if iso3=="COL";	capture replace cname="Comoros" if iso3=="COM";	capture replace cname="Mayotte" if iso3=="MYT";	capture replace cname="Congo" if iso3=="COG";	capture replace cname="Congo, the Democratic Republic of the" if iso3=="COD";	capture replace cname="Cook Islands" if iso3=="COK";	capture replace cname="Costa Rica" if iso3=="CRI";	capture replace cname="Croatia" if iso3=="HRV";	capture replace cname="Cuba" if iso3=="CUB";	capture replace cname="Cyprus" if iso3=="CYP";	capture replace cname="Czech Republic" if iso3=="CZE";	capture replace cname="Benin" if iso3=="BEN";	capture replace cname="Denmark" if iso3=="DNK";	capture replace cname="Dominica" if iso3=="DMA";	capture replace cname="Dominican Republic" if iso3=="DOM";	capture replace cname="Ecuador" if iso3=="ECU";	capture replace cname="El Salvador" if iso3=="SLV";	capture replace cname="Equatorial Guinea" if iso3=="GNQ";	capture replace cname="Ethiopia" if iso3=="ETH";	capture replace cname="Eritrea" if iso3=="ERI";	capture replace cname="Estonia" if iso3=="EST";	capture replace cname="Faroe Islands" if iso3=="FRO";	capture replace cname="Falkland Islands (Malvinas)" if iso3=="FLK";	capture replace cname="South Georgia and the South Sandwich Islands" if iso3=="SGS";	capture replace cname="Fiji" if iso3=="FJI";	capture replace cname="Finland" if iso3=="FIN";	capture replace cname="Aland Islands" if iso3=="ALA";	capture replace cname="France" if iso3=="FRA";	capture replace cname="French Guiana" if iso3=="GUF";	capture replace cname="French Polynesia" if iso3=="PYF";	capture replace cname="French Southern Territories" if iso3=="ATF";	capture replace cname="Djibouti" if iso3=="DJI";	capture replace cname="Gabon" if iso3=="GAB";	capture replace cname="Georgia" if iso3=="GEO";	capture replace cname="Gambia" if iso3=="GMB";	capture replace cname="Palestinian Territory, Occupied" if iso3=="PSE";	capture replace cname="Germany" if iso3=="DEU";	capture replace cname="Ghana" if iso3=="GHA";	capture replace cname="Gibraltar" if iso3=="GIB";	capture replace cname="Kiribati" if iso3=="KIR";	capture replace cname="Greece" if iso3=="GRC";	capture replace cname="Greenland" if iso3=="GRL";	capture replace cname="Grenada" if iso3=="GRD";	capture replace cname="Guadeloupe" if iso3=="GLP";	capture replace cname="Guam" if iso3=="GUM";	capture replace cname="Guatemala" if iso3=="GTM";	capture replace cname="Guinea" if iso3=="GIN";	capture replace cname="Guyana" if iso3=="GUY";	capture replace cname="Haiti" if iso3=="HTI";	capture replace cname="Heard Island and McDonald Islands" if iso3=="HMD";	capture replace cname="Holy See (Vatican City State)" if iso3=="VAT";	capture replace cname="Honduras" if iso3=="HND";	capture replace cname="Hong Kong" if iso3=="HKG";	capture replace cname="Hungary" if iso3=="HUN";	capture replace cname="Iceland" if iso3=="ISL";	capture replace cname="India" if iso3=="IND";	capture replace cname="Indonesia" if iso3=="IDN";	capture replace cname="Iran, Islamic Republic of" if iso3=="IRN";	capture replace cname="Iraq" if iso3=="IRQ";	capture replace cname="Ireland" if iso3=="IRL";	capture replace cname="Israel" if iso3=="ISR";	capture replace cname="Italy" if iso3=="ITA";	capture replace cname="Côte d'Ivoire" if iso3=="CIV";	capture replace cname="Jamaica" if iso3=="JAM";	capture replace cname="Japan" if iso3=="JPN";	capture replace cname="Kazakhstan" if iso3=="KAZ";	capture replace cname="Jordan" if iso3=="JOR";	capture replace cname="Kenya" if iso3=="KEN";	capture replace cname="Korea, Democratic People's Republic of" if iso3=="PRK";	capture replace cname="Korea, Republic of" if iso3=="KOR";	capture replace cname="Kuwait" if iso3=="KWT";	capture replace cname="Kyrgyzstan" if iso3=="KGZ";	capture replace cname="Lao People's Democratic Republic" if iso3=="LAO";	capture replace cname="Lebanon" if iso3=="LBN";	capture replace cname="Lesotho" if iso3=="LSO";	capture replace cname="Latvia" if iso3=="LVA";	capture replace cname="Liberia" if iso3=="LBR";	capture replace cname="Libya" if iso3=="LBY";	capture replace cname="Liechtenstein" if iso3=="LIE";	capture replace cname="Lithuania" if iso3=="LTU";	capture replace cname="Luxembourg" if iso3=="LUX";	capture replace cname="Macao" if iso3=="MAC";	capture replace cname="Madagascar" if iso3=="MDG";	capture replace cname="Malawi" if iso3=="MWI";	capture replace cname="Malaysia" if iso3=="MYS";	capture replace cname="Maldives" if iso3=="MDV";	capture replace cname="Mali" if iso3=="MLI";	capture replace cname="Malta" if iso3=="MLT";	capture replace cname="Martinique" if iso3=="MTQ";	capture replace cname="Mauritania" if iso3=="MRT";	capture replace cname="Mauritius" if iso3=="MUS";	capture replace cname="Mexico" if iso3=="MEX";	capture replace cname="Monaco" if iso3=="MCO";	capture replace cname="Mongolia" if iso3=="MNG";	capture replace cname="Moldova, Republic of" if iso3=="MDA";	capture replace cname="Montenegro" if iso3=="MNE";	capture replace cname="Montserrat" if iso3=="MSR";	capture replace cname="Morocco" if iso3=="MAR";	capture replace cname="Mozambique" if iso3=="MOZ";	capture replace cname="Oman" if iso3=="OMN";	capture replace cname="Namibia" if iso3=="NAM";	capture replace cname="Nauru" if iso3=="NRU";	capture replace cname="Nepal" if iso3=="NPL";	capture replace cname="Netherlands" if iso3=="NLD";	capture replace cname="Curaçao" if iso3=="CUW";	capture replace cname="Aruba" if iso3=="ABW";	capture replace cname="Sint Maarten (Dutch part)" if iso3=="SXM";	capture replace cname="Bonaire, Sint Eustatius and Saba" if iso3=="BES";	capture replace cname="New Caledonia" if iso3=="NCL";	capture replace cname="Vanuatu" if iso3=="VUT";	capture replace cname="New Zealand" if iso3=="NZL";	capture replace cname="Nicaragua" if iso3=="NIC";	capture replace cname="Niger" if iso3=="NER";	capture replace cname="Nigeria" if iso3=="NGA";	capture replace cname="Niue" if iso3=="NIU";	capture replace cname="Norfolk Island" if iso3=="NFK";	capture replace cname="Norway" if iso3=="NOR";	capture replace cname="Northern Mariana Islands" if iso3=="MNP";	capture replace cname="United States Minor Outlying Islands" if iso3=="UMI";	capture replace cname="Micronesia, Federated States of" if iso3=="FSM";	capture replace cname="Marshall Islands" if iso3=="MHL";	capture replace cname="Palau" if iso3=="PLW";	capture replace cname="Pakistan" if iso3=="PAK";	capture replace cname="Panama" if iso3=="PAN";	capture replace cname="Papua New Guinea" if iso3=="PNG";	capture replace cname="Paraguay" if iso3=="PRY";	capture replace cname="Peru" if iso3=="PER";	capture replace cname="Philippines" if iso3=="PHL";	capture replace cname="Pitcairn" if iso3=="PCN";	capture replace cname="Poland" if iso3=="POL";	capture replace cname="Portugal" if iso3=="PRT";	capture replace cname="Guinea-Bissau" if iso3=="GNB";	capture replace cname="Timor-Leste" if iso3=="TLS";	capture replace cname="Puerto Rico" if iso3=="PRI";	capture replace cname="Qatar" if iso3=="QAT";	capture replace cname="Réunion" if iso3=="REU";	capture replace cname="Romania" if iso3=="ROU";	capture replace cname="Russian Federation" if iso3=="RUS";	capture replace cname="Rwanda" if iso3=="RWA";	capture replace cname="Saint Barthélemy" if iso3=="BLM";	capture replace cname="Saint Helena, Ascension and Tristan da Cunha" if iso3=="SHN";	capture replace cname="Saint Kitts and Nevis" if iso3=="KNA";	capture replace cname="Anguilla" if iso3=="AIA";	capture replace cname="Saint Lucia" if iso3=="LCA";	capture replace cname="Saint Martin (French part)" if iso3=="MAF";	capture replace cname="Saint Pierre and Miquelon" if iso3=="SPM";	capture replace cname="Saint Vincent and the Grenadines" if iso3=="VCT";	capture replace cname="San Marino" if iso3=="SMR";	capture replace cname="Sao Tome and Principe" if iso3=="STP";	capture replace cname="Saudi Arabia" if iso3=="SAU";	capture replace cname="Senegal" if iso3=="SEN";	capture replace cname="Serbia" if iso3=="SRB";	capture replace cname="Seychelles" if iso3=="SYC";	capture replace cname="Sierra Leone" if iso3=="SLE";	capture replace cname="Singapore" if iso3=="SGP";	capture replace cname="Slovakia" if iso3=="SVK";	capture replace cname="Viet Nam" if iso3=="VNM";	capture replace cname="Slovenia" if iso3=="SVN";	capture replace cname="Somalia" if iso3=="SOM";	capture replace cname="South Africa" if iso3=="ZAF";	capture replace cname="Zimbabwe" if iso3=="ZWE";	capture replace cname="Spain" if iso3=="ESP";	capture replace cname="South Sudan" if iso3=="SSD";	capture replace cname="Sudan" if iso3=="SDN";	capture replace cname="Western Sahara" if iso3=="ESH";	capture replace cname="Suriname" if iso3=="SUR";	capture replace cname="Svalbard and Jan Mayen" if iso3=="SJM";	capture replace cname="Swaziland" if iso3=="SWZ";	capture replace cname="Sweden" if iso3=="SWE";	capture replace cname="Switzerland" if iso3=="CHE";	capture replace cname="Syrian Arab Republic" if iso3=="SYR";	capture replace cname="Tajikistan" if iso3=="TJK";	capture replace cname="Thailand" if iso3=="THA";	capture replace cname="Togo" if iso3=="TGO";	capture replace cname="Tokelau" if iso3=="TKL";	capture replace cname="Tonga" if iso3=="TON";	capture replace cname="Trinidad and Tobago" if iso3=="TTO";	capture replace cname="United Arab Emirates" if iso3=="ARE";	capture replace cname="Tunisia" if iso3=="TUN";	capture replace cname="Turkey" if iso3=="TUR";	capture replace cname="Turkmenistan" if iso3=="TKM";	capture replace cname="Turks and Caicos Islands" if iso3=="TCA";	capture replace cname="Tuvalu" if iso3=="TUV";	capture replace cname="Uganda" if iso3=="UGA";	capture replace cname="Ukraine" if iso3=="UKR";	capture replace cname="Macedonia, the former Yugoslav Republic of" if iso3=="MKD";	capture replace cname="Egypt" if iso3=="EGY";	capture replace cname="United Kingdom" if iso3=="GBR";	capture replace cname="Guernsey" if iso3=="GGY";	capture replace cname="Jersey" if iso3=="JEY";	capture replace cname="Isle of Man" if iso3=="IMN";	capture replace cname="Tanzania, United Republic of" if iso3=="TZA";	capture replace cname="United States" if iso3=="USA";	capture replace cname="Virgin Islands, U.S." if iso3=="VIR";	capture replace cname="Burkina Faso" if iso3=="BFA";	capture replace cname="Uruguay" if iso3=="URY";	capture replace cname="Uzbekistan" if iso3=="UZB";	capture replace cname="Venezuela, Bolivarian Republic of" if iso3=="VEN";	capture replace cname="Wallis and Futuna" if iso3=="WLF";	capture replace cname="Samoa" if iso3=="WSM";	capture replace cname="Yemen" if iso3=="YEM";	capture replace cname="Zambia" if iso3=="ZMB";
#delimit cr
label var cname "Country"
order cname iso3 year

 }

}

end

