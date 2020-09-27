using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade8.IDU
{
    public partial class IDU_G8Preview : System.Web.UI.Page
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
                //hfExamID.Value = "10019";
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
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    DataRow[] rowsFiltered = dt.Select("QID='txtQuestion1'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion1.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion2'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion2.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID='txtQuestion3'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion3.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion4'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion4.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion5'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion5.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion6'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion6.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion7'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion7.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion8'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion8.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion9'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion9.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion10'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion10.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion11'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion11.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion12'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion12.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion13'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion13.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion14'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion14.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion15'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion15.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion16'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion16.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion17'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion17.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion18'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion18.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion19'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion19.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion20'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion20.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion21'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion21.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion22'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion22.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion23'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion23.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion24'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion24.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion25'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion25.Text = rowsFiltered[0]["Answer"].ToString();



                    rowsFiltered = dt.Select("QID = 'txtQuestion26'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion26.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion27'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion27.InnerHtml = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion28'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion28.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion29'");

                    if (rowsFiltered.Length > 0)
                        hfCheckboxValue.Value = rowsFiltered[0]["Answer"].ToString();

                    if (hfCheckboxValue.Value != "")
                    {
                        string[] val = hfCheckboxValue.Value.Split(',');
                        for (int i = 0; i < val.Length; i++)
                        {
                            val[i] = val[i].Trim();
                            for (int b = 0; b < txtQuestion29.Items.Count; b++)
                            {
                                if (txtQuestion29.Items[b].Value == val[i])
                                {
                                    txtQuestion29.Items[b].Selected = true;
                                }
                            }
                        }
                    }


                    rowsFiltered = dt.Select("QID = 'txtQuestion30'");

                    if (rowsFiltered.Length > 0)
                        hfCheckboxValue.Value = rowsFiltered[0]["Answer"].ToString();

                    if (hfCheckboxValue.Value != "")
                    {
                        string[] values = hfCheckboxValue.Value.Split(',');
                        for (int j = 0; j < values.Length; j++)
                        {
                            values[j] = values[j].Trim();
                            for (int a = 0; a < txtQuestion30.Items.Count; a++)
                            {
                                if (txtQuestion30.Items[a].Value == values[j])
                                {
                                    txtQuestion30.Items[a].Selected = true;
                                }
                            }
                        }
                    }

                }

                dt.Clear();
                dt = objStudent.GetStudentDetailsByStudentID(Convert.ToInt32(hfStudentID.Value));

                if (dt.Rows.Count > 0)
                {
                    lblStudentHeaderName.Text = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                    lblGradeSection.Text = dt.Rows[0]["GradeName"].ToString() + " - " + dt.Rows[0]["SectionName"].ToString();
                }

                //}


            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }
    }
}