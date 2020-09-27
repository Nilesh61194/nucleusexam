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
    public partial class MathStdPreview : System.Web.UI.Page
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
                // get data using exam and student id 
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    txtQuestion1.Text = dt.Rows[0]["Answer"].ToString().Trim();
                    txtQuestion2.Text = dt.Rows[1]["Answer"].ToString().Trim();
                    txtQuestion3.Text = dt.Rows[2]["Answer"].ToString().Trim();
                    txtQuestion4.InnerHtml = dt.Rows[3]["Answer"].ToString().Trim();
                    txtQuestion5.Text = dt.Rows[4]["Answer"].ToString().Trim();
                    txtQuestion6.Text = dt.Rows[5]["Answer"].ToString().Trim();
                    txtQuestion7.Text = dt.Rows[6]["Answer"].ToString().Trim();
                    txtQuestion8.Text = dt.Rows[7]["Answer"].ToString().Trim();
                    txtQuestion9.InnerHtml = dt.Rows[8]["Answer"].ToString().Trim();
                    txtQuestion10.Text = dt.Rows[9]["Answer"].ToString().Trim();
                    txtQuestion11.Text = dt.Rows[10]["Answer"].ToString().Trim();
                    txtQuestion12.Text = dt.Rows[11]["Answer"].ToString().Trim();
                    txtQuestion13.Text = dt.Rows[12]["Answer"].ToString().Trim();
                    txtQuestion14.Text = dt.Rows[13]["Answer"].ToString().Trim();
                    txtQuestion15.Text = dt.Rows[14]["Answer"].ToString();
                    txtQuestion16.Text = dt.Rows[15]["Answer"].ToString();
                    txtQuestion17.Text = dt.Rows[16]["Answer"].ToString().Trim();
                    txtQuestion18.Text = dt.Rows[17]["Answer"].ToString().Trim();
                    txtQuestion19.Text = dt.Rows[18]["Answer"].ToString().Trim();
                    txtQuestion20.Text = dt.Rows[19]["Answer"].ToString().Trim();
                    txtQuestion21.Text = dt.Rows[20]["Answer"].ToString().Trim();
                    txtQuestion22.Text = dt.Rows[21]["Answer"].ToString().Trim();
                    txtQuestion23.Text = dt.Rows[22]["Answer"].ToString().Trim();
                    txtQuestion24.Text = dt.Rows[23]["Answer"].ToString().Trim();
                    txtQuestion25.Text = dt.Rows[24]["Answer"].ToString().Trim();
                }

                dt.Clear();
                dt = objStudent.GetStudentDetailsByStudentID(Convert.ToInt32(hfStudentID.Value));

                if (dt.Rows.Count > 0)
                {
                    lblStudentHeaderName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                    lblGradeSection.Text = dt.Rows[0]["GradeName"].ToString() + " - " + dt.Rows[0]["SectionName"].ToString();
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