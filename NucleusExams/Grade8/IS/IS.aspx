<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IS.aspx.cs" Inherits="NucleusExams.Grade8.IS.IS" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Unit 4 Let the energy flow</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link href="../../Content/all.css" rel="stylesheet" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../ckeditor4/ckeditor.js"></script>
    <style>
        .ulNav {
            list-style-type: none;
            margin: 0;
            overflow: hidden;
            background-color: #9fd8fb;
            width: 50%;
            margin-left: 20%;
        }

        .liNav {
            float: left;
        }

        .liNavA {
            display: block;
            color: black;
            text-align: center;
            padding: 5px;
            text-decoration: none;
            font-weight: bold;
        }

            .liNavA :hover {
                background-color: green !important;
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
    <script>
        var myVar;
        var myTimer;
        var myVarCKE;
        CKEDITOR.on('instanceReady', function (evt) {
            var editor = evt.editor;
            editor.on('focus', function (e) {
                //  debugger;
                // startAutoSaveCkeditor(e.editor.name);

                console.log('The editor named ' + e.editor.name + ' is now focused');
                startAutoSaveCKE(e.editor.name);

            });

            editor.on('blur', function (e) {
                // StopAutoSave(e.editor.name);

                console.log('The editor named ' + e.editor.name + ' is lost focused');
                StopAutoSave(e.editor.name);
            });

        });

        function CheckNet() {
            //debugger;
            var ifConnected = window.navigator.onLine;
            if (ifConnected) {
                console.log('Connection available');
            } else {
                //StopSave();
                clearInterval(myVar);
                clearInterval(myVarCKE);
                alert('Your wi-fi connection is lost.\nPlease check your wi-fi connection.');
            }
        }

        function startAutoSave(id) {
            //  debugger;
            myVar = setInterval(function () { callSave(id); }, 10000);
        }

        function startAutoSaveCKE(id) {
            //  debugger;
            myVarCKE = setInterval(function () { SaveCKE(id); }, 10000);
        }

        function StopSave() {
            console.log('Internat is not available');
            clearInterval(myVar);
            clearInterval(myVarCKE);
        }

        function StopAutoSave(id) {
            //debugger;
            if (id != null) {
                callSave(id);
                console.log('Saved stop ' + id);
                clearInterval(myVar);
                clearInterval(myVarCKE);
            }
        }

        $(document).ready(function () {
            //$('#ShowModalPopup').appendTo("form");
            //window.setInterval(function () {
            //    //debugger;
            //    SaveAnswerAllTime();
            //}, 10000);
            window.setInterval(function () {
                CheckNet();

            }, 15000);
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
            SaveForNextQuestion();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        // save when next question 
        function SaveForNextQuestion() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                if (value != "") {
                    SaveAnswer(id, value);
                }
            }
        }


        // save fuction 

        function callSave(control) {
            var id = control;
            var value = $('#' + id).val(); //document.getElementById("" + id + ""); //document.getElementById("" + id + "").value;
            if (value != "") {
                SaveAnswer(id, value);
            }
        }

        function SaveCKE(id) {
            var value = CKEDITOR.instances["" + id + ""].getData();
            if (value != "") {
                SaveAnswer(id, value);
            }
        }

        function SaveEditorAns(id) {
            var value = CKEDITOR.instances["" + id + ""].getData();
            if (value != "") {
                SaveAnswerEditor(id, value);
            }
        }


        function SaveTextBoxAns(control) {
            var id = control;
            var value = $('#' + id).val(); //document.getElementById("" + id + ""); //document.getElementById("" + id + "").value;
            if (value != "") {
                SaveTextBoxAnswer(id, value);
            }
        }

        function SaveTextBoxAnswer(ControlID, value) {
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
                        swal({
                            title: "Saved",
                            text: "Answer saved successfully.",
                            type: "success"
                        });
                        console.log("Saved Answer " + ControlID);
                    }
                    else {
                        alert("Exam is not Save ...!");

                    }

                },

                error: function (x, e) {
                    console.log(x.responseText);
                    alert('Answer is not save.\nSomething went wrong.');
                    clearInterval(myVar);
                    //alert(x.responseText);
                    //alert(x.status);

                }
            });
        }


        function SaveAnswerEditor(ControlID, value) {
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
                        swal({
                            title: "Saved",
                            text: "Answer saved successfully.",
                            type: "success"
                        });
                        console.log("Saved Answer " + ControlID);
                    }
                    else {
                        alert("Exam is not Save ...!");
                    }
                },

                error: function (x, e) {
                    console.log(x.responseText);
                    alert('Answer is not save.\nSomethig went wrong.');
                }
            });
        }



        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                if (value != "") {
                    SaveAnswer(id, value);
                }

            }

            var TextBoxID = ["txtQuestion3", "txtQuestion4"];
            var j;
            for (j = 0; j <= TextBoxID.length - 1; j++) {
                var id = TextBoxID[j];
                var value = document.getElementById(id).value;
                if (value != "") {
                    SaveAnswer(id, value);
                }
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
                        console.log("Saved Answer " + ControlID);
                    }
                    else {
                        alert("Exam is not Save ...!");
                    }
                },

                error: function (x, e) {
                    console.log(x.responseText);
                    alert('Answer is not save.\nSomethig went wrong.');
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
            //debugger;
            var currentTime = '<%= Session["ExamTimer"] %>';
            myTimer = setInterval(function () {
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




        function FinishExam() {
            var ifConnected = window.navigator.onLine;
            if (ifConnected) {
                var retVal = confirm("Are you sure you want to finish the exam?");
                if (retVal == true) {
                    SaveAnswerAllTime();
                    clearInterval(myTimer);
                    document.getElementById('<%= btnFinish.ClientID %>').click();
                } else {
                    return false;
                }
            } else {
                alert('Your wi-fi connection is lost.\nPlease check your wi-fi connection.');
            }

        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <asp:HiddenField ID="hfTotalDuration" runat="server" />
        <asp:HiddenField ID="hfCheckboxValue" runat="server" />
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
                <%--<a class="fa fa-calculator fa-2x" onclick="return OpenWindow();" href="#"></a>--%>
                <%--<a class="fa fa-calculator fa-2x" href="https://docs.google.com/document/d/1PUVTN5nWPDj95MopIwYD0vK4WehKviot3evLOOnWmZo/edit?usp=sharing" target="_blank"></a>--%>
            </div>
            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
                <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                    <!-- Indicators data-ride="carousel" -->

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <div style="margin: 20px">
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <b>Exam Instructions</b>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            <ol>
                                                <li>Remember to click on  <b>Save</b>  button after every answer.</li>
                                                <li>Wait for  <b>Saved Successfully</b>  dialogue box to appear after clicking save and before moving to next or previous question.</li>
                                                <li><b>Click ok</b> and then move to next / previous question.</li>
                                                <li>Do not click on <b>Finish</b> button until you want to end the exam.</li>
                                                <li>If internet is lost,
                                                    <ul>
                                                        <li><b>Do not reload / refresh your paper.</b></li>
                                                        <li>Continue answering your questions.</li>
                                                        <li>Notification about loss of wi-fi connection will appear every 10 secs.</li>
                                                        <li>Once internet is restored press <b>save</b> button to save all your answers.</li>
                                                    </ul>
                                                </li>

                                            </ol>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <b>Instructions to take screenshot of your graph / drawing/ image and paster in your answer</b>
                                        </div>
                                        <br />

                                        <div class="text-justify CustomFontSize">

                                            <ul>
                                                <li>Press <strong>Shift</strong> + <strong>Ctrl</strong> + <strong>Switch windows</strong>
                                                    <img src="../../Images/grey-ico-window.png" alt="" width="25px" height="15px" aria-hidden="true" class="md-content-icon content-icon-bottom">. Then, select the area you’d like to take screenshot.</li>
                                                <li>Screenshot image will appear in right hand bottom corner of the screen.</li>
                                                <li>Click on <b>copy to clipboard</b> appearing below the image.</li>
                                                <li>Go back to your answer in the paper where screenshot is to be used and press <b>Ctrl + V.</b></li>
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item" id="divContent">
                            <div style="margin: 20px">
                                <h4><b>Content</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Aim:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            To investigate the effect of carbon dioxide on the rate of photosynthesis
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Hypothesis:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            I predict that as we increase the concentration of carbon dioxide, the number of bubbles will decrease. This is because the amount of carbon dioxide is directly proportional to the amount of glucose formed during photosynthesis. Hence, the amount of oxygen released will decrease with the increase in the concentration of carbon dioxide.
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Method:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            <ol>
                                                <li>Open the <a href="https://www.newpathonline.com/api_player/enus_54_6206/h7sIbz/index.html" target="_blank">simulation.</a></li>
                                                <li>Set the Light intensity: 15000 lux</li>
                                                <li>Click on the button “Prepare plant”.</li>
                                                <li>Set the CO2 concentration at 0 ppm and start the timer. Note down the no. of bubbles released in 3 mins. Perform the step twice.</li>
                                                <li>Repeat step 4 for the CO2 concentration for 300, 600 and 1200 ppm and perform it step twice.</li>
                                                <li>Record the results in the observation table.</li>
                                                <li>Plot the <a href="https://chart-studio.plot.ly/create/#/" target="_blank">graph</a> of carbon dioxide versus no. of bubbles released.</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion1">
                            <div style="margin: 20px">
                                <h4><b>Que:1 Observation </b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Present</b>  collected data in an organized form.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 3-4</b>)</span>

                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion1');" onfocusout="return StopAutoSave('txtQuestion1');"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion1')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item" id="divQuestion2">

                            <div style="margin: 20px;">
                                <h4><b>Que:2 Graph</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Plot</b> the graph using <a href="https://chart-studio.plot.ly/create/#/" target="_blank">plotly</a>. Paste the screenshot of the graph in the space given below.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>

                                        </div>
                                        <br />
                                        <div>
                                            <span class="fa fa-paper-plane"></span>
                                            <b>Instructions to take screenshot of your graph / drawing/ image and paster in your answer</b>
                                        </div>
                                        <br />
                                        <div class="text-justify">

                                            <ul>
                                                <li>Press <strong>Shift</strong> + <strong>Ctrl</strong> + <strong>Switch windows</strong>
                                                    <img src="../../Images/grey-ico-window.png" alt="" width="25px" height="15px" aria-hidden="true" class="md-content-icon content-icon-bottom">. Then, select the area you’d like to take screenshot.</li>
                                                <li>Screenshot image will appear in right hand bottom corner of the screen.</li>
                                                <li>Click on <b>copy to clipboard</b> appearing below the image.</li>
                                                <li>Go back to your answer in the paper where screenshot is to be used and press <b>Ctrl + V.</b></li>
                                            </ul>

                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion2')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion3">
                            <div style="margin: 20px">
                                <h4><b>Que:3 Conclusion</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Explain</b> what your data interprets on the basis of the data collected connecting it with your aim. 
                                                    <b>Discuss</b> whether the given hypothesis was valid or not, referring to the data collected. 
                                                    <b>Justify</b> the result by using your scientific knowledge of the topic.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 5-8</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion3');" onfocusout="return StopAutoSave('txtQuestion3');" Rows="15" Width="100%"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveTextBoxAns('txtQuestion3')" class="btn btn-primary">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion4">

                            <div style="margin: 20px">
                                <h4><b>Que: 4 Evaluation</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Discuss</b> any limitations or weaknesses of the procedure, followed by its improvements or extensions</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion4');" onfocusout="return StopAutoSave('txtQuestion4');" Rows="15" Width="100%"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveTextBoxAns('txtQuestion4')" class="btn btn-primary">Save</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item" id="divQuestion5">
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
                        <div class="col-md-12 text-center" style="width: 100%!important">
                            <ul class="ulNav text-center">
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Instructions</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Content</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Que 1</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Que 2</a></li>
                                <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Que 3</a></li>
                                <li id="li6" class="liNav" data-target="#myCarousel" data-slide-to="5" onclick="return Top();"><a href="#" class="liNavA">Que 4</a></li>
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
