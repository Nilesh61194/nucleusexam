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
using System.Net.Http.Headers;
using Telerik.Web.UI;
using System.Data;
using NucleusExams.Models;

namespace NucleusExams
{
    public partial class Home : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // bind dropdown for grade 

                if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                {
                    ddlGrade.DataSource = objExam.GetGradeList();
                    ddlGrade.DataTextField = "GradeName";
                    ddlGrade.DataValueField = "GradeID";
                    ddlGrade.DataBind();
                    ddlGrade.Items.Insert(0, "Select Grade");
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
            int ID = Convert.ToInt32(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ExamID"]);

            bool row = objExam.deleteExamMaster(ID);

            if (row)
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "DeleteSuccess();", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "Error();", true);
            }

        }

        protected void gvExamMaster_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "EditExam")
            {
                decimal examid = Convert.ToDecimal(e.CommandArgument);
                DataTable dt = new DataTable();
                dt = objExam.GetExamByExamID(examid);
                if (dt.Rows.Count > 0)
                {
                    txtExamCode.Value = dt.Rows[0]["ExamCode"].ToString();
                    txtExamDate.Value = Convert.ToDateTime(dt.Rows[0]["ExamDate"]).ToString("yyyy-MM-dd");
                    txtExamDuration.Value = dt.Rows[0]["Duration"].ToString();
                    ddlGrade.SelectedValue = dt.Rows[0]["GradeID"].ToString();
                    txtSubjectName.Value = dt.Rows[0]["SubjectName"].ToString();
                    chkCode.Checked = Convert.ToBoolean(dt.Rows[0]["ISExamCode"].ToString());
                    txtExamURL.Value = dt.Rows[0]["ExamURL"].ToString();
                    txtExamName.Value = dt.Rows[0]["ExamName"].ToString();
                    hfExamID.Value = dt.Rows[0]["ExamID"].ToString();
                    //btnCreate.Visible = false;
                    //btnUpdate.Visible = true;
                    btnUpdate.Style.Add("display", "block");
                    btnCreate.Style.Add("display", "none");
                }
            }

            if (e.CommandName == "ExamActive")
            {

                decimal examid = Convert.ToDecimal(e.CommandArgument);
                bool status = objExam.updateExamStatus(examid);
                gvExamMaster.DataBind();
                if (status)
                {

                }
                else
                {

                }
            }


            if (e.CommandName == "EnableDisable")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showEnableDisablePopup", "$('#ExamEnableDisableModalPopup').modal('show');", true);
            }

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            ExamMaster obj = new ExamMaster();
            obj.ExamCode = txtExamCode.Value;
            obj.ExamDate = Convert.ToDateTime(txtExamDate.Value);
            obj.ExamName = txtExamName.Value;
            obj.SubjectName = txtSubjectName.Value;
            obj.Duration = Convert.ToInt32(txtExamDuration.Value);
            obj.ExamID = Convert.ToInt32(hfExamID.Value);
            obj.ExamURL = txtExamURL.Value;
            obj.GradeID = Convert.ToInt32(ddlGrade.SelectedItem.Value);
            obj.ISExamCode = chkCode.Checked;

            bool result = objExam.updateExamMaster(obj);

            if (result)
            {
                gvExamMaster.Rebind();
                btnUpdate.Style.Add("display", "none");
                btnCreate.Style.Add("display", "block");
                //btnCreate.Visible = true;
                //btnUpdate.Visible = false;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "UpdateSuccess();", true);

            }
            else
            {

            }

        }
    }
}