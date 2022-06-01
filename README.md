# DisneyETL
## Extract, transform and load -- Disneyland data!

### Proposal
In this project, Sally and Enne are working with two sets of data. The first is a set of Trip Advisor reviews of Disneyland, found on Kaggle. The second is a set of daily temperatures and crowd levels in Disneyland California, scraped from touringplans.com. We wrote a script to scrape data from the website for every day from September 1, 2014 through April 30, 2019. This scraped data was saved to a CSV to be imported into our transform file with the first dataset.

The two sets of data were extracted, transformed, and loaded into a relational database (sql). The process is explained in more detail below.

### Process
**Extract**:
 - The Disneyland reviews were gathered from Kaggle.com as a .csv and imported into Python as a dataframe using Pandas.
 
 - The Disneyland weather and crowd level (park data) was scraped (see SCRAPE file) from touringplans.com via a Python script where our login credentials for the site were entered, then the browser automatically navigated to a specific date from a list of dates, and the high temperature, low temperature, and crowd level were located on the page and saved into separate lists in Python. At the end of the list of dates, the script stopped and we were able to transform the four lists (date, max_temp, min_temp, crowd_level) into a dictionary, then transform into a dataframe. We saved this dataframe as a .csv to avoid having to run the script again. This .csv was imported into the TRANSFORM file below the Disneyland reviews data.

**Transform**: 
 - The Disneyland reviews dataframe was filtered to remove Disneyland Hong Kong and Disneyland Paris, leaving only Disneyland California reviews. Next, we dropped any rows where the review date was missing. We then copied the date column to change the datatype to datetime, so we could filter by date to look only from September 2014 through April 2019.
 
 - The park data dataframe did not need to be filtered by date, as our script to scrape the website included only the dates we were interested in collecting. We did, however, drop rows where the crowd level was unknown. Next, we created a Year_Month column to transform each row's full date into only year and month, so we will be able to more easily compare the two datasets by date. More of this is explained in Analyze.

 After all other filtering and changes were made, both dataframe column names were replaced with all lowercase names to match our PostgreSQL database column names in each table.

**Load**:

In PgAdmin, we created our database, Disneyland_db, and two tables: reviews and park_data. (See .sql file to view table setup.) After ensuring that the column names matched between our Python notebook and the database, we used sqlAlchemy to connect to our local database, and psycopg2 to import each dataframe into its respective table, then read the data with a simple select statement to ensure the data was imported properly.

View the ETL mapping document to see details on the final database and tables.

**Analyze**:

With both datasets in one notebook as dataframes (see ANALYZE file), we grouped by month/year for each dataset to get an average of crowd level by month, and average review rating by month. We then concatenated these to plot them together by date to look for correlations.


### Findings
We chose this topic because Disneyland is a very well-known place worldwide, and we recognize that a lot of data can be found on the parks. We have tried through these datasets to find some informative insights about Disneyland, extract some conclusions from Disneyland reviews and make a sentiment analysis.

Looking at the reviews data, we see that 63.5% of all Disneyland California reviews in our date range are 5 star reviews. This is expected, as Disneyland is the *Happiest Place on Earth*. 

Because the reviews dataset only gave us the month and year of each review, we had to group the data by month in both datasets to be able to compare. In doing this, we found no correlation between the average crowd level each month and the average review rating for the same month. We expected this outcome, because with high and low crowd levels averaged, and high and low reviews averaged, it would be hard to really see what happens each day and how crowds may have affected moods (and therefore, reviews). 

#### Next Steps
To take this analysis a step further, we would need to get Disneyland reviews that include the full date, not just month/year. Perhaps we could do this by scraping directly from Trip Advisor's website.

----