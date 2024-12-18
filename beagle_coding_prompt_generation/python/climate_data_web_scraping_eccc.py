# Import essnential modules
from datetime import timedelta, datetime
import pandas as pd
import numpy as np
import os

basic_url = 'https://climate.weather.gc.ca/climate_data/hourly_data_e.html?hlyRange=2002-06-04%7C2024-07-10&dlyRange=2002-06-04%7C2024-07-10&mlyRange=2003-07-01%7C2006-12-01&StationID=31688&Prov=ON&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1980&EndYear=2024&selRowPerPage=25&Line=19&searchMethod=contains&Month='

# Define start and end dates
start_date = '2017-01-01'
start_date = datetime.strptime(start_date, '%Y-%m-%d')
start_date = start_date.timestamp()

end_date = '2017-01-05'
end_date = datetime.strptime(end_date, '%Y-%m-%d')
end_date = end_date.timestamp()


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
   
    df_all = df_all.append(table)
               


beg = str(start_date)[2:4] + str(start_date)[5:7] + str(start_date)[8:10]
end = str(end_date)[2:4] + str(end_date)[5:7] + str(end_date)[8:10]
wmo = '71508' # The World's Meterological Organziation ID of the station 

os.chdir('C:\Outlier\Beagle Coding Prompt Collection\Session5_241001')
df_all.to_excel(fr'eccc_{beg}_{end}_{wmo}.xlsx', index = False)
print(df_all.head(10))