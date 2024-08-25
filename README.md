## Analyzing Schema
On downloading the csv files, i set to cleaning the data set, filling or wrong missing values and setting the type accordingly (currency, text, data/time). From my analysis, I considered a STAR schema best for the data modelling, hence i created a new fact table as it is central in a star schema and stores the measurable events (facts) that for analysis. This restructuring facilitates analytical queries, particularly for calculating metrics like Payment at Risk (PAR).

## PAR Days
In calculating the PAR Days the loan payments table is allows One loan for one or multiple payments, hence i removed existing primary key in Fact_loan table for a new composite primary key to address duplicates in loan_id column.


### Tools and Techniques
- **Web Scraping Tool:** Selenium was chosen for its suitability in handling the HTML structure and DOM elements of the site.
- **Rate Limiting Prevention:** To mitigate rate limiting and IP blocking, I implemented User-Agents to randomize access and simulate human browsing. Additionally, request delays were introduced to further reduce the risk of detection.

### Scheduling
- **Automated Scraping:** The daily scraping process is managed through GitHub Actions. A `.yml` configuration file is set up to trigger the scraping task at 12 AM daily.
- **Data Handling:** The `.yml` file includes instructions for incrementally loading the `car_list` results into the Big Query Warehouse.

### Notifications
- **Monitoring:** GitHub Actions is configured to send email notifications for both successful scraping operations and any errors or failures, ensuring timely monitoring and alerts.

### Challenges
- I had to search about five websites before settling for carsdirect
- Selecting a scraping tool -  I first tested beautiful soup, but on further reasearch i found it less efficient in handling sites with IP blocking
- I tried many yml settings to enable notifcations before reading github documentation on [notifications](https://github.com/notifications) 
