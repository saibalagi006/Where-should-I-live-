
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

input_data=pd.read_excel("Education_Data_Fcst_Input.xlsx", header=0,converters={'FIPS':str})
input_data.sort_values(by=['FIPS','year'], ascending=[True,True], inplace=True)

#input_data=pd.read_sql_query(sql_query,engine)


result_final_columns=['state','county','fips','year','GTE_Bachelors_Degree','fcst_simple_exponential_smoothing','fcst_Holt','fcst_Holt_Winters']


   

#fscl_yr=[2018,2019,2020]

#CrimeData.head()


CD=input_data.groupby(['State_Name','County_Name','FIPS']).size().reset_index().rename(columns={0:'count'})



Result_Details_Final=pd.DataFrame(columns=result_final_columns)

#k=0
for k in range(0,len(CD)):    
#for k in range(0,10): 
#for k in range(0,10):     
    state=CD.iloc[k,0]
    county=CD.iloc[k,1]
    fips=CD.iloc[k,2]
    
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
    
        
    data_pd=input_data.loc[(input_data.State_Name==state)&(input_data.County_Name==county)&(input_data.FIPS==fips),['year','GTE_Bachelors_Degree']]
  
##################################Holt's Model####################################################################################    
    y_train=data_pd.loc[(data_pd.year>=1970) &( data_pd.year<=1990),'GTE_Bachelors_Degree']
    
    y_test=data_pd.loc[(data_pd.year>1990) &( data_pd.year<=2013),'GTE_Bachelors_Degree']
    
    y_test_actual=np.array(y_test).tolist()
    #X_train=data_pd
    
    model = Holt(np.asarray(y_train))
    
    
    fit1 = model.fit(optimized=True)
    y_pred_holt = fit1.forecast(3)
    
    
#################################Simple exponential smoothing################################################
    
    model_simexp=SimpleExpSmoothing(np.asarray(y_train))
    fit2=model_simexp.fit(optimized=True)
    y_pred_simexp=fit2.forecast(3)
    
    
############################################################################################################
    
#########################Holt winter model############################################################

    model_HW=ExponentialSmoothing(np.asarray(y_train))
    fit3=ExponentialSmoothing(np.asarray(y_train), trend='add').fit()
    y_pred_HW=fit3.forecast(3)
    
#########################################################################################################    
    
    
#####################################################################################################################################

######################################################Prophet#######################################################################    
#    #X_train=X[6:105]
#    train_df=data_pd.loc[(data_pd.year>=1997) &( data_pd.year<=2006),['year','GTE_Bachelors_Degree']]
#    train_df.columns = ['ds', 'y']
#    test_df=data_pd.loc[(data_pd.year>2006) &( data_pd.year<=2011),['year','GTE_Bachelors_Degree']]
#    test_df.columns = ['ds', 'y']
#    m = Prophet()
#    m.fit(train_df);
#    future = m.make_future_dataframe(periods=9)
#    forecast = m.predict(test_df)
#    y_pred_prophet=forecast['yhat']
    
    
###################################################################################################################################    
    fscl_range=['2000','2013']
    
    yr_loop=0
    for yr in fscl_range:
        Result_Details_Final=Result_Details_Final.append({'state':state,'county':county,'fips':fips,'year':yr},ignore_index=True)
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'GTE_Bachelors_Degree']=y_test_actual[yr_loop]
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_Holt']=y_pred_holt[yr_loop]
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_simple_exponential_smoothing']=y_pred_simexp[yr_loop]
        Result_Details_Final.loc[(Result_Details_Final.state==state)&(Result_Details_Final.county==county)&(Result_Details_Final.fips==fips)&(Result_Details_Final.year==yr),'fcst_Holt_Winters']=y_pred_HW[yr_loop]

        yr_loop=yr_loop+1
        
writer = pd.ExcelWriter('Education_Comparison_Results.xlsx')
Result_Details_Final.to_excel(writer,'Sheet1')
writer.save()
        

print('Simple Exponential rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_simple_exponential_smoothing'] - Result_Details_Final.loc[:,'GTE_Bachelors_Degree'])**2).mean()),2))

print('Holt rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_Holt'] - Result_Details_Final.loc[:,'GTE_Bachelors_Degree'])**2).mean()),2))


print('Holt-winters rmse is ')
print(round(np.sqrt(((Result_Details_Final.loc[:,'fcst_Holt_Winters'] - Result_Details_Final.loc[:,'GTE_Bachelors_Degree'])**2).mean()),2))

#Result_Details_Final.to_sql('insert_df',engine,if_exists='replace',index=False)
#sql3="""
#select *
#into crime_Data_fcst_output
#from insert_df
#        """
#with engine.begin() as conn:
#    conn.execute(sql3)

