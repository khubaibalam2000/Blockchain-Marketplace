// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SendReceiveEther is IERC721Receiver, Ownable {

    IERC20 FT;
    IERC721 NFT;

    address private SirSufiyan = 0x9CAc3afd9854C017c0FC859c106C8d4aaaF72fb8;

    // To withdraw ether into the contract
    function withdraw(uint256 _amount) external payable {
        require(msg.value == _amount, "Not enough amount");
    }

    function withdrawNFT(uint256  _tokenId) external payable {
        NFT.transferFrom(msg.sender, address(this), _tokenId);
    }

    function withdrawFT(uint256  amount) external payable {
        NFT.transferFrom(msg.sender, address(this), amount);
    }

    // To deposit into amazon account
    function depositETH() external {
        payable(SirSufiyan).transfer(address(this).balance);
    }

    function depositNFT(uint256  _tokenId) external {
        NFT.transferFrom(address(this), SirSufiyan, _tokenId);
    }

    function depositFT() external payable{
        FT.transfer(SirSufiyan, FT.balanceOf(address(this)));
    }

    function setNFTAddr(address _addr) onlyOwner public {
        NFT = IERC721(_addr);
    }

    function setFTAddr(address _addr) onlyOwner public {
        FT  = IERC20(_addr);
    }

    function setSirSufiyanAddr(address _addr) onlyOwner public  {
        SirSufiyan = _addr;
    }

    function onERC721Received( address , address , uint256 , bytes calldata  ) public pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}