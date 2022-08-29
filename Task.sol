// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

contract Task  {
        uint  count = 0;
        uint  count1 = 0;
        address      owner;
        uint256 []   certified ;
    constructor() {
        owner=msg.sender;
        }
        
        struct Student{
            uint256 id;
            string  name;
            uint256 rang;
        }
            struct Examen{
            uint256 id;
            string  name;
            uint256 [] studentId;
        }
      event AddStudent(
         uint id,
         string name,
         uint256   rang

  );
      event AddExamen(
        uint id,
        string name,
        uint256 [] studentId

  );

        mapping(uint256=>Student)  public listofStudent;
        mapping(uint256=>Examen)   public  examen;
       uint [] examenids;
       uint [] studentid;

  modifier teacherOnly() {
        require(msg.sender == owner, 'Not owner');
        _;
    }
//only the teacher can add a new student  in the exam 

   function createStudent(string  memory name) public teacherOnly {
       require(bytes(name).length > 0,"Your Name Is empty");
        count++;
        listofStudent[count]=Student(count,name,0);
        emit AddStudent(count,name,0);
        }
//only the teacher can create an examan  
    function createExamen(string  memory name) public teacherOnly{
        require(bytes(name).length > 0,"Your Name Is empty");
            count1++;
            examen[count1]=Examen(count1,name,new uint256[](0));
            emit AddExamen(count1,name,new uint256[](0));
    }
    //only the student who has been registered by the teacher can pass the exam 
       function passExam(uint256 _studentid,uint256 _examenId) public {
         require(listofStudent[_studentid].id ==_studentid,"you are not register here");
         require(examen[_examenId].id ==_examenId,"check  the id of examen");
         examen[_examenId].studentId.push(_studentid);
    }
    //only the teacher can correct the exam and update the table of certificate 
       function correctExamen(uint256 _studentid,uint256 _examenId,uint256 _rang) public teacherOnly{
         require(examen[_examenId].id ==_examenId,"check  the id of examen");

               listofStudent[_studentid].rang=_rang;
      
    if(listofStudent[_studentid].rang>=10)
          return certified.push(listofStudent[_studentid].id);   
    }
    //get list of students that success in the exam 
      function getcertified() public view returns(uint256[] memory ){
        return certified;
    }
    
        function getlistofexamen(uint256 id) public view returns(uint256 ,string memory, uint256[] memory ){
        return (examen[id].id,examen[id].name,examen[id].studentId);
    }}
