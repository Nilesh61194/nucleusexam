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
        DataSet ds = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                    {
                        hfloggedInStaffID.Value = Session["StaffID"].ToString();
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
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
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

                dt = objExam.GetExamDetailByGradeID(Convert.ToDecimal(ddlGrade.SelectedItem.Value), Convert.ToDecimal(ddlAcademicYear.SelectedItem.Value), Convert.ToDecimal(hfloggedInStaffID.Value));
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
            // on check all section bind student name in student dropdown or clear student dropdown

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
            // on selected specific section bind student name in student dropdown or clear student dropdown
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

                    // assign all student 
                    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
                    {
                        decimal studenID = Convert.ToDecimal(item.Value);
                        objExam.insertEA_StudentEnrollment(studenID, examID,Convert.ToDecimal(hfloggedInStaffID.Value));
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
            dt.Clear();
            dt = objStudent.GetExamStartFinishStatuByExamID(Convert.ToDecimal(ddlExam.SelectedItem.Value));

            if (dt.Rows.Count > 0 && dt != null)
            {
                lblTotalStudent.Text = dt.Rows[0]["TotalStudent"].ToString();
                lblNotStartExam.Text = dt.Rows[0]["NotStartExam"].ToString();
                lblStartExam.Text = dt.Rows[0]["StartExam"].ToString();
                lblFinishExam.Text = dt.Rows[0]["FinishExam"].ToString();
                lblNotFinishExam.Text = dt.Rows[0]["NotFinishExam"].ToString();
                pChartExamStatus.DataSource = GetData(dt);
                pChartExamStatus.DataBind();

            }





            hfExamID.Value = ddlExam.SelectedItem.Value;
            //// get student id
            //int Studentcount = ddlStudent.CheckedItems.Count;
            //string StudentID = "";
            //if (Studentcount > 0)
            //{
            //    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlStudent.CheckedItems)
            //    {
            //        StudentID = StudentID + item.Value + ',';
            //    }
            //    StudentID = StudentID.Remove(StudentID.Length - 1, 1);
            //    hfStudentID.Value = StudentID;
            //}

            //// section id
            //int Sectioncount = ddlSection.CheckedItems.Count;
            //string SectionID = "";
            //if (Sectioncount > 0)
            //{
            //    foreach (Telerik.Web.UI.RadComboBoxItem item in ddlSection.CheckedItems)
            //    {
            //        SectionID = SectionID + item.Value + ',';
            //    }
            //    SectionID = SectionID.Remove(SectionID.Length - 1, 1);
            //    hfSectionID.Value = SectionID;
            //}

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

        protected void grvShowAssignedStudentList_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            grvShowAssignedStudentList.Rebind();

        }

        protected DataTable GetData(DataTable dt)
        {
            DataTable tbl = new DataTable();

            tbl.Columns.Add(new DataColumn("Count"));
            tbl.Columns.Add(new DataColumn("Title"));
            tbl.Columns.Add(new DataColumn("Color"));
            tbl.Columns.Add(new DataColumn("IsExploded"));

            tbl.Rows.Add(new object[] { dt.Rows[0]["StartExam"].ToString(), "Exam Start", "Black", true });
            tbl.Rows.Add(new object[] { dt.Rows[0]["NotStartExam"].ToString(), "Exam Not Start", "Gray", false });
            tbl.Rows.Add(new object[] { dt.Rows[0]["FinishExam"].ToString(), "Exam Finish Exam", "DarkGray", false });
            tbl.Rows.Add(new object[] { dt.Rows[0]["NotFinishExam"].ToString(), "Exam Not Finish", "DarkRed", false });

            return tbl;
        }

    }
}