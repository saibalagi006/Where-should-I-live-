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


import sqlalchemy
from sqlalchemy import create_engine
#from sklearn.feature_selection import RFE




#import matplotlib.pyplot as plt
#from pylab import rcParams
#import statsmodels.api as sm
import numpy as np
#from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
import pandas as pd
#import fastai
#from sklearn.model_selection import train_test_split
#from xgboost import XGBClassifier
#from sklearn import metrics
from sklearn.ensemble import RandomForestRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.svm import SVR
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import RandomizedSearchCV
import xgboost
from sklearn.linear_model import LinearRegression
#from sklearn.feature_selection import RFE
from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt



path='C:\\Users\\SBT0R1W\\OneDrive - The Home Depot\\Desktop\\Personal_Sai\\Georgia Tech\\Data Visualization and Analytics\\Project'

os.chdir(path)


connection_string = "mssql+pyodbc://dvahousing@dvahousing:Housing1@dvahousing.database.windows.net:1433/dvahousing?driver=ODBC+Driver+13+for+SQL+Server"
engine = sqlalchemy.engine.create_engine(connection_string)
engine.connect()
sql_query="""
select distinct State_Name as state, County_Name as county, year, fips
from unemployment_data_fcst_input
where fips in ('01002','01003','01004')
"""

input_data=pd.read_sql_query(sql_query,engine)

result_final_columns=['state','county','fips','year','actual_value','fcst_xgbr','fcst_rfr','fcst_knnr','fcst_svr','fcst_holt','fcst_LR']


   

fscl_yr=[2018,2019,2020]

#CrimeData.head()

CD=input_data.groupby(['state','county','fips']).size().reset_index().rename(columns={0:'count'})



Result_Details_Final=pd.DataFrame(columns=result_final_columns)


for k in range(0,len(CD)):        
    state=CD.iloc[k,0]
    county=CD.iloc[k,1]
    fips=CD.iloc[k,2]
    
    data="""
    select 
     --   FIPS	,
      --  County_Name	,
       -- State_code,	
       -- State_Name	,
        year	,
        isnull(civilian_labor_force,0) as 	civilian_labor_force,
        isnull(employed	,0) as employed,
        isnull(unemployed,0) as unemployed,
        isnull(unemployment_rate,0) as unemployment_rate
 from unemployment_data_fcst_input
 where   State_Name='{}'
        and County_Name='{}'
        and fips='{}'
    order by year asc
    """.format(state,county,fips)
    
    data_pd=pd.read_sql_query(data,engine)
    

    X_train=data_pd.loc[(data_pd.year>=2011) &( data_pd.year<=2014),:]
    
    #X_train=X[6:105]
        
    X_test=data_pd.loc[(data_pd.year>2014) &( data_pd.year<=2017),:]
    
    
    y_train=data_pd.loc[(data_pd.year>=2011) &( data_pd.year<=2014),'unemployed']
    
    y_test=data_pd.loc[(data_pd.year>2014) &( data_pd.year<=2017),'unemployed']

    X_train.drop(['unemployed'],axis=1,inplace=True)
    X_test.drop(['unemployed'],axis=1,inplace=True)
    y_test_actual=np.array(y_test).tolist()
    

####################################xgboosting regression##################################################    
    n_estimators_range=list(range(2,4,1))
    max_depth_range=list(range(1,3))
    param_grid = dict(n_estimators=n_estimators_range, max_depth=max_depth_range)
    xgbr = xgboost.XGBRegressor(n_estimators=100, learning_rate=0.05, gamma=0, subsample=0.75,
                               colsample_bytree=1, max_depth=7, booster='gblinear',nthread=0)
    rand = RandomizedSearchCV(xgbr, param_grid, cv=3, scoring='neg_mean_squared_error', n_iter=1, random_state=5, return_train_score=False)
    rand.fit(X_train,y_train)
    #print(rand.best_params_)
    #xgboostregressor.append(rand.best_params_)
    n_estimators=rand.best_params_['n_estimators']
    max_depth=rand.best_params_['max_depth']        
    xgbr = xgboost.XGBRegressor(n_estimators=n_estimators, learning_rate=0.05, gamma=0, subsample=0.75,
                               colsample_bytree=1, max_depth=max_depth, booster='gblinear',nthread=0)
    xgbr.fit(X_train, y_train)
    y_pred_xgbr = xgbr.predict(X_test)
    #y_pred_xgbr=y_pred
    #mse_xgbr = np.sqrt(((y_pred_xgbr - y_test_actual) ** 2).mean())
#############################################################################################################

