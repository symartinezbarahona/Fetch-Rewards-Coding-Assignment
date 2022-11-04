/* Create database*/ 
USE fetchRewards;
--CREATE DATEBASE fetch_rewards

--CREATE DATABASE fetchRewards

/*Contents of user.json file is read by bulkcolumn and stored in variable.*/
DECLARE @JSON VARCHAR(max)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\symar\OneDrive\Documents\Python_Projects\Fetch Rewards Assignment - Data Analyst\Fetch-Rewards-Coding-Assignment\usersClean.json', SINGLE_CLOB) as j; 

/* It is always recommended to validate the JSON with the ISJSON function, before trying to use the JSON data. 
This function will return 1 if it’s a valid JSON format. */ 
--Select @JSON
--If (ISJSON(@JSON)=1)
--Print 'Valid JSON'

/* Create table only if it does not exist 
IF OBJECT_ID(N'dbo.user', N'U') IS NULL
-CREATE TABLE fetchRewards.dbo.[user] (
[id] INT IDENTITY (1,1) PRIMARY KEY, 
[userId] VARCHAR(50) NOT NULL, 
[state] VARCHAR(5), 
createdDate DATETIME, 
lastLogin DATETIME, 
[role] VARCHAR(50), 
signUpSource VARCHAR(10),
active VARCHAR(10));
*/

/* Removed duplicates and placed results in CTE for future reference */ 
with jsonUsers as
(SELECT DISTINCT [userId], [state], createdDate, lastLogin, [role], signUpSource, active
FROM OPENJSON (@JSON)
/*$ characters in property names arent supported thus need to be quoted, so $oid needs to be "$oid", $date needs to be "$date", etc.. */ 
WITH (
[userId] VARCHAR(50) '$._id."$oid"',
[state] VARCHAR(50),
cd BIGINT'$.createdDate."$date"',
ll BIGINT '$.lastLogin."$date"',
[role] VARCHAR(50),
signUpSource VARCHAR(50),
active VARCHAR(50)) AS json
/*Unix epoch $date values overflow int storage so need to be deserialized as bigint types. Additionally, 
The dateadd function's numeric parameter is of type int, so to avoid Arithmetic overflow you'll need to divide the millisecond 
values by 1,000 and use them as seconds instead */ 
cross apply 
(SELECT createdDate = DATEADD(ss, cd/1000, '1970-01-01'),
lastLogin = DATEADD(ss, ll/1000, '1970-01-01')) calc )

select * 
from jsonUsers
order by [userId]