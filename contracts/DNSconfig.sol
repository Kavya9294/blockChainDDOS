pragma solidity >=0.4.25 <0.6.0;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract DNSconfig {
	//mapping (address => uint) dnsAddress;

	string[] private dnsAddress;
	string[] public domainName;
	address[] public blockedIps;

	//event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		dnsAddress[0] = "0.0.0.0";
		domainName[0] = "localHost";
	}

	function getLenDns() public returns(uint count) {
    	return dnsAddress.length;
	}

	function getLenBlocked() public returns(uint count) {
    	return blockedIps.length;
	}

	function setBlockedIp(address ipRestrict) public {
		blockedIps.push(ipRestrict);
	}

	function getBlockedIp(uint i) public returns(address){
		return blockedIps[i];
	}

	function isIpBlocked(address ipValue) public returns(bool){
		uint len = getLenBlocked();
		address curr;
		for(uint i =0; i< len; i++){
			curr = getBlockedIp(i);
			if(keccak256(abi.encodePacked((ipValue))) == keccak256(abi.encodePacked((curr))) ){
				return true;
			}
		}

		return false;
	}

	function addIpDomain(string memory ip, string memory domain) public {
		dnsAddress.push(ip);
		domainName.push(domain);
	}

	function getDomainName(uint i) public returns(string memory) {
		return (domainName[i]);
	}


	function resolveName(address receiver, string memory domain) public returns(string memory dName) {
		/*if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;*/
		//TODO: get ip from address
		if(isIpBlocked(receiver)){
			string memory curr;
			uint len = getLenDns();
			for(uint i = 0 ; i < len ; i++) {
				curr = getDomainName(i);
				if(keccak256(abi.encodePacked((domain))) == keccak256(abi.encodePacked((curr))) ){
					return dnsAddress[i];
				}
			}
		}
		return dnsAddress[0];
	}

	/*function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		//return balances[addr];
	}*/
}
