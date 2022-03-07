//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

interface IABInstructorDashboard { 

    function getSchool() view external returns (address _school);

    function getCourses() view external returns (address[] memory _courses);

    function createCourse() external returns (address _courseAddress);

}