# -*- coding: utf-8 -*-
"""
Created on Mon Apr  8 20:32:26 2019

@author: SBT0R1W
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Apr  8 12:30:40 2019

@author: SBT0R1W
"""

import time

import numpy as np
#from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
import pandas as pd

import os
from sklearn.model_selection import RandomizedSearchCV
import xgboost

import sqlalchemy
from sqlalchemy import create_engine
from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
#from sklearn.feature_selection import RFE


path='C:\\Users\\SBT0R1W\\OneDrive - The Home Depot\\Desktop\\Personal_Sai\\Georgia Tech\\Data Visualization and Analytics\\Project'

os.chdir(path)


connection_string = "mssql+pyodbc://dvahousing@dvahousing:Housing1@dvahousing.database.windows.net:1433/dvahousing?driver=ODBC+Driver+13+for+SQL+Server"
engine = sqlalchemy.engine.create_engine(connection_string)
engine.connect()
sql_query="""
select distinct state_code as state, county_name as county, year, fips
from Education_Data_Fcst_Input
"""

input_data=pd.read_sql_query(sql_query,engine)


result_final_columns=['state','county','fips','year','fcst']


   

fscl_yr=[2018,2019,2020]

#CrimeData.head()

ED=input_data.groupby(['state','county','fips']).size().reset_index().rename(columns={0:'count'})



Result_Details_Final=pd.DataFrame(columns=result_final_columns)

#k=2
for k in range(0,len(ED)):        
    state=ED.iloc[k,0]
    county=ED.iloc[k,1]
    fips=ED.iloc[k,2]
    
    data="""
        select GTE_Bachelors_Degree
        from Education_Data_Fcst_Input
        where state_code='{}'
        and county_name='{}'
        and fips='{}'
        and  year<=2017
    order by year asc
    """.format(state,county,fips)
    
    data_pd=pd.read_sql_query(data,engine)
    

    X_train=data_pd
    
    model = Holt(np.asarray(X_train['GTE_Bachelors_Degree']))
    
    fit1 = model.fit(optimized=True)
    pred1 = fit1.forecast(1)
    
    #X_train=X[6:105]
        

 
#    for j in range(0,3):
#        if j==0:
#            year1=2018
#        elif j==1:
#            year1=2019
#        elif j==2:
#            year1=2020
    year1=2020
    Result_Details_Final=Result_Details_Final.append({'state':state,'county':county,'fips':fips,'year':year1},ignore_index=True)
    Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==year1),'fcst']=pred1
    
Result_Details_Final.to_sql('insert_df',engine,if_exists='replace',index=False)
sql3="""
select *
into education_fcst_output
from insert_df
        """
with engine.begin() as conn:
    conn.execute(sql3)

