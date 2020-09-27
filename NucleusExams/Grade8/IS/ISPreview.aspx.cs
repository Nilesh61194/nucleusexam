using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade8.IS
{
    public partial class ISPreview : System.Web.UI.Page
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

                    }
                    else
                    {
                        divAll.Visible = false;
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
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    DataRow[] rowsFiltered = dt.Select("QID='txtQuestion1'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion1.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion2'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion2.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID='txtQuestion3'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion3.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion4'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion4.Text = rowsFiltered[0]["Answer"].ToString();

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
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }
    }
}