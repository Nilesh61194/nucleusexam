﻿using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.DemoPaper
{
    public partial class Maths1Preview : System.Web.UI.Page
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
                    txtQuestion1.Text = dt.Rows[0]["Answer"].ToString().Trim();
                    txtQuestion2.Text = dt.Rows[1]["Answer"].ToString().Trim();
                    txtQuestion3.Text = dt.Rows[2]["Answer"].ToString().Trim();
                    txtQuestion4.Text = dt.Rows[3]["Answer"].ToString().Trim();
                    txtQuestion5.InnerHtml = dt.Rows[4]["Answer"].ToString().Trim();
                    txtQuestion6.InnerHtml = dt.Rows[5]["Answer"].ToString().Trim();
                    txtQuestion7.InnerHtml = dt.Rows[6]["Answer"].ToString().Trim();
                    txtQuestion8.InnerHtml = dt.Rows[7]["Answer"].ToString().Trim();
                    txtQuestion9.InnerHtml = dt.Rows[8]["Answer"].ToString().Trim();
                    txtQuestion10.InnerHtml = dt.Rows[9]["Answer"].ToString().Trim();
                    txtQuestion11.InnerHtml = dt.Rows[10]["Answer"].ToString().Trim();
                    txtQuestion12.InnerHtml = dt.Rows[11]["Answer"].ToString().Trim();
                    txtQuestion13.InnerHtml = dt.Rows[12]["Answer"].ToString().Trim();
                    txtQuestion14.Text = dt.Rows[13]["Answer"].ToString().Trim();
                    txtQuestion15.Text = dt.Rows[14]["Answer"].ToString();
                    txtQuestion16.Text = dt.Rows[15]["Answer"].ToString();
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