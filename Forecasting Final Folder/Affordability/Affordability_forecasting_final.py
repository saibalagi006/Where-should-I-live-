
import time

import numpy as np
#from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
import pandas as pd

import os
from sklearn.model_selection import RandomizedSearchCV
import xgboost
from fbprophet import Prophet
import sqlalchemy
from sqlalchemy import create_engine
from statsmodels.tsa.api import ExponentialSmoothing, SimpleExpSmoothing, Holt
#from sklearn.feature_selection import RFE


path='C:\\Users\\SBT0R1W\\OneDrive - The Home Depot\\Desktop\\Personal_Sai\\Georgia Tech\\Data Visualization and Analytics\\Project\\Algorithm Comparison Data'

os.chdir(path)
#
#
#connection_string = "mssql+pyodbc://dvahousing@dvahousing:Housing1@dvahousing.database.windows.net:1433/dvahousing?driver=ODBC+Driver+13+for+SQL+Server"
#engine = sqlalchemy.engine.create_engine(connection_string)
#engine.connect()
#sql_query="""
#select distinct state, county, year, fips
#from crime_Data_fcst_input
#"""

input_data=pd.read_excel("affordability_data_fcst_input_final.xlsx", header=0,converters={'FIPS':str})

#input_data=pd.read_sql_query(sql_query,engine)


result_final_columns=['state','fips','year','fcst_simple_exponential_smoothing']


   

#fscl_yr=[2018,2019,2020]

#CrimeData.head()


CD=input_data.groupby(['State_Name','FIPS']).size().reset_index().rename(columns={0:'count'})



Result_Details_Final=pd.DataFrame(columns=result_final_columns)

#k=0
for k in range(0,len(CD)):    
#for k in range(0,10):     
    state=CD.iloc[k,0]
    #county=CD.iloc[k,1]
    fips=CD.iloc[k,1]
    
#    data="""
#        select crime_total 
#        from crime_Data_fcst_input
#        where state='{}'
#        and county='{}'
#        and fips='{}'
#        and year>2011 and year<=2017
#    order by year asc
#    """.format(state,county,fips)
#    
#    data_pd=pd.read_sql_query(data,engine)
    
        
    data_pd=input_data.loc[(input_data.State_Name==state)&(input_data.FIPS==fips),['year','price_to_income_rating']]
  
##################################Holt's Model####################################################################################    
    y_train=data_pd.loc[(data_pd.year>=2005) &( data_pd.year<=2018),'price_to_income_rating']
    
    #y_test=data_pd.loc[(data_pd.year>=2015) &( data_pd.year<=2018),'price_to_income_rating']
    
    #y_test_actual=np.array(y_test).tolist()
    #X_train=data_pd
#    
#    model = Holt(np.asarray(y_train))
#    
#    
#    fit1 = model.fit(optimized=True)
#    y_pred_holt = fit1.forecast(5)
#    
    
#################################Simple exponential smoothing################################################
    
    model_simexp=SimpleExpSmoothing(np.asarray(y_train))
    fit2=model_simexp.fit(optimized=True)
    y_pred_simexp=fit2.forecast(5)
    
    
############################################################################################################
    
#########################Holt winter model############################################################

#
#    model_HW=ExponentialSmoothing(np.asarray(y_train))
#    fit3=ExponentialSmoothing(np.asarray(y_train), seasonal_periods=4, trend='add', seasonal='add').fit(use_boxcox=True)
#    y_pred_HW=fit3.forecast(5)
#    
#    
#########################################################################################################    
    
    
#####################################################################################################################################

######################################################Prophet#######################################################################    
#    #X_train=X[6:105]
#    train_df=data_pd.loc[(data_pd.year>=1997) &( data_pd.year<=2006),['year','price_to_income_rating']]
#    train_df.columns = ['ds', 'y']
#    test_df=data_pd.loc[(data_pd.year>2006) &( data_pd.year<=2011),['year','price_to_income_rating']]
#    test_df.columns = ['ds', 'y']
#    m = Prophet()
#    m.fit(train_df);
#    future = m.make_future_dataframe(periods=9)
#    forecast = m.predict(test_df)
#    y_pred_prophet=forecast['yhat']
    
    
###################################################################################################################################    
    fscl_range=['2019','2020','2021','2022','2023']
    
    yr_loop=0
    for yr in fscl_range:
        Result_Details_Final=Result_Details_Final.append({'state':state,'fips':fips,'year':yr},ignore_index=True)
        #Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'price_to_income_rating']=y_test_actual[yr_loop]
        #Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_Holt']=y_pred_holt[yr_loop]
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_simple_exponential_smoothing']=y_pred_simexp[yr_loop]
        #Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_Holt_Winters']=y_pred_HW[yr_loop]

        yr_loop=yr_loop+1
        
writer = pd.ExcelWriter('Affordability_forecasting_Results_final.xlsx')
Result_Details_Final.to_excel(writer,'Sheet1')
writer.save()
        


#Result_Details_Final.to_sql('insert_df',engine,if_exists='replace',index=False)
#sql3="""
#select *
#into crime_Data_fcst_output
#from insert_df
#        """
#with engine.begin() as conn:
#    conn.execute(sql3)

