// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./IERC20.sol";

contract Send2Multi {
	function sendWithSameValue(address coinType, uint amount, address[] calldata receiverList) external {
		for(uint i=0; i<receiverList.length; i++) {
			// We must use low-level call to avoid solidity add EXTCODEHASH checks
			(bool success, bytes memory data) = coinType.call(
			    abi.encodeWithSignature("transferFrom(address,address,uint256)", 
						    msg.sender, receiverList[i], amount));
			bool ok = abi.decode(data, (bool));
			require(success && ok);
		}
	}
	function sendWithDifferentValues(address coinType, uint[] calldata receiverAndAmountList) external {
		for(uint i=0; i<receiverAndAmountList.length; i++) {
			uint96 amount = uint96(receiverAndAmountList[i]);
			address receiver = address(bytes20(uint160(receiverAndAmountList[i]>>96)));
			(bool success, bytes memory data) = coinType.call(
			    abi.encodeWithSignature("transferFrom(address,address,uint256)", 
						    msg.sender, receiver, uint(amount)));
			bool ok = abi.decode(data, (bool));
			require(success && ok);
		}
	}
}
