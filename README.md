## Analyzing Schema
On downloading the csv files, i set to cleaning the data set, filling wrong or missing values and setting the type accordingly (currency, text, data/time). From my analysis, I considered a STAR schema best for the data modelling, hence i created a new fact table as it is central in a star schema and stores the measurable events (facts) that for analysis. This restructuring facilitates analytical queries, particularly for calculating metrics like Payment at Risk (PAR).

## ETL/ELT
In selecting a data warehouse for ELT/ETL pipeline, i settled for postgres because its open-source, popular, and free. Plus i have worked with it in the past.

## PAR Days
In calculating the PAR Days the loan payments table allows one loan for one or multiple payments, hence i removed existing primary key in Fact_loan table for a new composite primary key to address duplicates in loan_id column.

## Monitoring and Alerting
 - I settled with Prometheus and Alerting Manager for my Monitoring and Alerting on errors that occur when the pipeline is running. Prometheus, a time-based database and monitoring system scraps metrics every 60secs from the PostgreSQL via postgres_exporter.
 - Prometheus is connected to the alert.rules.yml (attached) file path which contains set conditions under which Prometheus should trigger alerts (such as high rate of null values detected) based on the metrics it collects.
 - The alert manager which is also connected to prometheus receives alerts from Prometheus and routes them to my email as configured.

## Challenges
 - I had challenges setting the type for each column, as excel reverted the type after closing the csv file. As a solution i moved the table to Postgres and altered the data typer from the pgadmin interface.
 - I had drawbacks in column name similarities, so i had to cross-check multiple times, and set a unified patter for naming all columns.
 - Writing the query to calculate PAR Day was challenging but with research on youtube, documentation and online answers of similar problems i was able to calculate it
 - Locating the compatible alertmanger and prometheus raw files for dowmload 

