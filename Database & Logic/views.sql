alter  view vbranch  with encryption 
as 
  select id as branch_number , 
  branch as branch_name 
  from branch 
  

create view vcourse with encryption 
as 
  select course_id as c_number  ,course_name  as [name],
        max_degree as high_degree ,min_degree as low_degree ,dept_id as dept_number
  from courses 

create view vDepartment  with encryption 
as 
  select dept_id as dept_number , dept_name as [name] 
from department 

create view vExam with encryption 
 as 
  select Exam_id as Exam_number , [type] as  Exam_type ,
         start_time as starting , end_time as ending ,
		 duration as  exam_duration ,C_id course_id , total_degree as [degrees]
  from  Exam 


create view vExam_Question with encryption
as 
  select Exam_id as Exam_number , Q_ID AS Question_id
   from Exam_Question 

Create view vInstructor 
as
 select Ins_id as Ins_number ,Ins_name as [NAME] , ins_gender as Ins_gender , 
         Ins_address as Ins_location ,Ins_Email as Email ,Ins_age as age ,
		 Ins_phone as phone , salary as Ins_salary , city as ins_location
 from Instructor


 CREATE VIEW VIntake with encryption 
 as 
    select Intake_id as id ,Intake_num as Intake_number 
	from Intake

 create view vpick_Exam with encryption 
  as 
   select Exam_ID AS Exam_num , ID AS NUMBER ,C_ID AS course_id ,
   St_id as Student_number , Ins_ID AS instructor_number 
   from Pick_Exam

 create view vQuestion with encryption 
  as 
    select q_id as Question_num , question as question_name 
	 [type] as question_type , q_degree as question_degree 
	 c_id as course_id 
	from question 
 
 create view vST_COURSE with encryption 
  as 
    select st_id as st_number ,C_id as course_id 
            grade as st_grade 
 from St_course


 create view vstudent_answers with encryption 
 as 
  select e_id as Exam_num , st_id as Student_number, 
         q_id as question_number , answer as st_answer 
from student_answers 


create view vstudent with encryption 
 as 
  select st_id as st_number ,st_name as student_name ,email as St_Email ,
  city as St_city , st_gender as Gender ,st_age as AGE , graduation_year as grad_year 
  track_id as track_number ,  phone as st_phone,[password] as st_pass, branch_id as b_number
  from students

create view vTrack with encryption 
as 
 select Track_id as T_number , Track_name as Track ,Dept_id as Department_id
 from Track

 create view vTrack_course with encryption 
 as 
   select Track_id as t_id ,C_ID AS course_id 
   from Track_Course


Create view cTraining_manager with encryption 
as 
  select manager_id as manager_number , mgr_name as [name] ,
  Branch_id as B_number 
   from Training_manager 

create view vlog_account 
as 
select id as log_id ,[Type] as log_type , [user_name] as log_user , [password] as log_pass
from Log_Account 

create view vquestion_choices with encryption 
as 
  select id as q_id ,choice_text as choices ,is_correct as correct_answer,Qus_num as question_num
  from question_choices
----------------------------------------------------------------------------------------------------------------------


create view getfailed_students with encryption 
as 
  select SC.grade , SC.st_id , C.min_degree , S.st_name , S.Track_id ,SC.c_id
  from ST_course SC , courses C, students S ,Track T 
  where SC.st_id=S.st_id and SC.C_id=C.course_id and T.Track_id = S.track_id and SC.grade <=  C.min_degree

 create view getinstructor_coursesinfo
 as 
  select I.ins_name , IC.C_id ,C.course_name
  from Instructor I , Ins_course IC ,courses C
  WHERE I.Ins_id=IC.Ins_id and C.course_id=IC.C_id


 
CREATE VIEW AverageScores 
AS
SELECT C_id, AVG(grade) AS average_scores
FROM St_course
GROUP BY C_id 


CREATE VIEW OUTSTANDING_STUDENTS 
AS 
   SELECT st_id, grade AS high_scores, c_id
 FROM (SELECT st_id, grade, c_id,
           ROW_NUMBER() OVER (PARTITION BY c_id ORDER BY grade DESC) AS rank FROM St_course
   ) AS RankedStudents
  WHERE rank <= 10;