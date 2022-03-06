//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "https://github.com/decentology/hyperverse-mono/blob/0f4947dda72c32f78da014b499211aa64e59b572/packages/hyperverse-ethereum-tribes/contracts/Tribes.sol";
import "./Course.sol";
import "./InstructorDashboard.sol";
import "./StudentDashboard.sol";
import "../interfaces/IAcademyBoxCourse.sol";
import "../libraries/LAcademyBoxUtils.sol";


contract AcademyBox is IHyperverseModule, IAcademyBox { 

    using LAcademyBoxUtils for address;

    address administrator; 
    Tribes tribes; 
    address self; 

    mapping(address=>bool) hasStudentDashboard;
    mapping(address=>bool) hasInstructorDashboard; 
    mapping(address=>address) dashboardByInstructor; 
    mapping(address=>address) dashboardByStudent; 
    mapping(uint256=>address[]) studentBySchool; 

    struct School { 
        uint256 schoolId; 
        string name; 
        string description; 
        address instructor; 
    }

    struct Instructor { 
        string _summary; 
        uint256 [] _schoolIds;
        string [] _schoolNames;
    }

    School [] schools; 
    mapping(address=>School[]) schoolsByInstructor;
    mapping(uint256=>School) schoolById; 

    address [] activeCourses; 
    address [] retiredCourses; 


    constructor(address _administrator, address _tribesDeployment) {
        administrator = _administrator; 
        tribes = Tribes(_tribesDeployment);
        self = address(this);
    }

    function getCourses() view external returns (address [] memory _courseAddresses){
        return activeCourses; 
    }

    function getSchools() view external returns(uint256 [] memory _schoolIds, string [] memory _names, string [] memory _descriptions, address [] memory _instructors) {
        _schoolIds = new uint256[](schools.length);
        _names = new string[](schools.length);
        _descriptions = new string[](schools.length);
        _instructors = new address[](schools.length);

        for(uint256 x = 0; x < schools.length; x++) {
            School memory school = schools[x];
            _schoolIds[x] = school.schoolId; 
            _names[x] = school.name; 
            _descriptions[x] = school.description; 
            _instructors[x] = school.instructor; 
        }
        return (_schoolIds, _names, _descriptions, _instructors);
    }    

    function getSchools(uint256 [] memory _schoolIds) view external returns (uint256 [] memory _schoolIds, string [] memory _names, string [] memory _descriptions, address [] memory _instructors){

    }

    function getInstructor(address _instructor) view external returns (string memory _summary, uint256 [] memory _schoolIds){

    }


    function postCourse(address _course) external returns(bool _posted) {
        activeCourses.push(_course);
        return _posted; 
    }

    function retireCourse(address _course) external returns (bool _retired) {
        retiredCourses.push(_course);
        activeCourses = _course.remove(activeCourses);
    }

    function joinSchool(uint256 _schoolId, address _student, uint256 _dripAmount, address _charity, uint256 _split)  external returns (uint256 _schoolBadge) {
            // setup drip
            tribes.joinTribe(self, _schoolId); 
            studentBySchool[_schoolId].push(_student); 
            _schoolBadge = mintBadgeInternal(_student, _schoolId);
            return _schoolBadge; 
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

    function mintBadgeInternal(address _student, uint256 _schoolId) internal returns (uint256 _nftSchoolBadge) {
        
        return 0; 
    }

}
