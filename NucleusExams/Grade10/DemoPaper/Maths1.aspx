<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maths1.aspx.cs" Inherits="NucleusExams.Grade10.DemoPaper.Maths1" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>Demo Paper</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../ckeditor4/ckeditor.js"></script>
    <style>
        .txtBlank {
            border-top: none;
            border-left: none;
            border-right: none;
            border-bottom: groove;
        }

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

        function OpenWindow() {
            //Open the Popup window
            //Change the pagename here
            window.open('https://www.desmos.com/scientific', '_blank', 'height=450,width=500,scrollbars=0,location=1,toolbar=0,margin-left=50%');
            return false;
        }

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        function SaveAnswerAllTime() {

            var TextBoxID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4"];
            var j;
            for (j = 0; j <= TextBoxID.length - 1; j++) {
                var id = TextBoxID[j];
                var value = document.getElementById(id).value;
                SaveAnswer(id, value);
            }

            var CKEdiorID = ["txtQuestion6", "txtQuestion7", "txtQuestion9", "txtQuestion10", "txtQuestion11", "txtQuestion13",
                "txtQuestion14", "txtQuestion15", "txtQuestion16"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var RadEditorID = ["txtQuestion5", "txtQuestion8", "txtQuestion12"];
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
                                <div class="text-center">
                                    <h3><b>Criterion A: Knowing and understanding</b></h3>
                                </div>
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 1 Write down</b>  the answers of the following blanks.<span class="pull-right">(Level 1-2)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <p style="margin: 10px!important; text-align: justify; font-size: larger">
                                        <ol type="a" class="CustomFontSize">
                                            <li>A letter is randomly taken from English alphabets.
                                                The probability that the letter taken is a consonant is
                                                <asp:TextBox ID="txtQuestion1" runat="server" CssClass="txtBlank" Width="250px"></asp:TextBox>.<br />
                                            </li>
                                            <li>Parallelogram has
                                                <asp:TextBox ID="txtQuestion2" runat="server" CssClass="txtBlank" Width="250px"></asp:TextBox>
                                                order of rotational symmetry.<br />
                                            </li>
                                            <li>A card is randomly chosen from a deck of cards.The probability that the card chosen is a king of red colour is
                                                <asp:TextBox ID="txtQuestion3" runat="server" CssClass="txtBlank" Width="200px"></asp:TextBox>.</li>
                                            <li>State the coordinates of centre of rotation that maps the object to its image in the diagram below.<asp:TextBox ID="txtQuestion4" runat="server" CssClass="txtBlank" Width="250px"></asp:TextBox>. <a href=""></a>
                                                <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">Click here</a></b>
                                            </li>
                                        </ol>
                                    </p>
                                    <div class="row text-center">
                                        <img src="Image/Question1.PNG" />
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="item">

                            <div style="margin: 20px;">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger; word-wrap: break-word;">
                                    <h4><b>&nbsp;Question - 2</b>  In a stable of 42 horses, 27 are thoroughbreds ( T ) and 16 are mares ( M ). 4 horses are both thoroughbred and mare. <span class="pull-right">(Level 3-4)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>a. Organise</b> the specified information in the Venn Diagram &nbsp;<b><a onclick="return VennWindow('ImageEditor.aspx');" href="#" style="color: black!important;">Click here</a></b>
                                        </div>

                                        <br />
                                        <div>
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
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>b. State</b>  the probability that a randomly selected horse from the stable is
                                        </div>
                                        <div>
                                            <p class="CustomFontSize" style="background-color: #9fd8fb;">i.) thoroughbred or a mare.</p>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                            <br />
                                            <p class="CustomFontSize" style="background-color: #9fd8fb;">ii.) thoroughbred but not a mare.</p>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 3</b> A jar consists of 21 sweets. 12 are white and 9 are yellow. William picked two sweets one after the other to eat. <span class="pull-right">(Level 5-6)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) <b>Draw </b>a tree diagram to represent the given information. &nbsp;<b><a onclick="return VennWindow('ImageEditor.aspx');" href="#" style="color: black!important;">Click here</a></b>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion8" ExternalDialogsPath="~/RadEditorDialogs/">
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
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>Find </b>the probability that one sweet is yellow and one sweet is white.
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            c) <b>Find </b>the probability that none of the sweet is yellow
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 4</b> Find the equation of the line that is perpendicular to y = 2x + 1 and passes through the point (1, 3) which is the intersecting point of both the lines. <span class="pull-right">(Level 7-8)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <div class="text-center">
                                    <h3><b>Criterion B: Investigating patterns</b></h3>
                                </div>
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 5</b> Nirkhi has got a $100 iTunes gift card for her birthday. She started buying songs costing $2 each using the gift card. Leftover amount in her gift card (y) after buying number of songs(x) is shown in the graph below.</h4>
                                </div>

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="text-center">
                                            <img src="Image/Question5.PNG" />
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) After observing the pattern, <b>plot</b> any two points in the above graph. &nbsp;<b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#" style="color: black!important;">Click here</a></b> <span class="pull-right">(Level 1-2)</span>
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
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>Construct</b> a table of values from the graph of all the plotted points. <span class="pull-right">(Level 3-4)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 6 </b><span class="pull-right">(Level 3-4)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) <b>Find</b> the vertex form of the following quadratic function. 
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>State</b> the axis of symmetry for both the functions.<br />
                                            <b>(i) f(x) = (x-1) (x-3)</b>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>(ii) g(x) = x2 + 12x + 32</b>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
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
                        <div class="col-lg-12 col-md-12" style="width: 140%!important">
                            <ul class="ulNav">
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Que 1</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Que 2</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Que 3</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Que 4</a></li>
                                <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Que 5</a></li>
                                <li id="li6" class="liNav" data-target="#myCarousel" data-slide-to="5" onclick="return Top();"><a href="#" class="liNavA">Que 6</a></li>
                                <li id="li7" class="liNav" data-target="#myCarousel" data-slide-to="6" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
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
