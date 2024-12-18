'''
This is a test code to scrape climate data from the Environment and Climate Change Canada (ECCC) 
webiste that are publically available.
The scraped data will be useful later for climate risk assessment, climatic condition prediction 
with Machine Learning (ML) and thermal and hygrothermal simulation inputtings.
'''

# Import essnential modules
from datetime import date, timedelta, datetime
import pandas as pd
import numpy as np
import os

basic_url = r'https://climate.weather.gc.ca/climate_data/hourly_data_e.html?hlyRange=2002-06-04%7C2024-07-10&dlyRange=2002-06-04%7C2024-07-10&mlyRange=2003-07-01%7C2006-12-01&StationID=31688&Prov=ON&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1980&EndYear=2024&selRowPerPage=25&Line=19&searchMethod=contains&Month='

# Define start and end dates
start_date = date(2017,1,1)
end_date = date(2017,1,5)

# Create a date list between the two start and end dates
date_range = []
for current_date in range((end_date - start_date).days + 1):
    date_to_add = start_date + timedelta(days=current_date)

    # Extract year, month, day
    year = date_to_add.year
    month = date_to_add.month
    day = date_to_add.day
   
    # Append in a tuple containing year, month, day
    date_range.append((year, month, day))

df_all = pd.DataFrame([])


for year, month, day in date_range:
    url = basic_url + str(month) + '&Day=' + str(day) + '&txtStationName=Toronto&timeframe=1&Year=' + str(year)
    table = pd.read_html(url, index_col = False)[0]
    table['TIME LST'] = table['TIME LST'].str[:2].astype(int)
    df_temp = pd.concat([pd.Series(np.ones(24) * year).astype(int), pd.Series(np.ones(24) * month).astype(int), pd.Series(np.ones(24) * day).astype(int), table['TIME LST']], axis = 1)
    table['TIME LST'] = pd.Series([tuple(row) for row in df_temp.itertuples(index = False)])
    table.rename(columns = {'TIME LST': 'Date'}, inplace = True)
    table['Date'] = pd.Series([datetime(*cell[:4]) for cell in table['Date']])
   
    df_all = pd.concat([df_all, table], axis = 0)
               


beg = str(start_date)[2:4] + str(start_date)[5:7] + str(start_date)[8:10]
end = str(end_date)[2:4] + str(end_date)[5:7] + str(end_date)[8:10]
wmo = '71508' # The World's Meterological Organziation ID of the station 

os.chdir(r'C:\Outlier\Beagle Coding Prompt Collection\Session5_241001')
df_all.to_excel(f'eccc_{beg}_{end}_{wmo}.xlsx', index = False)
print(df_all.head(10))


''' Test output
                 Date  Temp  Dew Point  Rel Hum  Precip. Wind Dir 10s  \
0 2017-01-01 00:00:00   0.5       -4.3       70      0.0     LegendMM   
1 2017-01-01 01:00:00   0.8       -4.2       70      0.0     LegendMM   
2 2017-01-01 02:00:00   0.6       -4.9       67      0.0     LegendMM   
3 2017-01-01 03:00:00   1.0       -4.6       66      0.0     LegendMM   
4 2017-01-01 04:00:00   1.0       -4.6       66      0.0     LegendMM   
5 2017-01-01 05:00:00   1.1       -4.7       65      0.0     LegendMM   
6 2017-01-01 06:00:00   0.6       -4.8       67      0.0     LegendMM   
7 2017-01-01 07:00:00   0.1       -5.4       67      0.0     LegendMM   
8 2017-01-01 08:00:00  -0.3       -5.6       67      0.0     LegendMM   
9 2017-01-01 09:00:00  -0.3       -6.0       65      0.0     LegendMM   

   Wind Spd  Visibility   Press  Hmdx  Wind Chill  Definition  
0  LegendMM         NaN   99.34   NaN         NaN  LegendNANA  
1  LegendMM         NaN   99.52   NaN         NaN  LegendNANA  
2  LegendMM         NaN   99.64   NaN         NaN  LegendNANA  
3  LegendMM         NaN   99.82   NaN         NaN  LegendNANA  
4  LegendMM         NaN   99.98   NaN         NaN  LegendNANA  
5  LegendMM         NaN  100.06   NaN         NaN  LegendNANA  
6  LegendMM         NaN  100.16   NaN         NaN  LegendNANA  
7  LegendMM         NaN  100.29   NaN         NaN  LegendNANA  
8  LegendMM         NaN  100.44   NaN         NaN  LegendNANA  
9  LegendMM         NaN  100.56   NaN         NaN  LegendNANA 
'''
