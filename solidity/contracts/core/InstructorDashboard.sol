//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


contract InstructorDashboard { 

    address instructor; 

    constructor( address _instructor)  { 
        instructor = _instructor; 
    }

    function getCourses() view external returns (address _courses){
        
    }

}