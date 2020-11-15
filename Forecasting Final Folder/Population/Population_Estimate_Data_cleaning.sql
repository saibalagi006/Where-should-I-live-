--select *
--from unemployment_data

--select *
--from Population_Estimates_Data

--select *
--from Population_Estimate_fcst_input


--select *
--from County_Info_Final

drop table Population_Estimate_fcst_input

create table Population_Estimate_fcst_input(
FIPS Varchar(255),
County_Name varchar(255),
State_code varchar(255),
State_Name varchar(255),
year numeric(18,0),
POP_ESTIMATE numeric(18,0),
N_POP_CHANGE numeric(18,0),
Births numeric(18,0),
Deaths numeric(18,0),
Natural_Inc numeric(18,0),
International_Mig numeric(18,0),
Domestic_Mig numeric(18,0),
Net_Mig numeric(18,0),
Residual numeric(18,0),
GQ_Estimate numeric(18,0),
Birth_Rate float,
Death_Rate float,
Natural_Inc_Rate float,
International_Mig_Rate float,
Domestic_Mig_Rate float,
Net_Mig_Rate float
);


select distinct b.FIPS,
				b.County_Name,
				b.State_Name,
				b.State_Code
		into #temp1
from Population_Estimates_Data a
join County_Info_Final b
on a.FIPS=b.FIPS


select 2011 as year into #year union
select 2012 union
select 2013 union
select 2014 union
select 2015 union
select 2016 union
select 2017 union
select 2018 union
select 2019 union
select 2020 union
select 2021 union
select 2022 union
select 2023


select a.*, b.year
into #temp2
from #temp1 a
cross join #year b


insert into Population_Estimate_fcst_input
select 
 FIPS ,
County_Name ,
State_code ,
State_Name,
year ,
0 as POP_ESTIMATE ,
0 as N_POP_CHANGE,
0 Births,
0 Deaths,
0 Natural_Inc ,
0 International_Mig ,
0 Domestic_Mig ,
0 Net_Mig,
0 Residual,
0 GQ_Estimate ,
0.0 Birth_Rate ,
0.0 Death_Rate ,
0.0 Natural_Inc_Rate ,
0.0 International_Mig_Rate ,
0.0 Domestic_Mig_Rate ,
0.0 Net_Mig_Rate 
from #temp2 a

update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2011,
	N_POP_CHANGE=b.N_POP_CHG_2011,
	Births=b.Births_2011,
	Deaths=b.Deaths_2011,
	Natural_Inc=b.NATURAL_INC_2011,
	International_Mig=b.[INTERNATIONALMIG-2011],
	Domestic_Mig=DOMESTIC_MIG_2011,
	Net_Mig=b.NET_MIG_2011,
	Residual=b.RESIDUAL_2011,
	GQ_Estimate=b.GQ_ESTIMATES_2011,
	Birth_Rate=b.R_birth_2011,
	Death_Rate=b.R_death_2011,
	Natural_Inc_Rate=b.R_NATURAL_INC_2011,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2011,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2011,
	Net_Mig_Rate=b.R_NET_MIG_2011
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2011


update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2012,
	N_POP_CHANGE=b.N_POP_CHG_2012,
	Births=b.Births_2012,
	Deaths=b.Deaths_2012,
	Natural_Inc=b.NATURAL_INC_2012,
	International_Mig=b.INTERNATIONAL_MIG_2012,
	Domestic_Mig=DOMESTIC_MIG_2012,
	Net_Mig=b.NET_MIG_2012,
	Residual=b.RESIDUAL_2012,
	GQ_Estimate=b.GQ_ESTIMATES_2012,
	Birth_Rate=b.R_birth_2012,
	Death_Rate=b.R_death_2012,
	Natural_Inc_Rate=b.R_NATURAL_INC_2012,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2012,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2012,
	Net_Mig_Rate=b.R_NET_MIG_2012
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2012