##########################################Random forest regression##########################################################    
    n_estimators_range=list(range(1,3,1))
    max_depth_range=list(range(1,3))
    param_grid = dict(n_estimators=n_estimators_range, max_depth=max_depth_range)
    regr = RandomForestRegressor(max_depth=2, random_state=0,n_estimators=100)
    rand = RandomizedSearchCV(regr, param_grid, cv=3, scoring='neg_mean_squared_error', n_iter=1, random_state=5, return_train_score=False)
    rand.fit(X_train,y_train)
    n_estimators=rand.best_params_['n_estimators']
    max_depth=rand.best_params_['max_depth']  
    regr = RandomForestRegressor(max_depth=max_depth, random_state=0,n_estimators=n_estimators)
    regr.fit(X_train, y_train)
    y_pred_rfr = regr.predict(X_test)
    #y_pred=y_pred
            #regr_columns=['fcst_1_rfr','fcst_2_rfr','fcst_3_rfr','fcst_4_rfr','fcst_5_rfr','fcst_6_rfr','fcst_7_rfr','fcst_8_rfr','fcst_9_rfr','fcst_10_rfr','fcst_11_rfr','fcst_12_rfr','fcst_13_rfr' ]
            #Result_Details.loc[(Result_Details.fscl_wk==fscl_wk_ref)&(Result_Details.dept_nbr==dept_nbr)&(Result_Details.class_nbr==class_nbr)&(Result_Details.LOC_NBR==LOC_NBR1),regr_columns]=y_pred
            
    #y_pred_rfr=y_pred
###########################################################################################################################    
    
#####################################knn regressor######################################################################    
    n_neighbors_range=list(range(1,3,1))
    param_grid=dict(n_neighbors=n_neighbors_range)
    knn=KNeighborsRegressor(n_neighbors=2)
    rand = RandomizedSearchCV(knn, param_grid, cv=3, scoring='neg_mean_squared_error', n_iter=5, random_state=5, return_train_score=False)
    rand.fit(X_train,y_train)
    n_neighbors=rand.best_params_['n_neighbors']
    knn=KNeighborsRegressor(n_neighbors=n_neighbors)
    knn.fit(X_train, y_train)
    y_pred_knnr = knn.predict(X_test)
    
    #y_pred_knnr=y_pred
    
########################################################################################################################    
    
###########################################support vector regressor####################################################    
    C_range=list(range(1,11,1))
    param_grid=dict(C=C_range)
    svr1=SVR(C=1)
    rand = RandomizedSearchCV(svr1, param_grid, cv=3, scoring='neg_mean_squared_error', n_iter=5, random_state=5, return_train_score=False)
    rand.fit(X_train,y_train)
            #svrregressor.append(rand.best_params_)
    C=rand.best_params_['C']
    svr1=SVR(C=C)
    svr1.fit(X_train, y_train)
    y_pred_svr = svr1.predict(X_test)
    #y_pred_svr=y_pred
    
#############################################################################################################################


#####################################holt's winter model#####################################################################
    model = Holt(np.asarray(y_train))
    
    fit1 = model.fit(optimized=True)
    y_pred_holt = fit1.forecast(4)
    
####################################################################################################################################

###################################################Linear Regression#########################################################
    LR= LinearRegression()
    LR.fit(X_train, y_train)
    y_pred_LR=LR.predict(X_test)
    #y_pred_LR=y_pred
    
    
#######################################################################################################################################    
    fscl_range=['2015','2016','2017']
    
    yr_loop=0
    for yr in fscl_range:
        Result_Details_Final=Result_Details_Final.append({'state':state,'county':county,'fips':fips,'year':yr},ignore_index=True)
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'actual_value']=y_test_actual[yr_loop]        
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_xgbr']=y_pred_xgbr[yr_loop] 
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_rfr']=y_pred_rfr[yr_loop] 
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_knnr']=y_pred_knnr[yr_loop] 
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_svr']=y_pred_svr[yr_loop] 
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_holt']=y_pred_holt[yr_loop] 
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_LR']=y_pred_LR[yr_loop] 
        yr_loop=yr_loop+1
        #,'fscl_wk_predicted','fcst','fcst_xgbc','fcst_xgbr','fcst_rfr','fcst_knnr','fcst_svr']
        

print('xgbr rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_xgbr'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))

print('rfr rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_rfr'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))


print('knnr rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_knnr'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))


print('svr rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_svr'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))


print('holt rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_holt'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))


print('LR rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_LR'] - Result_Details_Final.loc[:,'actual_value'])**2).mean()),2))



    
Result_Details_Final.to_sql('insert_df',engine,if_exists='replace',index=False)
sql3="""
select *
into unemployment_model_selection
from insert_df
        """
with engine.begin() as conn:
    conn.execute(sql3)

