//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IAcademyBox.sol";
import "../interfaces/IABCourse.sol";
import "../interfaces/IABInstructorDashboard.sol";

import "./Course.sol";

contract InstructorDashboard is IABInstructorDashboard { 

    address instructor; 
    string instructorDetails; 
    IABCourseInstructor [] courses; 
    address [] courseAddresses; 
    IAcademyBox academyBox;
    IABSchool school;  
    

    constructor( address _instructor, string memory _instructorDetails, address _academyBox, address _school)  { 
        instructor = _instructor; 
        instructorDetails = _instructorDetails; 
        academyBox = IAcademyBox(_academyBox);
        school = IABSchool(_school);
    }

    function getSchool() view external returns (address _school) {
        return address(school);
    }

    function getCourses() view external returns (address[] memory _courses){
        return courseAddresses;         
    }

    function createCourse() external returns (address _courseAddress){
        IABCourseInstructor course_ = new Course(instructor, instructorDetails, address(academyBox), address(school));
        courses.push(course_);
        return address(course_);
    }

}