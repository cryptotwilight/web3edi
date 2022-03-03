// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./W3ECourse.sol";

contract W3ECourseCatalogue { 
    
    mapping(address=>W3ECourse[]) coursesByInstructor; 


    constructor() { 
        
    }

    function getCourses() view external returns (address [] memory _courses){

    }



    function createCourse(address _instructor) external returns (address _course) {
        W3ECourse course_ = new W3ECourse(_instructor);
        coursesByInstructor[_instructor].push(course_);
        return address(course_);
    }

    function removeCourse(address _course) external returns(uint256 _courseId){

    }

    
}