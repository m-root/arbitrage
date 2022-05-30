// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

// import "https://github.com/traderjoe-xyz/joe-core/blob/main/contracts/traderjoe/JoeFactory.sol";
import "https://github.com/traderjoe-xyz/joe-core/blob/main/contracts/traderjoe/JoePair.sol";


interface IJoePair{
    function getReserves() external view returns ( uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast );
}



contract gPair{

    address private factory = 0x9Ad6C38BE94206cA50bb0d90783181662f0Cfa10;
    uint private id = 1;

    function _getPair() external view returns(address pair){
        // pair = IJoeFactory(factory).allPairs(id);
        return IJoeFactory(factory).allPairs(id);
    }

    
}