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

        private string subjectName;


        private int duration;


        private bool iSExamCode;


        private string examCode;


        private DateTime examDate;




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


}