var GeorgeHolmesToken = artifacts.require("./GeorgeHolmesToken.sol");

module.exports = function(deployer) {
	deployer.deploy(GeorgeHolmesToken);
};
