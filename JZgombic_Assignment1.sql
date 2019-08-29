#	1a.	How many airplanes have listed speeds?

SELECT 
	count(*) AS 'Planes with Speed Listed'
FROM 
	planes
WHERE 
	speed IS NOT null;

#	1b.	What is the minimum listed speed?

SELECT
	MIN(speed) AS 'Minimum Listed Speed' 
FROM 
	planes;
    
#	1c.	What is the maximum listed speed?

SELECT
	MAX(speed) AS 'Maximum Listed Speed' 
FROM 
	planes;
    

#	2a.	What is the total distance flown by all of the planes in January 2013?

SELECT
	SUM(distance) AS 'Total Distance Travelled in January 2013' 
FROM 
	flights
WHERE
	month = 1 AND year = 2013;
    
#	2b.	What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

SELECT
	SUM(distance) AS 'Total Distance Travelled in 2013' 
FROM 
	flights
WHERE
	month = 1 AND year = 2013 AND tailnum = "";
    

#	3.	What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?

#	3a.	USING INNER JOIN (Using this method does not show the null values for tailnum.)

SELECT
	p.manufacturer, SUM(f.distance) AS 'Total Distance Travelled'
FROM 
	flights f
INNER JOIN 
	planes p
ON 
	f.tailnum = p.tailnum
WHERE
	f.month = 7 AND f.day = 5 AND f.year = 2013
GROUP BY
	p.manufacturer;
    
#	3b.	USING LEFT OUTER JOIN (Using this method shows the null values for tailnum.)
	
SELECT
	p.manufacturer, SUM(f.distance) AS 'Total Distance Travelled'
FROM 
	flights f
LEFT OUTER JOIN 
	planes p
ON 
	f.tailnum = p.tailnum
WHERE
	f.month = 7 AND f.day = 5 AND f.year = 2013
GROUP BY
	p.manufacturer;
    

#	4.	What is the average distance travelled by Turbo-Fan planes with over 100 seats for each carrier?

SELECT 
	a.name, 
	COUNT(p.engine) AS 'Number of Turbo-Fan Planes', 
    AVG(f.distance) AS 'Average Distance Travelled'
FROM 
	airlines a
INNER JOIN 
	flights f 
ON 
	a.carrier = f.carrier
INNER JOIN 
	planes p 
ON 
	f.tailnum = p.tailnum
WHERE 
	f.month = 7 AND f.year = 2013 AND p.engine = 'turbo-fan' AND p.seats > 100
GROUP BY 
	a.name
ORDER BY 
	a.name ASC;