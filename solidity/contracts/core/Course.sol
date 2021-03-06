//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/c239e1af8d1a1296577108dd6989a17b57434f8e/contracts/token/ERC20/IERC20.sol";
import "../interfaces/IABCourseInstructor.sol";
import "../interfaces/IAcademyBox.sol";
import "../interfaces/IABSchool.sol";

contract Course is IABCourseInstructor { 

    address self; 
    string title; 
    string description; 
    string logo; 
    uint256 passMark; 
    uint256 [] sectionIds;
    uint256 courseFee;     
    uint256 marksPerSection; 
    string status; 

    IAcademyBox academyBox; 
    IABSchool school; 

    address NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

   // DripsToken dripsToken;  

    struct Section { 
        string title;
        string video;
        string textContent;
        string questionBank;
        uint256 passMark; 
        uint256 fee; 
        string summary;
    }

    struct SectionResult {
        uint256 score; 
        uint256 passMark; 
        bool  passFail;         
    }

    struct Purchase { 
        uint256 id; 
        string purchaseType; 
        uint256 typeId; 
        uint256 amount; 
    }

    address instructor; 
    string instructorDetails; 
    mapping(uint256=>Section) courseSectionById; 

    address [] students;         
    mapping(address=>bool) hasPurchaseByStudent; 
    mapping(uint256=>mapping(address=>bool)) hasPurchasedSectionByStudentBySection;
    mapping(address=>Purchase[]) purchasesByStudent; 
    mapping(address=>mapping(uint256=>SectionResult)) sectionResultBySectionIdByStudent;
    

        
    constructor( address _instructor, string memory _instructorDetails, address _academyBox, address _school) { 
        self = address(this);
        instructor = _instructor; 
        instructorDetails = _instructorDetails;         
        academyBox = IAcademyBox(_academyBox);
        school = IABSchool(_school);
     //   dripsToken = DripsToken(_dripsToken);
    }

    function getSchool() view external returns(address _school) {
        return address(school); 
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

    function getCourseFee() view external returns (uint256 _fee) {
        return courseFee; 
    }

    function getPassMark() view external returns (uint256 _passMark) {
        return passMark; 
    }

    function getStatus() view external returns (string memory _status) {
        return status; 
    }

    function getSections() view external returns (uint256 [] memory _sectionIds){
        return sectionIds; 
    }

    function getSectionSummary(uint256 _sectionId) view external returns (string memory _secionSummary){ 
        Section memory section_ = courseSectionById[_sectionId];
        return section_.summary; 
    }

    function getSection(uint256 _sectionId) view external returns( string memory _sectionTitle, string memory _sectionVideo, string memory _sectionTextContent,          
                                                                         string memory _sectionQuestionBank, uint256 _passMark) {
        address student_ = msg.sender; 
        if(hasPurchaseByStudent[student_] || hasPurchasedSectionByStudentBySection[_sectionId][student_]){                                                                        
            Section memory section_ = courseSectionById[_sectionId];
            return (section_.title, section_.video, section_.textContent, section_.questionBank, section_.passMark);
        }
        return ("","", "", "", 0);
    }

    function purchaseCourseSection(uint256 _sectionId, uint256 _sectionFee, address _erc20) payable external returns(uint256 _sectionPaymentReference){
        


    }

    function tipInstructor(uint256 _amount, address _erc20) payable external returns (uint256 _tipPaymentReference){

    }                                                                          

    function purchaseCourse(uint256 _courseFee, address _erc20) payable external returns (uint256 _coursePaymentReference){
        _coursePaymentReference = processPurchaseInternal(_courseFee, _erc20);


        return _coursePaymentReference;
    }

    function mintCourseCompletionNFT(address _student) external returns (uint256 _nftId, uint256 _passMark){

    }

    function submitCourseSectionAnswers(address  _student,
                                        uint256 _sectionId,  
                                        uint256 [] memory _questionNumber, 
                                        uint256[] memory _correctResponse,
                                        uint256 [] memory _submittedResponse ) external returns (uint256 _score, bool _passFail) {
                _score = getScoreInternal(_questionNumber, _correctResponse, _submittedResponse);
                Section memory section_ = courseSectionById[_sectionId];
                if(_score > section_.passMark) {
                    _passFail = true; 
                }
                else { 
                    _passFail = false; 
                }
                SectionResult memory result_ = SectionResult({
                                                        passMark : section_.passMark,
                                                        passFail : _passFail, 
                                                        score : _score
                                                    });
                sectionResultBySectionIdByStudent[_student][_sectionId] = result_;

        return (_score, _passFail);
    }

    function addCourseSection(  string memory _sectionTitle, 
                                string memory _sectionVideo, 
                                string memory _sectionTextContent, 
                                string memory _sectionQuestionBank,
                                uint256 _passMark, 
                                uint256 _fee,
                                string memory _summary) external returns (uint256 _sectionId) {
        _sectionId = sectionIds.length+1;        
        Section memory section_ = Section({
                                            title : _sectionTitle,
                                            video : _sectionVideo, 
                                            textContent : _sectionTextContent,                                                
                                            questionBank : _sectionQuestionBank,
                                            passMark : _passMark,
                                            fee : _fee,
                                            summary : _summary
                                        });
        courseSectionById[_sectionId] = section_; 
        sectionIds.push(_sectionId);
        return _sectionId; 
    }

    function removeCourseSection(uint256 _sectionId) external returns (bool _removed) {
        delete courseSectionById[_sectionId];
        return _removed; 
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

    function setCourseFee(uint256 _fee) external returns (bool _set) {
        courseFee = _fee; 
        return true; 
    }

    function setStatus(string memory _status) external returns (bool _set){
        status = _status; 
        return true; 
    }

    function populateCourse(string memory _title, string memory _logo, string memory _description, uint256 _fee, uint256 _passMark, uint256 _marksPerSection) external returns (bool _populated) {
        title = _title; 
        logo = _logo; 
        description = _description; 
        courseFee = _fee; 
        passMark = _passMark; 
        marksPerSection = _marksPerSection;

        return true; 
    }
            
//======================================== INTERNAL ======= 

    function getTxRef() view internal returns (uint256 _ref) {
        return block.timestamp; 
    }


    function getScoreInternal(  uint256 [] memory questionNumber, 
                        uint256[] memory _correctResponse,
                        uint256 [] memory _submittedResponse ) pure internal returns (uint256 _score) {                            
        for(uint256 x = 0; x < questionNumber.length; x++){
            if(_correctResponse[x] == _submittedResponse[x]) {
                _score++;
            }
        }
        return _score;
    }

    function processPurchaseInternal(uint256 _amount, address _erc20Address) internal returns (uint256 _processed){ 
        if(_erc20Address == NATIVE) {            
            require(msg.value == _amount, " amount stated not equal to amount sent ");   
        }
        else {             
            IERC20 erc20 = IERC20(_erc20Address);
            erc20.transferFrom(msg.sender, self, _amount);                                           
        }    
        return getTxRef(); 
    }
}
