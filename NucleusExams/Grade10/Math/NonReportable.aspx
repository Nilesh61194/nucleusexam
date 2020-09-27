<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NonReportable.aspx.cs" Inherits="NucleusExams.Grade10.Math.NonReportable" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo Paper</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
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
    </style>
</head>
<body>
    <script>
        $(document).ready(function () {
            window.setInterval(function () {
                //debugger;
                SaveAnswerAllTime();
            }, 10000);
        });

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }

        function ResetTable() {
            var retVal = confirm("Are you sure you want to reset table value?");
            if (retVal == true) {
                var newValue = "<table class='telerik-reTable-4 reSelectDeleteTable' style='background-color: rgb(255, 255, 255); border: 0px solid; font-family: Tahoma; top: 266px; width: 1071px; height: 179px; opacity: 0.8;'><tbody>" +
                                "<tr class='telerik-reTableHeaderRow-4' style='border-width: 1pt 1pt 3pt; margin: 0in 0in 10pt; line-height: 16.8667px; font-size: 11pt; font-family: Calibri, sans-serif; width: 119.7pt; background: rgb(79, 129, 189);" +
                                "padding: 0in 5.4pt; color: rgb(255, 255, 255);'><td class='telerik-reTableHeaderFirstCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;" +
                                "<span style = 'font-weight: 700;' > Point </span></td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>x- axis</td>" +
                                "<td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp;y- axis</td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>" +
                                "x=1&nbsp;</td><td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>y=3&nbsp;&nbsp;</td><td class='telerik-reTableHeaderOddCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>" +
                                "y=x&nbsp;&nbsp;</td><td class='telerik-reTableHeaderEvenCol-4' style='padding: 0in 5.4pt; border-style: solid; text-align: center; vertical-align: top;'>&nbsp;y=-x</td></tr><tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102); " +
                                "font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                "<span style = 'font-weight: 700;' > (3,9)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4'" +
                                "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); " +
                                 "border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4'" +
                                 "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center;" +
                                 "vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center;" +
                                 "vertical-align: top;'><span style = 'font-weight: 700;' > (-2,7)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4'" +
                                 "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center;" +
                                 "vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt;" +
                                 "border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr>" +
                                 "<tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189);" +
                                 "border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (8,-11)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td>" +
                                 "<td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); " +
                                 "border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4'" +
                                 "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center;" +
                                 "vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                 "<span style = 'font-weight: 700;' > (-5,-4)&nbsp;</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                 "&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4'" +
                                 "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableOddRow-4' style='border-width: 1pt; color: rgb(102, 102, 102);" +
                                 "font-size: 10pt; vertical-align: top; border-bottom-style: solid; border-bottom-color: rgb(79, 129, 189);'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (0,0)</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt;" +
                                 "border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189);" +
                                 "border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                 "&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableEvenRow-4' style='color: rgb(102, 102, 102); font-size: 10pt; vertical-align: top;'><td class='telerik-reTableFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189);" +
                                 "border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (0,10)&nbsp;</span></td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189);" +
                                 "border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                 "&nbsp;</td><td class='telerik-reTableOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td></tr><tr class='telerik-reTableFooterRow-4'" +
                                 "style='color: rgb(53, 92, 140); font-size: 10pt; vertical-align: top; padding: 0in 5.4pt;'><td class='telerik-reTableFooterFirstCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><span style = 'font-weight: 700;' > (-12,0)</span></td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189);" +
                                 "border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>" +
                                 "&nbsp;</td><td class='telerik-reTableFooterEvenCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterOddCol-4' style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'>&nbsp;</td><td class='telerik-reTableFooterEvenCol-4'" +
                                 "style='padding: 0in 5.4pt; border-width: 1pt; border-color: rgb(79, 129, 189); border-style: solid; text-align: center; vertical-align: top;'><br></td></tr></tbody></table><br>";
                $find("<%=txtQuestion6.ClientID%>").set_html(newValue);
            } else {
                return false;
            }
        }


        function OpenWindow() {
            //Open the Popup window
            //Change the pagename here
            window.open('https://www.desmos.com/scientific', '_blank', 'height=450,width=500,scrollbars=0,location=1,toolbar=0,margin-left=50%');
            return false;
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
            args += "width=" + 900 + "," + "height=" + 850 + ","
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

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
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

        function SaveAnswerAllTime() {
            //debugger;

            var RadEditorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7",
                    "txtQuestion8", "txtQuestion9"];
            var i;
            for (i = 0; i <= RadEditorID.length - 1; i++) {
                var id = RadEditorID[i];
                var value = $telerik.findEditor("" + id + "").get_html();
                SaveAnswer(id, value);
            }

            //var CKEdiorID = ["txtQuestion10", "txtQuestion11", "txtQuestion12"];
            //var j;
            //for (j = 0; j <= CKEdiorID.length - 1; j++) {
            //    var id = CKEdiorID[j];
            //    var value = CKEDITOR.instances["" + id + ""].getData();
            //    SaveAnswer(id, value);
            //}
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
                    date2.setSeconds(date2.getSeconds() + 10);
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
                                <h3>Question - 1</h3>
                                <div style="border-style: solid; border-width: 1px;">

                                    <p style="margin: 10px!important;">
                                        <b>Draw</b> the following image by translating the shape to specified units.
                                    <br />
                                        a.  1 unit up, 7 unit left, 4 units down , 9 units right. <b>State</b> the rule using correct notation that you applied for transformation.<b> <a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">Click here</a></b>
                                        <br />
                                        <img src="Image/Maths_Q1_1.png" width="100%" />
                                    </p>

                                </div>

                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion1" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                                <br />
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            b.  Could the instructions be simplified so that transformation can be completed in fewer steps? <b>Explain.</b>
                                        </p>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion2" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                                <br />
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        c . <b>Write down</b> the translation using correct notation.
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion3" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                            </div>
                        </div>


                        <div class="item">

                            <div style="margin: 20px;">
                                <h3>Question - 2</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            Plot the shape with vertices (1,8), (-3, -5), (-4,7) an (-6,-2) Then plot the image of this shape after following
                                             transformation. (x,y) ------> (x-2, y-4) .<br />
                                            Also, <b>State</b> the coordinates of the image.  <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">Click here</a></b>
                                        </p>
                                    </div>
                                </div>
                                <div>
                                    <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion4" ExternalDialogsPath="~/RadEditorDialogs/">
                                        <Tools>
                                            <telerik:EditorToolGroup Tag="Formatting">
                                                <telerik:EditorTool Name="Underline" />
                                                <telerik:EditorTool Name="Bold" />
                                                <telerik:EditorTool Name="Italic" />
                                            </telerik:EditorToolGroup>
                                        </Tools>
                                    </telerik:RadEditor>
                                </div>
                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3>Question - 3</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            Given the translation (x, y) -----> (x-4, y+1), Find the preimage of the following image points                                                                 
                                        </p>
                                        <ol type="">
                                            <li>(5,9)</li>
                                            <li>(-2,0)</li>
                                        </ol>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion5" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3>Question - 4</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            <b>Write down</b> the reflection of each of the given points in the following reflection lines.
                                            <a onclick="return ResetTable()" style="font-weight: 100;" href="#">Reset</a>
                                            <%--<button id="btnResetTable" value="Reset" onclick="return ResetTable();" class="btn small "></button>--%>
                                        </p>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion6" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3>Question - 5</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            It seems that even superheroes love to use transformations to create their logos.
                                            <br />

                                            a. For each of the logo <b>describe</b>
                                            the transformation that each have been used to create it. 
                                        </p>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion7" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                                <br />

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            b. <b>Draw</b> reflection lines on the logos wherever appropriate. <b><a onclick="return VennWindow('VennDiagramImage.aspx');" href="#">Click here</a></b>
                                            <img src="Image/Maths_Q5.PNG" width="100%" height="130px" />
                                        </p>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion8" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                                <br />

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            c. The above logos are based on transformations. What is about transformations that is pleasing to look at? 
                                            How you can connect it with Global context. <b>Explain.</b>
                                        </p>
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion9" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                                <br />
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
                        <div class="col-lg-12 col-md-12">
                            <%--<b>Click on page number to navigate :</b>--%>
                            <ul class="ulNav">
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Page 1</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Page 2</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Page 3</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Page 4</a></li>
                                <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Page 5</a></li>
                                <li id="li6" class="liNav" data-target="#myCarousel" data-slide-to="5" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
                            </ul>
                        </div>
                    </div>

                    <%-- <ol>
                        <li data-target="#myCarousel" data-slide-to="0" class="active" onclick="return Top();"></li>
                        <li data-target="#myCarousel" data-slide-to="1" onclick="return Top();"></li>
                        <li data-target="#myCarousel" data-slide-to="2" onclick="return Top();"></li>
                        <li data-target="#myCarousel" data-slide-to="3" onclick="return Top();"></li>
                        <li data-target="#myCarousel" data-slide-to="4" onclick="return Top();"></li>
                        <li data-target="#myCarousel" data-slide-to="5" onclick="return Top();"></li>
                    </ol>--%>
                </div>
                <div id="divExamFinish" class="text-center" runat="server">
                    <strong>Your Exam is over
                    </strong>
                </div>
            </div>
        </div>
    </form>

</body>

</html>
