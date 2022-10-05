 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
    Udemy provides a lot of courses

*/
contract Sample_Udemy{

    struct Instructor{
        string name;
        string surname;
        //in real world, maybe a course is an nft
        //and we put cid here, instead of string array
        string[] courses;
    }

    Instructor public mInstructorData;

    mapping(address => Instructor) mInstructorList;

    function hasSenderOneEther(uint _value) internal pure returns (bool){
        return _value == 1 ether ? true : false;
    }

    function registerOrCancel() internal{
        require(hasSenderOneEther(msg.value), "Registration requires 1 ETH.");
    }

    function checkIfInstructorExists(Instructor memory _instructor) internal pure returns(bool){
        if(bytes(_instructor.name).length == 0){
            return false;
        }else{
            return true;
        }
    }

    /* 
        add a new instructor with his course 
        actually it creates a default value, when instructor is not available
        it would be ok to update the values
        but we only want the instructor to pay 1 ether

        if courses added, the instructor needs to pay 1 ether for each course
    */
    function registerInstructor(string memory name, string memory surname) external payable{
        registerOrCancel();

        //check if there is already an instructor
        //if the instructor is not available, then a default struct is returned
        mInstructorData = mInstructorList[msg.sender];
        if(!checkIfInstructorExists(mInstructorData)){
            mInstructorData.name = name;
            mInstructorData.surname = surname;
            mInstructorList[msg.sender] = mInstructorData;
        }else{
            //transaction is reverted
            require(false, "Already registred");
        }
    }

    function addANewCourse(string memory title) external payable{
        //let the instructor pay an ether each time
        registerOrCancel();

        for (uint i = 0; i < mInstructorList[msg.sender].courses.length; i++) {
            string memory course = mInstructorList[msg.sender].courses[i];
            if(keccak256(bytes(course)) == keccak256(bytes(title))){
                //already exists
                require(false, "Already added");
            }
        }

        // does not exists, just add it
        mInstructorList[msg.sender].courses.push(title);
    }

    function deleteACourse() internal{

    }

    function removeInstructor() internal{

    }

}

