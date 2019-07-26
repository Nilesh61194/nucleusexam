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
                bool IsExamActive = objStudent.IsExamActiveByExamID(ExamID);

                if (IsExamActive)
                {
                    bool IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(ExamID, StudentID);
                    if (IsExamActiveForStudent)
                    {
                        DataTable dt = new DataTable();
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

                        dt = objExam.GetExamByExamID(ExamID);

                        if (dt.Rows.Count > 0)
                        {
                            lblSubjectName.Text = dt.Rows[0]["SubjectName"].ToString();
                            lblDuration.Text = dt.Rows[0]["Duration"].ToString();
                            Session["AccessCode"] = dt.Rows[0]["ExamCode"];
                        }

                        Session["GradeSubjectName"] = lblGradeName.Text + " : " + lblSubjectName.Text;
                        lblGradeSubjectName.Text = Session["GradeSubjectName"].ToString();

                        bool IsExamStartByStudent = objStudent.IsExamStartByStudent(ExamID, StudentID);
                        if (IsExamStartByStudent)
                        {
                            divPreInstruction.Visible = false;
                            divExamError.Visible = false;
                            divExamFinish.Visible = false;
                            Session["ExamTimer"] = objStudent.getExamStartTimeByStudent(ExamID, StudentID);
                            Response.Redirect("DemoPaper.aspx");
                        }

                    }
                    else
                    {
                        divPreInstruction.Visible = false;
                        divExamError.Visible = false;
                        divExamFinish.Visible = true;
                    }
                }
                else
                {
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
                decimal Code = Convert.ToDecimal(Session["AccessCode"]);
                if (Code == Convert.ToDecimal(txtAccessToken.Text))
                {
                    objStudent.UpdateExamStartTimeByExamIDStudentID(Convert.ToDecimal(Session["EID"]), Convert.ToDecimal(Session["SID"]));
                    Session["ExamTimer"] = System.DateTime.Now;
                    Response.Redirect("DemoPaper.aspx");
                }
                else
                {
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