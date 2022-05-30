// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "https://github.com/traderjoe-xyz/joe-core/blob/main/contracts/traderjoe/JoePair.sol";
// pragma experimantal ABIEncoderV2;

interface IJoePair{
    function token0() external view returns(address);
    function token1() external view returns(address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimeStamp);
}

abstract contract TraderJoeFactory{
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;
    function allPairsLength() external view virtual returns(uint);
}

contract bundledQuery{
    function getReservesByPairs(IJoePair[] calldata _pairs) external view returns(uint256[3][] memory){
        uint256[3][] memory result = new uint256[3][](_pairs.length);
        for(uint i; i < _pairs.length; i++){
            (result[i][0], result[i][1], result[i][2]) = _pairs[i].getReserves();
        }
        return result;
    }

    function getPairsByIndexRange(TraderJoeFactory _joeFactory, uint256 _start, uint256 _stop)external view returns(address[3][] memory){
        uint256 _allPairsLength = _joeFactory.allPairsLength();

        if (_stop > _allPairsLength){
            _stop = _allPairsLength;
        }
        require( _stop > _start, "Please check the stop variable");

        uint256 _qty = _stop - _start;
        address[3][] memory result = new address[3][](_qty);

        for (uint i = 0; i < _qty; i++){
            IJoePair _joePair = IJoePair(_joeFactory.allPairs(_start+i));
            result[i][0] = _joePair.token0();
            result[i][1] = _joePair.token1();
            result[i][2] = address(_joePair);
        }

        return result;
    }
}