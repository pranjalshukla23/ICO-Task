//SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract CrowdToken is ERC20 {
    
    constructor() ERC20() public {

        _mint(msg.sender, 100000000);
    }
}
