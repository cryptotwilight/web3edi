//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "https://github.com/decentology/hyperverse-mono/blob/0f4947dda72c32f78da014b499211aa64e59b572/packages/hyperverse-ethereum-tribes/contracts/Tribes.sol";
import "./Course.sol";
import "./InstructorDashboard.sol";
import "./StudentDashboard.sol";


contract AcademyBox is IHyperverseModule { 


    address administrator; 
    Tribes tribes; 

    mapping(address=>bool) hasStudentDashboard;
    mapping(address=>bool) hasInstructorDashboard; 
    mapping(address=>address) dashboardByInstructor; 
    mapping(address=>address) dashboardByStudent; 

    address [] activeCourses; 


    constructor(address _administrator, address _tribesDeployment) {
        administrator = _administrator; 
        tribes = Tribes(_tribesDeployment);
    }

    function getCourses() view external returns (address [] _courseAddresses){
        return activeCourses; 
    }

    function getSchools() view external returns (uint256 schoolId, string memory _name, string memory _description, address _instructor) {

    }    

    function getInstructor(address _instructor) view external returns (string memory _summary, uint256 [] memory _schoolIds, string [] memory _schoolNames){

    }

    function joinSchool(uint256 _schoolId, address _student, uint256 _dripAmount, address _charity, uint256 _split)  external returns (uint256 _schoolBadge) {
            // setup drip
            tribes.joinTribe(_instructor, _schoolId );

            return 0; 
    }

    function leaveSchool(address _student) external returns (uint256 _schoolBadge, uint256 _startDate, uint256 _endDate){
            // cancel drip 
            tribes.leaveTribe(_student);

    }

    


    function getInstructorDashboard() external returns (address _instructorDashboard) {
        address instructor_ = msg.sender; 
        if(!hasInstructorDashboard[instructor_]) {
            dashboardByInstructor[instructor_] = address(new InstructorDashboard(instructor_));    
            hasInstructorDashboard[instructor_] = true; 
        }   
        return dashboardByInstructor[instructor_];                    
    }

    function getStudentDashboard() external returns (address _studentDashbaord) {
        address student_ = msg.sender; 
        if(!hasStudentDashboard[student_]) {
            dashboardByStudent[student_] = address(new StudentDashboard(student_));    
            hasStudentDashboard[student_] = true; 
        }   
        return dashboardByStudent[student_]; 
    }

    // ========================= INTERNAL ==

    

}
