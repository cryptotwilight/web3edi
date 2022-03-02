// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


interface IW3ECourse { 

    function getTitle() view external returns (string memory _courseTitle);

    function getDescription() view external returns (string memory _courseDescription);

    function getLogo() view external returns (string memory courseLogo);

    function getCourseSections() view external returns (uint256 [] memory _sectionIds);

    function getCourseSection(uint256 _sectionId) view external returns( string memory _sectionTitle, 
                                                                          string memory _sectionVideo, 
                                                                          string memory _sectionTextContent, 
                                                                          string memory _sectionQuestionBank);

    function submitCourseSectionAnswers(uint256 [] memory questionNumber, 
                                        uint256[] memory _correctResponse,
                                        uint256 [] memory _submittedResponse ) external returns (uint256 _score, bool _passFail);

}