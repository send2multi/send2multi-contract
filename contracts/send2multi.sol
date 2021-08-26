// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "./IERC20.sol";

contract Send2Multi {
	function sendWithSameValue(address coinType, uint amount, address[] calldata receiverList) external {
		for(uint i=0; i<receiverList.length; i++) {
			IERC20(coinType).transfer(receiverList[i], amount);
		}
	}
	function sendWithDifferentValues(address coinType, uint[] calldata receiverAndAmountList) external {
		for(uint i=0; i<receiverAndAmountList.length; i++) {
			uint96 amount = uint96(receiverAndAmountList[i]);
			address receiver = address(bytes20(uint160(receiverAndAmountList[i]>>96)));
			IERC20(coinType).transfer(receiver, uint(amount));
		}
	}
}
