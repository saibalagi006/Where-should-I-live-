select distinct [county code]
into #fips
--select *
from temperature_Data_final a

--select count(*)
--from County_Info_Final a
--join #fips b
--on a.FIPS=b.[County Code]

--select *
--from #fips

drop table temperature_fcst_input
select  b.FIPS,
		b.County_Name,
		b.State_Name,
		b.State_Code,
		a.Year,
		a.[Avg Daily Max Air Temperature (F)] as Avg_Max_Temp
into temperature_fcst_input 
--select *
from temperature_Data_final a
join County_Info_Final b
on a.[County Code]=b.FIPS


