using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.Math
{
    public partial class MathExt : System.Web.UI.Page
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
            //hfExamID.Value = "1001";
            //hfStudentID.Value = "5002";
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
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }

        protected void BindAnswer()

        {
            // bind all answer with question control 
            try
            {
                // get data using exam and student id 
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {

                    DataRow[] rowsFiltered = dt.Select("QID='txtQuestion1'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion1.Text = rowsFiltered[0]["Answer"].ToString();

                    string Question1 = txtQuestion1.Text.Trim().ToString();

                    bool status = string.IsNullOrEmpty(Question1);
                    if (status)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "CallMyFunction", "SetTableQ1();", true);
                    }

                    rowsFiltered = dt.Select("QID='txtQuestion2'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion2.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID='txtQuestion3'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion3.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion4'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion4.Text = rowsFiltered[0]["Answer"].ToString();//rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion5'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion5.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion6'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion6.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion7'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion7.Text = rowsFiltered[0]["Answer"].ToString();



                    rowsFiltered = dt.Select("QID = 'txtQuestion8'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion8.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion9'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion9.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion10'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion10.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion11'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion11.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion12'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion12.Content = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion13'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion13.Content = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion14'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion14.Content = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion15'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion15.Text = rowsFiltered[0]["Answer"].ToString();

                    string Question15 = txtQuestion15.Text.Trim().ToString();

                    status = string.IsNullOrEmpty(Question15);
                    if (status)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "SetTableQ8", "SetTableQ8();", true);
                    }


                    rowsFiltered = dt.Select("QID = 'txtQuestion16'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion16.Text = rowsFiltered[0]["Answer"].ToString();

                    string Question16 = txtQuestion16.Text.Trim().ToString();

                    status = string.IsNullOrEmpty(Question16);
                    if (status)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "SetTableQ9", "SetTableQ9();", true);
                    }


                    rowsFiltered = dt.Select("QID = 'txtQuestion17'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion17.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion18'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion18.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion19'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion19.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion20'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion20.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion21'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion21.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion22'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion22.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion23'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion23.Content = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion24'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion24.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion25'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion25.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion26'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion26.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion27'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion27.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion28'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion28.Content = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion29'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion29.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion30'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion30.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion31'");


                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "CallMyFunction", "SetTableQ1();", true);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "CallFunction", "SetTableQ8();", true);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "Call", "SetTableQ9();", true);
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
            myCarousel.Visible = false;
            divExamFinish.Visible = true;
            lblTimer.Visible = false;
        }
    }
}