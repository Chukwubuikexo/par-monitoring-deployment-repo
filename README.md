## Analyzing Schema
On downloading the csv files, i set to cleaning the data set, filling wrong or missing values and setting the type accordingly (currency, text, data/time). From my analysis, I considered a STAR schema best for the data modelling, hence i created a new fact table as it is central in a star schema and stores the measurable events (facts) that for analysis. This restructuring facilitates analytical queries, particularly for calculating metrics like Payment at Risk (PAR).

## ETL/ELT
In selecting a data warehouse for ELT/ETL pipeline, i settled for postgres because its open-source, popular, and free. Plus i have worked with it in the past.

## PAR Days
In calculating the PAR Days the loan payments table allows one loan for one or multiple payments, hence i removed existing primary key in Fact_loan table for a new composite primary key to address duplicates in loan_id column.

## Monitoring and alerts

## Challenges
I had challenges setting the type for each column, as excel reverted the type after closing the csv file. As a solution i moved the table to Postgres and altered the data typer from the pgadmin interface. I also had to drawbacks in column name similarities, so i had to cross-check multiple times, and set a unified patter for naming all columns. 

### Tools and Techniques
- **Web Scraping Tool:** Selenium was chosen for its suitability in handling the HTML structure and DOM elements of the site.
- **Rate Limiting Prevention:** To mitigate rate limiting and IP blocking, I implemented User-Agents to randomize access and simulate human browsing. Additionally, request delays were introduced to further reduce the risk of detection.



### Notifications
- **Monitoring:** GitHub Actions is configured to send email notifications for both successful scraping operations and any errors or failures, ensuring timely monitoring and alerts.

### Challenges
- I had to search about five websites before settling for carsdirect
- Selecting a scraping tool -  I first tested beautiful soup, but on further reasearch i found it less efficient in handling sites with IP blocking
- I tried many yml settings to enable notifcations before reading github documentation on [notifications](https://github.com/notifications) 
