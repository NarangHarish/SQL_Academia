## Problem #9 – Retrieving a subset of rows with testing for an exact string and inexact string
## Retrieve the offer number, course number, location, year, and faculty number from all course offerings in location BLM302 
 
select OfferNo, CourseNo, OffLocation, OffYear, FacNo from offering
where OffLocation = 'BLM302';

## Retrieve the offer number, course number, location, year, and faculty number from all course offerings in location BLM 3rd floor 

select OfferNo, CourseNo, OffLocation, OffYear, FacNo from offering
where left(OffLocation,4) = 'BLM3';
 
## Problem #10 – Using a derived column in both the column list and the WHERE clause
## Retrieve the student last name, student first name, and GPA plus 10% for all students with GPA plus 10% greater than 3 

alter table student add column GPA_plus10 decimal(3,2); -- add another column for GPA plus 10%
update student set GPA_plus10 = StdGPA*1.1; -- insert calculated values to GPA_plus10
select StdLastName, StdFirstName, GPA_plus10 from student 
where GPA_plus10 > 3;

 
## Problem #11 – Retrieving the number of rows from all of our tables
## For each of our tables, retrieve the number of rows, Tables are Student, Faculty, Offering, Course, and Enrollment

select concat ('Student table has ', count(*) , ' rows') from student;
select concat ('Faculty table has ', count(*) , ' rows') from faculty;
select concat ('Offering table has ', count(*) , ' rows') from offering;
select concat ('Enrollment table has ', count(*) , ' rows') from enrollment;

## Problem #12 – Examining the effect of NULL values on aggregate functions
## Retrieve the number of rows in the Faculty table using COUNT(*), COUNT(f.FacSupervisor), How many rows does each one return? 

select concat ('Faculty table has ', count(*) , ' rows') from faculty;
select concat ('Faculty table has ', count(f.FacSupervisor) , ' rows') from faculty f;

## Problem #13 – Aggregates on all rows of a table
## Retrieve the average GPA for all students 

select avg(StdGPA) from student;

## Problem #14 – Aggregates on a subset of rows of a table (using a WHERE clause)
## Retrieve the minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for freshman students 
 
select concat('Minimum GPA is ',min(StdGPA),'   Maximum GPA is ',max(StdGPA)) 
from student
where StdClass = 'FR';
select concat('Average GPA is ',avg(StdGPA),'   Average GPA plus 10% is ',avg(GPA_plus10)) 
from student 
where StdClass = 'FR';


## Problem #15 – Aggregates on a group of rows (using a GROUP BY clause)
## Retrieve the class name, minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for each class 

select StdClass, min(StdGPA), avg(StdGPA), max(StdGPA), avg(GPA_plus10)   from student group by StdClass;


## Problem #16 – Aggregates on a subset of rows that are grouped  (using a WHERE clause and a GROUP BY clause)
## Retrieve the class name, minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for each class but only for non-IS majors 

select StdClass,min(StdGPA), avg(StdGPA), max(StdGPA), avg(GPA_plus10)   from student where StdMajor != "IS" group by StdClass;
