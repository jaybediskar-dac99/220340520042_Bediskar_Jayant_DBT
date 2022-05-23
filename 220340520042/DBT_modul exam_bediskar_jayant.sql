
use MySQL;
Create table DEPT
(
DEPTNO int(2),
DNAME varchar(15),
LOC varchar(10)
);
insert into dept value
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

-- ------------------------------------------------------------------------ 
create table emp
(EMPNO int(4),
ENAME varchar(10),
JOB varchar(9),
HIREDATE date,
SAL float(7,2),
COMM float(7,2),
DEPTNO int(2)
);

insert into emp values
(7839,'KING','MANAGER','1991-11-17',5000,NULL,10),
(7698,'BLAKE','CLERK','1981-05-01',2850,NULL,30),
(7782,'CLARK','MANAGER','1981-06-09',2450,NULL,10),
(7566,'JONES','CLERK','1981-04-02',2975,NULL,20),
(7654,'MARTIN','SALESMAN','1981-09-28',1250,1400,30),
(7499,'ALLEN','SALESMAN','1981-02-20',1600,300,30);



-- 3. Display all the employees where SAL between 2500 and 5000 (inclusive of both).


select * from emp where sal between  2500 and 5000;



-- 4.Display all the ENAMEs in descending order of ENAME.
select ename from emp order by ename desc;

-- 5.Display all the JOBs in lowercase.
select lower(job) from emp;

-- 6.Display the ENAMEs and the lengths of the ENAMEs.

select ename,length(ename) from emp;

-- .7. Display the DEPTNO and the count of employees who belong to that DEPTNO .
select deptno,count(*) from emp group by deptno;

-- 8.Display the DNAMEs and the ENAMEs who belong to that DNAME.
select DNAME,ENAME from dept,emp where emp.deptno=dept.deptno;

-- 9.Display the position at which the string ‘AR’ occurs in the ename.
select ename,instr(ename,'AR') from emp;

-- 10.Display the HRA for each employee given that HRA is 20% of SAL. 
select ename,sal*0.2 as "HRA" from emp;
-- --------------------------------------------------------------------------------------------------------------------
/* Write a stored procedure by the name of PROC1 that accepts two varchar strings
as parameters. Your procedure should then determine if the first varchar string
exists inside the varchar string. For example, if string1 = ‘DAC’ and string2 =
‘CDAC, then string1 exists inside string2. The stored procedure should insert the
appropriate message into a suitable TEMPP output table. Calling program for the
stored procedure need not be written. */

create table temp(
string1 varchar(150),
string2 varchar(150),
message varchar(200)
);

delimiter //
create procedure PROC1(string1 varchar(150),string2 varchar(150))
begin
	declare message varchar(200);
    declare num int;
    select locate(string1,string2)into num;
		if num > 0 then
			insert into temp values(string1,string2,'String1 exists in String2');
		else
	        insert into temp values(string1,string2,'String1 does not exists in string2');
		end if;
	select * from temp;
end ; //
delimiter ;   

-- ---------------------------------------------------------------------------------------------------------------------
/* Create a stored function by the name of FUNC1 to take three parameters, the
sides of a triangle. The function should return a Boolean value:- TRUE if the
triangle is valid, FALSE otherwise. A triangle is valid if the length of each side is
less than the sum of the lengths of the other two sides. Check if the dimensions
entered can form a valid triangle. Calling program for the stored function need not
be written. */

delimiter //
create function FUNC1(side1 int,side2 int,side3 int)
returns boolean
deterministic
begin	
	if side1<(side2+side3) and side2<(side1+side3) and side3<(side1+side2) then
		return true;
	else
		return false;
	end if;
end ; //
delimiter ;

create table triangle
(
side1 int,
side2 int,
side3 int,
remark varchar(30)
);


delimiter //
create procedure tri(x int,y int,z int)
begin
	if FUNC1(x,y,z) then
		insert into triangle value(x,y,z,'VALID TRIANGLE');
	else
		insert into triangle values(x,y,z,'INVALID TRAINGLE');
	end if;
end ; //
delimiter ;

call tri(10,20,30);
call tri(30,20,30);
select * from triangle;

















