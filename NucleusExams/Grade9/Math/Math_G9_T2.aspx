<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Math_G9_T2.aspx.cs" Inherits="NucleusExams.Grade9.Math.Math_G9_T2" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Math</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link href="../../Content/all.css" rel="stylesheet" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../ckeditor4/ckeditor.js"></script>
    <%--<script src="../../ckeditor4/plugins/ckeditor_wiris/src/plugin.src.js"></script>--%>
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
        var editor;

        $(function () {
            $("#draggable").draggable({ axis: "y" });

        });



        //$(window).on('load', function () {
        //    // code here
        //    const ckeditorIntegrationInstance = WirisPlugin.instances[editor.name];
        //    // Can be that previously custom editor was used. So is needed disable
        //    // all the editors to avoid wrong behaviours.
        //    ckeditorIntegrationInstance.core.getCustomEditors().disable();
        //    ckeditorIntegrationInstance.openNewFormulaEditor();

        //});

        var myVar;
        var myTimer;
        var myVarCKE;

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

        CKEDITOR.on('instanceReady', function (evt) {
            editor = evt.editor;
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
                alert('Your wi-fi connection is lost.\nPlease check your wi-fi connection.\n Do not refresh or close the paper.');
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
                var value = CKEDITOR.instances["" + id + ""].getData();
                if (value != "") {
                    SaveAnswer(id, value);
                }
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
            //alert('error');
            swal("Error", msg, "error");
        }

        function Top() {
            var current = $('.active').attr("id");
            SaveOnNavigationByDivID(current);
            //  SaveForNextQuestion();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }


        function SaveOnNavigationByDivID(id) {
            if (id == "divQuestion1") {
                var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }


            }
            else if (id == "divQuestion2") {
                var CKEdiorID = ["txtQuestion4", "txtQuestion5", "txtQuestion6"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            else if (id == "divQuestion3") {
                var CKEdiorID = ["txtQuestion7"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            else if (id == "divQuestion4") {
                var CKEdiorID = ["txtQuestion8", "txtQuestion9", "txtQuestion10"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            console.log("All answer is saved of div of :- " + id);
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
            // debugger;
            var control = id;
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
            //  debugger;
            var EAM = {};
            EAM.StudentID = document.getElementById('<%= hfStudentID.ClientID%>').value;
            EAM.ExamID = document.getElementById('<%= hfExamID.ClientID%>').value;
            EAM.QID = ControlID;
            EAM.Answer = value;
            // debugger;
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

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8", "txtQuestion9", "txtQuestion10"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
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



        function BindAnswertoCkeditor() {
            // debugger;

            $.ajax({
                url: "<%=Page.ResolveUrl("/api/Exam/getEA_ExamAnswerMasterByQuestionIDStudentIDExamID")%>",
                data: { 'StudentID': document.getElementById('hfStudentID').value, ExamID: document.getElementById('hfExamID').value },
                type: "GET",
                async: false,
                success: function (data) {
                    //       debugger;
                    var datavalue = $(data).find('string').text();

                    var Row = data.filter(function (item) { if (item["QID"] == "txtQuestion1") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion1'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion2") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion2'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion3") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion3'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion4") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion4'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion5") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion5'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion6") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion6'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion7") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion7'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion8") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion8'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion9") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion9'].setData(Row[0]["Answer"]);
                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion10") return item });

                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion10'].setData(Row[0]["Answer"]);
                    }

                },
                error: function (x, e) {

                }

            });
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
        <div ng-app="" runat="server" id="divAll">
            <div class="container">
                <div class="row col-md-12 col-lg-12 ">
                    <div class="float-left col-md-6 col-lg-6">
                        <img src="../../Images/Logo/FS_Logo.png" /><br />

                    </div>
                    <div class="col-md-6 col-lg-6" style="text-align: end">
                        <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                        <br />
                        <asp:Label ID="lblTimer" runat="server" ClientIDMode="Static"></asp:Label><br />
                    </div>
                </div>
                <div id="div1" class="text-center" runat="server">
                    <div class="row">
                        <div class="col-md-4">
                        </div>
                        <div class="col-md-4">
                            <strong>
                                <asp:Label ID="lblGradeSubjectName" Font-Bold="true" runat="server"></asp:Label></strong>
                        </div>
                        <div class="col-md-4" style="text-align: right!important;">
                            <a class="fa fa-calculator fa-2x" onclick="return OpenWindow('https://www.desmos.com/testing/ibmyp/scientific');" href="#"></a>
                            <a class="fa fa-pencil-ruler fa-2x" href="https://www.desmos.com/calculator" target="_blank"></a>
                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-md-8 col-sm-8 col-lg-8">
                    <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                        <!-- Indicators data-ride="carousel" -->

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="item active" id="divInstructions">
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
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <b>Instructions for drawing tool</b>
                                            </div>
                                            <br />
                                            <div class="text-justify CustomFontSize">
                                                <ul>
                                                    <li>Select drawing tool from drawing menu.</li>
                                                    <li>After drawing shape (circle/rectangle/line) you need to click on <b>Apply</b> button.</li>
                                                    <li>Click on <b>Reset</b> button to completely erase your drawing.</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item" id="divQuestion1">
                                <div style="margin: 20px">
                                    <h4><b>Question 1</b></h4>
                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span><b>a)</b> AB is a chord in the circle having the center O and radius 8 cm.<br />
                                                    <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                                    <b>i)  Sketch</b> and shade the situation given above.</span>
                                                <b><a href="Diagram.aspx" target="_blank" style="color: black!important; text-decoration: underline">Click here to edit image and add screenshot in answer area given below</a></b>
                                            </div>
                                            <br />
                                            <div class="text-center" style="display: none;">
                                                <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=TextBox1.ClientID%>');</script>
                                            </div>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion1')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                                <span><b>ii)  Find </b>the area covered by the major sector created by AB if the minor angle made by AB at center of circle is 60º.</span>
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion2')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                            </div>
                                            <br />

                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                                <span><b>b)  Construct</b> Venn Diagram to represent the following set.</span><br />
                                                ( A’ ∪ B’ )’  <b><a href="Diagram.aspx" target="_blank" style="color: black!important; text-decoration: underline">Click here to edit image and add screenshot in answer area given below</a></b>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>

                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion3')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="item" id="divQuestion2">

                                <div style="margin: 20px;">
                                    <h4><b>Question 2</b></h4>

                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>Sergio is taking two summer classes at the local college. One course is ‘pass/fail’ (those are the only two grades) while the other course has a grading system of A, B, C, F (with F being the only failing grade).</span>
                                                <br />
                                                <span><b>a)  Organize </b>the data using appropriate mathematical strategy</span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                                <br />
                                                <b><a href="Diagram.aspx" target="_blank" style="color: black!important; text-decoration: underline">Click here to edit image and add screenshot in answer area given below</a></b>
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion4')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>b) Find the probability that:
                                                <br />
                                                    1) Sergio passes both classes.
                                                </span>
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion5')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>2) Sergio passes exactly one class.
                                                </span>
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion6')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                    </div>
                                </div>
                            </div>
                            <div class="item" id="divQuestion3">
                                <div style="margin: 20px">
                                    <h4><b>Question 3</b></h4>
                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>Diagram of a rectangle is shown here.
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 5-6</b>)</span>
                                                </span>
                                            </div>

                                            <img src="Image/q3figurea.png" />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                (https://www.drfrostmaths.com/resources/getfile.php?fid=934)
                                            <br />
                                                The perimeter of the rectangle is 28 cm. Find the possible value of ‘x’. Give your solution to 3 significant figures.
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion7')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item" id="divQuestion4">

                                <div style="margin: 20px">
                                    <h4><b>Question 4</b></h4>
                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>For the given situation for the circle having center O & radius 11 inch</span>
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 7-8</b>)</span>
                                            </div>
                                            <img src="Image/q4figurea.png" />
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span><b>a)  Find</b> the angle PAD</span>
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion8')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <b>b)  Find</b> the angle APC if angle PCO = 68°
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion9')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <b>C)  Calculate</b> the area of sector COD if the angle ODC = 21°.
                                            </div>
                                            <br />
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion10')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
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
                                    <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Que 1</a></li>
                                    <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Que 2</a></li>
                                    <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Que 3</a></li>
                                    <li id="li6" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Que 4</a></li>
                                    <li id="li7" class="liNav" data-target="#myCarousel" data-slide-to="5" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-4 col-lg-4">
                    <div id="draggable" class="draggable ui-widget-content">
                        <h3><b>Answer Text Box</b></h3>
                        <br />
                        <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine"></asp:TextBox>
                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=TextBox2.ClientID%>');</script>
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
