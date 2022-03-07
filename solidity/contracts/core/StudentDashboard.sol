//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IABSchool.sol";
import "../interfaces/IABCourse.sol";
import "../interfaces/IABStudentDashbaord.sol";
import "../libraries/LAcademyBoxUtils.sol";

contract StudentDashboard is IABStudentDashboard { 

    using LAcademyBoxUtils for address; 
    using LAcademyBoxUtils for IABCourse; 

    address student;
    IABSchool [] schools; 
    IABCourse [] courses; 
    
    address [] schoolAddresses; 
    address [] courseAddresses; 


    uint256 [] nftCertIds; 
    uint256 [] schoolBadges; 

    constructor(address _student) {
        student = _student; 
    }

    function getSchools() view external returns (address [] memory _schools) {
        return schoolAddresses; 
    }

    function getCourses() view external returns (address [] memory _courses){
        return courseAddresses; 
    }

    function getCertificates() view external returns (uint256 [] memory _nftCertId) {
        return  nftCertIds; 
    }

    function getSchoolBadges() view external returns (uint256 [] memory _schoolBadges) {
        return schoolBadges; 
    }

    function addCertificate(uint256 _certId) external returns (bool _added) {
        nftCertIds.push(_certId);
        return true; 
    }

    function addSchool(address _school) external returns (bool _added){
        
        
        schools.push(IABSchool(_school));
        schoolAddresses.push(_school);
        return true; 
    }

    function addCourse(address _course) external returns (bool _added){
        courses.push(IABCourse(_course));
        courseAddresses.push(_course);
        return true; 
    }

    function removeCourse(address _course) external returns (bool _removed) {
        courses = IABCourse(_course).remove(courses);
        return true; 
    }

}