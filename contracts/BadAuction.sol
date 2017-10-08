pragma solidity ^0.4.15;

import "./AuctionInterface.sol";

/** @title BadAuction */
contract BadAuction is AuctionInterface {
	/* Bid function, vulnerable to attack
	 * Must return true on successful send and/or bid,
	 * bidder reassignment
	 * Must return false on failure and send people
	 * their funds back
	 */

	function bid() payable external returns (bool) {
		// YOUR CODE HERE
		if (msg.value <= highestBid) {
			//give money back to sender if not highest bid.
			msg.sender.transfer(msg.value);
			return false;
		}

		if (highestBidder != 0) {
			 if (!highestBidder.send(highestBid)) {
					// 	if failed to give money back to previous highest bid, return money back to the new highest bid
				 	msg.sender.transfer(msg.value);
					return false;
			 }
		}

		highestBidder = msg.sender;
		highestBid = msg.value;
		return true;
	}

	/* Give people their funds back */
	function () payable {
		// YOUR CODE HERE
		revert();
	}
}
