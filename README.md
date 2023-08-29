# COVID-19 Data ETL Process

This repository contains a Python script that facilitates the extraction, transformation, and loading (ETL) of COVID-19 data into a PostgreSQL database. The script downloads a CSV file from a Google Drive link, transforms the data, and loads it into a PostgreSQL database table.

## Prerequisites

Before running the script, make sure you have the following prerequisites installed:

- Python 3.x
- PostgreSQL database
- Create a database called 
- Create a table using the provide create table script



## Usage
1. Clone the Repository:

Clone this repository to your local machine using Git:

``` bash
git clone https://github.com/your-username/covid-data-etl.git
```


2. Install required Python packages using the following command:

```bash
pip install -r requirements.txt'
```


3. Run the ETL Script to download data, cleanse data and upload to postgres:

```bash
python covid_etl.py
```
