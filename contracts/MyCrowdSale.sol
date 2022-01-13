pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";

contract MyCrowdSale is Crowdsale {

    constructor(address payable _wallet, IERC20 _token) Crowdsale(_wallet, _token) public {

    }
}
