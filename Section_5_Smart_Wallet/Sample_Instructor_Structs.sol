 // SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

/*
    Udemy provides a lot of courses

    Instructors can register their courses by paying money
    Instructors get listed as a member
    Instructos must add their coursed
    Instructors can remove their courses 
    - before all clients get their money back
    Instructors can delete themselves

    Clients can register to a course by paying the money
    Clients get listed as member
    

    many Instructors: name, surname, many courses
    Course: title, price, Instructor name,registered clients as list max 15

    They are added by Instructors, its their courses
    An 

    a course can have many Clients: name, surname, registers to a course by paying

*/
contract Sample_Udemy{

    struct Instructor{
        string name;
        string surname;
        mapping(address => )
    }
}

