{smcl}
{hline}
help for {hdr:hdrdata}{right:(Thomas Roca - UNDP HDRO || Agence Française de Développement)}
{hline}

{title:Loads Human Development Report Office data via API}

{title:Syntax}
{p 8 17 2} {cmdab:hdrdata} 
[ {cmd:,} {it:options} ]

{title:Description}

{p 4 4 2}
{cmd:hdrdata} hdrdata loads Human Development Report Office data via HDRO'API (see:{browse "http://hdr.undp.org/en/content/developers-data-api": http://hdr.undp.org/en/content/developers-data-api})

To use this program you have to intal insheetjson and libjson via the archices: 'ssc install insheetjon' and 'ssc install libjson'

The program connect to HDRO's API and load the data according to the indicator, year(s) and country(ies) you requieried:
You can find the list of indicators available on UNDP HDRO website see:{browse "http://hdr.undp.org/en/content/developers-data-api": http://hdr.undp.org/en/content/developers-data-api}
or here: 

36806  :  Adolescent birth rate (women aged 15-19 years)
101406 :  Adult literacy rate, both sexes
27706  :  Carbon dioxide emissions per capita
98106  :  Change in forest area, 1990/2011
105906 :  Combined gross enrollment in education (both sexes)
103706 :  Education index
43106  :  Employment to population ratio, population 25+
123506 :  Estimated GNI per capita (PPP), female
123606 :  Estimated GNI per capita (PPP), male
69706  :  Expected Years of Schooling (of children)
123306 :  Expected years of schooling, females
123406 :  Expected years of schooling, males
38006  :  Expenditure on education, Public (% of GDP)
53906  :  Expenditure on health, total (% of GDP)
136906 :  Female HDI
130006 :  Female to male ratio, parliamentary seats
20206  :  GDP per capita (2011 PPP $)
137906 :  Gender Development Index (Female to male ratio of HDI)
68606  :  Gender Inequality Index value
141706 :  GNI per capita in PPP terms (constant 2011 international $)
38606  :  Headcount, percentage of population in multidimensional poverty, (revised)
72206  :  Health index
137506 :  Human development index (HDI) value
103606 :  Income index
135106 :  Income quintile ratio
71406  :  Inequality-adjusted education index
138806 :  Inequality-adjusted HDI value
71606  :  Inequality-adjusted income index
71506  :  Inequality-adjusted life expectancy index
38506  :  Intensity of deprivation
48906  :  Labour force participation rate, female-male ratio
69206  :  Life expectancy at birth
120606 :  Life expectancy at birth, female
121106 :  Life expectancy at birth, male
71206  :  Loss due to inequality in education
71306  :  Loss due to inequality in income
71106  :  Loss due to inequality in life expectancy
137006 :  Male HDI
89006  :  Maternal mortality ratio
24106  :  Mean years of schooling (females aged 25 years and above)
24206  :  Mean years of schooling (males aged 25 years and above)
103006 :  Mean years of schooling (of adults)
38406  :  Multidimensional poverty index value
142506 :  Near poor headcount
122006 :  Old-age dependency ratio, ages 65 and older
73506  :  Overall percentage loss
135206 :  Palma ratio (Highest 10% over lowest 40%)
101006 :  Population in severe poverty (headcount)
38906  :  Population living below $1.25 PPP per day
44706  :  Population living on degraded land
24806  :  Population with at least secondary education, female/male ratio
68006  :  Population, female (thousands)
68106  :  Population, male (thousands)
306    :  Population, total both sexes (thousands)
45106  :  Population, urban (%)
46106  :  Primary school dropout rates
45806  :  Primary school teachers trained to teach
57506  :  Under-five mortality rate
121206 :  Young age dependency ratio, 0-14)


    {it:options}{col 38}alternatives
    {hline 160}
  	{cmdab:indicator}{cmd:(integer)}{col 38}The indicator id you want to load {col 140} 
	{cmdab:country}{cmd:(string)}{col 38}the list of country (iso3160 codes), coma separated. NB. not providing this option will load the data for all countries{col 140} 
	{cmdab:year}{cmd:(integer)}{col 38}the year list for which you want the data, coma separated. NB. not providing this option will load the data for all years{col 140} 
	
{title:Examples}
{p}

{p 4 8 2}{cmd:. hdrdata, indicator(137506) country(AFG,USA,MLI,COG,COD) year(2013)}{p_end}
{p 4 8 2}{cmd:. hdrdata, indicator(306) country(FRA)}{p_end}
{p 4 8 2}{cmd:. hdrdata, indicator(69206)}{p_end}

{title:Acknowledgements}

{p}
Eleonore Fournier-Tombs is the author of the API: kudos to her!
This program is a beta version and relies on the beta version of the API

{title:Author}

{p}
Thomas Roca,PhD, Researcher UNDP - Human Development Report Office, New York | Agence Française de Développement(AFD), France.
Email:{browse "mailto:roca.thomas@gmail.com":roca.thomas@gmail.com}
{p_end}
