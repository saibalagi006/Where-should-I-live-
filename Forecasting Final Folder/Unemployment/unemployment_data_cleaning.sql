--ALTER TABLE Unemployment_Data
--ALTER COLUMN FIPStxt varchar(255);

--update Unemployment_Data
--set FIPStxt='0'+FIPStxt
----select '0'+FIPStxt, *
--from Unemployment_Data
--where len(FIPStxt)=4


--select *
--from unemployment_data_fcst_input

drop table unemployment_data_fcst_input

create table unemployment_data_fcst_input
(FIPS Varchar(255),
County_Name varchar(255),
State_code varchar(255),
State_Name varchar(255),
year numeric(18,0),
civilian_labor_force numeric(18,0),
employed numeric(18,0),
unemployed numeric(18,0),
unemployment_rate numeric(18,0)
);



select distinct b.FIPS,
				b.County_Name,
				b.State_Name,
				b.State_Code
		into #temp1
from Unemployment_Data a
join County_Info_Final b
on a.FIPStxt=b.FIPS


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


insert into unemployment_data_fcst_input
select 
FIPS,
County_Name,
State_code,
State_Name,
year,
0 as civilian_labor_force,
0 as employed,
0 as unemployed,
0 as unemployment_rate
from #temp2

--select *
--from Unemployment_Data


update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2011,
	employed=Employed_2011,
	unemployed=Unemployed_2011,
	unemployment_rate=Unemployment_rate_2011
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2011


update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2012,
	employed=Employed_2012,
	unemployed=Unemployed_2012,
	unemployment_rate=Unemployment_rate_2012
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2012

update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2013,
	employed=Employed_2013,
	unemployed=Unemployed_2013,
	unemployment_rate=Unemployment_rate_2013
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2013

update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2014,
	employed=Employed_2014,
	unemployed=Unemployed_2014,
	unemployment_rate=Unemployment_rate_2014
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2014

update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2015,
	employed=Employed_2015,
	unemployed=Unemployed_2015,
	unemployment_rate=Unemployment_rate_2015
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2015

update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2016,
	employed=Employed_2016,
	unemployed=Unemployed_2016,
	unemployment_rate=Unemployment_rate_2016
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2016

update unemployment_data_fcst_input
set civilian_labor_force=Civilian_labor_force_2017,
	employed=Employed_2017,
	unemployed=Unemployed_2017,
	unemployment_rate=Unemployment_rate_2017
from unemployment_data_fcst_input a
join Unemployment_Data b
on a.FIPS=b.FIPStxt
where a.year=2017


select 
FIPS,
County_Name,
State_code,
State_Name,
2018 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2018
from unemployment_data_fcst_input
where year in (2015,2016, 2017)
group by FIPS,
County_Name,
State_code,
State_Name


update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2018 b
on a.FIPS=b.FIPS
where a.year=2018


select 
FIPS,
County_Name,
State_code,
State_Name,
2019 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2019
from unemployment_data_fcst_input
where year in (2016,2017, 2018)
group by FIPS,
County_Name,
State_code,
State_Name

update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2019 b
on a.FIPS=b.FIPS
where a.year=2019

select 
FIPS,
County_Name,
State_code,
State_Name,
2020 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2020
from unemployment_data_fcst_input
where year in (2017,2018, 2019)
group by FIPS,
County_Name,
State_code,
State_Name






update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2020 b
on a.FIPS=b.FIPS
where a.year=2020



select 
FIPS,
County_Name,
State_code,
State_Name,
2021 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2021
from unemployment_data_fcst_input
where year in (2018,2019, 2020)
group by FIPS,
County_Name,
State_code,
State_Name






update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2021 b
on a.FIPS=b.FIPS
where a.year=2021


select 
FIPS,
County_Name,
State_code,
State_Name,
2022 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2022
from unemployment_data_fcst_input
where year in (2019,2020, 2021)
group by FIPS,
County_Name,
State_code,
State_Name






update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2022 b
on a.FIPS=b.FIPS
where a.year=2022


select 
FIPS,
County_Name,
State_code,
State_Name,
2023 year,
avg(civilian_labor_force) as civilian_labor_force,
avg(employed) as employed,
0 as unemployed,
avg(unemployment_rate) as unemployment_rate
into #2023
from unemployment_data_fcst_input
where year in (2020,2021, 2022)
group by FIPS,
County_Name,
State_code,
State_Name






update unemployment_data_fcst_input
set civilian_labor_force=b.civilian_labor_force,
	employed=b.employed,
	unemployed=b.unemployed,
	unemployment_rate=b.unemployment_rate
from unemployment_data_fcst_input a
join #2023 b
on a.FIPS=b.FIPS
where a.year=2023


select *
from unemployment_data_fcst_input



