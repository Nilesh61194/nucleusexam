using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Configuration;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Auth.OAuth2.Flows;
using System.Threading;
using NucleusExams.Controllers;
using System.Data;
using System.Security.Cryptography;

namespace NucleusExams
{
    public partial class Login : System.Web.UI.Page
    {
        ExamController objExam = new ExamController();
        LoginController objLogin = new LoginController();
        protected void Page_Init(object sender, System.EventArgs e)
        {
            // Try
            if (base.IsPostBack == false)
            {
                if (HttpContext.Current.Request.Url.ToString().Contains("Login") == false)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }
                else if (Request.RawUrl.Contains("Login") == false)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                // FOLLWOING WILL CHECK IF THE USER'S EMAIL AND PASSWORD IS ALREADY SAVED, THEN WE DON'T NEED USER TO ASK FOR IT AGAIN,
                // SIMPLY REDIRECT USER TO THE HOME PAGE WHERE THEY CAN KICK OFF THEIR WORK
                if (Session["shEmail"] != null)
                {
                    if ((Session["shEmail"].ToString() != ""))
                    {
                        // VERIFY THEM AGAIN FOR SECURITY REASON
                        string email = Session["shEmail"].ToString();
                        if (email.Substring(0, 2) == "s.")
                        {
                            Boolean IsValidStudent = objLogin.IsValidStudentEmailID(email); // s.rudra.prajapati@fountainheadschools.org
                            //IsValidStudent = false; // Remove after paper check 
                            if (IsValidStudent)
                            {
                                Session["shEmail"] = email;
                                SetSessionValue(email, "Student");

                                // set md5 hash of student id and get activ exam id only one 

                                string StudentIDMd5 = MD5Hash(Session["StudentID"].ToString());
                                decimal GradeID = Convert.ToDecimal(Session["GradeID"]);
                                decimal examid = objExam.getExamIdOfActiveExam(GradeID);

                                bool Assign = objExam.IsExamAssignToStudent(Convert.ToDecimal(Session["StudentID"]), examid);
                                if (Assign)
                                {
                                    Response.Redirect("~/Paper/StartExam.aspx?SID=" + StudentIDMd5 + "&EID=" + examid + "", true);
                                }
                                else
                                {
                                    MessegesNotification.Text = "Exam is not active or may not assign to you";
                                    MessegesNotification.Show();
                                }
                            }
                            else
                            {
                                MessegesNotification.Text = "Student details not found in the database!";
                                MessegesNotification.Show();
                            }
                        }
                        // staff login 
                        // right how only my admin login is access by system and mail is nileshkumar.lokhande@fountainheadschools.org
                        else
                        {
                            if (email == ConfigurationManager.AppSettings["EAadmin_id"].ToString())
                            {
                                bool IsValidStaff = objLogin.IsValidStffEmailID(email);
                                if (IsValidStaff)
                                {
                                    Session["shEmail"] = email;
                                    SetSessionValue(email, "Staff");
                                    Response.Redirect("~/Home.aspx", true);
                                }
                                else
                                {
                                    //Response.Redirect("~/Login.aspx", true);
                                    MessegesNotification.Text = "Admin login details not found in the database!";
                                    MessegesNotification.Show();
                                }
                            }
                            else
                            {
                                bool IsStaff = objLogin.IsValidStffEmailID(email);
                                if (IsStaff)
                                {
                                    bool IsRights = objLogin.IsRightsOnExam(email);
                                    //if (IsRights)
                                    //{
                                    Session["shEmail"] = email;
                                    SetSessionValue(email, "Staff");
                                    Response.Redirect("~/Home.aspx", true);
                                    //}
                                    //else
                                    //{
                                    //    MessegesNotification.Text = "login details not found in the database!";
                                    //    MessegesNotification.Show();
                                    //    //Response.Redirect("~/Login.aspx", true);
                                    //}
                                }
                                else
                                {
                                    MessegesNotification.Text = "login details not found in the database of this email id " + email + "!";
                                    MessegesNotification.Show();
                                    //Response.Redirect("~/Login.aspx", true);
                                }
                            }
                        }
                    }
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            string ClientID = "";
            string ClientSecret = "";
            string Redirecturi = "";
            string MainUser = "";

            ClientID = ConfigurationManager.AppSettings["client_id"].ToString();
            ClientSecret = ConfigurationManager.AppSettings["client_secret"].ToString();
            Redirecturi = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Login.aspx";


            if (Request.QueryString["code"] == null)
            {
            }
            else
            {
                //string datafolder = Server.MapPath("App_Data/CalendarService.api.auth.store");
                // Dim scopes = New String() {PlusService.Scope.PlusMe, PlusService.Scope.UserinfoEmail, PlusService.Scope.PlusLogin, Google.Apis.Plus.v1.PlusService.Scope.UserinfoProfile} 'initialising the scope
                string UserId = MainUser.Trim(); // login user

                GoogleAuthorizationCodeFlow flow = null/* TODO Change to default(_) if this is not a reference type */; // declaring the authorization code flow
                ClientSecrets secrets = new ClientSecrets() { ClientId = ClientID, ClientSecret = ClientSecret };

                string code = Request.QueryString["code"];
                var scopes = new string[] { "https://www.googleapis.com/auth/userinfo.email", "https://www.googleapis.com/auth/userinfo.profile" };
                flow = new GoogleAuthorizationCodeFlow(new GoogleAuthorizationCodeFlow.Initializer() { Scopes = scopes, ClientSecrets = secrets });
                var token = flow.ExchangeCodeForTokenAsync(UserId, code, Redirecturi, CancellationToken.None).Result;
                Google.Apis.Auth.OAuth2.UserCredential credential = new UserCredential(flow, "me", token);
                token = credential.Token;

                string email = "";
                using (HttpClient client = new HttpClient())
                {
                    var res = client.GetAsync("https://www.googleapis.com/oauth2/v3/userinfo?access_token=" + token.AccessToken).Result;
                    var json = res.Content.ReadAsStringAsync();
                    GoogleAuthClass obj = JsonConvert.DeserializeObject<GoogleAuthClass>(json.Result);
                    email = obj.email; //"aman.kuba@fountainheadschools.org";  //
                }


                // check how will be login like student or staff
                // check for student login
                //string user = email.Substring(0,1);
                if (email.Substring(0, 2) == "s.")
                {
                    Boolean IsValidStudent = objLogin.IsValidStudentEmailID(email); // s.rudra.prajapati@fountainheadschools.org
                    if (IsValidStudent)
                    {
                        Session["shEmail"] = email;
                        SetSessionValue(email, "Student");

                        // set md5 hash of student id and get activ exam id only one 

                        string StudentIDMd5 = MD5Hash(Session["StudentID"].ToString());
                        decimal GradeID = Convert.ToDecimal(Session["GradeID"]);
                        decimal examid = objExam.getExamIdOfActiveExam(GradeID);
                        bool Assign = objExam.IsExamAssignToStudent(Convert.ToDecimal(Session["StudentID"]), examid);
                        if (Assign)
                        {
                            Response.Redirect("~/Paper/StartExam.aspx?SID=" + StudentIDMd5 + "&EID=" + examid + "", true);
                        }
                        else
                        {
                            MessegesNotification.Text = "Exam is not active or may not assign to you";
                            MessegesNotification.Show();
                        }
                    }
                    else
                    {
                        MessegesNotification.Text = "Student details not found in the database!";
                        MessegesNotification.Show();
                    }
                }
                // staff login 
                // right how only my admin login is access by system and mail is nileshkumar.lokhande@fountainheadschools.org
                else
                {
                    if (email == ConfigurationManager.AppSettings["EAadmin_id"].ToString())
                    {
                        bool IsValidStaff = objLogin.IsValidStffEmailID(email);
                        if (IsValidStaff)
                        {
                            Session["shEmail"] = email;
                            SetSessionValue(email, "Staff");
                            Response.Redirect("~/Home.aspx", true);
                        }
                        else
                        {
                            //Response.Redirect("~/Login.aspx", true);
                            MessegesNotification.Text = "Admin login details not found in the database!";
                            MessegesNotification.Show();
                        }
                    }
                    else
                    {
                        bool IsStaff = objLogin.IsValidStffEmailID(email);
                        if (IsStaff)
                        {
                            bool IsRights = objLogin.IsRightsOnExam(email);
                            if (IsRights)
                            {
                                Session["shEmail"] = email;
                                SetSessionValue(email, "Staff");
                                Response.Redirect("~/Home.aspx", true);
                            }
                            else
                            {
                                MessegesNotification.Text = "login details not found in the database!";
                                MessegesNotification.Show();
                                //Response.Redirect("~/Login.aspx", true);
                            }
                        }
                        else
                        {
                            MessegesNotification.Text = "login details not found in the database of this email id " + email + "!";
                            MessegesNotification.Show();
                            //Response.Redirect("~/Login.aspx", true);
                        }
                    }
                }
            }
        }


        protected void btnStudents_Click(object sender, ImageClickEventArgs e)
        {
            string ClientID = "";
            string ClientSecret = "";
            string Redirecturi = "";

            ClientID = ConfigurationManager.AppSettings["client_id"].ToString();
            ClientSecret = ConfigurationManager.AppSettings["client_secret"].ToString();
            Redirecturi = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + "/Login.aspx";
            authorize(ClientID, ClientSecret, Redirecturi);
        }

        public void authorize(string ClientID, string ClientSecret, string Redirecturi)
        {
            string Uri = "https://accounts.google.com/o/oauth2/auth?access_type=offline&response_type=code&client_id=" + ClientID + "&redirect_uri=" + Redirecturi + "&scope=https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile&include_granted_scopes=true";
            Response.Redirect(Uri);

        }


        // set session value for login user 
        public void SetSessionValue(string Email, string UserType)
        {
            if (UserType == "Staff")
            {
                DataTable dt = new DataTable();
                dt = objExam.getLogInStaffDetailsByEmailID(Email);
                if (dt.Rows.Count > 0)
                {
                    Session["UserName"] = dt.Rows[0]["FullName"].ToString();
                    Session["StaffID"] = dt.Rows[0]["StaffMasterID"].ToString();
                    Session["ImagePath"] = dt.Rows[0]["ImagePath"].ToString();
                    Session["UserType"] = UserType;
                }
            }
            else if (UserType == "Student")
            {
                DataTable dt = new DataTable();
                dt = objExam.getLogInStudentDetailsByEmailID(Email);
                if (dt.Rows.Count > 0)
                {
                    Session["UserName"] = dt.Rows[0]["FirstName"].ToString() + " " + dt.Rows[0]["LastName"].ToString();
                    Session["StudentID"] = dt.Rows[0]["StudentID"].ToString();
                    Session["ImagePath"] = dt.Rows[0]["StudentImage"].ToString();
                    Session["UserType"] = UserType;
                    Session["GradeID"] = dt.Rows[0]["GradeID"].ToString();
                }
            }
        }


        public static string MD5Hash(string input)
        {
            StringBuilder hash = new StringBuilder();
            MD5CryptoServiceProvider md5provider = new MD5CryptoServiceProvider();
            byte[] bytes = md5provider.ComputeHash(new UTF8Encoding().GetBytes(input));

            for (int i = 0; i < bytes.Length; i++)
            {
                hash.Append(bytes[i].ToString("x2"));
            }
            return hash.ToString();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            if (txtUserName.Text.Trim() != "" && txtpassword.Text.Trim() != "")
            {
                if (txtpassword.Text.Trim() == "Covid19Ch!n@")
                {
                    bool IsStaff = objLogin.IsValidStffEmailID(txtUserName.Text.Trim());
                    if (IsStaff)
                    {
                        Session["shEmail"] = txtUserName.Text.Trim();
                        SetSessionValue(txtUserName.Text.Trim(), "Staff");
                        Response.Redirect("~/Home.aspx", true);

                    }
                    else
                    {
                        MessegesNotification.Text = "login details not found in the database of this email id " + txtUserName.Text.Trim() + "!";
                        MessegesNotification.Show();
                        //Response.Redirect("~/Login.aspx", true);
                    }
                }

            }
            else
            {
                txtpassword.Text = "";
                txtUserName.Text = "";
                MessegesNotification.Text = "login details not found in the database of this email id " + txtUserName.Text.Trim() + "!";
                MessegesNotification.Show();
            }

        }
    }


    public class GoogleAuthClass
    {
        public string email { get; set; }
        public bool email_verified { get; set; }
        public string name { get; set; }
        public string picture { get; set; }
    }

}