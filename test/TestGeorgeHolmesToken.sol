pragma solidity ^0.4.0;

import 'truffle/Assert.sol';
import '../contracts/GeorgeHolmesToken.sol';


contract TestGeorgeHolmesToken {

	GeorgeHolmesToken private _token;
	address private _owner;

	function TestGeorgeHolmesToken() internal {
		_owner = msg.sender;
	}
	
	function beforeEach() internal {
		_token = new GeorgeHolmesToken();
	}

	function testTotalSupply() internal {
		Assert.equal(_token.totalSupply(), 10000, "Total supply is 10000");
	}
}