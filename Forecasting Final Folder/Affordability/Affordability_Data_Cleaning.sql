select *
from crime_Data_fcst_input

select count(*) , county_fips from 
[dbo].[affordability_data_fcst_input]
group by county_fips

select *
from affordability_data_fcst_input

drop table affordability_data_fcst_input_final
select cast(county_fips as varchar(255)) as county_fips,
	   st,
	   yr,
	   price_to_income_rating
into affordability_data_fcst_input_final
from affordability_data_fcst_input


delete 
--select *
from affordability_data_fcst_input_final
where county_fips is null


update affordability_data_fcst_input_final
set county_fips='0'+county_fips
--select *
from affordability_data_fcst_input_final
where len(county_fips)=4


