---------SQL COACHX PROJECT 1

CREATE DATABASE COACHX
USE COACHX

CREATE TABLE EMPLOYEEDETAIL(
EMPLOYEEID INT PRIMARY KEY,
FIRSTNAME VARCHAR(25),
LASTNAME VARCHAR(25),
SALARY MONEY,
JOININGDATE DATE,
DEPARTMENT VARCHAR(10),
GENDER CHAR
)
ALTER TABLE EmployeeDetail
ALTER COLUMN JoiningDate DATETIME;

ALTER TABLE EmployeeDetail
ALTER COLUMN GENDER VARCHAR(10);





INSERT INTO EMPLOYEEDETAIL VALUES (1,'VIKAS','AHIAWAT',600000,'2013/2/12 11:16','IT','MALE'),
                                  (2,'NIKITA','JAIN',530000,'2013/2/14 11:16','HR','FEMALE'),
								  (3,'ASHISH','KUMAR',1000000,'2013/2/12 11:16','IT','MALE'),
								  (4,'NIKHIL','SHARMA',480000,'2013/2/15 11:16','HR','MALE'),
								  (5,'ANISH','KADIAN',500000,'2013/2/16 11:16','PAROLL','MALE')


SELECT * FROM EMPLOYEEDETAIL

SELECT FIRSTNAME FROM EMPLOYEEDETAIL

SELECT UPPER(FIRSTNAME)FROM EMPLOYEEDETAIL

SELECT CONCAT(FIRSTNAME,' ', LASTNAME) AS FULLNAME FROM EMPLOYEEDETAIL

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME = 'VIKAS'

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME LIKE 'A%'

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME LIKE '%H'

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME LIKE 'A_P%'

SELECT *
FROM EMPLOYEEDETAIL
WHERE FirstName LIKE '[A-P]_';

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME NOT LIKE 'A_P%'

