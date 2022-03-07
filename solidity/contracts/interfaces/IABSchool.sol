//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


interface IABSchool { 

    function getSchoolId() view external returns (uint256 _schoolId);

    function getInstructor() view external returns (address _instructor);

    function getSummary() view external returns (string memory _summary);

    function getDescription() view external returns (string memory _schoolDescription);

    function mintCertificateNFT(address _student, address _course, uint256 _mark, string memory _status) external returns (uint256 _certificateNFTId);

    function mintCourseNFT(address _student, address _course) external returns (uint256 _courseNFTId);
    
    function joinSchool(address _student, uint256 _dripAmount, address _charity, uint256 _split)  external returns (uint256 _schoolBadgeNFTId);

    function leaveSchool(address _student) external returns (uint256 _schoolBadgeId, uint256 _startDate, uint256 _endDate);
}