//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


interface IAcademyBox { 

 function getCourses() view external returns (address [] memory _courseAddresses);

 function getSchools() view external returns (address [] memory _schoolAddresses);

 function getInstructor(address _instructor) view external returns (string memory _summary, address _school);

 function postCourse(address _course) external returns (bool _posted);

 function retireCourse(address _course) external returns (bool _retired);

 function openSchool(address _school) external returns (bool _opened);

 function closeSchool(address _school) external returns (bool _closed);

 function getHasInstructorHasDashboard() view external returns (bool _hasDashboard);

 function createInstructorDashboard(string memory _instructorSummary, string memory _schoolName, string memory _logo) external returns (address _instructorDashboard);

 function getInstructorDashboard() view external returns (address _instructorDashboard);

 function getHasStudentDashboard(address _student) view external returns (bool _hasDashboard);
 
 function createStudentDashboard(address _student) external returns (address _studentDashbaord);

 function getStudentDashboard(address _student) view  external returns (address _studentDashbaord);
 
}