// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

contract SimpleStorage{

    //create a balance of eth
    //get a token for add and update CarCV
    //pay with token for reading CarCV

    uint256 CarNFT_TokenBalance;

    //this data should update NFT data or create a new NFT
    mapping (string => CarNFT_CV) carNFTMapList;
    mapping (uint256 => License_Partner) partner;

    struct License_Partner{
        uint256 partner_ID;
        string name; 
    }

    struct CarNFT_CV{
        string uniqueCarID;
        string nft_ID;
        uint256 km;
        bool broken;
        bool hadCrash;
    }

    CarNFT_CV car;

    //only license partners should CUD NFT, create,update, delete 
    //partner should authorise with wallet address and should have a unique NFT as License
    function registerNewCar(CarNFT_CV _car, uint256 partner_ID){
        //check if authorised
        //do register car to NFT
    }

    function updateCar(CarNFT_CV _car){
        //do update NFT data of this car
        //pay the caller with a token
    }
}