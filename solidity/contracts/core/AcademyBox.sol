//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

//import "https://github.com/decentology/hyperverse-mono/blob/0f4947dda72c32f78da014b499211aa64e59b572/packages/hyperverse-ethereum-tribes/contracts/Tribes.sol";
import "./Course.sol";
import "./School.sol";
import "./InstructorDashboard.sol";
import "./StudentDashboard.sol";

import "../interfaces/IAcademyBox.sol";
import "../interfaces/IABSchool.sol";



 
contract AcademyBox is /*IHyperverseModule,*/ IAcademyBox { 

    using LAcademyBoxUtils for address;
    using LAcademyBoxUtils for IABSchool;

    address administrator; 
 //   Tribes tribes; 
    address self; 

    mapping(address=>bool) hasStudentDashboard;
    mapping(address=>bool) hasInstructorDashboard; 
    mapping(address=>address) dashboardByInstructor; 
    mapping(address=>address) dashboardByStudent; 
    mapping(uint256=>address[]) studentBySchool; 

    struct Instructor { 
        string _summary; 
        uint256 [] _schoolIds;
        string [] _schoolNames;
    }

    IABSchool [] schools; 
    address [] schoolAddresses; 

    uint256 schoolCounter; 

    mapping(address=>IABSchool) schoolsByInstructor;
    mapping(uint256=>IABSchool) schoolById; 
    mapping(address=>string) summaryByInstructor; 

    address [] activeCourses; 
    address [] retiredCourses; 

    constructor(address _administrator, address _tribesDeployment) {
        administrator = _administrator; 
       // tribes = Tribes(_tribesDeployment);
        self = address(this);
    }

    function getCourses() view external returns (address [] memory _courseAddresses){
        return activeCourses; 
    }

    function getSchools() view external returns (address [] memory _schools){
        return schoolAddresses; 
    }

    function getInstructor(address _instructor) view external returns (string memory _summary, address _school){
        _summary = summaryByInstructor[_instructor];
        return (_summary, address(schoolsByInstructor[_instructor]));
    }

    function openSchool(address _school) external returns (bool _schoolOpen){
        schools.push(IABSchool(_school));
        schoolAddresses.push(_school);
        return true; 
    }

    function closeSchool(address _school) external returns (bool _schoolClosed) {
        schools = IABSchool(_school).remove(schools);
        schoolAddresses = _school.remove(schoolAddresses);
        return true; 
    }

    function postCourse(address _course) external returns(bool _posted) {
        activeCourses.push(_course);
        return true;   
    }

    function retireCourse(address _course) external returns (bool _retired) {
        retiredCourses.push(_course);
        activeCourses = _course.remove(activeCourses);
        return true; 
    }


    function getHasInstructorHasDashboard() view external returns (bool _hasDashboard) {
        address instructor_ = msg.sender; 
        return hasInstructorDashboard[instructor_];
    }

    function createInstructorDashboard(string memory _instructorSummary, string memory _schoolName, string memory _logo) external returns (address _instructorDashboard) {
        
        address instructor_ = msg.sender; 
      //  tribes.addNewTribe(_schoolName);

        summaryByInstructor[instructor_] = _instructorSummary; 
        uint256 _schoolId = schoolCounter++; //tribes.totalTribes(self);
        
        School school = new School(_schoolName, instructor_, _schoolId, _logo/*, address(tribes) */);
    
        _instructorDashboard = address(new InstructorDashboard(instructor_, _instructorSummary, self, address(school))); 
        dashboardByInstructor[instructor_] =  _instructorDashboard; 
        hasInstructorDashboard[instructor_] = true;         
        return _instructorDashboard; 
    }

    function getInstructorDashboard() view external returns (address _instructorDashboard) {
        address instructor_ = msg.sender;         
        return dashboardByInstructor[instructor_];                    
    }


    function getHasStudentDashboard(address _student) view external returns (bool _hasDashboard) {
        return hasStudentDashboard[_student];
    }


    function createStudentDashboard(address _student) external returns (address _studentDashbaord){
        StudentDashboard dashboard_ = new StudentDashboard(_student);
        dashboardByStudent[_student] = address(dashboard_);
        return address(dashboard_);
    }

 
    function getStudentDashboard(address _student) view  external returns (address _studentDashbaord) {
        return dashboardByStudent[_student]; 
    }

    // ========================= INTERNAL ==



}
