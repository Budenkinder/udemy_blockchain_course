// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20 < 0.8.29;

contract CarNFT{

    //authentification and registration
    //  - partner logs in with wallet address - lets be metamask
    //  - partner registers the car and the tracker device
    //  -- car is created as an nft
    //  - partner must deposit eth
    //  - smart-contract stakes eth, could be an idea to earn eth

    //partner earns
    //  - partner receives token as minting

    //user request
    //  - only readable when paid by token
    //  - x% are burned, rest is shared among the stakeholders

    //nft creation during registration
    //  smart-contract gets an event with Car-ID and details
    //  smart-contract creates an NFT based on the Car-ID
    //  smart-contract checks if NFT exists with Car-ID, avoiding duplicates

    //user reads data
    //  web3 authenticates with metamask
    //  web3 sends token to read data
    //  smart-contract gets an event with Car-ID
    //  smart-contract gets all details for web3    

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
    function registerNewCar(CarNFT_CV memory _car, uint256 partner_ID) public{
        //check if authorised
        //do register car to NFT
    }

    function updateCar(CarNFT_CV memory _car) public{
        //do update NFT data of this car
        //pay the caller with a token
    }
}