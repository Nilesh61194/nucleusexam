using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Grade10.IDU
{
    public partial class IDU_G10 : System.Web.UI.Page
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
                    divExamFinish.Visible = false;

                    // check session value student and exam id 
                    if (Session["SID"] == null & Session["EID"] == null)
                    {
                        // if null then hide paper div 
                        myCarousel.Visible = false;
                    }
                    else
                    {

                        // assign value from session to local varible 

                        decimal ExamID = Convert.ToDecimal(Session["EID"]); // Convert.ToDecimal(Request.QueryString["EID"]);
                        decimal StudentID = Convert.ToDecimal(Session["SID"]); // objStudent.GetStudentIDByMD5HashCode(Request.QueryString["SID"]);

                        if (ExamID == 0 && StudentID == 0)
                        {

                            myCarousel.Visible = false;
                        }
                        else
                        {
                            // set value in control if session is not null 
                            hfStudentID.Value = StudentID.ToString();
                            hfExamID.Value = ExamID.ToString();
                            ChecRightsofExam(ExamID, StudentID);
                            lblStudentHeaderName.Text = Session["StudentName"].ToString();
                            lblGradeSubjectName.Text = Session["GradeSubjectName"].ToString();
                            hfTotalDuration.Value = Session["TotalDuration"].ToString() + " Minute";
                            //string content = "<table class='telerik-reTable-4 reSelectDeleteTable' style='background-color: rgb(255, 255, 255); border: 0px solid; font-family: Tahoma; top: 266px; width: 1071px; height: 179px; opacity: 0.8;'><tbody><tr class='telerik-reTableHeaderRow-4' style='border-width: 1pt 1pt 3pt; margin: 0in 0in 10pt; line-height: 16.8667px; font-size: 11pt; font-family: Calibri, sans-serif; width: 119.7pt; background: rgb(79, 129, 189); padding: 0in 5.4pt; color: rgb(255, 255, 255);'><td class='telerik-reTableHeaderFirstCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style = 'font-weight: 700;' > Point </span></td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>x- axis</td><td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp;y- axis</td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>x=1&nbsp;</td><td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>y=3&nbsp;&nbsp;</td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>y=x&nbsp;&nbsp;</td><td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp;y=-x</td></tr><tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (3,9)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (-2,7)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (8,-11)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (-5,-4)&nbsp;</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (0,0)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (0,10)&nbsp;</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableFooterRow-4' style='color: rgb(53, 92, 140); font-size: 10pt; vertical-align: top; padding: 0in 5.4pt;'><td class='telerik-reTableFooterFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (-12,0)</span></td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><br></td></tr></tbody></table><br>";
                            //txtQuestion6.Content = content;
                            ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);

                        }
                    }
                    BindAnswer();
                }
                else
                {
                    // set value when page is postback and call autosave 
                    // on auto postback call saveanswer here also 

                    decimal ExamID = Convert.ToDecimal(hfExamID.Value);
                    decimal StudentID = Convert.ToDecimal(hfStudentID.Value);
                    ChecRightsofExam(ExamID, StudentID);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "SaveAnswerAllTime();", true);
                    ScriptManager.RegisterStartupScript(Page, typeof(Page), "setQuestionTimer", "startQuestionTimer();", true);
                    BindAnswer();
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);

            }
            //hfExamID.Value = "10017";
            //hfStudentID.Value = "420";
            //BindAnswer();
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
                    //txtQuestion1.Text = dt.Rows[0]["Answer"].ToString();
                    //txtQuestion2.Text = dt.Rows[1]["Answer"].ToString();
                    //txtQuestion3.Text = dt.Rows[2]["Answer"].ToString();
                    //txtQuestion4.Value = dt.Rows[3]["Answer"].ToString();
                    //txtQuestion5.Text = dt.Rows[4]["Answer"].ToString();
                    //txtQuestion6.Text = dt.Rows[5]["Answer"].ToString();
                    //txtQuestion7.Value = dt.Rows[6]["Answer"].ToString();
                    //txtQuestion8.Text = dt.Rows[7]["Answer"].ToString();
                    //txtQuestion9.Text = dt.Rows[8]["Answer"].ToString();
                    //txtQuestion10.Text = dt.Rows[9]["Answer"].ToString();
                    //txtQuestion11.Text = dt.Rows[10]["Answer"].ToString();
                    //txtQuestion12.Text = dt.Rows[11]["Answer"].ToString();
                    //txtQuestion13.Text = dt.Rows[12]["Answer"].ToString();
                    //txtQuestion14.Text = dt.Rows[13]["Answer"].ToString();
                    //txtQuestion15.Text = dt.Rows[14]["Answer"].ToString();
                    //txtQuestion16.Text = dt.Rows[15]["Answer"].ToString();
                    //txtQuestion17.Text = dt.Rows[16]["Answer"].ToString();
                    //txtQuestion18.Text = dt.Rows[17]["Answer"].ToString();
                    //txtQuestion19.Text = dt.Rows[18]["Answer"].ToString();
                    //txtQuestion20.Text = dt.Rows[19]["Answer"].ToString();
                    //txtQuestion21.Text = dt.Rows[20]["Answer"].ToString();
                    //txtQuestion22.Text = dt.Rows[21]["Answer"].ToString();
                    //txtQuestion23.Text = dt.Rows[22]["Answer"].ToString();
                    //txtQuestion24.Text = dt.Rows[23]["Answer"].ToString();
                    //txtQuestion25.Text = dt.Rows[24]["Answer"].ToString();
                    //txtQuestion26.Text = dt.Rows[25]["Answer"].ToString();
                    //txtQuestion27.Text = dt.Rows[26]["Answer"].ToString();
                    //txtQuestion28.Value = dt.Rows[27]["Answer"].ToString();
                    //txtQuestion29.Text = dt.Rows[28]["Answer"].ToString();

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
                        txtQuestion4.Value = rowsFiltered[0]["Answer"].ToString();//rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion5'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion5.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion6'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion6.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion7'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion7.Value = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion8'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion8.Text = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion9'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion9.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion10'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion10.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion11'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion11.Text = rowsFiltered[0]["Answer"].ToString();


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
                        txtQuestion16.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion17'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion17.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion18'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion18.Text = rowsFiltered[0]["Answer"].ToString();

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
                        txtQuestion27.Text = rowsFiltered[0]["Answer"].ToString();


                    rowsFiltered = dt.Select("QID = 'txtQuestion28'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion28.Value = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID = 'txtQuestion29'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion29.Text = rowsFiltered[0]["Answer"].ToString();


                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }

        protected void ChecRightsofExam(decimal ExamID, decimal StudentID)
        {
            // this method is used for check exam is active for stundet or not 

            try
            {
                // get and check url that exam is active for that url or not 
                string url = Request.Url.AbsolutePath;

                bool IsExamActive = objStudent.IsExamActiveByExamIDExamURL(ExamID, url);

                if (!IsExamActive)
                {
                    myCarousel.Visible = false;
                }
                else
                {
                    // check exam active for student or not 

                    bool IsExamActiveForStudent = objStudent.IsExamActiveByExamIDStudentID(ExamID, StudentID);
                    if (!IsExamActiveForStudent)
                    {
                        divExamFinish.Visible = true;
                        myCarousel.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                string errmsg = ex.Message;
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "closeScript", "ErrorFunction(" + errmsg + ");", true);
            }
        }
        protected void btnFinish_Click(object sender, EventArgs e)
        {
            objStudent.UpdateExamEndTimeByExamIDStudentID(Convert.ToDecimal(hfExamID.Value), Convert.ToDecimal(hfStudentID.Value));
            myCarousel.Visible = false;
            divExamFinish.Visible = true;
            lblTimer.Visible = false;
        }

    }
}