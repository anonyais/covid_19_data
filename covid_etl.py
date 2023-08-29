import pandas as pd
import requests
from sqlalchemy import create_engine


engine = create_engine('postgresql://postgres:001986@localhost:5432/covid_19_data')

def download_covid_data(file_id):
    file_url = 'https://drive.google.com/uc?id=1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b'
    output_path = 'covid_19_data.csv'
    
    response = requests.get(file_url)

    if response.status_code == 200:
        with open(output_path, 'wb') as file:
            file.write(response.content)
        print(f"Downloaded file to '{output_path}'")
    else:
        print(f"Failed to download the file. Status code: {response.status_code}")
        

    

def transform_and_load_covid_data(table_name):
    df = pd.read_csv('covid_19_data.csv')
    df["ObservationDate"] = pd.to_datetime(df["ObservationDate"], format="%m/%d/%Y")
    df["LastUpdate"] = pd.to_datetime(df["LastUpdate"], format="%m/%d/%Y %H:%M")
    df.rename(columns={"SNo": "sno","ObservationDate": "observation_date","Province": "province","Country": "country","LastUpdate": "last_update","Confirmed": "confirmed","Deaths": "deaths","Recovered": "recovered"}, inplace=True)
    print(df.head())
    df.to_sql(table_name,engine,if_exists='append', index=False)
    print("Data successfully uploaded")



if __name__ == "__main__":
    file_id = '1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b'
    table_name = 'covid_19_data'
    download_covid_data(file_id)
    transform_and_load_covid_data(table_name)
