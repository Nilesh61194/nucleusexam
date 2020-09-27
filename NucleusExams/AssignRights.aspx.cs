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
    public partial class AssignRights : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                {
                    dt = objExam.GetWorkingStaffList();
                    if (dt.Rows.Count > 0)
                    {
                        cboStaffList.DataSource = dt;
                        cboStaffList.DataValueField = "StaffMasterID";
                        cboStaffList.DataTextField = "FullName";
                        cboStaffList.DataBind();

                    }
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        protected void btnStaffAssign_Click(object sender, EventArgs e)
        {
            // add right for staff and teacher 
            bool status = false;
            try
            {
                // check of selected staff count or give validation msg

                int count = cboStaffList.CheckedItems.Count;
                if (count > 0)
                {
                    foreach (Telerik.Web.UI.RadComboBoxItem item in cboStaffList.CheckedItems)
                    {
                        decimal staffID = Convert.ToDecimal(item.Value);
                        status = objExam.InsertRightsToTeacher(staffID, chkRights.Checked, chkAdminRights.Checked, Convert.ToDecimal(Session["StaffID"]));

                    }
                    if (status)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "AssignSuccess();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
                    }
                    cboStaffList.ClearCheckedItems();
                    chkRights.Checked = false;
                    chkAdminRights.Checked = false;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ValidationForStaffSelection();", true);
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }

        protected void gvExamMaster_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            try
            {
                dt = objExam.getEA_StaffRights();
                if (dt.Rows.Count > 0)
                {
                    gvExamMaster.DataSource = dt;
                    gvExamMaster.DataBind();
                }
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }
        }
    }

}