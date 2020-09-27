using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NucleusExams.Models
{
    public class QuestionClass
    {
        public int QuestionID { get; set; }
        public Nullable<decimal> ExamID { get; set; }
        public string QuestionType { get; set; }
        public Nullable<int> QuestionMarks { get; set; }
        public string Question { get; set; }

        public decimal StaffID { get; set; }
    }
}