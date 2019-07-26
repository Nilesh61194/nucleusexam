using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Paper
{
    public partial class DemoPaper : System.Web.UI.Page
    {

        ExamController objExam = new ExamController();
        StudentController objStudent = new StudentController();
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["SID"] = "841";
            //Session["EID"] = "10";

            try
            {
                if (!IsPostBack)
                {
                    divExamFinish.Visible = false;

                    if (Session["SID"] == null & Session["EID"] == null)
                    {
                        myCarousel.Visible = false;
                    }
                    else
                    {

                        decimal ExamID = Convert.ToDecimal(Session["EID"]); // Convert.ToDecimal(Request.QueryString["EID"]);
                        decimal StudentID = Convert.ToDecimal(Session["SID"]); // objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);

                        if (ExamID == 0 && StudentID == 0)
                        {

                            myCarousel.Visible = false;
                        }
                        else
                        {
                            hfStudentID.Value = StudentID.ToString();
                            hfExamID.Value = ExamID.ToString();
                            ChecRightsofExam(ExamID, StudentID);
                            lblStudentHeaderName.Text = Session["StudentName"].ToString();
                            lblGradeSubjectName.Text = Session["GradeSubjectName"].ToString();
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);

                        }
                    }
                    BindAnswer();
                }
                else
                {
                    decimal ExamID = Convert.ToDecimal(hfExamID.Value);
                    decimal StudentID = Convert.ToDecimal(hfStudentID.Value);
                    ChecRightsofExam(ExamID, StudentID);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "SaveAnswerAllTime();", true);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);
                    BindAnswer();
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);

            }
        }

        protected void BindAnswer()
        {
            try
            {
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    txtQuestion1.Content = dt.Rows[0]["Answer"].ToString();
                    txtQuestion2.Content = dt.Rows[1]["Answer"].ToString();
                    txtQuestion3.Content = dt.Rows[2]["Answer"].ToString();
                    txtQuestion4.Content = dt.Rows[3]["Answer"].ToString();
                    txtQuestion5.Content = dt.Rows[4]["Answer"].ToString();
                    txtQuestion6.Content = dt.Rows[5]["Answer"].ToString();
                    txtQuestion7.Content = dt.Rows[6]["Answer"].ToString();
                    txtQuestion8.Content = dt.Rows[7]["Answer"].ToString();
                    txtQuestion9.Content = dt.Rows[8]["Answer"].ToString();
                    txtQuestion10.Text = dt.Rows[9]["Answer"].ToString();
                    txtQuestion11.Text = dt.Rows[10]["Answer"].ToString();
                    txtQuestion12.Text = dt.Rows[11]["Answer"].ToString();
                    txtQuestion13.Content = dt.Rows[12]["Answer"].ToString();
                    txtQuestion14.Content = dt.Rows[13]["Answer"].ToString();
                    txtQuestion15.Content = dt.Rows[14]["Answer"].ToString();
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
                string url = Request.Url.AbsolutePath;

                bool IsExamActive = objStudent.IsExamActiveByExamIDExamURL(ExamID, url);

                if (!IsExamActive)
                {
                    myCarousel.Visible = false;
                }
                else
                {
                    bool IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(ExamID, StudentID);
                    if (!IsExamActiveForStudent)
                    {
                        divExamFinish.Visible = true;
                        myCarousel.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            objStudent.UpdateExamEndTimeByExamIDStudentID(Convert.ToDecimal(hfExamID.Value), Convert.ToDecimal(hfStudentID.Value));
            //ChecRightsofExam(Convert.ToDecimal(ViewState["EID"]), Convert.ToDecimal(ViewState["SID"]));
            myCarousel.Visible = false;
            divExamFinish.Visible = true;
        }
    }
}