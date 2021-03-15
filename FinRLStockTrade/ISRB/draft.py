import pandas as pd

df=pd.read_csv('done_data_IJRB.csv')
ensemble_account_value['Date'] = df.datadate.unique()