SELECT * FROM EMPLOYEEDETAIL
WHERE EMPLOYEEID =(SELECT SUBSTRING(GENDER,1,4) FROM EMPLOYEEDETAIL WHERE GENDER LIKE '%_ _LE'

SELECT * FROM EMPLOYEEDETAIL
WHERE GENDER LIKE '__LE%'

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME LIKE 'A____'

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME LIKE 'VIK%AS'

SELECT DEPARTMENT FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT

SELECT MAX(SALARY) AS HIGHTS_SALARY FROM EMPLOYEEDETAIL

SELECT MIN(SALARY)AS LOWESSALARY FROM EMPLOYEEDETAIL

SELECT JOININGDATE FROM EMPLOYEEDETAIL
WHERE JOININGDATE = '15 FEB 2013'

SELECT * FROM EMPLOYEEDETAIL
SELECT FORMAT(JoiningDate, 'dd MMM yyyy') AS FormattedJoiningDate
FROM EMPLOYEEDETAIL

SELECT FORMAT(JoiningDate, 'YYYY/MM/DD') AS FormattedJoiningDate
FROM EMPLOYEEDETAIL

+
SELECT FORMAT(JoiningDate, 'yyyy/MM/dd') AS FormattedJoiningDate
FROM EMPLOYEEDETAIL;


SELECT FORMAT(JoiningDate, 'HH:mm:ss') AS TimePart
FROM EMPLOYEEDETAIL


SELECT FORMAT(JOININGDATE, 'yyyy') AS YEAR FROM EMPLOYEEDETAIL

SELECT FORMAT(JoiningDate, 'yyyy') AS Year
FROM EMPLOYEEDETAIL;

SELECT FORMAT(JoiningDate, 'mmm') AS months
FROM EMPLOYEEDETAIL;


SELECT GETDATE() AS CurrentDate;

SELECT GETUTCDATE() AS CurrentUTCDate;


select firstname ,getdate() from EMPLOYEEDETAIL


SELECT * FROM EMPLOYEEDETAIL

SELECT 
    FIRSTNAME,
    GETDATE() AS CurrentDate,
    JoiningDate,
    DATEDIFF(MONTH, JoiningDate, GETDATE()) AS MonthsDifference
FROM EMPLOYEEDETAIL;


select CONCAT( firstname,'_',LASTNAME) AS FULLNAME,GETDATE() AS CURRENTDATE, JOININGDATE , DATEDIFF(MONTH, JOININGDATE , GETDATE()) AS MONTHDIFFERENCE FROM EMPLOYEEDETAIL


SELECT * FROM EMPLOYEEDETAIL

SELECT *
FROM EMPLOYEEDETAIL
WHERE YEAR(JoiningDate) = 2013;

SELECT *
FROM EMPLOYEEDETAIL
WHERE MONTH(JoiningDate) = 2


SELECT COUNT( EMPLOYEEID) TOTAL_EMP FROM EMPLOYEEDETAIL

SELECT TOP (1) *  FROM EMPLOYEEDETAIL

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME IN ('VIKAS','ASHISH','NIKHIL')

SELECT * FROM EMPLOYEEDETAIL
WHERE FIRSTNAME NOT IN ('VIKAS','ASHISH','NIKHIL')

SELECT * FROM EMPLOYEEDETAIL

SELECT RTRIM(FirstName) AS FirstName
FROM EMPLOYEEDETAIL

SELECT LTRIM(FirstName) AS FirstName
FROM EMPLOYEEDETAIL

SELECT 
    FIRSTNAME,
    CASE 
        WHEN GENDER = 'MALE' THEN 'M'
        WHEN GENDER = 'FEMALE' THEN 'F'
    END AS GENDER
FROM EMPLOYEEDETAIL
WHERE GENDER IN ('MALE', 'FEMALE');


SELECT FIRSTNAME ,
       CASE 
	   WHEN GENDER ='MALE' THEN 'M'
	   WHEN GENDER = 'FEMALE' THEN 'F'
	   END AS GENDER
FROM EMPLOYEEDETAIL
WHERE GENDER IN ('MALE' ,'FEMALE')

SELECT 'HELLO ' + FIRSTNAME AS PrefixedName
FROM EMPLOYEEDETAIL

SELECT CONCAT('HELLO ', FIRSTNAME) AS PrefixedName
FROM EMPLOYEEDETAIL;

SELECT * FROM EMPLOYEEDETAIL
WHERE SALARY > 600000

SELECT * FROM EMPLOYEEDETAIL
WHERE SALARY < 700000


SELECT * FROM EMPLOYEEDETAIL
WHERE SALARY BETWEEN 500000 AND 600000

CREATE TABLE PROJECTDETAIL(
PROJECTDETAILSID INT ,
EMPLOYEEDETAILID INT,
PROJECTNAME VARCHAR (25)
)

INSERT INTO PROJECTDETAIL VALUES (1,1,'TASK TRACK'),
                                 (2,2,'CLP'),
								 (3,1,'SYRVEY MANAGMENT'),
								 (4,2, 'HR MANAGMENT'),
								 (5,3,'TASK TRACK'),
								 (6,3,'GRS'),
								 (7,3,'DDS'),
								 (8,4,'HR MANAGMENT'),
								 (9,6,'GL MANAGMENT')

SELECT * FROM EMPLOYEEDETAIL
SELECT * FROM PROJECTDETAIL

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY  FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY  FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY ASC

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY  FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT
ORDER BY TOTAL_SALARY DESC


SELECT 
    DEPARTMENT,
    COUNT(*) AS TotalEmployees,
    SUM(SALARY) AS TotalSalary
FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT;

SELECT DEPARTMENT, 
COUNT(*) AS TOTALEMPLOYEES,
SUM(SALARY) AS TOTALSALARY 
FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT

SELECT DEPARTMENT ,AVG(SALARY) AS AVGSALARY FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT
ORDER BY AVGSALARY ASC

SELECT DEPARTMENT, MIN(SALARY) AS MINSALARY FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT

SELECT DEPARTMENT, MAX(SALARY) AS MAXSALARY FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT

SELECT DEPARTMENT, MIN(SALARY) AS MINSALARY FROM EMPLOYEEDETAIL
GROUP BY DEPARTMENT
ORDER BY MINSALARY ASC

SELECT * FROM EMPLOYEEDETAIL
SELECT * FROM PROJECTDETAIL

SELECT * FROM EMPLOYEEDETAIL E
INNER JOIN PROJECTDETAIL P
ON E.EMPLOYEEID = P.EMPLOYEEDETAILID


SELECT CONCAT( E.FIRSTNAME,' ' ,E.LASTNAME)AS EMP_NAME,P.PROJECTNAME FROM EMPLOYEEDETAIL E 
JOIN PROJECTDETAIL P ON E.EMPLOYEEID = P.EMPLOYEEDETAILID
ORDER BY EMP_NAME ASC 

SELECT 
    CONCAT(E.FIRSTNAME, ' ', E.LASTNAME) AS EMPLOYEENAME,
    P.PROJECTNAME 
FROM 
    EMPLOYEEDETAIL E
JOIN 
    PROJECTDETAIL P ON E.EMPLOYEEID = P.EMPLOYEEDETAILID
ORDER BY 
   E.FIRSTNAME ASC


SELECT CONCAT (E.FIRSTNAME,' ',E.LASTNAME) AS EMP_NAME ,COALESCE (P.PROJECTNAME, 'NO PROJECT ASSIGNED')AS PROJECT_NAME FROM EMPLOYEEDETAIL E
LEFT JOIN PROJECTDETAIL P 
ON P.EMPLOYEEDETAILID = E.EMPLOYEEID

SELECT  CONCAT (E. FIRSTNAME,'',E.LASTNAME) AS EMP_NAME  ,P.PROJECTNAME FROM EMPLOYEEDETAIL E
RIGHT JOIN PROJECTDETAIL P 
ON P.EMPLOYEEDETAILID = E.EMPLOYEEID
ORDER BY E.FIRSTNAME

SELECT * FROM EMPLOYEEDETAIL E
FULL JOIN  PROJECTDETAIL P
ON  E.EMPLOYEEID = P.EMPLOYEEDETAILID

SELECT CONCAT(E.FIRSTNAME,' ',E.LASTNAME) AS  EMP_NAEM , P.PROJECTNAME  FROM EMPLOYEEDETAIL E 
FULL JOIN PROJECTDETAIL P
ON  E.EMPLOYEEID = P.EMPLOYEEDETAILID
ORDER BY E.FIRSTNAME  


SELECT  CONCAT(E.FIRSTNAME,' ',E.LASTNAME) AS EMP_NAEM , P.PROJECTNAME,EMPLOYEEID  FROM EMPLOYEEDETAIL E 
JOIN PROJECTDETAIL P
ON  E.EMPLOYEEID = P.EMPLOYEEDETAILID
WHERE P.EMPLOYEEDETAILID IN (SELECT EMPLOYEEDETAILID FROM PROJECTDETAIL GROUP BY EMPLOYEEDETAILID
HAVING COUNT(PROJECTDETAILSID) > 1)
ORDER BY E.FIRSTNAME ASC

SELECT 
    CONCAT(E.FIRSTNAME, ' ', E.LASTNAME) AS EMPLOYEENAME,
    P.PROJECTNAME
FROM 
    EMPLOYEEDETAIL E
JOIN 
    PROJECTDETAIL P ON E.EMPLOYEEID = P.EMPLOYEEDETAILID
WHERE 
    P.EMPLOYEEDETAILID IN (
        SELECT 
            EMPLOYEEDETAILID 
        FROM 
            PROJECTDETAIL 
        GROUP BY 
            EMPLOYEEDETAILID 
        HAVING 
            COUNT(PROJECTDETAILSID) > 1
    )
ORDER BY 
    E.FIRSTNAME ASC;

SELECT CONCAT(E.FIRSTNAME,' ',E.LASTNAME) AS EMP_NAME, P.PROJECTNAME FROM EMPLOYEEDETAIL E
JOIN PROJECTDETAIL P 
ON E.EMPLOYEEID = P.EMPLOYEEDETAILID
WHERE PROJECTNAME IN (SELECT PROJECTNAME FROM PROJECTDETAIL GROUP BY PROJECTNAME
HAVING COUNT(DISTINCT  EMPLOYEEDETAILID) > 1 )
ORDER BY P.PROJECTNAME , FIRSTNAME ASC

SELECT * FROM EMPLOYEEDETAIL E
CROSS JOIN PROJECTDETAIL P
ORDER BY FIRSTNAME ASC

CREATE TABLE FUELDETAIL (
ID INT,
FUEL INT,
DATE DATETIME
)

SELECT * FROM FUELDETAIL
-- Insert records into the table
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (1, 10, '2014-04-25 10:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (2, 9, '2014-04-25 11:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (3, 8, '2014-04-25 12:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (4, 6, '2014-04-25 13:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (5, 12, '2014-04-25 14:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (6, 11, '2014-04-25 15:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (7, 10, '2014-04-25 16:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (8, 9, '2014-04-25 17:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (9, 8, '2014-04-25 18:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (10, 10, '2014-04-25 19:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (11, 9, '2014-04-25 20:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (12, 8, '2014-04-25 21:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (13, 7, '2014-04-25 22:00:00.000');
INSERT INTO FUELDETAIL (ID, FUEL, DATE) VALUES (14, 15, '2014-04-25 23:00:00.000');



SELECT CONCAT(UPPER(LEFT(FIRSTNAME , 1)),LOWER(SUBSTRING(FIRSTNAME,2,LEN(FIRSTNAME))))AS FIRSTNAME FROM EMPLOYEEDETAIL



	SELECT 
    CONCAT(UPPER(LEFT(FIRSTNAME, 1)), LOWER(SUBSTRING(FIRSTNAME, 2, LEN(FIRSTNAME)))) AS FIRSTNAME_FORMATTED,
    CONCAT(UPPER(LEFT(LASTNAME, 1)), LOWER(SUBSTRING(LASTNAME, 2, LEN(LASTNAME)))) AS LASTNAME_FORMATTED
FROM 
   EMPLOYEEDETAIL

 select * from EMPLOYEEDETAIL

 SELECT STRING_AGG(FIRSTNAME, ', ') AS EMPLOYEENAMES
FROM EMPLOYEEDETAIL

 select * from EMPLOYEEDETAIL
 select * from PROJECTDETAIL
 SELECT * FROM FUELDETAIL

 select  P.PROJECTNAME, STRING_AGG(FIRSTNAME,',')AS FIRST_NAME
 from EMPLOYEEDETAIL E
 JOIN PROJECTDETAIL P 
 ON P.EMPLOYEEDETAILID=E.EMPLOYEEID
 GROUP BY P.PROJECTNAME
HAVING COUNT(E.EMPLOYEEID)>1
ORDER BY P.PROJECTNAME


SELECT * FROM FUELDETAIL;
-----------ADVANCE QUTION 4 
/*DVANCE ----YOU HAVER FUEL DETAIL TABLE WITH ID,FUEL ,AND DATE COLUMNS,--FUEL COLUMS IS CONTAIN IS CONTAIN FUEL QUANTITY AT A PARTICULAR TIME WHEN CAR START TRAVALING . SO WE NEED
TO FIND OUT THAT WHEN THE DRIVER FILL PERTROL IN HIS?HER CAR,  BY FUEL DETAIL TABLE IMAGE ON THE TOP OF THIS POST , YOU CAN UNDERSTAND THE QUERY 
---CAR START DRIVING AT 10AN ON 25TH APRIL WITH PETROL(10 LITER)--AT 11 AM PETROL WAS 9 LITERS --AT 121 AM PERTREOL WAS 8 LITERS --AT 2 PM (14) PETROL WAS 12 LITERS
---THIS MEANS THAT HE/SHE FILL THE PETROL ART 25 APRIL 2014 AT 2 PM NEXT TIME FILL PETROL AT 7 PM 25TH APRIL 2014 -- AND NEXT TIME HE FILL PETROL AT 11PM 25TH APRIL 2014 */

WITH FuelChanges AS (
    SELECT 
        ID,
        FUEL,
        DATE,
        LAG(FUEL) OVER (ORDER BY DATE) AS PrevFUEL
    FROM 
        FUELDETAIL
)
SELECT 
    ID,
    FUEL,
    DATE
FROM 
    FuelChanges
WHERE 
    FUEL > PrevFUEL;

