## Analyzing Schema
STAR schema for anaalysis as its best for the data modelling. This restructuring facilitates analytical queries, particularly for calculating metrics like Payment at Risk (PAR).

## ETL/ELT
Postgres  for ELT/ETL pipeline

## PAR Days
In calculating the PAR Days the loan payments table allows one loan for one or multiple payments, so a new composite primary key to address duplicates in loan_id column.

## Monitoring and Alerting
Prometheus and Alerting Manager for my Monitoring and Alerting on errors that occur when the pipeline is running. Prometheus, a time-based database and monitoring system scraps metrics every 60secs from the PostgreSQL via postgres_exporter.
 - Prometheus is connected to the alert.rules.yml (attached) file path which contains set conditions under which Prometheus should trigger alerts (such as high rate of null values detected) based on the metrics it collects.
 - The alert manager which is also connected to prometheus receives alerts from Prometheus and routes them to my email as configured.

