using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NucleusExams
{
    public partial class MasterPage : System.Web.UI.MasterPage
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


                ClearAllMenuLinks();

                string NAVUrl = Request.Path;

                if (NAVUrl == "/Home.aspx")
                {
                    LiCreateExam.Attributes.Add("class", "active");
                }
                else if (NAVUrl == "/AssignToTeacher.aspx")
                {
                    LiAssignToTeacher.Attributes.Add("class", "active");
                }
                else if (NAVUrl == "/AssignToStudent.aspx")
                {
                    LiAssignToStudent.Attributes.Add("class", "active");
                }
                else if (NAVUrl == "/MyExam.aspx")
                {
                    LiMyExam.Attributes.Add("class", "active");
                }

            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }

        public void ClearAllMenuLinks()
        {
            LiCreateExam.Attributes.Remove("class");
            LiAssignToStudent.Attributes.Remove("class");
            LiAssignToTeacher.Attributes.Remove("class");
            LiMyExam.Attributes.Remove("class");
        }
    }
}