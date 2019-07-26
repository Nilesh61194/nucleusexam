using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams
{
    public partial class AssignToTeacher : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                {
                    dt = objExam.GetAcademicYearForExamMaster();
                    if (dt.Rows.Count > 0)
                    {
                        ddlAcademicYear.DataSource = dt;
                        ddlAcademicYear.DataValueField = "AcademicYearID";
                        ddlAcademicYear.DataTextField = "AcademicYear1";
                        ddlAcademicYear.DataBind();
                        ddlAcademicYear.Items.Insert(0, "Select Academic Year");
                    }

                    dt = objExam.GetWorkingStaffList();
                    if (dt.Rows.Count > 0)
                    {
                        ddlTeacher.DataSource = dt;
                        ddlTeacher.DataValueField = "StaffMasterID";
                        ddlTeacher.DataTextField = "FullName";
                        ddlTeacher.DataBind();
                        ddlTeacher.Items.Insert(0, "Select Teacher");
                    }

                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            //exam assign to teacher 
            try
            {

                int count = ddlTeacher.CheckedItems.Count;
                if (count > 0)
                {
                    decimal examID = Convert.ToDecimal(ddlExam.SelectedValue);

                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlTeacher.CheckedItems)
                    {
                        decimal staffID = Convert.ToDecimal(item.Value);

                        objExam.insertEA_TeacherEnrollment(staffID, examID);
                    }

                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "AssignSuccess();", true);

                }
                else
                {

                }
            }
            catch
            {

            }
        }

        protected void ddlAcademicYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAcademicYear.SelectedIndex != 0)
            {
                dt = objExam.GetGradeDetailByExamID(Convert.ToInt32(ddlAcademicYear.SelectedItem.Value));
                ddlGrade.DataSource = dt;
                ddlGrade.DataValueField = "GradeID";
                ddlGrade.DataTextField = "GradeName";
                ddlGrade.DataBind();
                ddlGrade.Items.Insert(0, "Select Grade");

            }
            else
            {
                ddlGrade.Items.Clear();
                ddlExam.Items.Clear();
            }
        }

        protected void ddlGrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlGrade.SelectedIndex != 0)
            {
                dt = objExam.GetExamDetailByGradeID(Convert.ToInt32(ddlGrade.SelectedItem.Value));
                ddlExam.DataSource = dt;
                ddlExam.DataValueField = "ExamID";
                ddlExam.DataTextField = "ExamName";
                ddlExam.DataBind();
                ddlExam.Items.Insert(0, "Select Exam");
            }
            else
            {
                ddlExam.Items.Clear();
                ddlGrade.Items.Clear();
            }
        }
    }
}