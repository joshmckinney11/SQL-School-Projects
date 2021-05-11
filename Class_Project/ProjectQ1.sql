create database EmployeeCourse;

use EmployeeCourse;

create table Employee(
EmployeeID INT NOT NULL auto_increment,
EmployeeFirstName varchar (20),
EmployeeLastName varchar (20),
Supervisor Int,
primary key (EmployeeID)
);

INSERT INTO Employee(EmployeeFirstName,EmployeeLastName,Supervisor) VALUES
('JOSH', 'WHITE', 1),
('Malcom', 'Brown', 3),
('Sarah', 'Miller', 1),
('Adam', 'Gordon', 2),
('Greg', 'Leroy', 2);

create table Course(
CourseID int not null,
CourseTitle varchar (30),
primary key (CourseID)
);

Insert Into Course(CourseID,CourseTitle) values
(1001, 'English 1'),
(1002, 'English 2'),
(2001, 'Math 1'),
(3001, 'Science 1'),
(3002, 'English 2');

Create table EmployeeClasses(
EID int not null auto_increment,
EmployeeID int,
CourseID int,
primary key (EID),
foreign key (EmployeeID) references Employee(EMployeeID),
foreign key (CourseID) references Course(CourseID)
);

Insert Into EmployeeClasses(EmployeeID,CourseID) values
(1,1001),
(2,1002),
(3,2001),
(4,3001),
(5,3002);

