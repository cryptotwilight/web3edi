//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


interface IAcademyBox{ 

 function getCourses() view external returns (address [] _courseAddresses);

 function getSchools() view external returns (uint256 schoolId, string memory _name, string memory _description, address _instructor);

 function getInstructor(address _instructor) view external returns (string memory _summary, uint256 [] memory _schoolIds, string [] memory _schoolNames);

 function joinSchool(uint256 _schoolId, address _student, uint256 _dripAmount, address _charity, uint256 _split)  external returns (uint256 _schoolBadge);

 function leaveSchool(address _student) external returns (uint256 _schoolBadge, uint256 _startDate, uint256 _endDate);


}