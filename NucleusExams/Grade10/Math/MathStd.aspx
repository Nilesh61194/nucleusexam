﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MathStd.aspx.cs" Inherits="NucleusExams.Grade10.Math.MathStd" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Math Std Grade 10</title>
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
            alert(msg);
        }

        function SetTable() {
            var newValue = "<table align='center' border='2' cellpadding='1' cellspacing='1' style='width: 700px;'><thead><tr><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-c7680510-7fff-8951-703d-f6ef63ff3841'>Depth of water ( in metres)</b></th><th scope='col'><meta charset='utf-8' /><b id='docs-internal-guid-5c740c95-7fff-a63b-7487-53b7550790b6'>Light Intensity (in lux)</b></th></tr></thead><tbody><tr><td>&nbsp;1</td><td>&nbsp;937.5</td></tr><tr><td>&nbsp;2</td><td>&nbsp;840.75</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table>";
            CKEDITOR.instances['txtQuestion16'].setData(newValue)
        }

        // save fuction 
        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8",
                            "txtQuestion10", "txtQuestion11", "txtQuestion12", "txtQuestion13", "txtQuestion14", "txtQuestion15", "txtQuestion16",
                            "txtQuestion17", "txtQuestion18", "txtQuestion19", "txtQuestion20", "txtQuestion21", "txtQuestion22", "txtQuestion23", "txtQuestion24",
                            "txtQuestion25"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var RadEditorID = ["txtQuestion4", "txtQuestion9"];
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

        function TableReset()
        {
            var retVal = confirm("Are you sure you want to reset table  ?");
            if (retVal == true) {
                SetTable();
            }
            else
            {
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
                                <h3><b>Criterion A and Criterion C</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>1. We can transform figures using coordinate rules. Complete this pattern created by Rahul for his new design of tshirt. <b>Write down</b> the inputs for the printing machine using mathematical language(as accepted by the machine)</span>
                                            <span style="float: right!important">(A - level 1-2)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q1.png" /><br />
                                            <b>Source:</b>
                                            https://teacher.desmos.com/activitybuilder/custom/589a31ddda95a7a50509daa5
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>2. <b>Find</b> the scale factor of the enlargement with centre at the origin if the image of point T(6,-18) is T’ (2,-6).</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(A - level 3-4)                                                </span>
                                        </div>

                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>3. The triangle with vertices A(-1, 2), B(-4, 2), C (-3,0) has been rotated -90&deg; through point D (3,2). </span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(A - level 3-4)</span>
                                            <br />
                                            a. <b>Construct</b> a table of values to rotate the figure through centre of rotation
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>3. b.<b> Draw</b> the Object and Image.</span>
                                            <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">GeoGebra</a></b>
                                            <span style="float: right!important; background-color: #9fd8fb;">(C -strand 3)</span>
                                        </div>
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None"
                                                RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                                EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion4" ExternalDialogsPath="~/RadEditorDialogs/">
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
                                            <span>4.  Let the function be  f(x)=x<sup>2</sup> + 4 , <b>Find</b>
                                                <br />
                                                a. f(2x) </span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(C -strand 3)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>4. b. 3f(x)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>5. <b>Describe</b> the transformation done to the function y=2<sup>x+1</sup>  if the original function was y=2<sup>x</sup> using appropriate mathematical terminology and form</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(C - strand 1 and 2)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>6. If the function  f(x)=x<sup>2</sup> + 8x + 10 has been translated vertically upward by 5 units and then  reflected over y-axis. <b>Find</b> the new function.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(A - Level 5-6)</span>
                                        </div>
                                        <br />
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>7. <b>Show</b> all the steps required using logical structure to <b>find</b> the COR of the transformation done to the object ABCD to form an image A’B’C’D’. <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">GeoGebra</a></b></span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(C - Level (v))</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q7.png" />
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None"
                                                RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                                EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion9" ExternalDialogsPath="~/RadEditorDialogs/">
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
                                            <span>8. Consider the function f(x)=4x<sup>2</sup> - 8x + 3:
                                                <br />
                                                a. <b>Describe</b> fully the single transformation that maps the graph of y=f(x) onto the graph of y=f(x-1)
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>8. b.<b> Write down</b> the equation of the line of symmetry of y=2f(x).</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>8. c. <b>Write down</b> the range of the function for the values 0.5 &#8804; x &#8804;1.5</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(A  Level 5-6, c strand 1)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>8. d.  <b>Find</b> the value of k. If f(2x-3) = 16x<sup>2</sup> - kx +63</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(A - Level 7-8)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>9.  A model  in the shape of a right circular cone has a height of 8 cm and base radius of 6 cm. It took approximately 302 cm<sup>3</sup> of a material to 
                                                completely fill the model. The investor claims that since the actual object will be enlarged by a scale factor of 250, the material required
                                                 would be approximately 4.71 x 10<sup>9</sup> cm<sup>3</sup> . Is the investor correct?. <b>Explain</b> using coherent mathematical lines of reasoning.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion C - strand 4)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>10.  Consider the function f(x)= 2sin(3x) + 4. <b>Write down</b>  the mathematical terminologies for the value of 2, 3 and 4 in the given function. (features of the trigonometric function) 
                                            </span>
                                            <span style="float: right!important; background-color: #9fd8fb;"></span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
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
                                            <span>11. The Neistat brothers are doing an experiment to understand the behaviour of light and its intensity in water. 
                                                From their study it is found that the intensity of natural light decreases as it passes through water. The intensity at a depth ‘x’ 
                                                metres from the surface of water varies.
                                            </span>
                                            <br />
                                            <div class="text-center">
                                                <img src="Image/Q11.png" /><br />
                                                (Image showing the intensity of light in water)     (image source: https://bit.ly/2KRtqPt)
                                            </div>
                                            <br />
                                            <span>The unit to measure light intensity is ‘lux’. (1 lux = 1 lumen / sq. meter) 
                                                <br />
                                                On an overcast day, the light intensity is 1075 lux in the chamber where the Neistat brothers are doing the experiment. They have a
                                                 transparent water tank of 20 metres height to take readings through it. 
                                                    <br />
                                                It was observed that as the depth of water increases, light intensity (or illumination) decreases by 10% with increase in depth. 
                                                Apart from this, the moment the light enters the medium of water, light intensity decreases by 30 lux by default at any given depth.
                                                <br />
                                                <br />
                                                (<b>Recommended light levels : source</b> - <a href="https://bit.ly/2hOv8CH" target="_blank">https://bit.ly/2hOv8CH</a>)

                                            </span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>a)  Write down</b> the answers to complete the table given below.</span> <u><b><a onclick="return TableReset()" href="#">Reset Table</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>b)  Describe</b> the relationship between the depth of water and the intensity of light.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>c)  Find</b> a general rule for the relationship between the depth of water and the intensity of light. (strand ii)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>d) Verify</b> the general rule for the relationship between the depth of water and the intensity of light.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>e) Justify</b>  the general rule for the relationship between the depth of water and the intensity of light.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion20.ClientID%>');</script>
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
                                            <span>The periodical rise and fall of the sea level, once or twice a day, mainly due to the attraction of the sun and the moon, is called a tide. The study of tides 
                                                is very complex, spatially and temporally, as it has great variations in frequency, magnitude and height. The moon’s gravitational pull to a great extent and to 
                                                a lesser extent the sun’s gravitational pull, are the major causes for the occurrence of tides. Another factor is centrifugal force which acts opposite to
                                                 gravitational pull of earth. Tides occur due to a balance between all these forces.
                                                <br />
                                                <br />
                                                (<b>Source:</b> <a href="https://bit.ly/2Ha6HMv" target="_blank">https://bit.ly/2Ha6HMv)</a></span>
                                            <br />
                                            <div class="text-center">
                                                <img src="Image/Q12.png" />
                                                <br />
                                                (Source : https://bit.ly/2KORAsR )
                                            </div>
                                            <br />

                                            <span>The National Oceanic and Atmospheric Administration (NOAA) is a government agency (United States Department of Commerce) which focuses on the
                                                 conditions of oceans, major waterways and the atmosphere.<br />

                                                According to the data of NOAA Tide Predictions , you are trying to model a function which correctly provides the 
                                                height of tides around the harbour located in Honolulu, Hawaii, USA. The height of water in the harbour is 3.5 m at high tide and 12 hours 
                                                later at low tide it is 0.5 m. The graph below shows how the height of water changes with time over 24 hours.
                                            </span>
                                            <br />
                                            <div class="text-center">
                                                <img src="Image/Q12.1.png" />
                                            </div>
                                            <br />
                                            <span><b>12. a) Identify</b> the relevant elements which affects the tidal height near the harbour.
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion21.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>12. b) Select</b> and <b>apply</b> a mathematical strategy to model a function which correctly gives the height of tides at the harbour. 
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion22.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span><b>12. c) Find</b> the tidal height at 3 AM. </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion23" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion23.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize"><b>12. d) Justify</b> the degree of accuracy of your solution in the previous question.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion24" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion24.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize"><b>12. e)</b> According to you, the model developed here correctly predicts the tidal height. <b>Justify</b> whether it makes
                                                 sense or not in real life to predict the tidal heights based on the modelled function. You can use the link provided here to find out more 
                                                about the measurements of tidal height. </span>
                                            <br />
                                            ( <b>Link :</b> <a href="https://bit.ly/2z0K3lc" target="_blank">Tide Predictions</a> )
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion25" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion25.ClientID%>');</script>
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
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Criterion A and Criterion C</a></li>
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
