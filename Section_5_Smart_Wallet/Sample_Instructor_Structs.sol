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
        if(checkIfInstructorExists(mInstructorData)){
            //transaction is reverted
            require(false, "Already registred");
        }else{

            //TODO: it is updating, but it should add a new instructor
            //TODO: update and new instructor should be separated
            mInstructorData.name = name;
            mInstructorData.surname = surname;
            mInstructorList[msg.sender] = mInstructorData;
        }
    }

    function isCourseUnique(string memory _courseA, string memory _courseB) internal pure returns(bool){
            if(keccak256(bytes(_courseA)) == keccak256(bytes(_courseB))){
                //already exists
                return false;
            }

            return true;
    }

    function addANewCourse(string memory title) external payable{
        //let the instructor pay an ether each time
        require(hasSenderOneEther(msg.value), "Requires 1 ether");

        for (uint i = 0; i < mInstructorList[msg.sender].courses.length; i++) {
            string memory course = mInstructorList[msg.sender].courses[i];
            require(isCourseUnique(course, title));
        }

        // does not exists, just add it
        mInstructorList[msg.sender].courses.push(title);
    }

    /*
        Delete a course also for 1 ether
    */
    function deleteACourse(string memory title) external payable{
        require(hasSenderOneEther(msg.value), "Requires 1 ether");

        //find the instructorData
        mInstructorData = mInstructorList[msg.sender];
        if(checkIfInstructorExists(mInstructorData)){
            //find the course to be deleted
            for (uint i = 0; i < mInstructorData.courses.length; i++) {
                string memory course = mInstructorData.courses[i];
                if(!isCourseUnique(course, title)){
                    //normally use "delete" to remove the element
                    //but the gap is still there, so move all elements
                    mInstructorData.courses[i] = "";
                }
            }

        }else{
            //transaction is reverted
            require(false, "You must register first.");
        }
    }

    function removeInstructor() external payable{
        require(hasSenderOneEther(msg.value), "Requires 1 ether");
        //find the instructorData
        if(checkIfInstructorExists(mInstructorList[msg.sender])){
            delete mInstructorList[msg.sender];
        }
    }
}