update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2013,
	N_POP_CHANGE=b.N_POP_CHG_2013,
	Births=b.Births_2013,
	Deaths=b.Deaths_2013,
	Natural_Inc=b.NATURAL_INC_2013,
	International_Mig=b.INTERNATIONAL_MIG_2013,
	Domestic_Mig=DOMESTIC_MIG_2013,
	Net_Mig=b.NET_MIG_2013,
	Residual=b.RESIDUAL_2013,
	GQ_Estimate=b.GQ_ESTIMATES_2013,
	Birth_Rate=b.R_birth_2013,
	Death_Rate=b.R_death_2013,
	Natural_Inc_Rate=b.R_NATURAL_INC_2013,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2013,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2013,
	Net_Mig_Rate=b.R_NET_MIG_2013
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2013

update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2014,
	N_POP_CHANGE=b.N_POP_CHG_2014,
	Births=b.Births_2014,
	Deaths=b.Deaths_2014,
	Natural_Inc=b.NATURAL_INC_2014,
	International_Mig=b.INTERNATIONAL_MIG_2014,
	Domestic_Mig=DOMESTIC_MIG_2014,
	Net_Mig=b.NET_MIG_2014,
	Residual=b.RESIDUAL_2014,
	GQ_Estimate=b.GQ_ESTIMATES_2014,
	Birth_Rate=b.R_birth_2014,
	Death_Rate=b.R_death_2014,
	Natural_Inc_Rate=b.R_NATURAL_INC_2014,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2014,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2014,
	Net_Mig_Rate=b.R_NET_MIG_2014
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2014


update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2015,
	N_POP_CHANGE=b.N_POP_CHG_2015,
	Births=b.Births_2015,
	Deaths=b.Deaths_2015,
	Natural_Inc=b.NATURAL_INC_2015,
	International_Mig=b.INTERNATIONAL_MIG_2015,
	Domestic_Mig=DOMESTIC_MIG_2015,
	Net_Mig=b.NET_MIG_2015,
	Residual=b.RESIDUAL_2015,
	GQ_Estimate=b.GQ_ESTIMATES_2015,
	Birth_Rate=b.R_birth_2015,
	Death_Rate=b.R_death_2015,
	Natural_Inc_Rate=b.R_NATURAL_INC_2015,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2015,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2015,
	Net_Mig_Rate=b.R_NET_MIG_2015
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2015


update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2016,
	N_POP_CHANGE=b.N_POP_CHG_2016,
	Births=b.Births_2016,
	Deaths=b.Deaths_2016,
	Natural_Inc=b.NATURAL_INC_2016,
	International_Mig=b.INTERNATIONAL_MIG_2016,
	Domestic_Mig=DOMESTIC_MIG_2016,
	Net_Mig=b.NET_MIG_2016,
	Residual=b.RESIDUAL_2016,
	GQ_Estimate=b.GQ_ESTIMATES_2016,
	Birth_Rate=b.R_birth_2016,
	Death_Rate=b.R_death_2016,
	Natural_Inc_Rate=b.R_NATURAL_INC_2016,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2016,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2016,
	Net_Mig_Rate=b.R_NET_MIG_2016
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2016


update Population_Estimate_fcst_input
set pop_Estimate=b.POP_ESTIMATE_2017,
	N_POP_CHANGE=b.N_POP_CHG_2017,
	Births=b.Births_2017,
	Deaths=b.Deaths_2017,
	Natural_Inc=b.NATURAL_INC_2017,
	International_Mig=b.INTERNATIONAL_MIG_2017,
	Domestic_Mig=DOMESTIC_MIG_2017,
	Net_Mig=b.NET_MIG_2017,
	Residual=b.RESIDUAL_2017,
	GQ_Estimate=b.GQ_ESTIMATES_2017,
	Birth_Rate=b.R_birth_2017,
	Death_Rate=b.R_death_2017,
	Natural_Inc_Rate=b.R_NATURAL_INC_2017,
	International_Mig_Rate=b.R_INTERNATIONAL_MIG_2017,
	Domestic_Mig_Rate=b.R_DOMESTIC_MIG_2017,
	Net_Mig_Rate=b.R_NET_MIG_2017
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2017



