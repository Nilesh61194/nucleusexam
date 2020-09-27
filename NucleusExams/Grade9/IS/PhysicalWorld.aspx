<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhysicalWorld.aspx.cs" Inherits="NucleusExams.Grade9.IS.PhysicalWorld" ValidateRequest="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Physical World</title>
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


        for (instance in CKEDITOR.instances) {
            var editor = CKEDITOR.instances[instance];
            if (editor) {
                editor.on('focus', function (event) {
                    var f = $("#cke_contents_" + event.editor.name + " iframe");
                    var h = f.contents().find("html").height();
                    f.height(h);
                    $("#cke_contents_" + event.editor.name).attr('style', "height: " + h + "px;");
                });
            }
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
            swal("Error", msg, "error");
        }

        function Top() {
            var current = $('.active').attr("id");
            SaveOnNavigationByDivID(current);
            //  SaveForNextQuestion();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }


        function SaveOnNavigationByDivID(id) {

            console.log("All answer is saved of div of :- " + id);

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
            //console.log("All answer is saved of div of :- " + id);
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

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6"];
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
                },
                error: function (x, e) {
                    alert('Response from database of answer error');
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
        <div class="container" ng-app="" runat="server" id="divAll">
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
                        <a class="fa fa-pencil-ruler fa-2x" href="https://www.desmos.com/calculator" target=""></a>
                    </div>
                </div>
            </div>
            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
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
                                <h4><b>Criterion B</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span><b><u>Background:</u></b> Observe the effect of original car speed upon the skid distance. The simulation involves a toy car rolling down a hill,
                                                 hitting a box, and skidding to a stop. The height from which the car is released can be modified. The speed of the car at the bottom 
                                                of the hill (prior to contact with the box) is reported. The distance that the car (and box) skid before stopping can be measured. 
                                                <br />
                                                <br />
                                                Dear students when you click on <a href="https://www.physicsclassroom.com/Physics-Interactives/Work-and-Energy/Stopping-Distance/Stopping-Distance-Interactive"
                                                    target="_blank"><b style="color: blue; text-decoration: underline;">INTERACTIVE</b></a> here, please maximize it by clicking on the arrow at the top on left of the window. 
                                            </span>
                                            <div class="row">
                                                <img src="Image/INTERACTIVE.jpg" width="90%" style="margin-left: 55px!important" />
                                            </div>
                                            <br />
                                            <span><b>1. State</b> a problem or question to be tested  by a scientific investigation. <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (i) [Level: 1-2]</b>)</span>
                                            </span>
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

                                            <span><b>2. Formulate </b>the hypothesis about the car’s speed and skidding distance of the car.
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (ii) [Level: 3-4]</b>)</span>
                                            </span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion2')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                            <span><b>3. Design</b> a scientific investigation which includes:<br />
                                                1) Procedure, 2) List of Materials & 3) Apparatus & Safety measures:                                           
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (iii) [Level: 7-8]</b>)</span>
                                            </span>
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
                                <h4><b>Criterion C</b></h4>

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <div>
                                                <b><u>Background:</u></b> The stopping distance of a car is the distance it will need to travel till the time it will take to stop in response to some emergency.<br />
                                                <br />
                                                <b>1. The stopping distance consists of 2 parts: </b>
                                                <ul>
                                                    <li>The thinking distance – the distance travelled for the time  when the driver feels the need to apply the brake and then applies the brake.
                                                    </li>
                                                    <li>The braking distance – the distance travelled by the car after brake is applied.
                                                    </li>
                                                    <li><b>Factors Affecting Stopping Distances:</b>
                                                    </li>
                                                </ul>
                                                <div class="row text-center">
                                                    <div class="col-md-1">
                                                    </div>
                                                    <div class="col-md-10">
                                                        <table border="1" class="text-center" style="width: 100%">
                                                            <tr>
                                                                <td><b>Thinking Distance</b></td>
                                                                <td><b>Braking Distance</b></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Intoxication<br />
                                                                    (Consumption of alcohol or drugs)</td>
                                                                <td>The condition of the vehicle<br />
                                                                    (Worn tyre or poor brakes)</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Distractions<br />
                                                                    (e.g. Using a mobile phone)</td>
                                                                <td>The condition of the road and weather
                                                                    <br />
                                                                    (e.g. a wet or icy road)</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Tiredness<br />
                                                                    (Reaction time increase when tired)</td>
                                                                <td>The mass of the vehicle<br />
                                                                    (A heavy vehicle takes longer to stop)</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div class="col-md-1">
                                                    </div>

                                                </div>
                                                <br />
                                                <p>
                                                    The student is given the task of a scientific investigation. Here car crash experiment is conducted at different initial speeds as shown in 
                                                    infographic below. There is one limitation for the investigation as the student cannot control the condition of the road and weather. 
                                                    The student collects and records the data for car crash experiments at different speeds as shown below:           
                                                </p>
                                                <div class="text-center">
                                                    <img src="Image/ImageC2.png" /><br />
                                                    <b>Graph of impact speed at 45 m (In wet-road conditions)</b><br />
                                                </div>
                                                <br />
                                                Analysing the data and graph, the student formulates the hypothesis that <b>“The main factor affecting stopping distance of the 
                                                car here is the initial speed of the car.”</b>
                                            </div>
                                            <br />
                                            <span><b>1. Interpret</b> the graph and the information given above to <b>explain</b> the effects of various factors on stopping distance of the car.<span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (ii) [ Level 7-8]</b>)</span></span><br />
                                            <br />

                                        </div>

                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion4')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>2. <b>Outline</b> the validity of the hypothesis made by the student.  
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (iii) [ Level 3-4]</b>)</span></span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion5')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>3. <b>State</b> improvements or extensions to the method that would benefit the scientific investigation.	
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (V) [Level 1-2]</b>)</span></span>
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
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Criterion B</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Criterion C</a></li>
                                <li id="li7" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
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
