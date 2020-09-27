using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.IDU
{
    public partial class IDU_G10Preview : System.Web.UI.Page
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
                //hfExamID.Value = "10017";
                //hfStudentID.Value = "420";
                //BindAnswer();
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
                    txtQuestion1.InnerHtml = dt.Rows[0]["Answer"].ToString();
                    txtQuestion2.InnerHtml = dt.Rows[1]["Answer"].ToString();
                    txtQuestion3.InnerHtml = dt.Rows[2]["Answer"].ToString();
                    txtQuestion4.Value = dt.Rows[3]["Answer"].ToString();
                    txtQuestion5.Text = dt.Rows[4]["Answer"].ToString();
                    txtQuestion6.Text = dt.Rows[5]["Answer"].ToString();
                    txtQuestion7.Value = dt.Rows[6]["Answer"].ToString();
                    txtQuestion8.Text = dt.Rows[7]["Answer"].ToString();
                    txtQuestion9.Text = dt.Rows[8]["Answer"].ToString();
                    txtQuestion10.Text = dt.Rows[9]["Answer"].ToString();
                    txtQuestion11.Text = dt.Rows[10]["Answer"].ToString();
                    txtQuestion12.Text = dt.Rows[11]["Answer"].ToString();
                    txtQuestion13.Text = dt.Rows[12]["Answer"].ToString();
                    txtQuestion14.InnerHtml = dt.Rows[13]["Answer"].ToString();
                    txtQuestion15.InnerHtml = dt.Rows[14]["Answer"].ToString();
                    txtQuestion16.InnerHtml = dt.Rows[15]["Answer"].ToString();
                    txtQuestion17.Text = dt.Rows[16]["Answer"].ToString();
                    txtQuestion18.Text = dt.Rows[17]["Answer"].ToString();
                    txtQuestion19.Text = dt.Rows[18]["Answer"].ToString();
                    txtQuestion20.Text = dt.Rows[19]["Answer"].ToString();
                    txtQuestion21.InnerHtml = dt.Rows[20]["Answer"].ToString();
                    txtQuestion22.InnerHtml = dt.Rows[21]["Answer"].ToString();
                    txtQuestion23.Text = dt.Rows[22]["Answer"].ToString();
                    txtQuestion24.Text = dt.Rows[23]["Answer"].ToString();
                    txtQuestion25.Text = dt.Rows[24]["Answer"].ToString();
                    txtQuestion26.Text = dt.Rows[25]["Answer"].ToString();
                    txtQuestion27.InnerHtml = dt.Rows[26]["Answer"].ToString();
                    txtQuestion28.Value = dt.Rows[27]["Answer"].ToString();
                    txtQuestion29.InnerHtml = dt.Rows[28]["Answer"].ToString();
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