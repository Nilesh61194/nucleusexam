<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartExam.aspx.cs" Inherits="NucleusExams.Paper.StartExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Start Exam</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/popup.css" rel="stylesheet" />
    <script src="../assets/js/sweetalert-dev.js"></script>

    <script type="text/javascript">
        function StartSave() {
            debugger;
            var AccessCode = document.getElementById("txtAccessToken").value;

            if (AccessCode = "" || AccessCode.length < 8) {
                swal("Error", "Enter Access Code ...!!", "error");
                return false;
            }
        }

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }

        function WrongAccessCode() {
            swal("Error", "Entered wrong access token \n Try again... ", "error");
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <div class="container" runat="server" id="divAll">
            <div class="row col-md-12 col-lg-12 ">
                <div class="float-left col-md-6 col-lg-6">
                    <img src="../Images/Logo/FS_Logo.png" /><br />
                </div>
                <div class="col-md-6 col-lg-6" style="text-align: end">
                    <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="lblTimer" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
            <div id="div1" class="text-center" runat="server">
                <strong>MYP TERM 2 EXAMINATION (April 2019)
                    <br />
                    <asp:Label ID="lblGradeSubjectName" Font-Bold="true" runat="server"></asp:Label></strong>
            </div>

            <div id="divSomethingWentWrong" class="text-center" runat="server">
                <strong>Something Went Wrong
                    <br />
                    Please check your url</strong>
            </div>
            <div id="divExamError" class="text-center" runat="server">
                <strong>Exam is not started yet
                </strong>
            </div>
            <div id="divExamFinish" class="text-center" runat="server">
                <strong>Your Exam is over
                </strong>
            </div>

            <div id="divPreInstruction" runat="server">
                <div class="row table-bordered border-dark">
                    <div class="col-md-12 text-center">
                        <strong class="text-capitalize"><u>School Code: 004196</u>
                        </strong>
                    </div>
                    <div class="row col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Name of Student:</strong>
                            <asp:Label Text="{{Name}}" ID="lblSTudentName" runat="server"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Section:</strong>
                            <asp:Label ID="lblSectionName" Text="{{Section}}" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="row col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Grade:</strong>
                            <asp:Label ID="lblGradeName" runat="server" Text="{{Grade}}"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Roll No:</strong>
                            <asp:Label ID="lblRollNo" runat="server" Text="{{Roll NO}}"></asp:Label>
                        </div>
                    </div>
                    <div class="row  col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Subject:</strong>
                            <asp:Label ID="lblSubjectName" runat="server" Text="Language & Literature"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Duration:</strong>
                            <asp:Label ID="lblDuration" ClientIDMode="Static" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="row  col-md-12 col-sm-12 col-lg-12" style="margin-top: 1%">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <b>Enter Access Token :</b>
                        <asp:TextBox ID="txtAccessToken" runat="server" onkeypress="return isNumberKey(event)" MaxLength="8"></asp:TextBox>
                        <%--OnClientClick="return StartSave();"--%>
                        <asp:Button ID="btnStartExam" OnClick="btnStartExam_Click" OnClientClick="return StartSave();" runat="server" CssClass="btn-success float-right" Text="Start Exam" />
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function addZero(i) {
                if (i < 10) {
                    i = "0" + i;
                }
                return i;
            }
            function startQuestionTimer() {
                var currentTime = '<%= Session["ExamTimer"] %>';

                setInterval(function () {
                    if (currentTime != "") {
                        var date1 = new Date(currentTime);
                        var date2 = new Date();

                        var diff = new Date(date2 - date1);
                        var hour = addZero(diff.getUTCHours());
                        var min = addZero(diff.getUTCMinutes());
                        var sec = addZero(diff.getUTCSeconds());
                        var duration = '<%= lblDuration.Text %>';
                        document.getElementById('lblTimer').innerHTML = hour + ":" + min + ":" + sec + " / " + duration;
                    }
                    else {
                        var data = document.getElementById('lblTimer');
                        if (data != null) {
                            document.getElementById('lblTimer').innerHTML = '--';
                        }
                    }
                }, 1000);
            }

        </script>
    </form>
</body>
</html>


