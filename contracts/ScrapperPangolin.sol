// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "https://github.com/traderpangolin-xyz/pangolin-core/blob/main/contracts/traderpangolin/pangolinPair.sol";
// pragma experimantal ABIEncoderV2;

interface IpangolinPair{
    function token0() external view returns(address);
    function token1() external view returns(address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimeStamp);
}

abstract contract TraderpangolinFactory{
    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;
    function allPairsLength() external view virtual returns(uint);
}

contract bundledQuery{
    function getReservesByPairs(IpangolinPair[] calldata _pairs) external view returns(uint256[3][] memory){
        uint256[3][] memory result = new uint256[3][](_pairs.length);
        for(uint i; i < _pairs.length; i++){
            (result[i][0], result[i][1], result[i][2]) = _pairs[i].getReserves();
        }
        return result;
    }

    function getPairsByIndexRange(TraderpangolinFactory _pangolinFactory, uint256 _start, uint256 _stop)external view returns(address[3][] memory){
        uint256 _allPairsLength = _pangolinFactory.allPairsLength();

        if (_stop > _allPairsLength){
            _stop = _allPairsLength;
        }
        require( _stop > _start, "Please check the stop variable");

        uint256 _qty = _stop - _start;
        address[3][] memory result = new address[3][](_qty);

        for (uint i = 0; i < _qty; i++){
            IpangolinPair _pangolinPair = IpangolinPair(_pangolinFactory.allPairs(_start+i));
            result[i][0] = _pangolinPair.token0();
            result[i][1] = _pangolinPair.token1();
            result[i][2] = address(_pangolinPair);
        }

        return result;
    }
}