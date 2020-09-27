using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams
{
    public partial class MyExam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //protected void btnPDF_Click(object sender, EventArgs e)
        //{
        //    Response.ContentType = "application/pdf";
        //    Response.AddHeader("content-dispositipon", "attachment;filename=panel.pdf");
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    StringWriter stringwriter = new StringWriter();
        //    HtmlTextWriter htmltextwriter = new HtmlTextWriter(stringwriter);
        //    DivPrint.RenderControl(htmltextwriter);
        //    StringReader stringreader = new StringReader(stringwriter.ToString());

        //    Document Doc = new Document(PageSize.A4, 10f, 10f, 40f, 0f);
        //    HTMLWorker htmlparser = new HTMLWorker(Doc);
        //    PdfWriter.GetInstance(Doc, Response.OutputStream);
        //    Doc.Open();
        //    htmlparser.Parse(stringreader);
        //    Doc.Close();
        //    Response.Write(Doc);
        //    Response.Close();

        //}
    }
}