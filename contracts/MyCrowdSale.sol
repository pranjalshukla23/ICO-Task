pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";

contract MyCrowdSale is Crowdsale {

    enum CrowdSaleStage {preSale, seedSale, finalSale}

    CrowdSaleStage public stage;

    constructor(uint256 _rate, address payable _wallet, IERC20 _token) Crowdsale( _rate,_wallet, _token) public {

    }

    function () external payable {
        buyTokens(_msgSender());
    }

    function setRate(uint stage) internal{

        if(stage == uint(CrowdSaleStage.preSale)){

            _rate = 326797;
        }
        else if(stage == uint(CrowdSaleStage.seedSale)){

            _rate = 163398;
        }
        else{

            _rate = 236797;
        }
    }

    function buyTokens(address beneficiary) public nonReentrant payable {
        uint256 weiAmount = msg.value;
        _preValidatePurchase(beneficiary, weiAmount);

        if(_token.balanceOf(address(this)) >= 70000000){
            stage = CrowdSaleStage.preSale;

            setRate(uint(stage));
        }
        else if(_token.balanceOf(address(this)) > 20000000 && _token.balanceOf(address(this)) < 70000000){

            stage = CrowdSaleStage.seedSale;
            setRate(uint(stage));
        }
        else{

            stage = CrowdSaleStage.finalSale;
            setRate(uint(stage));
        }

        // calculate token amount to be created
        uint256 tokens = _getTokenAmount(weiAmount);

        // update state
        _weiRaised = _weiRaised.add(weiAmount);

        _processPurchase(beneficiary, tokens);
        emit TokensPurchased(_msgSender(), beneficiary, weiAmount, tokens);

        _updatePurchasingState(beneficiary, weiAmount);

        _forwardFunds();
        _postValidatePurchase(beneficiary, weiAmount);
    }
}
