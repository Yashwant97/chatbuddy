create database chatbuddy;
use chatbuddy;
create table chatuser(userid int(10) Primary key Auto_increment, name varchar(255) not null, email varchar(255) not null,password varchar(255) not null,gender enum('Male','Female','Others'),phone varchar(255) not null,status enum('Online','Offline');
