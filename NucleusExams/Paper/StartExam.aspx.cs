using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Paper
{
    public partial class StartExam : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        StudentController objStudent = new StudentController();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)

        {
            try
            {
                if (!IsPostBack)
                {
                    divPreInstruction.Visible = true;
                    divExamError.Visible = false;
                    divExamFinish.Visible = false;

                    // check here querystring value is null or not
                    if (Request.QueryString["SID"] == null & Request.QueryString["EID"] == null)
                    {
                        divSomethingWentWrong.Visible = true;
                        divPreInstruction.Visible = false;

                    }
                    else
                    {
                        // when querystring value is not null 
                        decimal ExamID = Convert.ToDecimal(Request.QueryString["EID"]);
                        decimal StudentID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);

                        if (ExamID == 0 && StudentID == 0)
                        {
                            divSomethingWentWrong.Visible = true;
                            divPreInstruction.Visible = false;

                        }
                        else
                        {
                            // if querystring is not null then get value in session 

                            Session["SID"] = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);
                            hfStudentID.Value = Session["SID"].ToString();
                            Session["EID"] = Request.QueryString["EID"];
                            hfExamID.Value = Session["EID"].ToString();
                            divSomethingWentWrong.Visible = false;
                            ChecRightsofExam(ExamID, StudentID);
                        }
                    }
                }
                else
                {
                    // get data from querystring and check right of exam 

                    decimal ExamID = Convert.ToDecimal(Request.QueryString["EID"]);
                    decimal StudentID = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);
                    ChecRightsofExam(ExamID, StudentID);
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);

            }
        }

        protected void ChecRightsofExam(decimal ExamID, decimal StudentID)
        {
            try
            {
                // first check exam active or not 

                bool IsExamActive = objStudent.IsExamActiveByExamID(ExamID);

                if (IsExamActive)
                {
                    // check exam active for student or not 

                    bool IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(ExamID, StudentID);
                    if (IsExamActiveForStudent)
                    {

                        DataTable dt = new DataTable();
                        // get stundet details by suing student id 

                        dt = objStudent.GetStudentDetailsByStudentID(StudentID);

                        if (dt.Rows.Count > 0)
                        {
                            lblGradeName.Text = dt.Rows[0]["GradeName"].ToString();
                            lblSTudentName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                            lblSectionName.Text = dt.Rows[0]["SectionName"].ToString();
                            lblRollNo.Text = dt.Rows[0]["RollNo"].ToString();
                            lblStudentHeaderName.Text = lblSTudentName.Text;
                            Session["StudentName"] = lblSTudentName.Text;

                            dt.Clear();
                        }

                        // get exam details by using exam id 

                        dt = objExam.GetExamByExamID(ExamID);

                        if (dt.Rows.Count > 0)
                        {
                            lblSubjectName.Text = dt.Rows[0]["SubjectName"].ToString();
                            lblDuration.Text = dt.Rows[0]["Duration"].ToString() + " " + "Minute";
                            Session["TotalDuration"] = dt.Rows[0]["Duration"].ToString();
                            Session["AccessCode"] = dt.Rows[0]["ExamCode"];
                        }


                        Session["GradeSubjectName"] = lblGradeName.Text + " : " + lblSubjectName.Text;
                        lblGradeSubjectName.Text = Session["GradeSubjectName"].ToString();

                        // check here exam start by student or not 
                        // if start then student will navigate to exam page or else stay this page only 

                        bool IsExamStartByStudent = objStudent.IsExamStartByStudent(ExamID, StudentID);
                        if (IsExamStartByStudent)
                        {
                            divPreInstruction.Visible = false;
                            divExamError.Visible = false;
                            divExamFinish.Visible = false;
                            Session["ExamTimer"] = objStudent.getExamStartTimeByStudent(ExamID, StudentID);

                            string URL = objStudent.GetExamURlByExamID(Convert.ToDecimal(Session["EID"]));
                            // Response.Redirect("~/Paper/GetPaper");
                            Response.Redirect(URL + "?SID=" + Request.QueryString["SID"] + "&EID=" + Request.QueryString["EID"] + "");
                        }

                    }
                    else
                    {
                        // hide when exam not active for student  

                        divPreInstruction.Visible = false;
                        divExamError.Visible = false;
                        divExamFinish.Visible = true;
                    }
                }
                else
                {
                    // hide when exam is not active 

                    divPreInstruction.Visible = false;
                    divExamError.Visible = false;
                    divExamFinish.Visible = false;
                    divSomethingWentWrong.Visible = true;
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }

        protected void btnStartExam_Click(object sender, EventArgs e)
        {
            try
            {
                // on basis of exam id get acces code from db 


                decimal Code = Convert.ToDecimal(Session["AccessCode"]);

                // check access code with student entered code 

                if (Code == Convert.ToDecimal(txtAccessToken.Text))
                {
                    // if match then start is start and navidate to exam page 
                    EA_StudentEnrollment obj = new EA_StudentEnrollment();
                    obj.StudentID = Convert.ToDecimal(Session["SID"]);
                    obj.ExamID = Convert.ToDecimal(Session["EID"]);
                    objStudent.UpdateExamStartTimeByExamIDStudentID(obj);
                    Session["ExamTimer"] = System.DateTime.Now;

                    string URL = objStudent.GetExamURlByExamID(Convert.ToDecimal(Session["EID"]));
                    Response.Redirect(URL + "?SID=" + Request.QueryString["SID"] + "&EID=" + Request.QueryString["EID"] + "");
                }
                else
                {
                    // call function when call wrong entered code 
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "WrongAccessCode();", true);
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }
    }
}