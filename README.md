# Fetch Rewards Coding Project
## Overview
In this project, I will demonstrate my ability to reason about data as well as showcase how I communicate findings and insights with stakeholders and business executives.

----
## Requirements
1. Review unstructured JSON data and diagram a new structured relational data model

2. Generate a query that answers a predetermined business question
    - What are the top 5 brands by receipts scanned for most recent month?
    - How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
    - When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
    - When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
    - Which brand has the most spend among users who were created within the past 6 months?
    - Which brand has the most transactions among users who were created within the past 6 months?

>  
3. Generate a query to capture data quality issues against the new structured relational data model

4. Write a short email or Slack message to the business stakeholder
    - What questions do you have about the data?
    - How did you discover the data quality issues?
    - What do you need to know to resolve the data quality issues?
    - What other information would you need to help you optimize the data assets you're trying to create?
    - What performance and scaling concerns do you anticipate in production and how do you plan to address them?

----

### Setup

1. Fork or clone this repo to your own computer and `cd` into the directory

2. Make sure you have the proper dependencies installed.
    - You can do this by typing `pip install -r requirements.txt` in the command line

---
## The Data

### Receipts Data Schema

Column | Definition
--- | -----------
_id | uuid for this receipt
bonusPointsEarned | Number of bonus points that were awarded upon receipt completion
createDate | The date that the event was created
dateScanned | Date that the user scanned their receipt
finishedDate | Date that the receipt finished processing
modifyDate | The date the event was modified
pointsAwardedDate | The date we awarded points for the transaction
pointsEarned | The number of points earned for the receipt
purchaseDate | The date of the purchase
purchasedItemCount | Count of number of items on the receipt
rewardsReceiptItemList | The items that were purchased on the receipt
rewardsReceiptStatus | Status of the receipt through receipt validation and processing
totalSpent | The total amount on the receipt
userId | String id back to the User collection for the user who scanned the receipt

----
----

### Users Data Schema

Column | Definition
--- | -----------
_id | User Id
state | state abbreviation
createdDate | When the user created their account
lastLogin | Last time the user was recorded logging in to the app
role | Constant value set to 'CONSUMER'
active | Indicates if the user is active; only Fetch will de-activate an account with this flag

----
----

Column | Definition
--- | -----------
_id | Brand uuid
barcode | The barcode on the item
brandCod | String that corresponds with the brand column in a partner product file
category | The category name for which the brand sells products in
categoryCode | The category code that references a BrandCategory
cpg | Reference to CPG collection
topBrand | Boolean indicator for whether the brand should be featured as a 'top brand'
name |Brand name

---

## Additional Requirements

1. Database Diagram
    -  Given the lack of knowledge on the API and the overall data schemas, I have incoporated a theoretical relational data model, found in the repo as `fetchRewards Database Diagram.pdf`.   Using SQL Server Management Studio, I illustrate how a proper relational database would look like once more information is acquired and certain data quality issues are addressed.  
    - One thing to note, specifically for the receipts table, is that the diagram includes an alternative id column which is theorized as a potential primary key since the current table is formatted by item and not receipt. This was purposely done to extract brand data more easily. 

2. Email to stakeholders
    - This can be found in the repo as `Email to Stakeholder.pdf` and includes a preliminary analysis of findings as well as product and system recommendations. 
    - Visuals were developed using ThinkCell in Microsoft Powerpoint. The idea behind them was to make information more digestable and insightful as they relate to day-to-day business needs. You can find the ppt file as `Stakeholder Visuals.pptx` in the supplemental folder.  
