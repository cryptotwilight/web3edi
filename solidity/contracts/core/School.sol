//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "https://github.com/decentology/hyperverse-mono/blob/0f4947dda72c32f78da014b499211aa64e59b572/packages/hyperverse-ethereum-tribes/contracts/Tribes.sol";
import "../libraries/LAcademyBoxUtils.sol";
import "../interfaces/IABSchool.sol";
import "./AcademyBoxNFT.sol";


contract School is IABSchool { 

    using LAcademyBoxUtils for address;

    address self; 
    AcademyBoxNFT certificateNFT; 
    AcademyBoxNFT courseNFT; 
    AcademyBoxNFT badgeNFT; 
    Tribes tribes; 

    uint256 mintedCertCount;
    uint256 mintedCourseCount;

    string name; 
    address instructor;     
    uint256 id;
    string summary; 
    string description; 
    string logo; 

    uint256 totalStudentContributions; 

    struct StudentSchoolRecord { 
        uint256 schoolId; 
        uint256 schoolBadge;
        address student; 
        uint256 joinDate; 
        uint256 leaveDate; 
    }

    struct StudentContribution { 
        address student; 
        uint256 contribution; 
        address charity; 
        uint256 split; 

    }

    mapping(address=>StudentContribution) studentContributionByStudent; 

    mapping(address=>bool) hasSchoolRecord; 
    mapping(address=>StudentSchoolRecord) schoolRecordByStudent; 
    
    constructor(string memory _name, address _instructor, uint256 _schoolId, string memory _logo/*, address _tribesDeployment*/ ){
        certificateNFT = new AcademyBoxNFT("W3EDI_CERTIFICATE", _name);
        courseNFT = new AcademyBoxNFT("W3EDI_COURSE", _name);
        badgeNFT = new AcademyBoxNFT("W3EDI_SCHOOL_BADGE", _name);
        
        instructor = _instructor; 
        name = _name;  
        id = _schoolId; 
        //tribes = Tribes(_tribesDeployment);
        logo = _logo; 
        self = address(this);
    }

    function getSchoolId() view external returns (uint256 _schoolId){
        return id; 
    }

    function getInstructor() view external returns (address _instructor){
        return instructor; 
    }

    function getSummary() view external returns (string memory _summary){
        return summary; 
    }

    function getDescription() view external returns (string memory _schoolDescription){
        return description; 
    }

    function getLogo() view external returns (string memory _schoolLogo){
        return logo; 
    }

    function getMintedCertificateCount() view external returns (uint256 _count) {
        return mintedCertCount; 
    }

    function getMintedCourseCount() view external returns (uint256 _mintedCourseCount){
        return mintedCourseCount; 
    }

    function mintCertificateNFT(address _student, address _course, uint256 _mark, string memory _status) external returns (uint256 _certificateNFTId){

        mintedCertCount++;
        return 0; 
    }

    function mintCourseNFT(address _student, address _course) external returns (uint256 _courseNFTId){
        
        mintedCourseCount++;
    }
    
    function joinSchool(address _student, uint256 _dripAmount, address _charity, uint256 _split)  external returns (uint256 _schoolBadgeNFTId){
       // tribes.joinTribe(self, id); 
        StudentContribution memory contribution_ = StudentContribution({
                                                                            student : _student,
                                                                            contribution : _dripAmount, 
                                                                            charity : _charity, 
                                                                            split : _split
                                                                        });
        studentContributionByStudent[_student] = contribution_; 
        _schoolBadgeNFTId = mintBadgeInternal(_student);
        updateSchoolRecordInternal(_student, _schoolBadgeNFTId, block.timestamp, 0);
        return _schoolBadgeNFTId; 
    }

    function leaveSchool(address _student) external returns (uint256 _schoolBadgeId, uint256 _startDate, uint256 _endDate){
      //  tribes.leaveTribe(_student);
        StudentSchoolRecord memory schoolRecord = schoolRecordByStudent[_student];
        updateSchoolRecordInternal(_student, schoolRecord.schoolBadge, 0, block.timestamp);
        schoolRecord = schoolRecordByStudent[_student];
        return (schoolRecord.schoolBadge, schoolRecord.joinDate, schoolRecord.leaveDate);
    }

    // ========================= INTERNAL ==

    function mintBadgeInternal(address _student) internal returns (uint256 _nftSchoolBadge) {
        
        return 0; 
    }

    function updateSchoolRecordInternal ( address _student, uint256 _schoolBadgeNFTId, uint256 _joinDate, uint256 _leaveDate) internal returns (bool _updated) {
        if(!hasSchoolRecord[_student]){
            StudentSchoolRecord memory schoolRecord_ = StudentSchoolRecord({  
                                                                             schoolId : id, 
                                                                             schoolBadge : _schoolBadgeNFTId,
                                                                             student : _student,
                                                                             joinDate : _joinDate, 
                                                                             leaveDate : _leaveDate
                                                                            });
            hasSchoolRecord[_student] = true; 
            schoolRecordByStudent[_student] = schoolRecord_; 
            return true; 
        }
        StudentSchoolRecord memory schoolRecord = schoolRecordByStudent[_student];
        schoolRecord.leaveDate = _leaveDate;  
        return true; 
    }

}