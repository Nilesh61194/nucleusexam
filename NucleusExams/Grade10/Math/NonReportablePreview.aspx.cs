using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.Math
{
    public partial class NonReportablePreview : System.Web.UI.Page
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
                            lblGradeSubjectName.Text = dt.Rows[0]["ExamName"].ToString() + " - " + dt.Rows[0]["SubjectName"].ToString();
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
            string defaultImageUrl = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAImCAIAAACDxJhEAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAk5SURBVHhe7dYBDQAADMOg+ze962gCKrgBAGSpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAkLU9arA0NR01ojsAAAAASUVORK5CYII=";
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
                    txtQuestion4.InnerHtml = dt.Rows[3]["Answer"].ToString();
                    txtQuestion5.InnerHtml = dt.Rows[4]["Answer"].ToString();
                    txtQuestion6.InnerHtml = dt.Rows[5]["Answer"].ToString();
                    txtQuestion7.InnerHtml = dt.Rows[6]["Answer"].ToString();
                    txtQuestion8.InnerHtml = dt.Rows[7]["Answer"].ToString();
                    txtQuestion9.InnerHtml = dt.Rows[8]["Answer"].ToString();
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