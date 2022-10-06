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

    constructor(){
        mInstructorData = mInstructorList[msg.sender];
        mInstructorData.name="";
        mInstructorData.surname="";
    }

    function hasSenderOneEther(uint _value) internal pure returns (bool){
        return _value == 1 ether ? true : false;
    }

    function forFree(uint _value) internal pure returns(bool){
        return _value == 0 ether ? true : false;
    }

    function registerOrCancel() internal{
        require(hasSenderOneEther(msg.value), "Registration requires 1 ETH.");
    }

    function isRegistred(Instructor memory _instructor) internal pure returns(bool){
        return !isEmptyString(_instructor.name);
    }

    function isEmptyString(string memory str) internal pure returns(bool){
        return bytes(str).length == 0;
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
        //avoid to have empty strings as input
        //because then looks like default values
        require(!isEmptyString(name), "input name is empty");
        require(!isEmptyString(surname),"input surname is empty");

        //check if there is already an instructor
        //if the instructor is not available, then a default struct is returned
        if(isRegistred(mInstructorList[msg.sender])){
            //transaction is reverted
            require(false, "Already registred");
        }else{

            //TODO: it is updating, but it should add a new instructor
            //TODO: update and new instructor should be separated
            mInstructorList[msg.sender].name = name;
            mInstructorList[msg.sender].surname = surname;
        }

        mInstructorData = mInstructorList[msg.sender];
    }

    function getInstructorData() public view returns(string memory){
        return string.concat(
            mInstructorList[msg.sender].name,
            mInstructorList[msg.sender].surname);
    }

    function isCourseUnique(string memory _courseA, string memory _courseB) internal pure returns(bool){
            if(keccak256(bytes(_courseA)) == keccak256(bytes(_courseB))){
                //already exists
                return false;
            }

            return true;
    }

    function addANewCourse(string memory title) external payable{
        require(isRegistred(mInstructorList[msg.sender]));
        require(hasSenderOneEther(msg.value), "Requires 1 ether");
        require(!isEmptyString(title), "input title is empty");

        for (uint i = 0; i < mInstructorList[msg.sender].courses.length; i++) {
            string memory course = mInstructorList[msg.sender].courses[i];
            require(isCourseUnique(course, title));
        }

        // does not exists, just add it
        mInstructorList[msg.sender].courses.push(title);
    }

    function getCourses() external returns(string[] memory){
        return mInstructorList[msg.value].courses;
    }

    function deleteACourse(string memory title) external{
        //require(hasSenderOneEther(msg.value), "Requires 1 ether");

        //find the instructorData
        mInstructorData = mInstructorList[msg.sender];
        if(isRegistred(mInstructorData)){
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
        require(forFree(msg.value), "for free");
        //require(hasSenderOneEther(msg.value), "Requires 1 ether");
        //find the instructorData
        if(isRegistred(mInstructorList[msg.sender])){
            delete mInstructorList[msg.sender];
            mInstructorData = mInstructorList[msg.sender];
        }
    }
}

