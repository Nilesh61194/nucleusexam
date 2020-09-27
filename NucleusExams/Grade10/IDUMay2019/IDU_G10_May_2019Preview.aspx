<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IDU_G10_May_2019Preview.aspx.cs" Inherits="NucleusExams.Grade10.IDUMay2019.IDU_G10_May_2019Preview" EnableViewState="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>IDU G10 May 2019</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <%--<link href="../../Content/all.css" rel="stylesheet" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />--%>

    <%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />--%>
    <script src="../../ckeditor4/ckeditor.js"></script>

    <link href="../../Content/kendo.default-v2.min.css" rel="stylesheet" />

    <script src="../../Scripts/jquery.min.kendo.js" type="text/javascript"></script>

    <script src="../../Scripts/jszip.min.js" type="text/javascript"></script>

    <script src="../../Scripts/kendo.all.min.js" type="text/javascript"></script>

    <script>

        function getPDF(selector) {
            debugger;

            var file = document.getElementById("lblExamSubject").innerText + document.getElementById("lblStudentHeaderName").innerText + "_" + document.getElementById("lblGradeSection").innerText;
            kendo.drawing.drawDOM($(selector)).then(function (group) {
                kendo.drawing.pdf.saveAs(group, "" + file + ".pdf");
            });
        }
    </script>

    <%--<script>
        // Import DejaVu Sans font for embedding

        // NOTE: Only required if the Kendo UI stylesheets are loaded
        // from a different origin, e.g. cdn.kendostatic.com
        kendo.pdf.defineFont({
            "DejaVu Sans": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans.ttf",
            "DejaVu Sans|Bold": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Bold.ttf",
            "DejaVu Sans|Bold|Italic": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Oblique.ttf",
            "DejaVu Sans|Italic": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Oblique.ttf",
            "WebComponentsIcons": "https://kendo.cdn.telerik.com/2017.1.223/styles/fonts/glyphs/WebComponentsIcons.ttf"
        });
    </script>--%>

    <!-- Load Pako ZLIB library to enable PDF compression -->

    <script src="../../Scripts/modernizr-2.6.2.js"></script>
    <style>
        .CustomFontSize {
            text-align: justify;
            font-size: larger;
        }

        .CustomPTag {
            margin: 0px 50px 10px !important;
        }

        table, th, td {
            border: 1px solid black;
        }

        .divAnswer {
            border-style: solid;
            padding: 5px;
            overflow-wrap: break-word;
        }

        .divComment {
            border-style: solid;
            padding: 5px;
            overflow-wrap: break-word;
            width: 100%;
            background-color: cornsilk;
            font-weight: bold;
            text-align: justify !important;
        }


        .clsTxt {
            width: 100%;
            min-height: 50px;
            max-height: none;
            resize: none;
            border-style: solid;
            border-width: 3px;
            border-color: black !important;
            overflow-y: hidden;
        }

        .btnCustome {
            background-color: dodgerblue !important;
            margin: unset !important;
            padding: 0px 10px !important;
            margin-top: 2px !important;
        }

        .borderClas {
            border-style: solid;
            border-width: 3px;
            text-align: center !important;
        }

        #load {
            width: 100%;
            height: 100%;
            position: fixed;
            z-index: 9999;
            background: url("../../Images/Logo/Nucleus.gif") no-repeat center center rgba(0,0,0,0.25);
        }
    </style>
    <script>
        var myVar;
        var myTimer;
        var myVarCKE;

        document.onreadystatechange = function () {
            var state = document.readyState
            if (state == 'interactive') {
                document.getElementById('contents').style.visibility = "hidden";
            } else if (state == 'complete') {
                setTimeout(function () {
                    document.getElementById('interactive');
                    document.getElementById('load').style.visibility = "hidden";
                    document.getElementById('contents').style.visibility = "visible";
                }, 1000);
            }
        }

        $(document).ready(function () {
            
            BindCommentMarks();

            $("img").css('width', "99%")
            ///   BindAnswertoCkeditor();

        });

        //function CalculateFinalMarks()
        //{
        //    debugger;
        //    var sum = 0;
        //    var ele = document.getElementsByClassName("borderClas");
        //    for (var i = 0; i < ele.length;i++)
        //    {
        //        var id = ele[i].id;
        //        if (document.getElementById(id).value != "" && document.getElementById(id).value != null)
        //        {
        //            sum = sum + parseFloat(document.getElementById(id).value);
        //            alert(document.getElementById(id).value);
        //        }
                
        //    }

        //    document.getElementById("divTotalMarks").innerText = "Obtained Marks : " + sum;

        //    document.getElementById("divGrade").innerText = "Grade : " + calculateGrade(sum);
            
        //    $('html, body').animate({ scrollTop: 0 }, 'fast');

        //    return false;
        //}


        function calculateGrade(marks) {
           

            var Number = parseInt(marks);
            if (Number >= 0 && Number <= 9) {
                return "1";
            }
            else if (Number >= 10 && Number <= 18) {
                return "2";
            }
            else if (Number >= 19 && Number <= 32) {
                return "3";
            }
            else if (Number >= 33 && Number <= 41) {
                return "4";
            }
            else if (Number >= 42 && Number <= 50) {
                return "5";
            }
            else if (Number >= 51 && Number <= 59) {
                return "6";
            }
            else if (Number >= 60 && Number <= 80) {
                return "7";
            }
            else {
                return "0";
            }

        }

        function isNumber(evt) {
            debugger;

            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            // (evt.which != 46 || $(this).val().indexOf('.') != -1) && // || (evt.which == 46 && $(this).caret().start == 0)
            if (charCode == 13) {
                evt.preventDefault();
                return false;
            }
            return true;
        }

        function SetClassForStudent() {
            $(".btnCustome").css({ "display": "none" });
            $(".clsTxt").css({ "display": "none" });
            $('.clsTxt').attr("disabled", "disabled");
            $('.borderClas').attr("disabled", "disabled");
        }

        function SetClassForChecker() {
            $(".divComment").css({ "display": "none" });
        }

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }

        function resizeTextBox(Id) {
            Id.style.height = "1px";
            Id.style.height = (1 + Id.scrollHeight) + "px";
        }

        function SaveComment(Comment, Mark)
        {

            debugger;
            var CommentGiven = document.getElementById(Comment).value;
            var ObMarks = document.getElementById(Mark).value;

            if (ObMarks == "") {
                ObMarks = 0;
            }
            if (CommentGiven != "" || ObMarks != "") {

                var ECS = {};
                ECS.StudentID = document.getElementById('<%= hfStudentID.ClientID%>').value;
                ECS.ExamID = document.getElementById('<%= hfExamID.ClientID%>').value;
                ECS.CommentBy = document.getElementById('<%= hfStaffID.ClientID%>').value;
                ECS.ScoreType = "Marks";
                ECS.QID = Comment;
                ECS.Comment = CommentGiven;
                ECS.ObtainScore = ObMarks;
                $.ajax({

                    url: "<%=Page.ResolveUrl("/api/Exam/insertEA_ExamCommentScoreMaster")%>",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(ECS),
                    dataType: "json",

                    success: function (response) {

                        if (response) {
                            debugger;
                            alert("Saved.");
                        }
                        else {
                            alert("Comment / Marks is not Save ...!");
                            console.log(Comment);
                        }
                    },

                    error: function (x, e) {
                        console.log(x.responseText);
                        alert('Comment / Marks is not Save ...!.\nSomethig went wrong.');
                        //alert(x.responseText);
                        //alert(x.status);

                    }
                });
            }
            else {
                alert('Please enter comment or marks');
            }


            return false;
        }

        function BindCommentMarks() {
            
            debugger;

            var totalmarks = 0;
            $.ajax({
                url: "<%=Page.ResolveUrl("/api/Exam/getEA_ExamCommentScoreMasterStudentIDExamID")%>",
                data: { 'StudentID': document.getElementById('hfStudentID').value, ExamID: document.getElementById('hfExamID').value },
                type: "GET",
                async: false,
                success: function (data) {
                     debugger;
                    var datavalue = $(data).find('string').text();

                    var Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue1") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue1").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue1").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue1").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue1").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue1").css({ "display": "none" });

                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue2") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue2").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue2").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue2").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue2").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue2").css({ "display": "none" });
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue3") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue3").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue3").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue3").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue3").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue3").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue4") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue4").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue4").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue4").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue4").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);

                    }
                    else {
                        $("#divCommentQue4").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue5") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue5").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue5").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue5").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue5").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue5").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue6") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue6").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue6").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue6").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue6").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue6").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue7") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue7").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue7").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue7").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue7").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue7").css({ "display": "none" });
                    }


                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue8") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue8").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue8").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue8").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue8").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue8").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue9") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue9").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue9").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue9").innerText = Row[0]["Comment"];
                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue9").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue9").css({ "display": "none" });
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue10") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue10").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue10").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue10").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue10").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue10").css({ "display": "none" });

                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue11") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue11").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue11").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue11").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue11").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue11").css({ "display": "none" });

                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue12") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue12").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue12").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue12").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue12").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue12").css({ "display": "none" });

                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue13") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue13").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue13").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue13").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue13").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue13").css({ "display": "none" });

                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue14") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue14").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue14").value = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue14").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue14").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue14").css({ "display": "none" });

                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtCommentQue15") return item });

                    if (Row.length > 0) {
                        document.getElementById("txtCommentQue15").value = Row[0]["Comment"];
                        document.getElementById("txtMarkQue15").innerText = Row[0]["ObtainScore"];
                        document.getElementById("divCommentQue15").innerText = Row[0]["Comment"];

                        if (Row[0]["Comment"] == "" || Row[0]["Comment"] == null) {
                            $("#divCommentQue15").css({ "display": "none" });

                        }
                        totalmarks = totalmarks + parseFloat(Row[0]["ObtainScore"]);
                    }
                    else {
                        $("#divCommentQue5").css({ "display": "none" });
                    }

                    document.getElementById("divTotalMarks").innerText = "Obtained Marks : " + totalmarks;

                    document.getElementById("divGrade").innerText = "Grade : " + calculateGrade(totalmarks);

                },
                error: function (x, e) {
                    alert('Response from database of answer error');
                }

            });
        }

    </script>

