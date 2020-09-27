<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NucleusExams.Login" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--  
    Document Title
    =============================================
    -->
    <title>NUCLEUS | Exam Login</title>
    <!-- Default style sheets-->
    <link href="assets/Login/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="assets/Login/css/style.css" rel="stylesheet" />
    <link href="Content/popup.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <main>
            <div class="page-loader">
                <div class="loader">Loading...</div>
                <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
                <telerik:RadSkinManager ID="RadSkinManager1" runat="server"></telerik:RadSkinManager>
                <telerik:RadNotification ID="MessegesNotification" Width="250px" hright="200px" runat="server"></telerik:RadNotification>
            </div>
            <section class="home-section home-full-height bg-dark-30" id="home" data-background="Images/Home.jpeg">

                <%--<div class="img-responsive" style="background-image: url('../Images/Home.jpeg')">--%>
                <div class="titan-caption">
                    <div class="caption-content">
                        <img src="assets/Login/images/Nucleus_Logo.png" width="150" height="150" /><br />
                        <div class="font-alt mb-40 titan-title-size-4">Welcome to Nucleus</div>
                        <asp:ImageButton ID="btnStudents" OnClick="btnStudents_Click" ImageUrl="~/assets/Login/images/login-google.png" runat="server" Width="260" />
                        <br />
                        <br />
                        <div class="container hidden">
                            <div class="row">
                                <div class="col-md-3">
                                    <b>Enter UserName :</b>
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox CssClass="form-control" runat="server" ID="txtUserName"></asp:TextBox>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-3">
                                    <b>Enter Password :</b>
                                </div>
                                <div class="col-md-9">
                                    <asp:TextBox CssClass="form-control" runat="server" ID="txtpassword" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <br />
                            <div class="row text-center">
                                <asp:Button Text="Login" CssClass="btn btn-primary" runat="server" ID="btnLogin" OnClick="btnLogin_Click"/>
                            </div>
                        </div>
                    </div>
                </div>

            </section>
        </main>
        <!--  
    JavaScripts 
    =============================================
    -->

        <script src="Scripts/sweetalert-dev.js"></script>
        <script src="assets/Login/lib/jquery/dist/jquery.js"></script>
        <script src="assets/Login/lib/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="assets/Login/lib/wow/dist/wow.js"></script>
        <script src="assets/Login/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
        <script src="assets/Login/lib/isotope/dist/isotope.pkgd.js"></script>
        <script src="assets/Login/lib/imagesloaded/imagesloaded.pkgd.js"></script>
        <script src="assets/Login/lib/flexslider/jquery.flexslider.js"></script>
        <script src="assets/Login/lib/owl.carousel/dist/owl.carousel.min.js"></script>
        <%--<script src="assets/Login/lib/smoothscroll.js"></script>--%>
        <script src="assets/Login/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
        <script src="assets/Login/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
        <script src="assets/Login/js/plugins.js"></script>
        <script src="assets/Login/js/main.js"></script>
    </form>
</body>
</html>
