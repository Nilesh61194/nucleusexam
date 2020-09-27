using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.IDUMay2019
{
    public partial class IDU_G10_May_2019Preview : System.Web.UI.Page
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
                    if (Request.QueryString["EID"].ToString() != null && Request.QueryString["SID"].ToString() != null)
                    {
                        hfExamID.Value = Request.QueryString["EID"].ToString();
                        hfStudentID.Value = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]).ToString();
                        BindAnswer();

                        dt = objExam.GetExamByExamID(Convert.ToDecimal(hfExamID.Value));
                        if (dt.Rows.Count > 0)
                        {
                            lblExamSubject.Text = dt.Rows[0]["ExamName"].ToString() + " - " + dt.Rows[0]["SubjectName"].ToString();
                        }
                        //else
                        //{
                        //    string msg = "Exam is not found in system.";
                        //    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction('" + msg + "');", true);
                        //}
                        
                    }
                    else
                    {
                        divAll.Visible = false;
                    }
                    bool StaffId = Request.QueryString.AllKeys.Contains("CheckerID"); //string.IsNullOrWhiteSpace(Request.QueryString["CheckerID"].ToString());

                    if (StaffId)
                    {
                        hfStaffID.Value = objStudent.GetStudentIDByMD5HashCode(Request.QueryString["CheckerID"]).ToString();

                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "SetClassForChecker();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "SetClassForStudent();", true);
                    }
                    BindAnswer();
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
            // bind all answer with question control 
            try
            {
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    DataRow[] rowsFiltered = dt.Select("QID='txtQuestion1'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion1.Value = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion2'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion2.Value = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion3'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion3.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion4'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion4.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion5'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion5.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion6'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion6.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion7'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion7.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion8'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion8.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion9'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion9.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion10'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion10.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion11'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion11.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion12'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion12.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion13'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion13.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion14'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion14.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion15'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion15.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion16'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion16.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion17'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion17.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion18'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion18.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion19'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion19.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion20'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion20.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                }

                dt.Clear();
                dt = objStudent.GetStudentDetailsByStudentID(Convert.ToInt32(hfStudentID.Value));

                if (dt.Rows.Count > 0)
                {
                    lblStudentHeaderName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                    lblGradeSection.Text = dt.Rows[0]["GradeName"].ToString() + " - " + dt.Rows[0]["SectionName"].ToString();
                }

                //}


            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction('" + errmsg + "');", true);

            }
        }
    }
}