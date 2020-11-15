--select a.*, isnull(b.state_name,'') as State_Name
--into County_Info
--from county1 a
--left join state_info b
--on a.State_code=b.state_code


--select distinct State_code
--from County_Info
--where state_name =''


--update County_Info_Final
--set state_name='American Samoa'
--from County_Info_Final
--where state_code='AS'

--update County_Info_Final
--set state_name='DistrictofColumbia'
--from County_Info_Final
--where state_code='DC'

--update County_Info_Final
--set state_name='Guam'
--from County_Info_Final
--where state_code='GU'


--update County_Info_Final
--set state_name='Puerto Rico'
--from County_Info_Final
--where state_code='PR'


--update County_Info_Final
--set state_name='Virgin Islands'
--from County_Info_Final
--where state_code='VI'


--Select cast(FIPS as varchar(255)) AS FIPS,
--       CAST(NAME AS VARCHAR(255)) AS County_Name,
--	   cast(state_Code as varchar(255)) as State_Code,
--	   cast(state_name as varchar(255)) as State_Name
--	   into County_Info_Final
--from County_Info

--drop table County_Info

--drop table county1

------------------------------------------------------------------------------------------------------------

drop table crime_Data_fcst_input

select 2011 as year into #year union
select 2012 union
select 2013 union
select 2014 union
select 2015 union
select 2016 union
select 2017


select a.state,
	   a.county,
	   a.year,
	   b.fips,
	   a.violent_total,
	   a.PROPERTY_TOTAL
	   into #temp1
	 -- select *
	   from crime_Data a
 join County_Info_Final b
on a.COUNTY=b.County_Name
and a.STATE=b.State_Name
where year between 2011 and 2017



select state, county, fips, avg(violent_total) as violent_total_avg, avg(property_total) as property_total_avg
into #temp2
	   from crime_Data a
 join County_Info_Final b
on a.COUNTY=b.County_Name
and a.STATE=b.State_Name
where year between 2011 and 2017
group by state, county, fips



select state, county, year, fips, violent_total_avg, property_total_avg
into #temp4 
from #temp2 a
cross join #year



insert into #temp1
select *
from #temp4 a
where not exists (select 1 from #temp1 b
where a.STATE=b.STATE
and a.COUNTY=b.COUNTY
and a.FIPS=b.FIPS
and a.year=b.YEAR
)



select 
a.state,
	   a.county,
	   a.year,
	   a.fips,
	   a.violent_total+a.PROPERTY_TOTAL as crime_total
into crime_Data_fcst_input
from #temp1 a

--select count(*),year
--from crime_Data
--group by year

--select state, county, year, fips, violent_total+property_total as total_crime
--from crime_Data_fcst_input


--select *
--from crime_Data_fcst_input


--select *
--from crime_Data

--select *
--from crime_Data_fcst_input

--select *
--from county_info_final



select distinct fips
into #del
from crime_Data_fcst_input
where crime_total=0



delete a
from crime_Data_fcst_input a
join #del d
on a.FIPS=d.FIPS


select *
from crime_Data_fcst_input
order by fips, year asc

