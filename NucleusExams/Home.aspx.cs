using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using NucleusExams.Controllers;
using System.Configuration;
using System.Net.Http;
using Telerik.Web.UI;
using System.Data;
using NucleusExams.Models;

namespace NucleusExams
{
    public partial class Home : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // bind dropdown for grade first time
                if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                {
                    ddlGrade.DataSource = objExam.GetGradeList();
                    ddlGrade.DataTextField = "GradeName";
                    ddlGrade.DataValueField = "GradeID";
                    ddlGrade.DataBind();
                    ddlGrade.Items.Insert(0, "Select Grade");
                    hfloggedInStaffID.Value = Session["StaffID"].ToString();
                    BindGrid();
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }


        protected void btnCreate_Click(object sender, EventArgs e)
        {

        }

        protected void gvExamMaster_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string contactName = "record";

                //for the Classic RenderMode
                //LinkButton button = dataItem["DeleteColumn"].Controls[0] as LinkButton;
                //button.Attributes["onclick"] = "return confirm('Are you sure you want to delete " +
                //    contactName + "?')";

                //for the Lightweight RenderMode
                ElasticButton button = dataItem["DeleteColumn"].Controls[0] as ElasticButton;
                button.Attributes["onclick"] = "if (!confirm('Are you sure you want to delete " + contactName + "?')) {return false;}";


            }
        }

        protected void gvExamMaster_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            // delete exam using exam id
            int ID = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ExamID"]);

            bool row = objExam.deleteExamMaster(ID);

            if (row)
            {
                BindGrid();
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "DeleteSuccess();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }

        }

        protected void gvExamMaster_ItemCommand(object sender, GridCommandEventArgs e)
        {

            // editexam and set value in control for update
            if (e.CommandName == "EditExam")
            {
                if (CheckEditRights(Convert.ToDecimal(e.CommandArgument)))
                {

                    decimal examid = Convert.ToDecimal(e.CommandArgument);
                    DataTable dt = new DataTable();
                    dt = objExam.GetExamByExamID(examid);
                    if (dt.Rows.Count > 0)
                    {

                        txtExamDate.Value = Convert.ToDateTime(dt.Rows[0]["ExamDate"]).ToString("yyyy-MM-dd");
                        txtExamDuration.Value = dt.Rows[0]["Duration"].ToString();
                        ddlGrade.SelectedValue = dt.Rows[0]["GradeID"].ToString();
                        txtSubjectName.Value = dt.Rows[0]["SubjectName"].ToString();
                        txtExamURL.Value = dt.Rows[0]["ExamURL"].ToString();
                        txtExamName.Value = dt.Rows[0]["ExamName"].ToString();
                        hfExamID.Value = dt.Rows[0]["ExamID"].ToString();
                        //btnCreate.Visible = false;
                        //btnUpdate.Visible = true;
                        btnUpdate.Style.Add("display", "block");
                        btnCreate.Style.Add("display", "none");
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "errorAccess();", true);
                }
            }

            // exam active & de-active using exam id 

            if (e.CommandName == "ExamActive")
            {
                if (CheckEditRights(Convert.ToDecimal(e.CommandArgument)))
                {

                    decimal examid = Convert.ToDecimal(e.CommandArgument);
                    bool status = objExam.updateExamStatus(examid);

                    if (status)
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "UpdateSuccess();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
                    }
                    BindGrid();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "errorAccess();", true);
                }
            }


            if (e.CommandName == "EnableDisable")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showEnableDisablePopup", "$('#ExamEnableDisableModalPopup').modal('show');", true);
            }


        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // update exam 

            ExamMaster obj = new ExamMaster();
            obj.ExamDate = Convert.ToDateTime(txtExamDate.Value);
            obj.ExamName = txtExamName.Value;
            obj.SubjectName = txtSubjectName.Value;
            obj.Duration = Convert.ToInt32(txtExamDuration.Value);
            obj.ExamURL = txtExamURL.Value;
            obj.GradeID = Convert.ToInt32(ddlGrade.SelectedItem.Value);
            obj.ExamID = Convert.ToDecimal(hfExamID.Value);
            obj.CreatedBy = Convert.ToDecimal(hfloggedInStaffID.Value);
            bool result = objExam.updateExamMaster(obj);

            if (result)
            {

                BindGrid();
                btnUpdate.Style.Add("display", "none");
                btnCreate.Style.Add("display", "block");
                //btnCreate.Visible = true;
                //btnUpdate.Visible = false;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "UpdateSuccess();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "error();", true);
            }

        }

        protected void btnUpdate_Click1(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public void BindGrid()
        {
            dt = objExam.GetExamDetailsByStaffID(Convert.ToInt32(hfloggedInStaffID.Value), false);
            //if (dt != null && dt.Rows.Count > 0)
            //{
            gvExamMaster.DataSource = dt;
            gvExamMaster.DataBind();

            // }
            //else
            // {
            //     gvExamMaster.Rebind();
            // }

        }

        protected void gvExamMaster_PageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            gvExamMaster.CurrentPageIndex = e.NewPageIndex;
            BindGrid();

        }

        protected void gvExamMaster_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            gvExamMaster.CurrentPageIndex = gvExamMaster.CurrentPageIndex;
            BindGrid();

        }

        public bool CheckEditRights(decimal ExamID)
        {
            ExamMaster obj = new ExamMaster();
            obj.ExamID = ExamID;
            obj.CreatedBy = Convert.ToDecimal(hfloggedInStaffID.Value);

            bool IsEdit = objExam.CheckEditRightsOnExambyExamIDStaffID(obj.ExamID, obj.CreatedBy);

            return IsEdit;


        }

    }
}