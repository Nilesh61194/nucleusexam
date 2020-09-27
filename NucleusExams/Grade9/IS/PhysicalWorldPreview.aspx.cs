using NucleusExams.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using IronPdf;

namespace NucleusExams.Grade9.IS
{
    public partial class PhysicalWorldPreview : System.Web.UI.Page
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
                dt = objExam.getEA_ExamAnswerMasterByQuestionIDStudentIDExamID(Convert.ToInt32(hfStudentID.Value), Convert.ToInt32(hfExamID.Value));
                if (dt.Rows.Count > 0)
                {
                    DataRow[] rowsFiltered = dt.Select("QID='txtQuestion1'");

                    if (rowsFiltered.Length > 0)
                        txtQuestion1.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion2'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion2.InnerHtml = rowsFiltered[0]["Answer"].ToString();
                    
                    rowsFiltered = dt.Select("QID='txtQuestion3'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion3.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion4'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion4.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion5'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion5.InnerHtml = rowsFiltered[0]["Answer"].ToString();

                    rowsFiltered = dt.Select("QID='txtQuestion6'");
                    if (rowsFiltered.Length > 0)
                        txtQuestion6.InnerHtml = rowsFiltered[0]["Answer"].ToString();

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


        // Code of pdf generate for paper 

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    //Response.ContentType = "application/pdf";
        //    //Response.AddHeader("content-disposition", "attachment;filename=TestPage.pdf");
        //    //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    //StringWriter sw = new StringWriter();
        //    //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //    //this.form1.RenderControl(hw);
        //    //StringReader sr = new StringReader(sw.ToString());
        //    //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        //    //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //    //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //    //pdfDoc.Open();
        //    //htmlparser.Parse(sr);
        //    //pdfDoc.Close();
        //    //Response.Write(pdfDoc);
        //    //Response.End();

        //    // Create a PDF from an existing HTML
        //    ////var Renderer = new IronPdf.HtmlToPdf();
        //    ////Renderer.PrintOptions.MarginTop = 50;  //millimeters
        //    ////Renderer.PrintOptions.MarginBottom = 50;
        //    ////Renderer.PrintOptions.CssMediaType = PdfPrintOptions.PdfCssMediaType.Print;
        //    ////Renderer.PrintOptions.Header = new SimpleHeaderFooter()
        //    ////{
        //    ////    CenterText = lblExamSubject.Text,
        //    ////    DrawDividerLine = true,
        //    ////    FontSize = 16
        //    ////};
        //    ////Renderer.PrintOptions.Footer = new SimpleHeaderFooter()
        //    ////{
        //    ////    LeftText = System.DateTime.Now.ToString(),
        //    ////    //RightText = "Page {page} of {total-pages}",
        //    ////    DrawDividerLine = true,
        //    ////    FontSize = 14
        //    ////};
        //    //var PDF = Renderer.RenderHTMLFileAsPdf("Assets/TestInvoice1.html");
        //    //var OutputPath = "Invoice.pdf";
        //    //PDF.SaveAs(OutputPath);
        //    //// This neat trick opens our PDF file so we can see the result
        //    //System.Diagnostics.Process.Start(OutputPath);

        //   var Renderer = new IronPdf.HtmlToPdf();
        //    var PDF = Renderer.RenderUrlAsPdf("https://exam.fountainheadschools.org/Grade10/IS/ISPreview.aspx?SID=9BE40CEE5B0EEE1462C82C6964087FF9&EID=30");
        //    PDF.SaveAs("StudentPaper.pdf");
        //    // This neat trick opens our PDF file so we can see the result
        //    System.Diagnostics.Process.Start("wikipedia.pdf");

        //    //try
        //    //{
        //    //    Document pdfDoc = new Document(PageSize.A4, 25, 10, 25, 10);
        //    //    PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //    //    pdfDoc.Open();
        //    //    Paragraph Text = new Paragraph("This is test file");
        //    //    pdfDoc.Add(Text);
        //    //    pdfWriter.CloseStream = false;
        //    //    pdfDoc.Close();
        //    //    Response.Buffer = true;
        //    //    Response.ContentType = "application/pdf";
        //    //    Response.AddHeader("content-disposition", "attachment;filename=Example.pdf");
        //    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    //    Response.Write(pdfDoc);
        //    //    Response.End();
        //    //}
        //    //catch (Exception ex)
        //    //{ Response.Write(ex.Message); }

        //}
    }
}