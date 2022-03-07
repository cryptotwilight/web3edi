//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;


interface IABCourse { 

    function getTitle() view external returns (string memory _courseTitle);

    function getDescription() view external returns (string memory _courseDescription);

    function getSchool() view external returns (address _school);

    function getLogo() view external returns (string memory _logo);

    function getCourseFee() view external returns (uint256 _fee);

    function getPassMark() view external returns (uint256 _passMark);

    function getSections() view external returns (uint256 [] memory _sectionIds);

    function getSectionSummary(uint256 _sectionId) view external returns (string memory _summary); 

    function getSection(uint256 _sectionId) view external returns(  string memory _sectionTitle, 
                                                                    string memory _sectionVideo, 
                                                                    string memory _sectionTextContent,          
                                                                    string memory _sectionQuestionBank, 
                                                                    uint256 _passMark );

    function purchaseCourseSection(uint256 _sectionId, uint256 _sectionFee, address _erc20) payable external returns(uint256 _sectionPaymentReference);

    function tipInstructor(uint256 _amount, address _erc20) payable external returns (uint256 _tipPaymentReference);

    function purchaseCourse(uint256 _courseFee, address _erc20) payable external returns (uint256 _coursePaymentReference);

    function mintCourseCompletionNFT(address _student) external returns (uint256 _nftId, uint256 _passMark);

    function submitCourseSectionAnswers( address _student,
                                         uint256 _sectionId,  
                                         uint256 [] memory _questionNumber, 
                                         uint256 [] memory _correctResponse,
                                         uint256 [] memory _submittedResponse ) external returns (uint256 _score, bool _passFail);

}