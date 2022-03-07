//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "../interfaces/IABCourse.sol";

interface IABCourseInstructor is IABCourse { 

    function addCourseSection( string memory _sectionTitle,                                 
                                string memory _sectionVideo, 
                                string memory _sectionTextContent, 
                                string memory _sectionQuestionBank,
                                uint256 _passMark, 
                                uint256 _fee,
                                string memory _summary) external returns (uint256 _sectionId);

    function removeCourseSection(uint256 _sectionId) external returns (bool _removed);

    function setTitle(string memory _title) external returns ( bool _set);

    function setLogo(string memory _logo) external returns ( bool _set);
    
    function setDescription(string memory _description) external returns ( bool _set);
    function setCourseFee(uint256 _fee) external returns (bool _set); 
}

