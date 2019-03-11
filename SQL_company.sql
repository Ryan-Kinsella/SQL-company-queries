/* Ryan Kinsella, 10194574 */

/*Q1
Which projects do Wong, Borg and English work on?  
List the employee's name and the name of the project that they work on.
*/
select FName, LName, PName 
from employee, project 
where (Lname = "Borg" or Lname = "Wong" or Lname = "English") and Dno = Dnum;

/*Q2
Which employees have both a son and a daughter dependent? 
List the employee's first and last names.
*/
select Fname, Lname
from Dependent son, Dependent daughter, Employee
where son.ESSN = SSN and daughter.ESSN = SSN and daughter.Relationship = "Daughter" and son.Relationship = "Son";

/*Q3
List the department locations, the project names associated with each department,
and the number of employees that work on each project.
*/
select Dlocation, Pname,  count(Pname) as numEmployees 
from Deptlocations, project, works_on 
where DNumber = Dnum and Pnumber = Pno and dlocation = plocation 
group by Pname;

/*Q4
List all projects that are worked on by both (ie. not either or, but both)
Narayan and Jabbar. List the project name and id.
*/
select Pname, Pnumber
from Works_on join Employee on Works_on.ESSN = Employee.SSN join Project on Works_on.Pno = Project.Pnumber 
where Lname = "Narayan" and (Pname, Pnumber) in
(select Pname, Pnumber
from Works_on join Employee on Works_on.ESSN = Employee.SSN join Project on Works_on.Pno = Project.Pnumber 
where Lname = "Jabbar");

/*Q5
For each employee who has a dependent born after 1970, list the employee's name and the (approximate) 
age of their dependent. Use the year to get an approximate age.
*/
select Fname, Lname, 2019-year(Dependent.Bdate) as Age
from Employee join Dependent on Employee.SSN=Dependent.ESSN
where year(Dependent.Bdate)>'1970';

/*Q6
List the employees that work on all projects located in Sugarland.
List the employee's first and last name, the project name, along with the total number of hours
that they work on this project.


--First way to do, using the join function (there is no advantage to either method)
--select Fname, Lname, Pname, Hours
--from Works_on join Employee on SSN = ESSN join Project on Pnumber = Pno
--where PLocation = "Sugarland"

--Second way to do, using the where statements instead of join function
*/
select Fname, Lname, Pname, Hours
from Works_on, Employee, Project
where SSN = ESSN and Pnumber = Pno and PLocation = "Sugarland";

/*Q7
Make a list of all the employees and their supervisor's names.  If they do not have a supervisor,
they should still appear in the list, but the supervisor's name should be blank (or null).

--Create custom headers for two seperate employee tables, and join them where employeeSSN = supervisorSSN
*/
select employ.Fname AS 'employee Fname',
    employ.Lname AS 'employee Lname',
    super.Fname AS 'supervisor Fname',
    super.Lname AS 'supervisor Lname'
from Employee employ left join Employee super on employ.SuperSSN = super.SSN;

/*Q8
Make a list that includes the project name, the manager's first and 
last name and the project's location.
*/
select Pname, Fname, Lname, PLocation
from Employee, Project, Department, Works_on
where MGRSSN = SSN and Dnumber = Dnum and Pnumber = Pno
group by Pname;

/*Q9
Which employees earn the maximum salary.  The maximum salary will be defined as the highest recorded salary 
in the database. List the employee's name and SSN.
*/
select max(Salary) as "Max Salary", Fname, Lname, SSN
from Employee;

/*Q10
Which manager makes the most money? Show their first and last name.
*/
select max(Salary) as "Most Money", Fname, Lname
from Employee, Department
where MGRSSN = SSN;

