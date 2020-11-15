
drop table Education_Data_Fcst_Input

select 1970 as year into #year union
select 1980 union
select 1990 union
select 2000 union
select 2013 union
select 2020 


create table Education_Data_Fcst_Input(
FIPS Varchar(255),
County_Name varchar(255),
State_code varchar(255),
State_Name varchar(255),
year numeric(18,0),
GTE_Bachelors_Degree numeric(18,0),
Pct_Bachelors_Degree numeric(18,0)
);


select distinct b.FIPS,
				b.County_Name,
				b.State_Name,
				b.State_Code
		into #temp1
from Education_Level_Data a
join County_Info_Final b
on a.FIPS_code=b.FIPS



select a.*, b.year
into #temp2
from #temp1 a
cross join #year b


insert into Education_Data_Fcst_Input
select 
FIPS ,
County_Name ,
State_code ,
State_Name ,
year ,
0.0 as GTE_Bachelors_Degree ,
0.0 as Pct_Bachelors_Degree 
from #temp2


update Education_Data_Fcst_Input
set GTE_Bachelors_Degree=Four_years_of_college_or_higher_1970,
	Pct_Bachelors_Degree=Percent_of_adults_completing_four_years_of_college_or_higher_197
from Education_Data_Fcst_Input a
join Education_Level_Data b
on a.FIPS=b.FIPS_Code
where a.year=1970


update Education_Data_Fcst_Input
set GTE_Bachelors_Degree=Four_years_of_college_or_higher_1980,
	Pct_Bachelors_Degree=Percent_of_adults_completing_four_years_of_college_or_higher_198
from Education_Data_Fcst_Input a
join Education_Level_Data b
on a.FIPS=b.FIPS_Code
where a.year=1980

update Education_Data_Fcst_Input
set GTE_Bachelors_Degree=Bachelors_degree_or_higher_1990,
	Pct_Bachelors_Degree=Percent_of_adults_with_a_bachelors_degree_or_higher_1990
from Education_Data_Fcst_Input a
join Education_Level_Data b
on a.FIPS=b.FIPS_Code
where a.year=1990

update Education_Data_Fcst_Input
set GTE_Bachelors_Degree=Bachelors_degree_or_higher_2000,
	Pct_Bachelors_Degree=Percent_of_adults_with_a_bachelors_degree_or_higher_2000
from Education_Data_Fcst_Input a
join Education_Level_Data b
on a.FIPS=b.FIPS_Code
where a.year=2000

update Education_Data_Fcst_Input
set GTE_Bachelors_Degree=Bachelors_degree_or_higher_2013_17,
	Pct_Bachelors_Degree=Percent_of_adults_with_a_bachelors_degree_or_higher_2013_17
from Education_Data_Fcst_Input a
join Education_Level_Data b
on a.FIPS=b.FIPS_Code
where a.year=2013





