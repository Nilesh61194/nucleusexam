using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NucleusExams.Models
{
    public class NucleusExamCustomClass
    {

    }


    public class ExamMaster
    {
        private decimal examID;
        public decimal ExamID
        {
            get
            {
                return examID;
            }

            set
            {
                examID = value;
            }
        }

        private string examName;
        public string ExamName
        {
            get
            {
                return examName;
            }

            set
            {
                examName = value;
            }
        }

        private decimal gradeID;
        public decimal GradeID
        {
            get
            {
                return gradeID;
            }

            set
            {
                gradeID = value;
            }
        }


        private decimal createdBy;
        private decimal updatedBy;

        private decimal academicYearID;
        public decimal AcademicYearID
        {
            get
            {
                return academicYearID;
            }

            set
            {
                academicYearID = value;
            }
        }

        public string SubjectName
        {
            get
            {
                return subjectName;
            }

            set
            {
                subjectName = value;
            }
        }

        public int Duration
        {
            get
            {
                return duration;
            }

            set
            {
                duration = value;
            }
        }

        public bool ISExamCode
        {
            get
            {
                return iSExamCode;
            }

            set
            {
                iSExamCode = value;
            }
        }

        public string ExamCode
        {
            get
            {
                return examCode;
            }

            set
            {
                examCode = value;
            }
        }

        public DateTime ExamDate
        {
            get
            {
                return examDate;
            }

            set
            {
                examDate = value;
            }
        }


        public DateTime UpdatedDate
        {
            get
            {
                return updatedDate;
            }

            set
            {
                updatedDate = value;
            }
        }
        public string ExamURL
        {
            get
            {
                return examURL;
            }

            set
            {
                examURL = value;
            }
        }

        public bool ISActive
        {
            get
            {
                return iSActive;
            }

            set
            {
                iSActive = value;
            }
        }

        public decimal CreatedBy
        {
            get
            {
                return createdBy;
            }

            set
            {
                createdBy = value;
            }
        }


        public decimal UpdatedBy
        {
            get
            {
                return updatedBy;
            }

            set
            {
                updatedBy = value;
            }
        }

        private string subjectName;


        private int duration;


        private bool iSExamCode;


        private string examCode;


        private DateTime examDate;


        private DateTime updatedDate;

        private string examURL;


        private bool iSActive;


    }



    public class EA_ExamAnswerMaster
    {

        private string qID;
        private decimal examID;
        private decimal studentID;
        private string answer;
        public string QID
        {
            get
            {
                return qID;
            }

            set
            {
                qID = value;
            }
        }

        public decimal ExamID
        {
            get
            {
                return examID;
            }

            set
            {
                examID = value;
            }
        }

        public string Answer
        {
            get
            {
                return answer;
            }

            set
            {
                answer = value;
            }
        }

        public decimal StudentID
        {
            get
            {
                return studentID;
            }

            set
            {
                studentID = value;
            }
        }


    }

    public class EA_QuestionMasterCustome
    {
        public int QuestionID { get; set; }
        public Nullable<decimal> ExamID { get; set; }
        public string QuestionType { get; set; }
        public Nullable<int> QuestionMarks { get; set; }
        public string Question { get; set; }
        public Nullable<decimal> EntryBy { get; set; }
        public Nullable<System.DateTime> EntryDate { get; set; }

        public string Options { get; set; }

    }


    public class OptionMaster
    {
        public int OptionID { get; set; }
        public Nullable<decimal> ExamID { get; set; }
        public string OptionValue { get; set; }
        public Nullable<bool> IsRightAnswer { get; set; }
        public Nullable<decimal> EntryBy { get; set; }
        public Nullable<System.DateTime> EntryDate { get; set; }
        public Nullable<int> QuestionID { get; set; }
    }

    //public class EA_StudentEnrollment
    //{
    //    public decimal ES_EnrollmentID { get; set; }
    //    public decimal StudentID { get; set; }
    //    public decimal ExamID { get; set; }
    //    public decimal GradeID { get; set; }
    //    public decimal SectionID { get; set; }
    //    public System.DateTime ExamStartTime { get; set; }
    //    public System.DateTime ExamEndTime { get; set; }
    //    public System.DateTime ActualStartTime { get; set; }
    //    public System.DateTime ActualEndTime { get; set; }
    //    public int Duration { get; set; }
    //    public System.DateTime AssignDate { get; set; }
    //    public bool ISExamEnable { get; set; }
    //    public bool ISExamFinish { get; set; }
    //    public decimal EntryBy { get; set; }
    //    public System.DateTime EntryDate { get; set; }
    //}
}