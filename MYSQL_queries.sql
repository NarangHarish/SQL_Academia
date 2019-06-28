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
                                                                              
## Problem #17 – Aggregates that are grouped and subsetted (using a GROUP BY clause and a HAVING clause)
## Retrieve the class name, minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for each class but only for classes with an average GPA less than 3.5. 
 
select s.StdClass, min(s.StdGPA), max(s.StdGPA), avg(s.StdGPA), avg(s.StdGPA)*1.1 as gpaplus10 
from student s
group by s.StdClass
having avg(s.StdGPA) < 3.5 ;

## Problem #18 – Aggregates of a subset of rows that are grouped and subsetted (using a WHERE clause, a GROUP BY clause, and a HAVING clause)
## Retrieve the class name, minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for each class but only for non-IS majors and only for classes with an average GPA greater than 3 for non-IS majors.

select s.StdClass, min(s.StdGPA), max(s.StdGPA), avg(s.StdGPA), avg(s.StdGPA)*1.1 as gpaplus10 
from student s
where s.StdMajor != 'IS'
group by s.StdClass
having avg(s.StdGPA) < 3 ;
 

## Problem #19 – Cartesian Products, how many rows expected 
## Perform a Cartesian Product between tables Student, Offering, Enrollment, Course, and Faculty How many columns are expected? 

select count(*) from student s; ## (Result -11)
select count(*) from offering o; ## (Result -13)
select count(*) from enrollment e; ## (Result -37)
select count(*) from course c; ## (Result -7)
select count(*) from faculty f; ## (Result -6)

select count(*) from student s, offering o, enrollment e, course c, faculty f; (Result -222,222)
## Optional 
select * from student, enrollment, offering, course, faculty;

select count(*) from information_schema.columns where TABLE_SCHEMA ='practice'
and TABLE_NAME = 'student'; (Result -10)
select count(*) from information_schema.columns where TABLE_SCHEMA ='practice'
and TABLE_NAME = 'offering'; (Result -8)
select count(*) from information_schema.columns where TABLE_SCHEMA ='practice'
and TABLE_NAME = 'enrollment'; (Result -3)
select count(*) from information_schema.columns where TABLE_SCHEMA ='practice'
and TABLE_NAME = 'course'; (Result -3)
select count(*) from information_schema.columns where TABLE_SCHEMA ='practice'
and TABLE_NAME = 'faculty'; (Result -11)

##  Problem #20 – Cartesian Products, figuring out which rows match
 
##  Perform a Cartesian Product between tables Student, Offering, Enrollment, Course, and Faculty 
##  Retrieve only the columns which are needed to show matching based on the relationship between the five tables and order in such a way as to tell the matching records. 

select  c.CourseNo, o.CourseNo, 
f.Facno, o.FacNo,
o.OfferNo, e.OfferNo,
s.StdNo, e.StdNo
from student as s, offering as o, enrollment as e, course as c, faculty as f
order by 1,2,3,4,5,6,7,8;
 
## Problem #21 – Turning a Cartesian Product into an Inner Join by adding a WHERE clause to the Cross Product Syntax 
## Start with a Cartesian Product between tables Student, Offering, Enrollment, Course, and Faculty 
## Retrieve only the columns which are needed to show matching based on the relationship between the five tables and order in such a way as to tell the matching records 
## Add a WHERE clause to turn the Cartesian Product into an Inner Join. 

select  c.CourseNo, o.CourseNo, 
	f.Facno, o.FacNo,
	o.OfferNo, e.OfferNo,
	s.StdNo, e.StdNo
from student as s, offering as o, enrollment as e, course as c, faculty as f
where c.CourseNo = o.CourseNo
	AND f.Facno = o.FacNo
	AND o.OfferNo = e.OfferNo
	AND s.StdNo = e.StdNo
order by 1,2,3,4,5,6,7,8;

## Problem #22 – Converting an Inner Join from Cross Product Syntax to Join Operator Syntax 
## Start with the Inner Join using Cross Product Syntax for the tables: Student, Offering, Enrollment, Course, and Faculty Convert to Join Operator Syntax.

select  c.CourseNo, o.CourseNo, 
	f.Facno, o.FacNo,
	o.OfferNo, e.OfferNo,
	s.StdNo, e.StdNo
from ((( course c inner join offering o
			on c.CourseNo = o.CourseNo)
			inner join enrollment e 
			on o.OfferNo = e.OfferNo)
			inner join student s 
			on s.StdNo = e.StdNo)
			inner join faculty f 
			on f.Facno = o.FacNo
order by 1,2,3,4,5,6,7,8;
 
## Problem #23 – Combining Inner Join and WHERE, GROUP BY, and HAVING clauses 
## List the course number, offer number, and average grade of students enrolled in fall 2010 IS course offerings in which more than one student is enrolled. 

select o.CourseNo, o.OfferNo, avg(e.EnrGrade) as AVG_Grade
from offering o inner join enrollment e
	on e.OfferNo = o.OfferNo
where o.OffTerm = "Fall"
	and o.CourseNo like 'IS%'
	and o.OffYear =  '2010'
group by o.CourseNo, o.OfferNo
having count(*) > 1
order by 1, 3 desc;

## fall 2009
select o.CourseNo, o.OfferNo, avg(e.EnrGrade) as AVG_Grade
from offering o inner join enrollment e
	on e.OfferNo = o.OfferNo
where o.OffTerm = "Fall"
	and o.CourseNo like 'IS%'
	and o.OffYear =  '2009'
group by o.CourseNo, o.OfferNo
having count(*) > 1
order by 1, 3 desc;

