// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./IW3ECourse.sol";

contract W3ECourse is IW3ECourse { 

    string title; 
    string description; 
    string logo; 
    uint256 [] sectionIds; 

    struct CourseSection { 
        string title;
        string video;
        string textContent;
        string questionBank;
    }

    mapping(uint256=>CourseSection) courseSectionById; 
    
    constructor() { 
        
    }

    function getTitle() view external returns (string memory _courseTitle){
        return title; 
    }

    function getDescription() view external returns (string memory _courseDescription){
        return description; 
    }

    function getLogo() view external returns (string memory _logo){
        return logo; 
    }

    function getCourseSections() view external returns (uint256 [] memory _sectionIds){
        return sectionIds; 
    }

    function getCourseSection(uint256 _sectionId) view external returns( string memory _sectionTitle, 
                                                                          string memory _sectionVideo, 
                                                                          string memory _sectionTextContent, 
                                                                          string memory _sectionQuestionBank){
       CourseSection memory section_ = courseSectionById[_sectionId];
       return (section_.title, section_.video, section_.textContent, section_.questionBank);
    }

    function submitCourseSectionAnswers(uint256 [] memory questionNumber, 
                                        uint256[] memory _correctResponse,
                                        uint256 [] memory _submittedResponse ) external returns (uint256 _score, bool _passFail) {

    }

    function addCourseSection(string memory _sectionTitle, 
                                string memory _sectionVideo, 
                                string memory _sectionTextContent, 
                                string memory _sectionQuestionBank) external returns (uint256 _sectionId) {
        _sectionId = sectionIds.length+1;        
        CourseSection memory section_ = CourseSection({
                                                title : _sectionTitle,
                                                video : _sectionVideo, 
                                                textContent : _sectionTextContent,                                                
                                                questionBank : _sectionQuestionBank
                                                    });
        courseSectionById[_sectionId] = section_; 
        sectionIds.push(_sectionId);
        return _sectionId; 
    }

    function setTitle(string memory _title) external returns ( bool _set) {
        title = _title; 
        return true; 
    }

    function setLogo(string memory _logo) external returns ( bool _set) {
        logo = _logo;
        return true; 
    }
    
    function setDescription(string memory _description) external returns ( bool _set) {
        description = _description; 
        return true; 
    }


}