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
#from sklearn.feature_selection import RFE
from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt


path='C:\\Users\\SBT0R1W\\OneDrive - The Home Depot\\Desktop\\Personal_Sai\\Georgia Tech\\Data Visualization and Analytics\\Project'

os.chdir(path)


connection_string = "mssql+pyodbc://dvahousing@dvahousing:Housing1@dvahousing.database.windows.net:1433/dvahousing?driver=ODBC+Driver+13+for+SQL+Server"
engine = sqlalchemy.engine.create_engine(connection_string)
engine.connect()
sql_query="""
select distinct State_Name as state, county_name as county, year, fips
from Population_Estimate_fcst_input
"""

input_data=pd.read_sql_query(sql_query,engine)


result_final_columns=['state','county','fips','year','fcst']


   

fscl_yr=[2018,2019,2020]

#CrimeData.head()

CD=input_data.groupby(['state','county','fips']).size().reset_index().rename(columns={0:'count'})



Result_Details_Final=pd.DataFrame(columns=result_final_columns)

#k=1
for k in range(0,len(CD)):        
    state=CD.iloc[k,0]
    county=CD.iloc[k,1]
    fips=CD.iloc[k,2]
    
    data="""
    select 
   -- FIPS	,
   -- County_Name	,
   -- State_code	,
   -- State_Name	,
    year	,
    POP_ESTIMATE,	
    N_POP_CHANGE,
    Births	,
    Deaths	,
    Natural_Inc	,
    International_Mig,	
    Domestic_Mig	,
    Net_Mig	Residual	,
    GQ_Estimate	Birth_Rate	,
    Death_Rate	,
    Natural_Inc_Rate	,
    International_Mig_Rate,	
    Domestic_Mig_Rate	,
    Net_Mig_Rate
 from Population_Estimate_fcst_input
 where   State_Name='{}'
        and county_name='{}'
        and fips='{}'
    order by year asc
    """.format(state,county,fips)
    
    data_pd=pd.read_sql_query(data,engine)
    

    X_train=data_pd.loc[(data_pd.year>2011) &( data_pd.year<=2017),:]
    
    #X_train=X[6:105]
        
    X_test=data_pd.loc[(data_pd.year>2017) &( data_pd.year<=2023),:]
    
    
    y_train=data_pd.loc[(data_pd.year>2011) &( data_pd.year<=2017),'POP_ESTIMATE']
    
    y_test=data_pd.loc[(data_pd.year>2017) &( data_pd.year<=2023),'POP_ESTIMATE']

    X_train.drop(['POP_ESTIMATE'],axis=1,inplace=True)
    X_test.drop(['POP_ESTIMATE'],axis=1,inplace=True)
    
#    n_estimators_range=list(range(2,10,1))
#    max_depth_range=list(range(1,5))
##    param_grid = dict(n_estimators=n_estimators_range, max_depth=max_depth_range)
##    xgbr = xgboost.XGBRegressor(n_estimators=10, learning_rate=0.05, gamma=0, subsample=0.75,
##                               colsample_bytree=1, max_depth=7, booster='gblinear',nthread=0)
##    rand = RandomizedSearchCV(xgbr, param_grid, cv=5, scoring='neg_mean_squared_error', n_iter=1, random_state=5, return_train_score=False)
##    rand.fit(X_train,y_train)
##    #print(rand.best_params_)
##    #xgboostregressor.append(rand.best_params_)
##    n_estimators=rand.best_params_['n_estimators']
##    max_depth=rand.best_params_['max_depth']        
#    xgbr = xgboost.XGBRegressor(n_estimators=2, learning_rate=0.05, gamma=0, subsample=0.75,
#                               colsample_bytree=1, max_depth=2, booster='gblinear',nthread=0)
#    xgbr.fit(X_train, y_train)
#    y_pred = xgbr.predict(X_test)
 
    model = Holt(np.asarray(y_train))
    
    fit1 = model.fit(optimized=True)
    y_pred = fit1.forecast(6)    
    
    
    yr_loop=0
    fscl_range=['2018','2019','2020','2021','2022','2023']
    for yr in fscl_range:
        Result_Details_Final=Result_Details_Final.append({'state':state,'county':county,'fips':fips,'year':yr},ignore_index=True)
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst']=y_pred[yr_loop]
        yr_loop=yr_loop+1
Result_Details_Final.to_sql('insert_df',engine,if_exists='replace',index=False)
sql3="""
select *
into population_fcst_output_final
from insert_df
        """
with engine.begin() as conn:
    conn.execute(sql3)
