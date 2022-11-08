
USE fetchRewards

/*Contents of user.json file is read by bulkcolumn and stored in variable.*/
DECLARE @JSON VARCHAR(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\symar\OneDrive\Documents\Python_Projects\Fetch Rewards Assignment - Data Analyst\Fetch-Rewards-Coding-Assignment\receiptsClean.json', SINGLE_CLOB) as j; 

/* It is always recommended to validate the JSON with the ISJSON function, before trying to use the JSON data. 
This function will return 1 if it’s a valid JSON format. */ 
--Select @JSON
--If (ISJSON(@JSON)=1)
--Print 'Valid JSON'

/* Removed duplicates and placed results in CTE for future reference */ 
with jsonReceipts as
(SELECT DISTINCT [receiptId],
bonusPointsEarned, 
bonusPointsEarnedReason,
createDate,
dateScanned, 
finishedDate, 
modifyDate,  
pointsAwardedDate 
pointsEarned, 
PurchaseDate, 
purchasedItemCount, 
rewardsReceiptItemList, 
rewardsReceiptStatus, 
totalSpent , 
userId
FROM OPENJSON (@JSON)
/*$ characters in property names arent supported thus need to be quoted, so $oid needs to be "$oid", $date needs to be "$date", etc.. */ 
WITH (
[receiptId] VARCHAR(50) '$._id."$oid"',
bonusPointsEarned int, 
bonusPointsEarnedReason VARCHAR(255),
cd BIGINT'$.createDate."$date"',
ds BIGINT'$.dateScanned."$date"',
fd BIGINT '$.finishedDate."$date"',
md BIGINT '$.modifyDate."$date"',
pad BIGINT '$.pointsAwardedDate."$date"', 
pointsEarned decimal(10,2), 
pd BIGINT '$.purchaseDate."$date"',
purchasedItemCount int, 
rewardsReceiptItemList nvarchar(max)'$.rewardsReceiptItemList' as json, 
rewardsReceiptStatus VARCHAR(50), 
totalSpent decimal(10,2), 
userId VARCHAR(50)) json
/*Unix epoch $date values overflow int storage so need to be deserialized as bigint types. Additionally, 
The dateadd function's numeric parameter is of type int, so to avoid Arithmetic overflow you'll need to divide the millisecond 
values by 1,000 and use them as seconds instead */ 
cross apply 
(SELECT createDate = DATEADD(ss, cd/1000, '1970-01-01'),
dateScanned = DATEADD(ss, ds/1000, '1970-01-01'), 
finishedDate = DATEADD(ss, fd/1000, '1970-01-01'), 
modifyDate = DATEADD(ss, md/1000, '1970-01-01'), 
pointsAwardedDate = DATEADD(ss, pad/1000, '1970-01-01'), 
PurchaseDate = DATEADD(ss, pd/1000, '1970-01-01')) calc )

SELECT *
FROM jsonReceipts
order by ReceiptId














