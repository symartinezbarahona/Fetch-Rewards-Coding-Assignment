USE fetchRewards

/*Contents of user.json file is read by bulkcolumn and stored in variable.*/
DECLARE @JSON VARCHAR(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\symar\OneDrive\Documents\Python_Projects\Fetch Rewards Assignment - Data Analyst\Fetch-Rewards-Coding-Assignment\brandsClean.json', SINGLE_CLOB) as j; 

/* It is always recommended to validate the JSON with the ISJSON function, before trying to use the JSON data. 
This function will return 1 if it’s a valid JSON format. */ 
--Select @JSON
--If (ISJSON(@JSON)=1)
--Print 'Valid JSON'

/* Removed duplicates and placed results in CTE for future reference */ 
with jsonBrands as
(SELECT DISTINCT *
FROM OPENJSON (@JSON)
/*$ characters in property names arent supported thus need to be quoted, so $oid needs to be "$oid", $date needs to be "$date", etc.. */ 
WITH (
[brandId] VARCHAR(50) '$._id."$oid"',
barcode VARCHAR(50), 
category VARCHAR(50),
categoryCode VARCHAR(50), 
cpg NVARCHAR(MAX)'$.cpg' as json, 
[name] VARCHAR(50), 
topBrand varchar(50)) json)

SELECT *
FROM jsonBrands
order by brandId