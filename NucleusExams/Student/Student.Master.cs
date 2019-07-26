using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams.Student
{
    public partial class Student : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["shEmail"] != null)
                {
                    lblUserName.Text = Session["UserName"].ToString();
                    string imgpath = Session["ImagePath"].ToString();
                    UserImg.ImageUrl = "https://nucleus.fountainheadschools.org/" + imgpath.Substring(2);
                }
            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}