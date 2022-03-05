//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract StudentDashboard { 

    address student;

    constructor(address _student) {
        student = _student; 
    }

    function getSchools() view external returns (uint256 [] memory _schools) {

    }

    function getCertificates() view external returns (address [] memory certNFTContracts) {

    }


    function getCourses() view external returns(address [] memory _courses){

    }


}