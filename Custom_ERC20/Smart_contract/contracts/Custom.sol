// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;


error NotOwner();
error addressZero();
error NotApproved();
error AlreadyOwner();


event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);


interface MYIERC721 {

    function balanceOf(address _owner) external view returns (uint256);
    function ownerOf(uint256 _tokenId) external view returns (address);
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    function setApprovalForAll(address _operator, bool _approved) external;
    function getApproved(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);


}

contract MYERC721 {

    uint256  public tokenId;

    mapping(address => uint256)balances;
    mapping(uint256 => address)nftowners;
    mapping(address => mapping(uint256 => address))approval;
    mapping(address => mapping(address => bool))operatorApproal;

    
    function balanceOf(address _owner) external view returns (uint256){

        return balances[_owner];
    }


    function ownerOf(uint256 _tokenId) external view returns (address) {
        return nftowners[_tokenId];
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        if(_to == address(0)) revert addressZero();
        if(nftowners[_tokenId] != _from ) revert NotOwner();
        if(approval[_from][_tokenId] != msg.sender  || operatorApproal[_from][msg.sender] != true) revert NotApproved();

        balances[_from] -= 1;
        balances[_to] += 1;
        nftowners[_tokenId] = _to;

        emit Transfer( _from, _to, _tokenId);
    }


    function approve(address _approved, uint256 _tokenId) external payable {
        if(nftowners[_tokenId] == msg.sender) revert AlreadyOwner();
        approval[msg.sender][_tokenId] = _approved;

    }


    

}