select 
FIPS,
County_Name,
State_code,
State_Name,
2018 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2018
from Population_Estimate_fcst_input
where year in (2015,2016,2017)
group by FIPS,
County_Name,
State_code,
State_Name


update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2018 b
on a.fips=b.fips
where a.year=2018

select 
FIPS,
County_Name,
State_code,
State_Name,
2019 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2019
from Population_Estimate_fcst_input
where year in (2016,2017,2018)
group by FIPS,
County_Name,
State_code,
State_Name


update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2019 b
on a.fips=b.fips
where a.year=2019

select 
FIPS,
County_Name,
State_code,
State_Name,
2020 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2020
from Population_Estimate_fcst_input
where year in (2017,2018,2019)
group by FIPS,
County_Name,
State_code,
State_Name


update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2020 b
on a.fips=b.fips
where a.year=2020

select 
FIPS,
County_Name,
State_code,
State_Name,
2021 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2021
from Population_Estimate_fcst_input
where year in (2018,2019,2020)
group by FIPS,
County_Name,
State_code,
State_Name


update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2021 b
on a.fips=b.fips
where a.year=2021

select 
FIPS,
County_Name,
State_code,
State_Name,
2022 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2022
from Population_Estimate_fcst_input
where year in (2019,2020,2021)
group by FIPS,
County_Name,
State_code,
State_Name


update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2022 b
on a.fips=b.fips
where a.year=2022

select 
FIPS,
County_Name,
State_code,
State_Name,
2023 as year,
0 as POP_ESTIMATE,
avg(N_POP_CHANGE) as N_POP_CHANGE,
avg(Births) as Births,
avg(Deaths) as Deaths,
avg(Natural_Inc) as Natural_Inc,
avg(International_Mig) as International_Mig,
avg(Domestic_Mig) as Domestic_Mig,
avg(Net_Mig) as Net_Mig,
avg(Residual) as Residual,
avg(GQ_Estimate) as GQ_Estimate,
avg(Birth_Rate) as Birth_Rate,
avg(Death_Rate) as Death_Rate,
avg(Natural_Inc_Rate) as Natural_Inc_Rate,
avg(International_Mig_Rate) as International_Mig_Rate,
avg(Domestic_Mig_Rate) as Domestic_Mig_Rate,
avg(Net_Mig_Rate) as Net_Mig_Rate
into #2023
from Population_Estimate_fcst_input
where year in (2020,2021,2022)
group by FIPS,
County_Name,
State_code,
State_Name





update Population_Estimate_fcst_input
set 
FIPS=b.FIPS,
County_Name=b.County_Name,
State_code=b.State_code,
State_Name=b.State_Name,
year=b.year,
POP_ESTIMATE=b.POP_ESTIMATE,
N_POP_CHANGE=b.N_POP_CHANGE,
Births=b.Births,
Deaths=b.Deaths,
Natural_Inc=b.Natural_Inc,
International_Mig=b.International_Mig,
Domestic_Mig=b.Domestic_Mig,
Net_Mig=b.Net_Mig,
Residual=b.Residual,
GQ_Estimate=b.GQ_Estimate,
Birth_Rate=b.Birth_Rate,
Death_Rate=b.Death_Rate,
Natural_Inc_Rate=b.Natural_Inc_Rate,
International_Mig_Rate=b.International_Mig_Rate,
Domestic_Mig_Rate=b.Domestic_Mig_Rate,
Net_Mig_Rate=b.Net_Mig_Rate
from Population_Estimate_fcst_input a
join #2023 b
on a.fips=b.fips
where a.year=2023



select *
from Population_Estimate_fcst_input
order by fips, year





