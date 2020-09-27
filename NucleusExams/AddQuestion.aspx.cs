using NucleusExams.Controllers;
using NucleusExams.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace NucleusExams
{
    public partial class AddQuestion : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        QuestionController objQuestion = new QuestionController();
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Header.DataBind();

            if (!IsPostBack)
            {
                if (Session["shEmail"] != null && Session["UserType"].ToString() == "Staff")
                {

                    dt = objExam.GetExamByExamID(Convert.ToDecimal(Request.QueryString["ExamId"]));
                    if (dt.Rows.Count > 0 && dt != null)
                    {
                        lblGrade.Text = dt.Rows[0]["GradeName"].ToString();
                        lblExamName.Text = dt.Rows[0]["ExamName"].ToString();
                        DateTime date = Convert.ToDateTime(dt.Rows[0]["ExamDate"]);
                        lblExamDate.Text = date.ToString("dd/MMM/yyyy", CultureInfo.InvariantCulture); //Convert.ToDateTime(dt.Rows[0]["ExamDate"].ToString()).ToShortDateString().ToString("dd/MM/yyyy");
                        lblExamCode.Text = dt.Rows[0]["ExamCode"].ToString();
                        lblExamDuration.Text = dt.Rows[0]["Duration"].ToString();
                        hfExamID.Value = Request.QueryString["ExamId"].ToString();
                        hfloggedInStaffID.Value = Session["StaffID"].ToString();
                        dt.Clear();
                    }
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        protected void gvExamMaster_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuestion")
            {
                if (CheckEditRights(Convert.ToDecimal(hfExamID.Value)))
                {
                    int QuestionID = Convert.ToInt32(e.CommandArgument);

                    bool result = objQuestion.DeleteQuestion(QuestionID);

                    if (result)
                    {

                        gvQuestion.Rebind();
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "Delete", "DeleteMsg();", true);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "Error", "ErrorMsg();", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "errorAccess();", true);
                }
            }

            if (e.CommandName == "EditQuestion")
            {
                if (CheckEditRights(Convert.ToDecimal(hfExamID.Value)))
                {
                    int QuestionID = Convert.ToInt32(e.CommandArgument);

                    dt.Clear();

                    dt = objQuestion.GetQuestionDetailsByID(QuestionID);

                    if (dt.Rows.Count > 0 && dt != null)
                    {
                        txtQuestion.Content = dt.Rows[0]["Question"].ToString();
                        txtQuestionMarks.Text = dt.Rows[0]["QuestionMarks"].ToString();
                        ddlQuestionType.SelectedValue = dt.Rows[0]["QuestionType"].ToString();
                        btnSaveQuestion.Text = "UPDATE";
                        hfQuestionID.Value = dt.Rows[0]["QuestionID"].ToString();
                    }


                    if (ddlQuestionType.SelectedItem.Value != "TextBox" && ddlQuestionType.SelectedItem.Value != "Editor")
                        ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "bindOptionValues();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "errorAccess();", true);
                }
            }

        }

        protected void btnUpdateQuestion_Click(object sender, EventArgs e)
        {
            gvQuestion.Rebind();
            btnSaveQuestion.Text = "SAVE";
        }

        public bool CheckEditRights(decimal ExamID)
        {
            ExamMaster obj = new ExamMaster();
            obj.ExamID = ExamID;
            obj.CreatedBy = Convert.ToDecimal(hfloggedInStaffID.Value);

            bool IsEdit = objExam.CheckEditRightsOnExambyExamIDStaffID(obj.ExamID, obj.CreatedBy);

            return IsEdit;


        }

        protected void btnExamPreview_Click(object sender, EventArgs e)
        {
            if (CheckEditRights(Convert.ToDecimal(hfExamID.Value)))
            {
                Session["PreviewExamID"] = hfExamID.Value;
                string url = "~/Paper/ExamPreview";
                StringBuilder sb = new StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.open('");
                sb.Append(url);
                sb.Append("');");
                sb.Append("</script>");
                ClientScript.RegisterStartupScript(this.GetType(),
                        "script", sb.ToString());
                //Response.Redirect("");
            }
        }
    }
}