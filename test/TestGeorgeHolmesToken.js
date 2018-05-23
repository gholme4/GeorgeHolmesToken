const GeorgeHolmesToken = artifacts.require("./GeorgeHolmesToken.sol");

contract('GeorgeHolmesToken', (accounts) => {
	const creatorAddress = accounts[0];
	const firstUserAddress = accounts[1];
	const secondUserAddress = accounts[2];
	const externalAddress = accounts[3];


	it('should have a total token supply of of 10000 ', () => {
		return GeorgeHolmesToken.deployed()
			.then((instance) => {
				return instance.__totalSupply;
			})
			.then((totalSupply) => {
				assert.equal(totalSupply, 10000);
			})
			.catch((err) => {
				assert.notEqual(err.message, "assert.fail()", "balance doesn't equal 10000" );
			});
	});

	it('should have owner with balance of 10000 ', () => {
		return GeorgeHolmesToken.deployed()
			.then((instance) => {
				return instance.balaceOf(creatorAddress);
			})
			.then((balance) => {
				assert.equal(balance, 10000);
			})
			.catch((err) => {
				assert.notEqual(err.message, "assert.fail()", "Owner balance doesn't equal 10000" );
			});
	});

	it('should transfer 500 to second user', () => {
		var token;
		return GeorgeHolmesToken.deployed()
			.then((instance) => {
				token = instance;
				return token.transfer(secondUserAddress, 500, { from: creatorAddress});
			})
			.then((result) => {
				return token.balaceOf(secondUserAddress);
			})
			.then((balance) => {
				assert.equal(balance, 500);
			})
			.catch((err) => {
				assert.notEqual(err.message, "assert.fail()", "second user didn't receive 500" );
			});
	});

	it('should not allow 20000 transfer', () => {
		var token;
		return GeorgeHolmesToken.deployed()
			.then((instance) => {
				token = instance;
				return token.transfer(secondUserAddress, 500, { from: creatorAddress});
			})
			.then((result) => {
				assert.equal(result, false);
			})
			.catch((err) => {
				assert.notEqual(err.message, "assert.fail()", "second user didn't receive 500" );
			});
	});

	
});