/*


update Population_Estimate_fcst_input
set pop_Estimate=0.7*b.POP_ESTIMATE_2017+0.2*B.POP_ESTIMATE_2016+0.1*B.POP_ESTIMATE_2015,
	N_POP_CHANGE=0.7*b.N_POP_CHG_2017+0.2*B.N_POP_CHG_2016+0.1*B.N_POP_CHG_2015,
	Births=0.7*b.Births_2017+0.2*B.Births_2016+0.1*B.Births_2015,
	Deaths=0.7*b.Deaths_2017+0.2*Deaths_2016+0.1*Deaths_2015,
	Natural_Inc=0.7*b.NATURAL_INC_2017+0.2*B.NATURAL_INC_2016+0.1*B.NATURAL_INC_2015,
	International_Mig=0.7*b.INTERNATIONAL_MIG_2017+0.2*B.INTERNATIONAL_MIG_2016+0.1*B.INTERNATIONAL_MIG_2015,
	Domestic_Mig=0.7*B.DOMESTIC_MIG_2017+0.2*B.DOMESTIC_MIG_2016+0.1*B.DOMESTIC_MIG_2015,
	Net_Mig=0.7*b.NET_MIG_2017+0.2*B.NET_MIG_2016+0.1*B.NET_MIG_2015,
	Residual=0.7*b.RESIDUAL_2017+0.2*B.RESIDUAL_2016+0.1*B.RESIDUAL_2015,
	GQ_Estimate=0.7*b.GQ_ESTIMATES_2017+0.2*B.GQ_ESTIMATES_2016+0.1*B.GQ_ESTIMATES_2015,
	Birth_Rate=0.7*b.R_birth_2017+0.2*B.R_birth_2016+0.1*B.R_birth_2015,
	Death_Rate=0.7*b.R_death_2017+0.2*B.R_death_2016+0.1*B.R_death_2015,
	Natural_Inc_Rate=0.7*b.R_NATURAL_INC_2017+0.2*B.R_NATURAL_INC_2016+0.1*B.R_NATURAL_INC_2015,
	International_Mig_Rate=0.7*b.R_INTERNATIONAL_MIG_2017+0.2*B.R_INTERNATIONAL_MIG_2016+0.1*B.R_INTERNATIONAL_MIG_2015,
	Domestic_Mig_Rate=0.7*b.R_DOMESTIC_MIG_2017+0.2*B.R_DOMESTIC_MIG_2016+0.1*B.R_DOMESTIC_MIG_2015,
	Net_Mig_Rate=0.7*b.R_NET_MIG_2017+0.2*B.R_NET_MIG_2016+0.1*B.R_NET_MIG_2015
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2018



update Population_Estimate_fcst_input
set pop_Estimate=0.7*b.POP_ESTIMATE_2018+0.2*B.POP_ESTIMATE_2017+0.1*B.POP_ESTIMATE_2016,
	N_POP_CHANGE=0.7*b.N_POP_CHG_2017+0.2*B.N_POP_CHG_2016+0.1*B.N_POP_CHG_2015,
	Births=0.7*b.Births_2017+0.2*B.Births_2016+0.1*B.Births_2015,
	Deaths=0.7*b.Deaths_2017+0.2*Deaths_2016+0.1*Deaths_2015,
	Natural_Inc=0.7*b.NATURAL_INC_2017+0.2*B.NATURAL_INC_2016+0.1*B.NATURAL_INC_2015,
	International_Mig=0.7*b.INTERNATIONAL_MIG_2017+0.2*B.INTERNATIONAL_MIG_2016+0.1*B.INTERNATIONAL_MIG_2015,
	Domestic_Mig=0.7*B.DOMESTIC_MIG_2017+0.2*B.DOMESTIC_MIG_2016+0.1*B.DOMESTIC_MIG_2015,
	Net_Mig=0.7*b.NET_MIG_2017+0.2*B.NET_MIG_2016+0.1*B.NET_MIG_2015,
	Residual=0.7*b.RESIDUAL_2017+0.2*B.RESIDUAL_2016+0.1*B.RESIDUAL_2015,
	GQ_Estimate=0.7*b.GQ_ESTIMATES_2017+0.2*B.GQ_ESTIMATES_2016+0.1*B.GQ_ESTIMATES_2015,
	Birth_Rate=0.7*b.R_birth_2017+0.2*B.R_birth_2016+0.1*B.R_birth_2015,
	Death_Rate=0.7*b.R_death_2017+0.2*B.R_death_2016+0.1*B.R_death_2015,
	Natural_Inc_Rate=0.7*b.R_NATURAL_INC_2017+0.2*B.R_NATURAL_INC_2016+0.1*B.R_NATURAL_INC_2015,
	International_Mig_Rate=0.7*b.R_INTERNATIONAL_MIG_2017+0.2*B.R_INTERNATIONAL_MIG_2016+0.1*B.R_INTERNATIONAL_MIG_2015,
	Domestic_Mig_Rate=0.7*b.R_DOMESTIC_MIG_2017+0.2*B.R_DOMESTIC_MIG_2016+0.1*B.R_DOMESTIC_MIG_2015,
	Net_Mig_Rate=0.7*b.R_NET_MIG_2017+0.2*B.R_NET_MIG_2016+0.1*B.R_NET_MIG_2015
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2019






update Population_Estimate_fcst_input
set pop_Estimate=0.7*b.POP_ESTIMATE_2017+0.2*B.POP_ESTIMATE_2016+0.1*B.POP_ESTIMATE_2015,
	N_POP_CHANGE=0.7*b.N_POP_CHG_2017+0.2*B.N_POP_CHG_2016+0.1*B.N_POP_CHG_2015,
	Births=0.7*b.Births_2017+0.2*B.Births_2016+0.1*B.Births_2015,
	Deaths=0.7*b.Deaths_2017+0.2*Deaths_2016+0.1*Deaths_2015,
	Natural_Inc=0.7*b.NATURAL_INC_2017+0.2*B.NATURAL_INC_2016+0.1*B.NATURAL_INC_2015,
	International_Mig=0.7*b.INTERNATIONAL_MIG_2017+0.2*B.INTERNATIONAL_MIG_2016+0.1*B.INTERNATIONAL_MIG_2015,
	Domestic_Mig=0.7*B.DOMESTIC_MIG_2017+0.2*B.DOMESTIC_MIG_2016+0.1*B.DOMESTIC_MIG_2015,
	Net_Mig=0.7*b.NET_MIG_2017+0.2*B.NET_MIG_2016+0.1*B.NET_MIG_2015,
	Residual=0.7*b.RESIDUAL_2017+0.2*B.RESIDUAL_2016+0.1*B.RESIDUAL_2015,
	GQ_Estimate=0.7*b.GQ_ESTIMATES_2017+0.2*B.GQ_ESTIMATES_2016+0.1*B.GQ_ESTIMATES_2015,
	Birth_Rate=0.7*b.R_birth_2017+0.2*B.R_birth_2016+0.1*B.R_birth_2015,
	Death_Rate=0.7*b.R_death_2017+0.2*B.R_death_2016+0.1*B.R_death_2015,
	Natural_Inc_Rate=0.7*b.R_NATURAL_INC_2017+0.2*B.R_NATURAL_INC_2016+0.1*B.R_NATURAL_INC_2015,
	International_Mig_Rate=0.7*b.R_INTERNATIONAL_MIG_2017+0.2*B.R_INTERNATIONAL_MIG_2016+0.1*B.R_INTERNATIONAL_MIG_2015,
	Domestic_Mig_Rate=0.7*b.R_DOMESTIC_MIG_2017+0.2*B.R_DOMESTIC_MIG_2016+0.1*B.R_DOMESTIC_MIG_2015,
	Net_Mig_Rate=0.7*b.R_NET_MIG_2017+0.2*B.R_NET_MIG_2016+0.1*B.R_NET_MIG_2015
from Population_Estimate_fcst_input a
join Population_Estimates_Data b
on a.FIPS=b.FIPS
where a.year=2018





select *
from unemployment_data

*/