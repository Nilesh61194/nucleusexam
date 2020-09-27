using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NucleusExams.Controllers
{
    public class PaperController : Controller
    {
        StudentController objStudent = new StudentController();
        EA_StudentEnrollment stu = new EA_StudentEnrollment();
        ExamController objExam = new ExamController();

        // GET: Paper
        public ActionResult GetPaper()
        {

            using (dbEntities entities = new dbEntities())
            {
                stu.StudentID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]); //Convert.ToDecimal(Session["SID"]);
                stu.ExamID = Convert.ToDecimal(Request.QueryString["EID"]); //Convert.ToDecimal(Session["EID"]);

                ViewBag.Student = entities.StudentCurrentGradeSectionDetails.Where(e => e.StudentID == stu.StudentID).ToList();
                ViewBag.Question = entities.ea_spgEA_QuestionMasterByExamIDStudentID(stu.ExamID,stu.StudentID).ToList();
                DataTable dt = new DataTable();
                dt = objExam.GetExamByExamID(Convert.ToDecimal(stu.ExamID));
                if (dt.Rows.Count > 0 && dt != null)
                {

                    ViewBag.GradeSubject = dt.Rows[0]["GradeName"].ToString() + " : " + dt.Rows[0]["SubjectName"].ToString();
                }
                //  ViewBag.GradeSubject = ViewBag.Student[0].GradeName + entities.EA_ExamMaster.SingleOrDefault(e => e.ExamID == stu.ExamID).ExamName;  //Session["GradeSubjectName"].ToString();
				// http://localhost:59353/Paper/StartExam.aspx?SID=250413D2982F1F83AA62A3A323CD2A87&EID=40036
                ViewBag.ExamStatus = ChecRightsofExam(Convert.ToDecimal(stu.ExamID), Convert.ToDecimal(stu.StudentID));
                return View();
            }
        }

        public ActionResult PreviewPaper()
        {

            using (dbEntities entities = new dbEntities())
            {
                string SID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]).ToString();
                stu.StudentID = Convert.ToDecimal(SID); //Convert.ToDecimal(Session["SID"]);
                stu.ExamID = Convert.ToDecimal(Request.QueryString["EID"]); //Convert.ToDecimal(Session["EID"]);

                ViewBag.Student = entities.StudentCurrentGradeSectionDetails.Where(e => e.StudentID == stu.StudentID).ToList();
                ViewBag.Question = entities.ea_spgEA_QuestionMasterByExamID1(stu.ExamID).ToList();
                return View();
            }


        }


        public ActionResult StudentPreviewPaper()
        {

            using (dbEntities entities = new dbEntities())
            {
                string SID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]).ToString();
                stu.StudentID = Convert.ToDecimal(SID); //Convert.ToDecimal(Session["SID"]);
                stu.ExamID = Convert.ToDecimal(Request.QueryString["EID"]); //Convert.ToDecimal(Session["EID"]);

                ViewBag.Student = entities.StudentCurrentGradeSectionDetails.Where(e => e.StudentID == stu.StudentID).ToList();
                ViewBag.Question = entities.ea_spgEA_QuestionMasterByExamID1(stu.ExamID).ToList();
                return View();
            }


        }

        protected bool ChecRightsofExam(decimal ExamID, decimal StudentID)
        {
            try
            {
                bool IsExamActive = objStudent.IsExamActiveByExamID(ExamID);

                if (!IsExamActive)
                {
                    return false;
                }
                else
                {
                    // check exam active for student or not 

                    bool IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(ExamID, StudentID);
                    if (!IsExamActiveForStudent)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                return false;
            }
        }



        public ActionResult GetPaperWithStartExam()
        {

            using (dbEntities entities = new dbEntities())
            {
                stu.StudentID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]); //Convert.ToDecimal(Session["SID"]);
                stu.ExamID = Convert.ToDecimal(Request.QueryString["EID"]); //Convert.ToDecimal(Session["EID"]);

                ViewBag.Student = entities.StudentCurrentGradeSectionDetails.Where(e => e.StudentID == stu.StudentID).ToList();
                ViewBag.Question = entities.ea_spgEA_QuestionMasterByExamID1(stu.ExamID).ToList();
                DataTable dt = new DataTable();
                dt = objExam.GetExamByExamID(Convert.ToDecimal(stu.ExamID));
                if (dt.Rows.Count > 0 && dt != null)
                {

                    ViewBag.GradeSubject = dt.Rows[0]["GradeName"].ToString() + " : " + dt.Rows[0]["SubjectName"].ToString();
                    ViewBag.ExamCode = dt.Rows[0]["ExamCode"];
                }
                ViewBag.IsExamActive = objStudent.IsExamActiveByExamID(Convert.ToDecimal(stu.ExamID));
                ViewBag.IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(Convert.ToDecimal(stu.ExamID), Convert.ToDecimal(stu.StudentID));
                ViewBag.IsExamStartByStudent = objStudent.IsExamStartByStudent(Convert.ToDecimal(stu.ExamID), Convert.ToDecimal(stu.StudentID));
                ViewBag.GradeSubject = ViewBag.Student[0].GradeName + entities.EA_ExamMaster.SingleOrDefault(e => e.ExamID == stu.ExamID).ExamName;  //Session["GradeSubjectName"].ToString();
                ViewBag.ExamStatus = ChecRightsofExam(Convert.ToDecimal(stu.ExamID), Convert.ToDecimal(stu.StudentID));
                return View();
            }
        }

        //[HttpPost]
        //public void UpdateExamStartTime(decimal ExamID, decimal StudentID)
        //{
        //    objStudent.UpdateExamStartTimeByExamIDStudentID(ExamID, StudentID);
        //}


        public ActionResult ExamPreview()
        {

            using (dbEntities entities = new dbEntities())
            {
                ViewBag.Question = entities.ea_spgEA_QuestionMasterByExamID1(Convert.ToDecimal(Session["PreviewExamID"])).ToList();
                DataTable dt = new DataTable();
                dt = objExam.GetExamByExamID(Convert.ToDecimal(Convert.ToDecimal(Session["PreviewExamID"])));
                if (dt.Rows.Count > 0 && dt != null)
                {

                    ViewBag.GradeSubject = dt.Rows[0]["GradeName"].ToString() + " : " + dt.Rows[0]["SubjectName"].ToString();
                }
                return View();
            }
        }


    }
}