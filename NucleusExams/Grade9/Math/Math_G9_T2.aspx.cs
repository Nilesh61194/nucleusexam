using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace NucleusExams.Grade9.Math
{
    public partial class Math_G9_T2 : System.Web.UI.Page
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
                    divExamFinish.Visible = false;

                    // check session value student and exam id 
                    if (Session["SID"] == null & Session["EID"] == null)
                    {
                        // if null then hide paper div 
                        myCarousel.Visible = false;
                    }
                    else
                    {

                        // assign value from session to local varible 

                        decimal ExamID = Convert.ToDecimal(Session["EID"]); // Convert.ToDecimal(Request.QueryString["EID"]);
                        decimal StudentID = Convert.ToDecimal(Session["SID"]); // objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);

                        if (ExamID == 0 && StudentID == 0)
                        {

                            myCarousel.Visible = false;
                        }
                        else
                        {
                            // set value in control if session is not null 
                            hfStudentID.Value = StudentID.ToString();
                            hfExamID.Value = ExamID.ToString();
                            ChecRightsofExam(ExamID, StudentID);
                            lblStudentHeaderName.Text = Session["StudentName"].ToString();
                            lblGradeSubjectName.Text = Session["GradeSubjectName"].ToString();
                            hfTotalDuration.Value = Session["TotalDuration"].ToString() + " Minute";
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);

                        }
                    }
                    BindAnswer();
                }
                else
                {
                    // set value when page is postback and call autosave 
                    // on auto postback call saveanswer here also 

                    decimal ExamID = Convert.ToDecimal(hfExamID.Value);
                    decimal StudentID = Convert.ToDecimal(hfStudentID.Value);
                    ChecRightsofExam(ExamID, StudentID);
                    //ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "SaveAnswerAllTime();", true);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);
                    BindAnswer();
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction('" + errmsg + "');", true);

            }

            //hfExamID.Value = "05";
            //hfStudentID.Value = "05";
            //BindAnswer();
        }

        protected void ChecRightsofExam(decimal ExamID, decimal StudentID)
        {
            // this method is used for check exam is active for stundet or not 

            try
            {
                // get and check url that exam is active for that url or not 
                string url = Request.Url.AbsolutePath;

                bool IsExamActive = objStudent.IsExamActiveByExamIDExamURL(ExamID, url);

                if (!IsExamActive)
                {
                    myCarousel.Visible = false;
                }
                else
                {
                    // check exam active for student or not 

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
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction('" + errmsg + "');", true);
            }
        }

        protected void BindAnswer()
        {
            //  bind all answer with question control
            try
            {
                // get data using exam and student id 
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "BindAnswertoCkeditor();", true);
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction('" + errmsg + "');", true);
            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            objStudent.UpdateExamEndTimeByExamIDStudentID(Convert.ToDecimal(hfExamID.Value), Convert.ToDecimal(hfStudentID.Value));
            myCarousel.Visible = false;
            divExamFinish.Visible = true;
            lblTimer.Visible = false;
        }
        void Page_LoadComplete(object sender, EventArgs e)
        {
            bool Connection = IsConnectedToInternet();
            if (Connection)
            {
                BindAnswer();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "ConnectionScript", "StopAutoSave();", true);

            }

        }

        public bool IsConnectedToInternet()
        {
            string host = "http://www.c-sharpcorner.com";
            bool result = false;
            Ping p = new Ping();
            try
            {
                PingReply reply = p.Send(host, 3000);
                if (reply.Status == IPStatus.Success)
                    return true;
            }
            catch { }
            return result;
        }
    }
}