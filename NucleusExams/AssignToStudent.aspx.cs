using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NucleusExams.Controllers;
using System.Data;
using Telerik.Web.UI;

namespace NucleusExams
{
    public partial class AssignToStudent : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        StudentController objStudent = new StudentController();
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
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }

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
                ddlSection.Items.Clear();
            }
        }

        protected void ddlGrade_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlGrade.SelectedIndex != 0 && ddlGrade.SelectedItem != null)
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
                ddlSection.Items.Clear();
            }
        }

        protected void ddlExam_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlExam.SelectedIndex != 0 && ddlGrade.SelectedItem.Value != "Select Grade")
            {
                dt = objExam.GetSectionByGradeID(Convert.ToInt32(ddlGrade.SelectedItem.Value));
                ddlSection.DataSource = dt;
                ddlSection.DataValueField = "SectionID";
                ddlSection.DataTextField = "SectionName";
                ddlSection.DataBind();
                hfExamID.Value = ddlExam.SelectedItem.Value;
                grvShowAssignedStudentList.DataBind();
                //ddlSection.Items.Insert(0, "Select Section");
            }
            else
            {
                ddlSection.Items.Clear();
            }
        }

        protected void ddlSection_CheckAllCheck(object sender, Telerik.Web.UI.RadComboBoxCheckAllCheckEventArgs e)
        {
            try
            {
                int count = ddlSection.CheckedItems.Count;
                if (count > 0)
                {
                    string checkedSectionIDs = "";

                    foreach (var item in ddlSection.CheckedItems)
                        checkedSectionIDs += item.Value + ",";

                    checkedSectionIDs = checkedSectionIDs.Remove(checkedSectionIDs.Length - 1, 1);

                    dt = objExam.GetStudentDetailBySectionID(checkedSectionIDs);
                    ddlStudent.DataSource = dt;
                    ddlStudent.DataValueField = "StudentID";
                    ddlStudent.DataTextField = "FullName";
                    ddlStudent.DataBind();
                    
                }
                else
                {
                    ddlStudent.Items.Clear();
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void ddlSection_ItemChecked(object sender, Telerik.Web.UI.RadComboBoxItemEventArgs e)
        {
            try
            {
                int count = ddlSection.CheckedItems.Count;
                if (count > 0)
                {
                    string checkedSectionIDs = "";

                    foreach (var item in ddlSection.CheckedItems)
                        checkedSectionIDs += item.Value + ",";

                    checkedSectionIDs = checkedSectionIDs.Remove(checkedSectionIDs.Length - 1, 1);

                    dt = objExam.GetStudentDetailBySectionID(checkedSectionIDs);
                    ddlStudent.DataSource = dt;
                    ddlStudent.DataValueField = "StudentID";
                    ddlStudent.DataTextField = "FullName";
                    ddlStudent.DataBind();

                }
                else
                {
                    ddlStudent.Items.Clear();
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            // assig exam to selected student 
            try
            {

                int count = ddlStudent.CheckedItems.Count;
                if (count > 0)
                {
                    decimal examID = Convert.ToDecimal(ddlExam.SelectedValue);

                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
                    {
                        decimal studenID = Convert.ToDecimal(item.Value);
                        objExam.insertEA_StudentEnrollment(studenID, examID);
                    }
                    ClearCombobox();
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "AssignSuccess();", true);

                }
                else
                {

                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void btnShowStudent_Click(object sender, EventArgs e)
        {
            hfExamID.Value = ddlExam.SelectedItem.Value;
            ClearCombobox();
            // grvShowAssignedStudentList.DataBind();
        }

        protected void btnEnableExam_Click(object sender, EventArgs e)
        {
            // enable exam for student by using exam id and student id 
            try
            {

                int count = ddlStudent.CheckedItems.Count;
                if (count > 0)
                {
                    decimal examID = Convert.ToDecimal(ddlExam.SelectedValue);

                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
                    {
                        decimal studenID = Convert.ToDecimal(item.Value);
                        objStudent.UpdateEnableExamByStudentIDExamID(studenID, examID);
                    }
                    ClearCombobox();
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "EnableExam();", true);
                }
                else
                {

                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void btnDeleteAssign_Click(object sender, EventArgs e)
        {
            // remove assign exam of student 
            try
            {
                int count = ddlStudent.CheckedItems.Count;
                if (count > 0)
                {
                    decimal examID = Convert.ToDecimal(ddlExam.SelectedValue);

                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
                    {
                        decimal studenID = Convert.ToDecimal(item.Value);
                        objStudent.DeleteStudentEnrollment(studenID, examID);
                    }
                    ClearCombobox();
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "DeleteStudent();", true);
                }
                else
                {


                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void btnDisableExam_Click(object sender, EventArgs e)
        {
            // disable exam of student by using examid and student id 
            try
            {
                int count = ddlStudent.CheckedItems.Count;
                if (count > 0)
                {
                    decimal examID = Convert.ToDecimal(ddlExam.SelectedValue);

                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
                    {
                        decimal studenID = Convert.ToDecimal(item.Value);
                        objStudent.UpdateDisableExamByStudentIDExamID(studenID, examID);
                    }
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "DisableExam();", true);
                }
                else
                {

                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }



        public void ClearCombobox()
        {
            if (ddlStudent.CheckedItems.Count > 0)
            {
                foreach (RadComboBoxItem rcbItem in ddlStudent.Items)
                {
                    rcbItem.Checked = false;
                }

            }


            if (ddlSection.CheckedItems.Count > 0)
            {
                foreach (RadComboBoxItem rcbItem in ddlSection.Items)
                {
                    rcbItem.Checked = false;
                }

            }
        }

    }
}