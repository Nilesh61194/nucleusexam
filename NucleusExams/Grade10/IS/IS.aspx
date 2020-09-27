<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IS.aspx.cs" Inherits="NucleusExams.Grade10.IS.IS" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IS Grade 10</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />--%>
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
        }
    </style>
</head>
<body>
    <script>

        var myVar;

        function CheckNet() {
            //debugger;
            var ifConnected = window.navigator.onLine;
            if (ifConnected) {
                console.log('Connection available');
            } else {
                StopSave();
                alert('Your wi-fi connection is lost.\nPlease check your wi-fi connection. \nRe-login in new tab.');
            }
        }


        function startAutoSave(id) {
            //  debugger;
            myVar = setInterval(function () { callSave(id); }, 10000);

        }

        function StopSave() {
            console.log('Internat is not available');
            clearInterval(myVar);
        }

        function StopAutoSave(id) {
            //debugger;
            if (id != null) {
                callSave(id);
                console.log('Saved stop ' + id);
                clearInterval(myVar);
            }
        }


        $(document).ready(function () {
            window.setInterval(function () {
                CheckNet();

            }, 20000);
        });

        function callSave(control) {
            var id = control;
            var value = $('#' + id).val(); //document.getElementById("" + id + ""); //document.getElementById("" + id + "").value;
            if (value != "") {
                SaveAnswer(id, value);
            }
        }

        function OpenWindow() {
            //Open the Popup window
            //Change the pagename here
            window.open('https://www.desmos.com/scientific', '_blank', 'height=450,width=500,scrollbars=0,location=1,toolbar=0,margin-left=50%');
            return false;
        }

        function errorfunction(msg) {
            swal("error", msg, "error");
        }

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        function SaveRadEditor(control) {
            var value = $telerik.findEditor("" + control + "").get_html();
            if (value != "") {
                SaveAnswer(control, value);
                
            }
        }

        //function allanswersave() {
        //    SaveAnswerAllTime();
        //}

        function SaveEditorAns(id) {
            var value = CKEDITOR.instances["" + id + ""].getData();
            if (value != "") {
                SaveAnswer(id, value);
            }
        }
        function SaveAnswer(ControlID, value) {
            if (ControlID != null && value != "") {
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
                            return true;
                            console.log("Saved Answer " + ControlID);
                        }
                        else {
                            alert("Exam is not Save ...!");
                        }
                    },

                    error: function (x, e) {
                        console.log(x.responseText);
                        alert('Please refresh the page.');
                        //alert(x.responseText);
                        //alert(x.status);

                    }
                });
            }
        }


        function addZero(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }

        function startQuestionTimer() {
            // debugger;
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
                //SaveAnswerAllTime();
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

                        <div style="margin: 10px">
                            <p class="CustomFontSize"><b>General instructions:</b></p>
                            <ul class="CustomFontSize">
                                <li>Link for the <a href="https://qph.fs.quoracdn.net/main-qimg-16d206c3fc1953c5ccbdd7a4eb72e09c.webp" target="_blank">reactivity</a> series.</li>
                                <li>Link for <a href="https://www.ptable.com" target="_blank">periodic table.</a></li>
                            </ul>
                        </div>
                        <div class="item active">
                            <div>
                                <h3><b>Criterion A: Knowing and Understanding:</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <ul class="CustomFontSize" style="list-style: lower-roman">
                                                <li>explain scientific knowledge</li>
                                                <li>apply scientific knowledge and understanding to solve problems set in familiar and unfamiliar situations</li>
                                                <li>analyse and evaluate information to make scientifically supported judgments.</li>
                                            </ul>
                                            <br />
                                            <span class="CustomFontSize">1. The drug <b>clomiphene</b> is given to Amy who is facing difficulty in conceiving. The drug increases the secretion of FSH and Oestrogen. As part of treatment, Amy was given clomiphene for five days. The concentration of oestrogen in her blood was measured every day for 27 days. The results are shown in the graph below:
                                            </span>
                                            <br />
                                            <div class="text-center">
                                                <img src="Image/Q1.png" /><br />
                                                <b>Anovulatory cycle: Anovulatory cycle is a menstrual cycle characterized by the absence of ovulation</b>
                                            </div>
                                            <br />
                                            <p class="CustomFontSize">
                                                Amy after some research found out the best possible fertility drug that can induce multiple pregnancy (A pregnancy with more than one fetus) as John and Amy wanted to have twins. The data for which is shown below in the table:
                                            </p>
                                            <table style="width: 100%; text-align: center;">
                                                <tr>
                                                    <th style="width: 33%; text-align: center;">Fertility Drug</th>
                                                    <th style="width: 33%; text-align: center;">Fertility Drug</th>
                                                    <th style="width: 34%; text-align: center;">Successful birth rate (in %)</th>
                                                </tr>
                                                <tr>
                                                    <td>Clomiphene</td>
                                                    <td><b>5.7</b></td>
                                                    <td><b>23</b></td>
                                                </tr>
                                                <tr>
                                                    <td>Letrozole</td>
                                                    <td><b>14.3</b></td>
                                                    <td><b>18</b></td>
                                                </tr>
                                                <tr>
                                                    <td>Gonadotropin injections</td>
                                                    <td><b>13.4</b></td>
                                                    <td><b>30</b></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>1.a  Outline</b> how clomiphene might help Amy in having a successful pregnancy <b>by applying scientific knowledge</b> to the understanding from the above graphs</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i-Level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div>

                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion1');" onfocusout="return StopAutoSave('txtQuestion1');" Rows="12" Width="100%"></asp:TextBox>
                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>--%>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>1.b  Analyse</b> the information given in the above table <b>to make a scientifically supported judgement</b> about the best fertility drug that should be utilized by Amy in order to have successful conception of twins</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iii - Level 5-6</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion2');" onfocusout="return StopAutoSave('txtQuestion2');" Rows="12" Width="100%"></asp:TextBox>
                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>--%>
                                        </div>
                                        <br />

                                        <div>
                                            <p class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <b>2. Hindustan Aeronautics Limited (HAL)</b> is manufacturing a combat Helicopter for which they made a prototype model for testing purposes. Helicopter contains several components in which major component is Dry battery giving emf of 50V, and a powerful motor which will rotate the rotor blade to lift the helicopter from the ground up to 500m of height carrying the total mass of 100kg . The basic design of the battery and its equivalent electrochemical cell used is shown in below images.
                                            </p>
                                            <div class="row">
                                                <div class="col-md-12 col-lg-12 col-sm-12">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <img src="Image/Q2.png" />
                                                            </td>
                                                            <td>
                                                                <img src="Image/Q3.png" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>https://chemdemos.uoregon.edu/sites/chemdemos1.uoregon.edu/files/DaniellCell%20image32.jpg</td>
                                                            <td>http://pediaa.com/wp-content/uploads/2017/08/Difference-Between-Electrochemical-Cell-and-Electrolytic-Cell-1.jpg</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: center;">Dry Battery</td>
                                                            <td style="text-align: center;">Electrochemical cell</td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span><b>2a. Explain</b> the working of dry battery by applying your scientific knowledge of electrochemical cell
                                                    <br />
                                                    <b>Note: Refer to the reactivity series tab given in the paper</b></span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i - Level 7-8</b>)</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion3');" onfocusout="return StopAutoSave('txtQuestion3');" Rows="12" Width="100%"></asp:TextBox>
                                                <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>--%>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span><b>2.b </b>HAL observed that the motor did not give enough power to lift up the model from the ground even with high power supply. <b>Apply</b> your scientific knowledge and understanding to <b>suggest</b> solution to this problem.</span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>strand ii-Level 1-2</b>)</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion4');" onfocusout="return StopAutoSave('txtQuestion4');" Rows="12" Width="100%"></asp:TextBox>
                                                <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>--%>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span><b>Q:3 Identify</b> the tropism observed in venus flytrap in the image given below.</span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i - Level 1-2</b>)</span>
                                                <br />
                                                <div class="text-center" style="background-color: white!important;">
                                                    <img src="Image/Q4.gif" />
                                                    <br />
                                                    Image source: https://gifimage.net/wp-content/uploads/2018/06/venus-fly-trap-gif-7.gif
                                                </div>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion5');" onfocusout="return StopAutoSave('txtQuestion5');" Rows="12" Width="100%"></asp:TextBox>
                                                <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Criterion B: Inquiring and Designing</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <ul class="CustomFontSize" style="list-style: lower-roman">
                                            <li>explain a problem or question to be tested by a scientific investigation</li>
                                            <li>formulate a testable hypothesis and explain it using scientific reasoning</li>
                                            <li>explain how to manipulate the variables, and explain how data will be collected</li>
                                            <li>design scientific investigations.</li>
                                        </ul>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <p class="CustomFontSize">
                                                <b>Task 1:</b><br />
                                                Jason is working in the research and development department of an industry. He wants to suggest production department to electroplate iron taps with copper or silver to give an antique look. Help Jason to plan an investigation to find out which metal out of the two suggested above will electroplate the water tap faster.
                                            </p>
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:1 State</b> a problem or research question:</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i - Level 1-2</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion6');" onfocusout="return StopAutoSave('txtQuestion6');" Rows="12" Width="100%"></asp:TextBox>
                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>--%>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:2 Formulate</b> a hypothesis: (I predict that….. This is because…)</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand ii - level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion7');" onfocusout="return StopAutoSave('txtQuestion7');" Rows="12" Width="100%"></asp:TextBox>
                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>--%>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:3 Outline</b>  how to manipulate the Variables to collect the data in the given experiment:</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iii - level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12 col-lg-12 col-sm-12">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 30%; padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Independent Variable:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important; width: 70%; height: 130px!important">
                                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion8');" onfocusout="return StopAutoSave('txtQuestion8');" Rows="12" Width="100%"></asp:TextBox>
                                                            <%--<script type="text/javascript" lang="javascript" style="height: 120px!important">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Dependent Variable:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important; height: 130px!important">
                                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion9');" onfocusout="return StopAutoSave('txtQuestion9');" Rows="12" Width="100%"></asp:TextBox>
                                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Constant Variable:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important; height: 130px!important">
                                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion10');" onfocusout="return StopAutoSave('txtQuestion10');" Rows="12" Width="100%"></asp:TextBox>
                                                            <%--<script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:4 Design</b> a  logical, complete and safe method with proper selection of materials and equipment to  find out which metal out of the two suggested is better in terms of time required for electroplating.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iv - Level 7-8</b>)</span>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12 col-lg-12 col-sm-12">
                                                <table style="width: 100%;">
                                                    <tr>
                                                        <td style="width: 20%; padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Safety measures:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important; width: 80%;" class="text-center">
                                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion11');" onfocusout="return StopAutoSave(''txtQuestion11');" Rows="12" Width="100%"></asp:TextBox>
                                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion11')" class="btn btn-primary">Save</button>
                                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Materials:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important;" class="text-center">
                                                            <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion12')" class="btn btn-primary">Save</button>
                                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding: 10px!important">
                                                            <p class="CustomFontSize">
                                                                <b>Procedure:</b><br />
                                                            </p>
                                                        </td>
                                                        <td style="padding: 10px!important;" class="text-center">
                                                            <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion13')" class="btn btn-primary">Save</button>
                                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Criterion C: Processing and Evaluating</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <ul class="CustomFontSize" style="list-style: lower-roman">
                                            <li>present collected and transformed data</li>
                                            <li>interpret data and explain results using scientific reasoning</li>
                                            <li>evaluate the validity of a hypothesis based on the outcome of the scientific investigation</li>
                                            <li>evaluate the validity of the method</li>
                                            <li>explain improvements or extensions to the method.</li>
                                        </ul>
                                        <br />
                                        <b class="CustomFontSize">Q:1</b><br />
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>i. Present </b>the above data in the form of a suitable <b>Graph :-</b>( <u><a href="https://chart-studio.plot.ly/create/#/" target="_blank">plot.ly</a> / <a href="https://www.desmos.com/calculator" target="_blank">Desmos</a></u> ) to help the student derive a conclusion to his hypothesis.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i- level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch"
                                                Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion14" ExternalDialogsPath="~/RadEditorDialogs/">
                                                <Tools>
                                                    <telerik:EditorToolGroup Tag="Formatting">
                                                        <telerik:EditorTool Name="Underline" />
                                                        <telerik:EditorTool Name="Bold" />
                                                        <telerik:EditorTool Name="Italic" />
                                                    </telerik:EditorToolGroup>
                                                </Tools>
                                            </telerik:RadEditor>
                                            <div class="text-center">
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveRadEditor('txtQuestion14')" class="btn btn-primary">Save</button>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>ii. Interpret</b> the relationship between voltage and current and <b>explain</b> results obtained from graph and calculation using scientific reasoning.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand ii - level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <br />
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion15')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>iii. Discuss</b> the validity of a hypothesis based on the processed data of the scientific investigation.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iii - level 5-6</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion16')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>iv. Discuss</b> the validity of the method used by the student to research about the relationship between the concentration of electrolyte and resistance offered by the electrolyte.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iv - level 5-6</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion17')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>v. Outline</b> improvements or extensions to the method used by the student.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand v - level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion18')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <b class="CustomFontSize">Q:2</b><br />
                                        <div style="background-color: #9fd8fb;">
                                            <p class="CustomFontSize">
                                                Jordan was to research about the extraction of metals like copper and iron from their oxides using carbon, he hypothesised that he will be able to extract metals using carbon as they both are less reactive than carbon and hence he performed activity as shown in <u><a href="https://www.youtube.com/embed/uxjp4XbsOfU" target="_blank">video</a></u>
                                            </p>
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>i. Evaluate</b> the validity of method used by Jordan in his experiment as shown in video.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand iv - level 7-8</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion19')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>ii. State</b> extension for above method so that he can reduce remaining copper oxide to copper using products obtained from the above activity.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand v - level 1-2</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <br />
                                            <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion20')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion20.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3><b>Criterion D: Reflecting on the impacts of Science</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <ul class="CustomFontSize" style="list-style: lower-roman">
                                            <li>explain the ways in which science is applied and used to address a specific problem or issue</li>
                                            <li>discuss and evaluate the various implications of using science and its application to solve a specific problem or issue</li>
                                            <li>apply scientific language effectively</li>
                                            <li>document the work of others and sources of information used.</li>
                                        </ul>
                                        <br />
                                        <b class="CustomFontSize">Task 1:</b>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <p class="CustomFontSize">
                                                <b class="text-center">Why Magnetic Separation Matters for the Mining Industry</b>
                                                <br />
                                                One of the greatest challenges facing the mining industry is the separation of unwanted material generated by the extraction process from the valuable material. Mining, whether done through open seam or underground means, creates a huge amount of waste product in the form of worthless or low value minerals and unusable man-made materials. These materials can be extremely difficult to separate from the valuable materials miners are after. Perhaps the most efficient way of separating these materials is through magnetic separation.<br />
                                                <br />

                                                <b>What is Magnetic Separation?</b><br />
                                                Magnetic separation is the process of using magnetic force to remove metallic or ferrous materials from a mixture.<br />
                                                Magnetic separation machines consist of a vibratory feeding mechanism, an upper and lower belt and a magnet. The bulk material is fed through the vibrating mechanism onto the lower belt. At this point, the magnet pulls any material susceptible to magnetic attraction onto the upper belt, effectively separating the unwanted metals from the rest of the bulk.<br />
                                                <br />

                                                <b>How Magnetic Separation is Useful?</b><br />
                                                Magnetic separation has been used in the mining industry for more than 100 years, beginning with John Wetherill’s Wetherill Magnetic Separator, which was used in England in the late nineteenth century.<br />
                                                Magnetic separation is most commonly used in the mining industry to separate “tramp ore,” or unwanted waste metals, from the rest of the bulk material. Tramp ore typically consists of the man-made byproducts created by the mining process itself, such as wires from explosive charges, nuts and bolts, nails, broken pieces from hand tools such as jack hammers and drills or tips off of heavy duty extraction buckets.<br />
                                                Magnetic separation machines are usually placed at the beginning of a mine’s materials processing line to remove tramp ore before it can cause harm to “downstream” equipment such as ore crushers and conveyor belts, which can be easily damaged by metal shards or other sharp objects.<br />
                                                Most magnetic extraction systems are designed to be easily retrofitted onto existing production and conveyor systems, so major equipment relocation is unnecessary.<br />
                                                <br />
                                                Source: https://www.mainlandmachinery.com/magnetic-separation-in-the-mining-industry/
                                            </p>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span><b>Q:1 Summarize</b> the article given above to support the statement: “Magnetism is used to overcome the challenges faced in mining.”</span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i, iii - Level 3-4</b>)</span>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <br />
                                            <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion21')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion21.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <b class="CustomFontSize">Task 2:</b><br />
                                        <div style="background-color: #9fd8fb;">
                                            <p class="CustomFontSize">
                                                <b class="text-center">Products for Menstrual Hygiene:</b>
                                                <br />
                                                Menstruation represents periodical discharge from the uterus occurring in women from puberty to menopause. Sales within the feminine supplies market are essentially driven by the needs of menstruating women, whose numbers are dictated by changes or growth of the population. Plenty of effort has been put to establish legislation in order to make feminine products safer, as well as to specify the ingredients on the package.
                                                <br />

                                                <b>There are two principal types of menstrual products: </b>
                                                <br />
                                                <ol class="CustomFontSize">
                                                    <li>
                                                        <b>External protection:</b> External protection from pads and party-liners absorb the menstrual flow after it leaves the body.
                                                    </li>
                                                    <li>
                                                        <b>Internal protection</b> (such as tampons) are inserted into the vagina to absorb the menstrual flow before it leaves the body. Menstrual products are more commonly divided on disposable and reusable items which is given in the infograph:
                                                    </li>
                                                </ol>
                                            </p>
                                        </div>
                                        <div class="text-center">
                                            <img src="Image/Q6.png" /><br />
                                            <img src="Image/Q8.png" /><br />
                                            <img src="Image/Q7.PNG" /><br />
                                        </div>
                                        <br />
                                        <div>
                                            Image Source 1: https://payload.cargocollective.com/1/10/332028/5743830/bloodmoney.png
                                                <br />
                                            Image Source 2: https://impactwala.org/system/file_uploads/files/000/000/006/original/padwala_infographic.1.png?1523334585
                                                <br />
                                            Image Source 3: https://www.natracare.com/wp-content/uploads/2018/10/plastic-period-products-infographic.jpg
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:2 Discuss and evaluate</b> the implications of using different products for hygiene during menstruation by interacting with various factors by interpreting given infograph.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand ii,iii - Level 7-8</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion22')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion22.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q:3 Document</b> the source of the <b>Image 1</b> and <b>Image 3</b> in <u><a href="http://www.citethisforme.com/" target="_blank">MLA-7</a></u> format.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>strand i, iii - Level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion23" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion23')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion23.ClientID%>');</script>
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
                    <div class="row text-center">
                        <div class="col-lg-12 col-md-12 text-center" style="width: 100%!important">
                            <ul class="ulNav">
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Criterion A</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Criterion B</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Criterion C</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Criterion D</a></li>
                                <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
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
