<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MathExt.aspx.cs" Inherits="NucleusExams.Grade10.Math.MathExt" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>Math Ext Grade 10</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../ckeditor4/ckeditor.js"></script>
    <style>
        .ulNav {
            list-style-type: none;
            margin: 0;
            overflow: hidden;
            background-color: #333333;
            width: 35%;
            margin-left: 20%;
        }

        .liNav {
            float: left;
        }

        .liNavA {
            display: block;
            color: white;
            text-align: center;
            padding: 5px;
            text-decoration: none;
        }

            .liNavA :hover {
                background-color: #111111;
            }

        .button {
            background-color: #A1D9F2 !important;
            color: white !important;
            border: none !important;
            box-shadow: none !important;
            font-size: 17px !important;
            font-weight: 600 !important;
            border-radius: 3px !important;
            padding: 0px 0px !important;
            cursor: pointer !important;
            margin: unset !important;
        }

        .CustomFontSize {
            text-align: justify;
            font-size: larger;
        }

        .CustomPTag {
            margin: 0px 50px 10px !important;
        }

        table, th, td {
            border: 1px solid black;
            text-align: center !important;
        }
    </style>

</head>
<body>
    <script>
        $(document).ready(function () {
            window.setInterval(function () {
                ///debugger;
                SaveAnswerAllTime();
            }, 10000);
        });

        function OpenWindow() {
            //Open the Popup window
            //Change the pagename here
            window.open('https://www.desmos.com/scientific', '_blank', 'height=450,width=500,scrollbars=0,location=1,toolbar=0,margin-left=50%');
            return false;
        }

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }


        // save fuction 
        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8",
                            "txtQuestion9", "txtQuestion10", "txtQuestion11", "txtQuestion15", "txtQuestion16",
                            "txtQuestion17", "txtQuestion18", "txtQuestion19", "txtQuestion20", "txtQuestion21", "txtQuestion22", "txtQuestion24",
                            "txtQuestion25", "txtQuestion26", "txtQuestion27", "txtQuestion29", "txtQuestion30"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var RadEditorID = ["txtQuestion12", "txtQuestion13", "txtQuestion14", "txtQuestion23", "txtQuestion28"];
            var k;
            for (k = 0; k <= RadEditorID.length - 1; k++) {
                var id = RadEditorID[k];
                var value = $telerik.findEditor("" + id + "").get_html();
                SaveAnswer(id, value);
            }
        }

        function allanswersave() {
            SaveAnswerAllTime();
        }

        function SaveAnswer(ControlID, value) {
            // debugger;
            var EAM = {};
            EAM.StudentID = document.getElementById('<%= hfStudentID.ClientID%>').value;
            EAM.ExamID = document.getElementById('<%= hfExamID.ClientID%>').value;
            EAM.QID = ControlID;
            EAM.Answer = value;
            $.ajax({
                url: "<%=Page.ResolveUrl("/api/Exam/insertEA_ExamAnswerMaster")%>",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(EAM),
                dataType: "json",
                success: function (response) {

                    if (response) {
                        //alert("save");
                    }
                    else {
                        alert("Exam is not Save ...!");
                    }
                },

                error: function (x, e) {
                    console(x.responseText);
                    alert('Please refresh the page.');
                    //alert(x.responseText);
                    //alert(x.status);

                }
            });
        }


        function addZero(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }

        function startQuestionTimer() {
            debugger;
            var currentTime = '<%= Session["ExamTimer"] %>';
            setInterval(function () {
                if (currentTime != "") {

                    var date1 = new Date(currentTime);
                    var date2 = new Date();
                    date2.setSeconds(date2.getSeconds() + 30);
                    //console.log("starttime : =" + currentTime + "CurrentTime : =" + date2);
                    var diff = new Date(date2 - date1);
                    var hour = addZero(diff.getUTCHours());
                    var min = addZero(diff.getUTCMinutes());
                    var sec = addZero(diff.getUTCSeconds());
                    var duration = document.getElementById("hfTotalDuration").value;
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


        function VennWindow(PageLink) {
            //Open the Popup window
            //Change the pagename here
            xposition = 0; yposition = 0;
            if ((parseInt(navigator.appVersion) >= 4)) {
                xposition = (screen.width - 750);
                yposition = (screen.height - 550);
            }

            var args = "";
            args += "width=" + 750 + "," + "height=" + 600 + ","
            + "location=0,"
            + "menubar=0,"
            + "resizable=0,"
            + "scrollbars=0,"
            + "statusbar=false,dependent,alwaysraised,"
            + "status=false,"
            + "titlebar=no,"
            + "toolbar=0,"
            + "hotkeys=0,"
            + "screenx=" + xposition + ","  //NN Only
            + "screeny=" + yposition + ","  //NN Only
            + "left=" + xposition + ","     //IE Only
            + "top=" + yposition;           //IE Only

            window.open(PageLink, '_blank', args);
            return false;
        }

        function FinishExam() {
            var retVal = confirm("Are you sure you want to finish the exam?");
            if (retVal == true) {
                SaveAnswerAllTime();
                document.getElementById('<%= btnFinish.ClientID %>').click();
            } else {
                return false;
            }
        }


        function SetTableQ1() {
            var newValue = "<table align='center' border='2' cellpadding='1' cellspacing='1'><thead><tr><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-3b10dc5b-7fff-32dd-9258-c7ee178a716c'>Star</b></th><th scope='col'><p dir='ltr'><b id='docs-internal-guid-667fc1eb-7fff-4baf-1117-adf51e1decf5'>Distance from Sun</b></p></th><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-cfda2c75-7fff-9879-ad40-e1b5f380f702'>x-coordinate</b></th><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-82a1167c-7fff-c753-5373-dd64b6f89703'>y-coordinate</b></th><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-1e0e0ef0-7fff-e435-c69f-a7814bdc9089'>z-coordinate</b></th><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-e354d3fb-7fff-18ce-991f-3832b93cde77'>Distance from Polaris</b></th></tr></thead><tbody><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-420a0d98-7fff-3a68-642b-a4da7dd17e92'>Sun</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-3919c02a-7fff-d8c1-b313-3f4351bd7f8a'>0.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-3919c02a-7fff-d8c1-b313-3f4351bd7f8a'>0.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-de4a33d8-7fff-1096-cb36-dc1514d2efa6'>0.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-c8ac9520-7fff-f3b6-bc30-3bcf754cc306'>0.0</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-d089226f-7fff-67f7-9b27-db06d771db42'>Sirius</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-4bce42fa-7fff-0cab-43de-17cb76e81ead'>-3.4</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-477b3c11-7fff-274c-1108-64d09a6f2812'>-3.1</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-30a2e11c-7fff-0dae-f8e4-3f9af40c96f0'>7.3</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-b2e7596f-7fff-8127-45bf-ce7aac23f1c7'>Alpha Centauri</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-db9431db-7fff-25c0-a9bc-9bc4649881b1'>-1.8</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-2295bc21-7fff-3a48-d049-171c0434d38a'>0.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-e70d5d47-7fff-1d87-c825-c072bc8e5b71'>3.9</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-4cfab2ba-7fff-98fc-c0a1-af33fe8c73ae'>Wolf 359</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-d3e90fb5-7fff-3bc9-2708-e6b3728885ad'>4.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-02ab583c-7fff-4fb9-0a1f-f5b62661131d'>4.3</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-300c7ac9-7fff-321c-9bb3-835a3a1be63e'>5.1</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-c37e34c2-7fff-aae6-577b-6fb0a0c61fd8'>Procyon</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-c74b1f76-7fff-6404-1cf2-5dcbfff223fd'>-0.9</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-29a19cc6-7fff-64e6-8006-00db7ba78274'>5.6</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-a6d2c102-7fff-46c5-6d35-36cbeefc3e21'>-9.9</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-d2e14ff5-7fff-cd47-1682-d0e616e0b336'>Polaris</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-49c401ea-7fff-7f3f-5920-c1c5dece2b5b'>99.6</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-1ca5b01e-7fff-8066-8251-e463635351f6'>28.2</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-645db42a-7fff-5c02-c293-fa7007339056'>376.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-8e3b8313-7fff-d94e-f9e8-e8fd26471dc1'>0.0</b></td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-e18706ff-7fff-e7bb-c951-eb12c8e9e7ac'>Arcturus</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-006d8519-7fff-96a7-6f14-ad6d082c3078'>32.8</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-3e2065a4-7fff-92c5-402f-d4f0ad200e91'>9.1</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-bc1c25fb-7fff-78a5-8c6c-dcdc80d771f5'>11.8</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-17aedff2-7fff-07af-087c-4d6a9192a58a'>Tau Ceti</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-5ec4323a-7fff-aa8e-58bd-22730cc411e6'>-6.9</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-229015d4-7fff-aae9-04d9-8ad757e68b65'>-8.6</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-9e6e128f-7fff-9447-a673-6fd931a97eb9'>2.5</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-445bb256-7fff-1f78-ba72-070ba8405be0'>HD 209458</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-d68092ca-7fff-c0a5-5e03-a76b267081d3'>-94.1</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-67d6097d-7fff-c19c-c9f1-2e68b5496043'>-120.5</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-e609e8aa-7fff-ae52-0a70-b29627cf877f'>5.2</b></td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-e680ab82-7fff-3bab-d785-3da010a67255'>Zubenelgenubi</b></td><td>&nbsp;</td><td><meta charset='utf-8' /><b id='docs-internal-guid-ae3ab23a-7fff-f85b-e99b-616a0cb2ed18'>64.6</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-36e93360-7fff-da35-999d-58ae8ccf04ee'>-22.0</b></td><td><meta charset='utf-8' /><b id='docs-internal-guid-a96ff28c-7fff-c17f-3592-fa4a03101a66'>23.0</b></td><td>&nbsp;</td></tr></tbody></table>";
            CKEDITOR.instances['txtQuestion1'].setData(newValue)
        }

        function TableResetQ1() {
            var retVal = confirm("Are you sure you want to reset table  ?");
            if (retVal == true) {
                SetTableQ1();
            }
            else {
                return false;
            }
        }
        function SetTableQ8() {
            var newValue = "<p align='center'><b>Table 1</b><p><table align='center' border='2' cellpadding='1' cellspacing='1' style='width: 800px;'><tbody><tr><td><meta charset='utf-8' /><p dir='ltr'><b id='docs-internal-guid-2b3328a5-7fff-f95f-5dd9-853302f09e92'>Pattern finishes with&nbsp;</b><b id='docs-internal-guid-2b3328a5-7fff-f95f-5dd9-853302f09e92'>(n)</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-2072b17d-7fff-2897-14af-50c5ed5dcfc8'>Number of white tiles along </b><b>one side</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-38f6fb3c-7fff-4ea7-70fd-4d374221d986'>Number of white tiles in border</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-53f32b0d-7fff-761e-ce70-192ef16211ab'>Total number of white tiles in pattern</b></p></td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-5c17ae73-7fff-27c1-e735-4d5c3a22a531'>1st white border</b></td><td>3</td><td>8</td><td>8</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-217a9d37-7fff-4291-dfb7-721dd7c92773'>2nd white border</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td><meta charset='utf-8' /><b id='docs-internal-guid-dbad4a77-7fff-5a77-1d3a-2440b699fdb1'>3rd white border</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table>";
            CKEDITOR.instances['txtQuestion15'].setData(newValue)
        }

        function TableResetQ8() {
            var retVal = confirm("Are you sure you want to reset table  ?");
            if (retVal == true) {
                SetTableQ8();
            }
            else {
                return false;
            }
        }


        function SetTableQ9() {
            var newValue = "<p align='center'><b>Table 2</b><p><table align='center' border='2' cellpadding='1' cellspacing='1' style='width: 800px;'><tbody><tr><td><meta charset='utf-8' /><p dir='ltr'><b id='docs-internal-guid-2b3328a5-7fff-f95f-5dd9-853302f09e92'>Pattern finishes with&nbsp;</b><b id='docs-internal-guid-2b3328a5-7fff-f95f-5dd9-853302f09e92'>(n)</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-2072b17d-7fff-2897-14af-50c5ed5dcfc8'>Number of white tiles along </b><b>one side</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-38f6fb3c-7fff-4ea7-70fd-4d374221d986'>Number of white tiles in border</b></p></td><td><p dir='ltr'><b id='docs-internal-guid-53f32b0d-7fff-761e-ce70-192ef16211ab'>Total number of white tiles in pattern</b></p></td></tr><tr><td><b id='docs-internal-guid-5c17ae73-7fff-27c1-e735-4d5c3a22a531'>4th white border</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td><b id='docs-internal-guid-217a9d37-7fff-4291-dfb7-721dd7c92773'>5th white border</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table>";
            CKEDITOR.instances['txtQuestion16'].setData(newValue)
        }


        function TableResetQ9() {
            var retVal = confirm("Are you sure you want to reset table  ?");
            if (retVal == true) {
                SetTableQ9();
            }
            else {
                return false;
            }
        }


    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <asp:HiddenField ID="hfTotalDuration" runat="server" />
        <div class="container" ng-app="" runat="server" id="divAll">
            <div class="row col-md-12 col-lg-12 ">
                <div class="float-left col-md-6 col-lg-6">
                    <img src="../../Images/Logo/FS_Logo.png" /><br />

                </div>
                <div class="col-md-6 col-lg-6" style="text-align: end">
                    <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="lblTimer" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
            <div id="div1" class="text-center" runat="server">
                <strong>
                    <asp:Label ID="lblGradeSubjectName" Font-Bold="true" runat="server"></asp:Label></strong>
            </div>
            <div id="divTools" class="text-right">
                <a class="fa fa-calculator fa-2x" onclick="return OpenWindow();" href="#"></a>
            </div>
            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
                <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                    <!-- Indicators data-ride="carousel" -->

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <div style="margin: 20px">
                                <h3><b>Criterion A</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>1. Stars are spread out through space at many different distances from our own Sun and from each other in a 3-dimensional Cartesian system 
                                                with their respective coordinates given in the table below.Our own Sun is at the origin of this coordinate system, and all distances are given
                                                 in light-years.</span>
                                            <span style="float: right!important">(Level 1-2)</span>
                                            <br />
                                            <br />
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>State</b> the distances of each of these stars from the Sun in light-years to complete the 1st column in the table below.</span>
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. You moved to the North Star, Polaris. <b>State</b> the distances of each of these stars from Polaris in light-years to complete the 2nd column in the table below</span> <u><b><a onclick="return TableResetQ1()" href="#">Reset Table</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c. <b>Identify</b> the closest star to Polaris.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>2. Fractals are geometric constructions that are self-similar. This means that any part of a fractal looks like the overall fractal. Most fractals can be generated by repeating a simple set of rules.<br />
                                                <br />
                                                For example, the figures alongside show a fractal called as Sierpinski’s triangle.
                                            </span>
                                            <span style="float: right!important">(Level 3-4)</span>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-md-6" style="padding: 50px;">
                                                <img src="Image/Q2.2.png" width="90%" /><br />
                                                Figure 1 
                                            </div>
                                            <div class="col-md-6" style="padding: 50px;">
                                                <img src="Image/Q2.1.png" width="90%" /><br />
                                                Figure 2
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. Describe the transformation that maps &#9651;OAE onto &#9651;ECD and &#9651;ABC</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Describe</b> the transformation that maps &#9651; OBD onto &#9651; OAE</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c. <b>Describe</b> the transformation that maps &#9651; OBD onto &#9651; ECD and &#9651; ABC</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>d. <b>Find</b> the coordinates of the image of all the vertices of Figure 2 when it undergoes a rotation about E through -(3π/2).</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>e. <b>Describe</b> the transformation that maps &#9651; ABC onto &#9651; AEC</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>3. The two functions shown on the graph are f(x)=x<sup>2</sup>  and  g(x)=5(x-2)<sup>2</sup></span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Level 5-6)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q3.png" />
                                            <br />
                                            The graph of g(x) can be obtained from the graph of f(x) using two transformations.
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>Describe</b> each of the two transformations.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <p>
                                                The graph of g(x) is translated by a vector
                                            <img src="Image/Q3A.PNG" />
                                                to give the graph of h(x).
                                                <br />
                                                The point P(1,1) and Q(-2,4) on the graph of f(x) is translated onto the point P’ and Q’ on the graph of h(x)
                                            </p>
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Organize</b> the information in a logical structure to <b>calculate</b> the coordinates of the point P’ and Q’.</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>4. PQRS is a parallelogram. The point T divides the line PQ in the ratio 1:3, and U, V, and W are the midpoints of SR, PS, and QR respectively.<br />
                                            </span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Level 7-8)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q4A.PNG" /><br />
                                            <br />
                                            <img src="Image/Q4.png" />
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>Organize</b> the information in a logical structure to find
                                            <img src="Image/Q4B.PNG" />
                                                in terms of a and b</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Show that
                                            <img src="Image/Q4C.PNG" />
                                                = 0.5(5a + 2b)</b></span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Criterion B</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>This question looks at the number of grey tiles and the number of white tiles in a sequence of square patterns.<br />
                                                All the tiles are the same size and each is a square.<br />
                                                The grey tiles and white tiles make borders around a single grey tile.<br />
                                                The single grey tile is the first grey border.<br />
                                                The first white border is 8 white tiles surrounding the grey tile.<br />
                                                The second grey border is 16 grey tiles surrounding the 8 white tiles.<br />
                                                <br />
                                                <div class="text-center">
                                                    <img src="Image/Q5.1.png" />
                                                </div>
                                                <br />
                                                5. On the grid given, complete the diagram to <b>construct</b> the second white border. 
                                                <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                            </span>

                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion12" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>6. On the grid given, complete the diagram to <b>construct</b> the third grey border.</span>
                                            <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion13" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>7. On the grid given, complete the diagram to <b>construct</b> the third white border.</span>
                                            <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion14" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>8. <b>Use</b> your answers to previous questions to <b>state</b> the missing values in the table for the patterns that finish with a white border.</span> <u><b><a onclick="return TableResetQ8()" href="#">Reset Table</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>9. <b>Predict</b> the missing numbers and write down in the table.</span> <u><b><a onclick="return TableResetQ9()" href="#">Reset Table</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>10. <b>Describe</b> in your own words, three patterns you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>Derive</b> as a general rule the three patterns you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>12. <b>Verify</b> your general rules you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>13. <b>Justify</b> your general rules for the predicted values in table 2.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion20.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>14. <b>Explain</b> the general rule to find the total number of grey tiles in any pattern, n, that finishes with the white border through lines of reasoning that are complete, coherent and concise.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion21.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Criterion D</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>A committee wants to conduct a rowing championship competition in the city of Aberdeen in the month of January 2019.<br />
                                                You need to advise the committee on the appropriate time to conduct the race.<br />
                                                Following is the image from the rule book of International Rowing Federation(FISA):<br />
                                            </span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/CB1.png" />
                                            <br />
                                            <img src="Image/CB2.png" />
                                            <br />
                                            Source: http://www.worldrowing.com/uploads/files/Appendix_1_-_Courses_Bye-Laws.pdf
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>The heights of water in Aberdeen were measured every two hours on 1st January 2019.
                                                <br />
                                                <br />
                                                The high and low tides on that day were also recorded along with it. All the data is shown in the tables below, which is rounded up to 2 decimal places.</span>
                                            <br />
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 20%">Time(hours after midnight)</td>
                                                    <td style="width: 9%">0</td>
                                                    <td style="width: 9%">2</td>
                                                    <td style="width: 9%">3</td>
                                                    <td style="width: 9%">4</td>
                                                    <td style="width: 9%">6</td>
                                                    <td style="width: 9%">8</td>
                                                    <td style="width: 9%">9</td>
                                                    <td style="width: 9%">10</td>
                                                    <td style="width: 9%">12</td>
                                                </tr>
                                                <tr>
                                                    <td>Height(m)</td>
                                                    <td>2.45</td>
                                                    <td>3.88</td>
                                                    <td>4.10</td>
                                                    <td>3.84</td>
                                                    <td>2.45</td>
                                                    <td>1.00</td>
                                                    <td>0.80</td>
                                                    <td>1.02</td>
                                                    <td>2.45</td>
                                                </tr>
                                                <tr>
                                                    <td>Time(hours after midnight)</td>
                                                    <td>14</td>
                                                    <td>15</td>
                                                    <td>16</td>
                                                    <td>18</td>
                                                    <td>20</td>
                                                    <td>21</td>
                                                    <td>22</td>
                                                    <td>24</td>
                                                    <td>-</td>
                                                </tr>
                                                <tr>
                                                    <td>Height(m)</td>
                                                    <td>3.88</td>
                                                    <td>4.1</td>
                                                    <td>3.84</td>
                                                    <td>2.45</td>
                                                    <td>1.00</td>
                                                    <td>0.80</td>
                                                    <td>1.02</td>
                                                    <td>2.44</td>
                                                    <td>-</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>15. <b>Identify</b> the relevant elements that you need to take into consideration to model the height of water against time.
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion22.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>16. <b>Plot</b> the data sets on the graphing tool.</span>
                                            <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion23" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">17. <b>Identify</b> the appropriate principal axis of your graph.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion24" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion24.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">18. <b>Select and apply</b> an appropriate mathematical strategy to <b>derive</b> the model of the height of water against time. </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion25" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion25.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>19. <b>Write down</b> the range of your model.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion26" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion26.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>20. <b>Estimate</b> the height of the water at 06:30.</span>
                                            <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion27" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion27.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>21. <b>Suggest</b> the committee by estimating the appropriate time to conduct the race.</span>
                                            <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion28" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>22. <b>Justify</b> the factors that have influenced the degree of accuracy of your estimated appropriate time to conduct the race.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion29" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion29.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>23. <b>Justify</b> if your solution to the estimated appropriate time to conduct the race is reliable in a real-life context.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion30" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion30.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">
                            <div class="row">
                                <div class="col-lg-12 text-center">
                                    <h3><b>Are you sure you want to finish the exam?</b>
                                        <br />
                                        <br />
                                        Click on finish button to finish exam.
                                    </h3>
                                    <input type="button" id="btnMainFinish" onclick="FinishExam();" value="Finish Exam" class="btn btn-info" />
                                    <asp:Button ID="btnFinish" runat="server" OnClick="btnFinish_Click" Style="display: none;" />
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row" style="align-content: center;">
                        <div class="col-lg-5"></div>
                        <!-- Left and right controls -->
                        <div class="col-lg-1">
                            <a class="left" href="#myCarousel" data-slide="prev">
                                <span onclick="return Top();" class="glyphicon glyphicon-chevron-left"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </div>
                        <div class="col-lg-1">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="right" href="#myCarousel" data-slide="next">
                            <span onclick="return Top();" class="glyphicon glyphicon-chevron-right"></span>
                            <span class="sr-only">Next</span>
                        </a>
                        </div>
                        <div class="col-lg-5"></div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12" style="width: 120%!important">
                            <ul class="ulNav">
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Criterion A</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Criterion B</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Criterion D</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
            <div id="divExamFinish" class="text-center" runat="server">
                <strong>Your Exam is over
                </strong>
            </div>
        </div>
    </form>
</body>
</html>