</head>
<body>
    <div class="row text-center">
        <div class="box-col" style="display: none">
            <h4>Select Page size</h4>
            <select id="paper" style="width: 100px;">
                <option value="size-a4" selected>A4</option>
                <option value="size-letter">Letter</option>
                <option value="size-executive">Executive</option>
            </select>
        </div>
        <div class="box-col">
            <button class="export-pdf k-button" onclick="getPDF('.pdf-page')">Download as PDF</button>
        </div>
    </div>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <asp:HiddenField ID="hfStaffID" runat="server" />
        <div id="load"></div>
        <div id="contents">
            <div class="pdf-page size-a4">
                <div class="container" ng-app="" runat="server" id="divAll">
                    <div class="row col-md-12 col-lg-12 ">
                        <div class="float-left col-md-6 col-lg-6">
                            <img src="../../Images/Logo/FS_Logo.png" /><br />
                        </div>
                        <div class="col-md-6 col-lg-6" style="text-align: end">
                            <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                            <br />
                            <asp:Label ID="lblGradeSection" runat="server" ClientIDMode="Static"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4 text-center">
                            <strong>
                                <asp:Label ID="lblExamSubject" Font-Bold="true" runat="server"></asp:Label></strong>
                        </div>
                        <div class="col-md-1"></div>
                        <div class="col-md-3">
                            <div class="row text-left">
                                
                                <div class="col-md-8" id="divTotalMarks">
                                </div>
                                <div class="col-md-4" id="divGrade"></div>

                            </div>
                        </div>
                    </div>
                    <div class="container">
                        <%--<h2>Carousel Example</h2>--%>
                        <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                            <!-- Indicators data-ride="carousel" -->

                            <!-- Wrapper for slides -->
                            <div class="carousel-inner">
                                <div id="divQuestion1">
                                    <div style="margin: 20px">
                                        <h3><b>Question - 1</b> (10 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">

                                            <div style="margin: 10px!important;" class="text-center">
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1a</b> (2 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    The diagram represents different perspectives on the issue of freedom of speech. Identify <b>one</b> source making a case in favour of limited freedom of speech 
                                           and <b>one</b> source in favour of unlimited freedom of speech. Type the name of the source from the items given below .<br />
                                                    <br />
                                                    <div class="row">
                                                        <div class="col-md-2"><b>Items List :- </b></div>
                                                        <div class="col-md-2" style="background-color: orange; color: white;">Source A</div>
                                                        <div class="col-md-2" style="background-color: deepskyblue; color: white">Source C</div>
                                                        <div class="col-md-2" style="background-color: lightgreen; color: white">Source B</div>
                                                        <div class="col-md-2" style="background-color: hotpink; color: white">Source D</div>
                                                        <div class="col-md-2" style="color: white"></div>
                                                    </div>
                                                    <br />
                                                    <div class="row">
                                                        <div class="col-md-6" style="padding: 10px!important">
                                                            <p style="background-color: lightseagreen; color: white; font-weight: bold" class="text-center">Limited freedom of speech</p>
                                                            <input type="text" runat="server" id="txtQuestion1" disabled="disabled" style="width: 100%" />
                                                        </div>
                                                        <div class="col-md-6" style="padding: 10px!important">
                                                            <p style="background-color: lightseagreen; color: white; font-weight: bold" class="text-center">Unlimited freedom of speech</p>
                                                            <input type="text" runat="server" disabled="disabled" id="txtQuestion2" style="width: 100%" />
                                                        </div>
                                                    </div>

                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue1" class="divComment">
                                                        </div>
                                                        <asp:TextBox ID="txtCommentQue1" placeholder="Enter comment for question 1 a" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" id="txtMarkQue1" maxlength="2" class="borderClas" style="width: 100%!important;" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue1','txtMarkQue1')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1b</b> (4 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>State </b>the origin and the purpose of Source A and Source C.<br />
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-6">
                                                        <h4><b>Source A</b>
                                                            <br />
                                                            Origin of Source A</h4>
                                                        <%--<div id="txtQuestion3" class="divAnswer" runat="server" style="background-color: #EBEBE4;" ></div>--%>
                                                        <asp:TextBox ID="txtQuestion3" runat="server" Enabled="false" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion3');" onfocusout="return StopAutoSaveTextBox('txtQuestion3');" Height="250px" Width="100%"></asp:TextBox>

                                                        <br />
                                                        <h4><b>Purpose of the source A </b></h4>
                                                        <asp:TextBox ID="txtQuestion4" runat="server" Enabled="false" TextMode="MultiLine" CssClass="divAnswer" Height="300px" Width="100%"></asp:TextBox>
                                                    </div>
                                                    <div class="col-lg-6">
                                                        <h4><b>Source C</b><br />
                                                            Origin of Source C
                                                        </h4>
                                                        <asp:TextBox ID="txtQuestion5" runat="server" Enabled="false" TextMode="MultiLine" CssClass="divAnswer" Height="250px" Width="100%"></asp:TextBox>
                                                        <br />
                                                        <h4><b>Purpose of the source C</b></h4>
                                                        <asp:TextBox ID="txtQuestion6" runat="server" Enabled="false" TextMode="MultiLine" CssClass="divAnswer" Height="300px" Width="100%"></asp:TextBox>
                                                    </div>

                                                </div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue2" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue2" placeholder="Enter comment for question 1 b" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue2" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue2','txtMarkQue2')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1c</b> (4 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>Justify</b> one limitation of Source C.
                                                </div>

                                                <div id="txtQuestion7" runat="server" class="divAnswer text-left" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue3" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue3" placeholder="Enter comment for question 1 c" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue3" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue3','txtMarkQue3')">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divQuestion2">

                                    <div style="margin: 20px;">
                                        <h3><b>Question - 2</b> (10 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2a</b> (4 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    The data from the nudge theory in <b>reference 3</b> can be represented in scatter plot in order to look for patterns and make predictions.<br />
                                                    <b>Construct</b> a scatter diagram to represent the percentage of monetary target achieved against the average size of donation. .
                                                </div>

                                                <div id="txtQuestion8" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>x axis label :</b>
                                                </div>

                                                <div id="txtQuestion9" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>y axis label :</b>

                                                </div>

                                                <div id="txtQuestion10" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue4" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue4" placeholder="Enter comment for question 2 a" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue4" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue4','txtMarkQue4')">Save</button>
                                                    </div>
                                                </div>
                                                <br />

                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2b</b> (1 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>State </b>the relationship between the percentage of monetary target achieved and the average size of donation.
                                                </div>

                                                <div id="txtQuestion11" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue5" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue5" placeholder="Enter comment for question 2 b" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue5" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue5','txtMarkQue5')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2c</b> (1 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>Estimate </b>the average size of the donation for 50 % of the target achieved.
                                            
                                                </div>

                                                <div id="txtQuestion12" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue6" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue6" placeholder="Enter comment for question 2 c" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue6" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue6','txtMarkQue6')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2d</b> (1 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>Suggest </b>a reason why you would not predict the size of the donation for 80 % of the target achieved.
                                                </div>

                                                <div id="txtQuestion13" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue7" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue7" placeholder="Enter comment for question 2 d" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue7" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue7','txtMarkQue7')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2e</b> (3marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    <b>Key concept: Relationships</b>
                                                    <br />
                                                    Relationships in MYP mathematics refers to the connections between quantities, properties or concepts and these connections may be expressed as models, 
                                            rules or statements.
                                            <br />
                                                    Relationships provide opportunities for students to explore patterns in the world around them. Connections between the student 
                                            and mathematics in the real world are important in developing deeper understanding.
                                            <br />
                                                    <br />
                                                    Source: International Baccalaureate Organization 2019 
                                            <br />
                                                    <br />
                                                    <b>Explain </b>why the key concept of relationships is important in nudge theory. In your answer, you must use <b>two</b> examples to support your answer.
                                                </div>

                                                <div id="txtQuestion14" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue8" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue8" placeholder="Enter comment for question 2 e" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue8" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue8','txtMarkQue8')">Save</button>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>

                                <div id="divQuestion3">
                                    <div style="margin: 20px">
                                        <h3><b>Question - 3</b> (8 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div class="CustomFontSize">
                                                    A local charity has decided to set up a crowdfunding page to raise some money. They are aware of nudge theory but are unsure which technique to use 
                                            to increase the amount of money they receive.<br />
                                                    <b>Create </b>a presentation to inform the local charity which nudge technique they should use and why. In your presentation, 
                                            you must include:
                                                <ul>
                                                    <li>an example from the pre-release material where this technique has been used </li>
                                                    <li>an explanation of how the selected technique works</li>
                                                    <li>data showing how this technique can increase donations.</li>
                                                </ul>
                                                    <br />
                                                    Use the drawing canvas to create your presentation and write an answer to explain how the selected technique works and why in the response box 
                                            below the canvas. 
                                            
                                                </div>

                                                <div id="txtQuestion15" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue9" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue9" placeholder="Enter comment for question 3" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue9" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue9','txtMarkQue9')">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div id="divQuestion4">

                                    <div style="margin: 20px">
                                        <h3><b>Question - 4</b> (12 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div>
                                                    <p class="CustomFontSize">
                                                        <b>Compare and contrast </b>the two social media feeds in reference 7. In your answer, you must: 
                                            <ul class="CustomFontSize">
                                                <li>refer to perspectives on refugees and legal aid support </li>
                                                <li>refer to the use of data and sources</li>
                                                <li>provide directly linked similarities and differences between the posts</li>
                                                <li>provide a conclusion. </li>
                                            </ul>
                                                    </p>
                                                </div>

                                                <div id="txtQuestion16" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue10" class="divComment"></div>

                                                        <asp:TextBox ID="txtCommentQue10" placeholder="Enter comment for question 4" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue10" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue10','txtMarkQue10')">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div id="divQuestion5">
                                    <div style="margin: 20px">
                                        <h3><b>Question - 5</b> (20 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 5a</b> (12 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">
                                                    You have decided to use crowdfunding to raise money for legal support for refugees. You should use information from the four references above to maximize 
                                            the impact of your crowdfunding page.
                                            <br />
                                                    <b>Create</b> a crowdfunding page to convince people to donate to your cause. In your answer you must: 
                                            <ul>
                                                <li>provide numerical and social reasoning</li>
                                                <li>refer to issues and solutions</li>
                                                <li>use techniques and information from the pre-release material.</li>

                                            </ul>
                                                    <br />
                                                    Use the drawing canvas to create your crowdfunding page and explain why people should donate to your cause in the response box below the canvas. 
                                            
                                                </div>
                                                <div id="txtQuestion17" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue11" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue11" placeholder="Enter comment for question 5 a" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue11" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue11','txtMarkQue11')">Save</button>
                                                    </div>
                                                </div>
                                                <br />
                                                <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                                    <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 5b</b> (8 marks)</span>
                                                </div>
                                                <br />
                                                <div class="CustomFontSize">

                                                    <b>Analyse</b> how you have integrated numerical and social reasoning to create an effective
                                             page. In your answer, you must refer to:
                                            <br />
                                                    <ul>
                                                        <li>examples of numerical reasoning you have used in your crowdfunding page</li>
                                                        <li>examples of social reasoning you have used in your crowdfunding page </li>
                                                        <li>evidence from the pre-release material to support your analysis.</li>
                                                    </ul>
                                                </div>

                                                <div id="txtQuestion18" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue12" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue12" placeholder="Enter comment for question 5 b" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue12" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue12','txtMarkQue12')">Save</button>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div id="divQuestion6">
                                    <div style="margin: 20px">
                                        <h3><b>Question - 6</b> (12 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div class="CustomFontSize">
                                                    <b>To what extent</b> can someone know the truth if they only receive their information from one source? In your answer, you must include: 
                                            <ul>
                                                <li>a justification of when it is appropriate to only use one source</li>
                                                <li>a justification of when it is not appropriate to only use one source </li>
                                                <li>evidence from the pre-release material to support your arguments </li>
                                                <li>a conclusion.</li>
                                            </ul>

                                                </div>
                                                <div id="txtQuestion19" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue13" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue13" placeholder="Enter comment for question 6" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue13" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue13','txtMarkQue13')">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divQuestion7">
                                    <div style="margin: 20px">
                                        <h3><b>Question - 7</b> (8 Marks)</h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div class="CustomFontSize">
                                                    <b>Evaluate</b> how freedom of speech is important to facilitate social change from your perspective. In your answer, you must include :
                                        <br />
                                                    <ul>
                                                        <li>strengths of freedom of speech </li>
                                                        <li>limitations of freedom of speech </li>
                                                        <li>an example from your “service as action” experience</li>
                                                        <li>a conclusion. </li>
                                                    </ul>

                                                </div>
                                                <div id="txtQuestion20" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                                <br />
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue14" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue14" placeholder="Enter comment for question 7" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue14" style="width: 100%!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue14','txtMarkQue14')">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divFinalComment">
                                    <div style="margin: 20px">
                                        <h3><b>Final Comment</b></h3>
                                        <div style="border-style: solid; border-width: 1px;">
                                            <div style="margin: 10px!important;">
                                                <div class="row">
                                                    <div class="col-md-11">
                                                        <div id="divCommentQue15" class="divComment"></div>
                                                        <asp:TextBox ID="txtCommentQue15" placeholder="Enter final Comment" CssClass="clsTxt" runat="server" TextMode="MultiLine" onkeyup="return resizeTextBox(this);"></asp:TextBox>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <input type="text" class="borderClas" maxlength="2" id="txtMarkQue15" value="0" style="width: 100%!important; display: none!important" placeholder="marks" onkeypress="return isNumber(event);" />
                                                        <button class="btnCustome" onclick="return SaveComment('txtCommentQue15','txtMarkQue15')">Save</button>
                                                        <%--<br />--%>
                                                        <%--<button class="btnCustome" onclick="return CalculateFinalMarks()">Result</button>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
