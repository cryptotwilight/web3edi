//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/c239e1af8d1a1296577108dd6989a17b57434f8e/contracts/token/ERC721/ERC721.sol";

contract AcademyBoxNFT is ERC721 {

    uint256 private tokenCounter; 

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {
    }

    function mintNFT(address _student, string memory _ipfsHash) external returns (uint256 _nftId){
        _nftId = tokenCounter++;
        bytes memory data_ = getBytes(_ipfsHash);
        _safeMint(_student, _nftId, data_ );
        return _nftId; 
    }

    //=========================== INTERNAL ==================

    function getBytes(string memory _str) pure internal returns (bytes memory _data){ 
        return bytes(_str);
    }

}