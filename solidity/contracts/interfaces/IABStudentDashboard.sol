//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


interface IABStudentDashboard { 

    function getSchools() view external returns (address [] memory _schools);
    
    function getCourses() view external returns (address [] memory _courses);
    
    function getCertificates() view external returns (uint256 [] memory _nftCertId);
    
    function getSchoolBadges() view external returns (uint256 [] memory _schoolBadges);

    function addCertificate(uint256 _certId) external returns (bool _added);

    function addSchool(address _school) external returns (bool _added);

    function addCourse(address _course) external returns (bool _added);

    function removeCourse(address _course) external returns (bool _removed);


}