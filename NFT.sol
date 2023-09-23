// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BILLU is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 public price = 2 ether;

    constructor() ERC721("BILLU", "BLU") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeifuzkyybnpyiuq44qlvsb5ykya4iydqmy2ill4pz2kd7ukvtcsera";
    }

    function minter(address _to) private {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(_to, tokenId);
    }

    function safeMint(address _to) public onlyOwner {
        minter(_to);
    }

    function mint(address _to) public payable {
        require(msg.value >= price, "Not enough ETH sent; check price!");
        minter(_to);
    }

    function withdrawEther() public {
        payable(owner()).transfer(address(this).balance);
    }
}