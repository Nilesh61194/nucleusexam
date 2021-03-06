﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IDU_G8.aspx.cs" Inherits="NucleusExams.Grade8.IDU.IDU_G8" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>IDU Grade 8</title>
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
    <script>

        var myVar;
        var myTimer;
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
            $('#ShowModalPopup').appendTo("form");
            //window.setInterval(function () {
            //    //debugger;
            //    SaveAnswerAllTime();
            //}, 10000);
            window.setInterval(function () {
                CheckNet();

            }, 20000);
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

        // start script for open popup 
        function ShowPopUp(id) {

            if (id == 1) {
                document.getElementById('lblTitle').src = 'Map 1';
                document.getElementById('imgPopUp').src = 'Image/s1.PNG';
            }
            else if (id == 2) {
                document.getElementById('lblTitle').src = 'Map 2';
                document.getElementById('imgPopUp').src = 'Image/s2.PNG';
            }
            else if (id == 3) {
                document.getElementById('lblTitle').src = 'Map 3';
                document.getElementById('imgPopUp').src = 'Image/s3.PNG';
            }
            else if (id == 4) {
                document.getElementById('lblTitle').src = 'Map 4';
                document.getElementById('imgPopUp').src = 'Image/s4.PNG';
            }
            else if (id == 5) {
                document.getElementById('lblTitle').src = 'Map 5';
                document.getElementById('imgPopUp').src = 'Image/s5.PNG';
            }
            else if (id == 6) {
                document.getElementById('lblTitle').src = 'Map 6';
                document.getElementById('imgPopUp').src = 'Image/s6.PNG';
            }
            else if (id == 7) {
                document.getElementById('lblTitle').src = 'Map 7';
                document.getElementById('imgPopUp').src = 'Image/s7.PNG';
            }
            $('#ShowModalPopup').modal('show');
            return false;
        }

        function ShowWorldMap(id) {
            if (id == 1) {
                document.getElementById('imgWorld').src = 'Image/Q4.1.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Antarctica.PNG';
            }
            else if (id == 2) {
                document.getElementById('imgWorld').src = 'Image/Q4.2.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Auckland.PNG';
            }
            else if (id == 3) {
                document.getElementById('imgWorld').src = 'Image/Q4.3.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Baikonur.PNG';
            }
            else if (id == 4) {
                document.getElementById('imgWorld').src = 'Image/Q4.8.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Berlin.PNG';
            }
            else if (id == 5) {
                document.getElementById('imgWorld').src = 'Image/Q4.4.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Hadar.PNG';
            }
            else if (id == 6) {
                document.getElementById('imgWorld').src = 'Image/Q4.5.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Lima.PNG';
            }
            else if (id == 7) {
                document.getElementById('imgWorld').src = 'Image/Q4.6.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7Oslo.PNG';
            }
            else if (id == 8) {
                document.getElementById('imgWorld').src = 'Image/Q4.7.PNG';
                document.getElementById('imgWorldMap').src = 'Image/Q7San.PNG';
            }
        }

        function ShowWorldMapQ4(id) {
            if (id == 1) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.1.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Antarctica.PNG';
            }
            else if (id == 2) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.2.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Auckland.PNG';
            }
            else if (id == 3) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.3.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Baikonur.PNG';
            }
            else if (id == 4) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.8.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Berlin.PNG';
            }
            else if (id == 5) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.4.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Hadar.PNG';
            }
            else if (id == 6) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.5.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Lima.PNG';
            }
            else if (id == 7) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.6.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7Oslo.PNG';
            }
            else if (id == 8) {
                document.getElementById('imgWorldQ4').src = 'Image/Q4.7.PNG';
                document.getElementById('imgWorldMapQ4').src = 'Image/Q7San.PNG';
            }
        }

        function ShowRoute(get) {
            //debugger;
            var id = get.value;
            if (id == 1) {

                document.getElementById('imgRoute').src = 'Image/RS1.PNG';
            }
            else if (id == 2) {

                document.getElementById('imgRoute').src = 'Image/RS2.PNG';
            }
            else if (id == 3) {

                document.getElementById('imgRoute').src = 'Image/RS3.PNG';
            }
            else if (id == 4) {

                document.getElementById('imgRoute').src = 'Image/RS4.PNG';
            }
            else if (id == 5) {

                document.getElementById('imgRoute').src = 'Image/RS5.PNG';
            }
            else if (id == 6) {
                document.getElementById('imgRoute').src = 'Image/RS6.PNG';
            }
            else if (id == 0) {
                document.getElementById('imgRoute').src = 'Image/RS0.PNG';
            }

        }

        function Top() {
            SaveForNextQuestion();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        // save when next question 
        function SaveForNextQuestion() {

            var CKEdiorID = ["txtQuestion8", "txtQuestion11", "txtQuestion16", "txtQuestion17", "txtQuestion18", "txtQuestion27", "txtQuestion28"];
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

        function SaveEditorAns(id) {
            var value = CKEDITOR.instances["" + id + ""].getData();
            if (value != "") {
                SaveAnswerEditor(id, value);
            }
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

            var CKEdiorID = ["txtQuestion8", "txtQuestion11", "txtQuestion16", "txtQuestion17", "txtQuestion18", "txtQuestion27", "txtQuestion28"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                if (value != "") {
                    SaveAnswer(id, value);
                }

            }

            var TextBoxID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion9", "txtQuestion10",
                "txtQuestion12", "txtQuestion13", "txtQuestion14", "txtQuestion15", "txtQuestion19", "txtQuestion20", "txtQuestion21", "txtQuestion22",
                "txtQuestion23", "txtQuestion24", "txtQuestion25", "txtQuestion26"];

            var j;
            for (j = 0; j <= TextBoxID.length - 1; j++) {
                var id = TextBoxID[j];
                var value = document.getElementById(id).value;
                if (value != "") {
                    SaveAnswer(id, value);
                }
            }

            var CheckBoxID = ["txtQuestion29", "txtQuestion30"];
            var k;

            for (k = 0; k <= CheckBoxID.length - 1; k++) {
                var id = document.getElementById(CheckBoxID[k]);
                var checkBoxList1 = id.getElementsByTagName("input");
                var checkBoxSelectedItems1 = new Array();
                var ary = "";
                for (var i = 0; i < checkBoxList1.length; i++) {
                    if (checkBoxList1[i].checked) {
                        checkBoxSelectedItems1.push(checkBoxList1[i].value);
                        ary += checkBoxList1[i].value + ","
                    }
                }
                debugger;

                if (ary != "") {
                    SaveAnswer(CheckBoxID[k], ary.substring(0, ary.length - 1));
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
            var retVal = confirm("Are you sure you want to finish the exam?");
            if (retVal == true) {
                SaveAnswerAllTime();
                clearInterval(myTimer);
                document.getElementById('<%= btnFinish.ClientID %>').click();
            } else {
                return false;
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

            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 text-center">
                    <strong>
                        <asp:Label ID="lblGradeSubjectName" Font-Bold="true" runat="server"></asp:Label></strong>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-2 text-right">
                    <div class="row">
                        <div class="col-md-6">
                            <a class="fa fa-calculator fa-2x" onclick="return OpenWindow();" href="#"></a>
                        </div>
                        <div class="col-md-6">
                            <a class="fa fa-tools fa-2x" href="http://idprm.ibo.org/m17.html#/English" target="_blank"></a>
                            <br />
                            <b>Source</b>
                        </div>
                    </div>

                </div>
            </div>

            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
                <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                    <!-- Indicators data-ride="carousel" -->

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active" id="divQuestion1">

                            <div style="margin: 20px">
                                <h3><b>Question - 1</b> (15 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContent" style="overflow: auto; height: auto;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source2">Source 2</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source2" class="tab-pane fade in active">
                                                    <div style="margin-left: 25px">
                                                        <h4><b>Click on the button below each map image for an enlarged version.</b></h4>
                                                    </div>
                                                    <div class="row text-center">
                                                        <div class="col-md-1">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i1.PNG" class="img-responsive" />
                                                            <br />
                                                            <br />
                                                            <button onclick="return ShowPopUp(1);" class="button">Map 1</button>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i2.PNG" class="img-responsive" />
                                                            <br />

                                                            <button onclick="return ShowPopUp(2);" class="button">Map 2</button>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i3.PNG" class="img-responsive" />
                                                            <br />
                                                            <br />
                                                            <button onclick="return ShowPopUp(3);" class="button">Map 3</button>
                                                        </div>
                                                        <div class="col-md-1">
                                                        </div>
                                                    </div>
                                                    <div class="row text-center">
                                                        <div class="col-md-1">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i4.PNG" class="img-responsive" />
                                                            <br />
                                                            <br />
                                                            <button onclick="return ShowPopUp(4);" class="button">Map 4</button>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/15.PNG" class="img-responsive" />
                                                            <br />
                                                            <br />
                                                            <button onclick="return ShowPopUp(5);" class="button">Map 5</button>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i6.PNG" class="img-responsive" />

                                                            <button onclick="return ShowPopUp(6);" class="button">Map 6</button>
                                                        </div>
                                                        <div class="col-md-1">
                                                        </div>
                                                    </div>
                                                    <div class="row text-center">
                                                        <div class="col-md-1">
                                                        </div>
                                                        <div class="col-md-2">
                                                            <img src="Image/i7.PNG" class="img-responsive" />
                                                            <br />
                                                            <button onclick="return ShowPopUp(7);" class="button">Map 7</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1a</b> (3 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            Choose <b>three</b> different maps from above and <b>identify</b> their correct classification.
                                            <%--Drag and drop the “map choice” and “classification” into the boxes provided below. --%>
                                            Type the name of three selected maps for each choice and the classification type for that choice from the list given below.<br />
                                            <br />
                                            <div class="row text-center">
                                                <div class="col-md-2">
                                                    <b>Map Choice</b><br />
                                                    <ul style="list-style: none; font-weight: bold;">
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 1</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 2</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 3</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 4</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 5</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 6</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 7</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 8</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 10px!important">Map 9</li>
                                                    </ul>
                                                </div>
                                                <div class="col-md-4">
                                                    <b>Choice-1</b><br />
                                                    <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion1');" onfocusout="return StopAutoSave('txtQuestion1');" Rows="5" Width="70%"></asp:TextBox><br />
                                                    <b>Choice-2</b><br />
                                                    <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion2');" onfocusout="return StopAutoSave('txtQuestion2');" Rows="5" Width="70%"></asp:TextBox><br />
                                                    <b>Choice-3</b><br />
                                                    <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion3');" onfocusout="return StopAutoSave('txtQuestion3');" Rows="5" Width="70%"></asp:TextBox>
                                                </div>
                                                <div class="col-md-4">
                                                    <b>classification-1</b><br />
                                                    <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion4');" onfocusout="return StopAutoSave('txtQuestion4');" Rows="5" Width="70%"></asp:TextBox>
                                                    <b>classification-2</b><br />
                                                    <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion5');" onfocusout="return StopAutoSave('txtQuestion5');" Rows="5" Width="70%"></asp:TextBox>
                                                    <b>classification-3</b><br />
                                                    <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion6');" onfocusout="return StopAutoSave('txtQuestion6');" Rows="5" Width="70%"></asp:TextBox>
                                                </div>
                                                <div class="col-md-2">
                                                    <b>classification</b><br />
                                                    <ul style="list-style: none; font-weight: bold;">
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Satellite map</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Satirical map</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Physical map</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Political map</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Cartogram</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Climate map</li>
                                                        <li class="img-thumbnail" style="background-color: #9fd8fb; margin: 6px!important">Exploration and land claim map</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <br />

                                        <div id="divmainContent2" style="overflow: auto; height: auto;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source1">Source 1</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source1" class="tab-pane fade in active">

                                                    <div class="row" style="margin-left: 5px;">
                                                        <img src="Image/VS2.PNG" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1b</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Using <b>Source 1, explain two</b> ways in which maps are changing in the 21st century. In your answer you must:
                                            <ul class="CustomFontSize">
                                                <li>consider two changes</li>
                                                <li>consider at least one implication for each change. </li>
                                            </ul>
                                            </p>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion7');" onfocusout="return StopAutoSave('txtQuestion7');" Rows="12" Width="100%"></asp:TextBox>
                                        </div>
                                        <br />
                                        <div id="divmainContent3" style="overflow: auto; height: 700px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source3">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#Source4">Source 4</a></li>
                                                <li><a data-toggle="tab" href="#Source5">Source 5</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source3" class="tab-pane fade in active">
                                                    <div class="row" style="margin-left: 5px;">
                                                        <img src="Image/VSQ3.jpg" />
                                                    </div>
                                                </div>
                                                <div id="Source4" class="tab-pane fade">
                                                    <p class="CustomFontSize">
                                                        “Only in recent decades have alternative views of the globe made their way into maps. In 1974, Arno Peters offered a projection […] that corrected Gerardus Mercator’s 1569 map of the world […], which placed the Equator deep in the bottom half of the map, thus distorting the size of the Northern Hemisphere. In 1982, Jesse Levine created a 'turnabout map' of the Western Hemisphere, with its view from the south.”<br />
                                                        <br />
                                                        <b>Source: extract from “Americas: The Changing Face of Latin America and the Caribbean”, by Peter Winn</b><br />

                                                        <h4><b>Turnabout map</b></h4>
                                                        <img src="Image/src4.0.PNG" />
                                                    </p>
                                                </div>
                                                <div id="Source5" class="tab-pane fade CustomFontSize">
                                                    <p class="CustomFontSize">
                                                        <h3><b>Definition of cartography</b></h3>
                                                        <b>Cartography</b>, the art and science of graphically representing a geographical area, usually on a flat surface such as a map or chart; it may involve the superimposition of political, cultural, or other nongeographical divisions onto the representation of a geographical area. […] Cartography is an ancient discipline that dates from the prehistoric depiction of hunting and fishing territories.
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1c</b> (8 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <p>
                                                <b>
                                                    <h3>Add any screenshot</h3>
                                                </b>
                                            </p>
                                        </div>
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion8')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item" id="divQuestion2">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2</b> (15 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2a</b> (3 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Choose <b>one</b> mathematical related concept that is required in navigation. <b>Justify</b> your answer. You must include an example for your related concept.  
                                            </p>
                                        </div>
                                        <div class="text-center">
                                            <img src="Image/q2.PNG" />
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion9');" onfocusout="return StopAutoSave('txtQuestion9');" Rows="12" Width="100%"></asp:TextBox>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2b</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div id="divmainContentQ2" style="overflow: auto; height: auto;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source6">Source 6</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source6" class="tab-pane fade in active">
                                                    <div style="margin-left: 25px">
                                                        <img src="Image/vs6.PNG" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Explain</b> why the recording and analysis of data is important in navigation. Give an example to support your answer.
                                            </p>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion10');" onfocusout="return StopAutoSave('txtQuestion10');" Rows="12" Width="100%"></asp:TextBox>
                                            <br />
                                            <p class="CustomFontSize">
                                                Before compass and satellite navigation, those who went out to explore the Earth had to be innovative in their methods of navigation.<br />
                                                Watch the animation of the Sun stick method showing how early explorers used the Sun to identify north, south, east and west. 


                                            </p>
                                        </div>
                                        <div id="divmainContentQ21" style="overflow: auto; height: auto;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ2">Video Transcript</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ2" class="tab-pane fade in active">
                                                    <div style="margin-left: 25px">
                                                        <img src="Image/VSQ2.PNG" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2c</b> (8 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Evaluate</b> the Sun stick method of navigation. In your answer you must:
                                                <ul class="CustomFontSize">
                                                    <li>identify the advantages of this method</li>
                                                    <li>identify the disadvantages of this method</li>
                                                    <li>suggest times when it would be both useful and not useful</li>
                                                    <li>consider the accuracy of such an application both mathematically and in a real-life context.</li>
                                                </ul>

                                            </p>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion11')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion3">
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b> (20 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ3" style="overflow: auto; height: 800px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source31">Mercator and Gall-Peters map comparison tool</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ32">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ33">Source 4</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ34">Source 7</a></li>
                                            </ul>

                                            <div class="tab-content text-center">
                                                <div id="Source31" class="tab-pane fade in active">
                                                    <img src="Image/Q3.1.PNG" />
                                                    <br />
                                                    <img src="Image/Q3.2.PNG" />
                                                </div>
                                                <div id="SourceQ32" class="tab-pane fade">
                                                    <div class="row" style="margin-left: 5px;">
                                                        <img src="Image/VSQ3.jpg" />
                                                    </div>
                                                </div>
                                                <div id="SourceQ33" class="tab-pane fade">
                                                    <p class="CustomFontSize">
                                                        “Only in recent decades have alternative views of the globe made their way into maps. In 1974, Arno Peters offered a projection […] that corrected Gerardus Mercator’s 1569 map of the world […], which placed the Equator deep in the bottom half of the map, thus distorting the size of the Northern Hemisphere. In 1982, Jesse Levine created a 'turnabout map' of the Western Hemisphere, with its view from the south.”<br />
                                                        <br />
                                                        <b>Source: extract from “Americas: The Changing Face of Latin America and the Caribbean”, by Peter Winn</b><br />

                                                        <h4><b>Turnabout map</b></h4>
                                                        <img src="Image/src4.0.PNG" />
                                                    </p>
                                                </div>

                                                <div id="SourceQ34" class="tab-pane fade">
                                                    <br />
                                                    <div class="text-center">
                                                        <p><b>Click all the possible text and images within the source to find extra information.</b></p>
                                                    </div>
                                                    <div class="row">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td>
                                                                    <img src="Image/Q4.0.PNG" id="imgWorld" />
                                                                </td>
                                                                <td rowspan="2" style="padding: 10px;">
                                                                    <img id="imgWorldMap" src="Image/WhiteWorld.png" />
                                                                </td>
                                                            </tr>
                                                            <tr style="margin-left: 25%;">
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(1);">Antarctica</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(2);">Auckland</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(3);">Baikonur</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(4);">Berlin</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(5);">Hadar</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(6);">Lima</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(7);">Oslo</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMap(8);">San Francisco</p>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 3a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <p class="CustomFontSize"><b>Compare and contrast</b> the Mercator and Gall-Peters map projections. </p>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <h4><b>Similarity 1</b></h4>
                                                <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion12');" onfocusout="return StopAutoSave('txtQuestion12');" Height="250px" Width="100%"></asp:TextBox>

                                                <br />
                                                <h4><b>Difference 1</b></h4>
                                                <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion13');" onfocusout="return StopAutoSave('txtQuestion13');" Height="300px" Width="100%"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-6">
                                                <h4><b>Similarity 2</b></h4>
                                                <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion14');" onfocusout="return StopAutoSave('txtQuestion14');" Height="250px" Width="100%"></asp:TextBox>
                                                <br />
                                                <h4><b>Difference 2</b></h4>
                                                <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion15');" onfocusout="return StopAutoSave('txtQuestion15');" Height="300px" Width="100%"></asp:TextBox>
                                            </div>

                                        </div>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 3b</b> (16 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Discuss</b> how the Gall-Peters map projection represents scientific and technical innovation. In your answer you must:
                                                    <ul class="CustomFontSize">
                                                        <li>integrate elements from mathematics and individual and societies</li>
                                                        <li>use evidence from the maps to support your argument</li>
                                                        <li>consider strengths and limitations of the Gall-Peters map projection</li>
                                                        <li>provide a conclusion.</li>
                                                    </ul>
                                            </p>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion16')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item" id="divQuestion4">

                            <div style="margin: 20px">
                                <h3><b>Question - 4</b> (30 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ4" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ41">Route Simulator</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ42">Source 7 </a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ41" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/RS0.PNG" id="imgRoute" />
                                                        <br />

                                                        <select id="Select1" class="CustomFontSize" style="margin: 10px;" runat="server" onchange="return ShowRoute(this);">
                                                            <option value="0">Choose Route</option>
                                                            <option value="1">Hadar, Lima, Auckland, South Pole</option>
                                                            <option value="2">Hadar, Auckland, Baikonur, Berlin, San Francisco</option>
                                                            <option value="3">Hadar, Berlin, Baikonur, Auckland, South Pole</option>
                                                            <option value="4">Hadar, Berlin, Baikonur, San Francisco, Lima</option>
                                                            <option value="5">Hadar, Lima, San Francisco, Berlin, Baikonur</option>
                                                            <option value="6">Hadar, Lima, San Francisco, Berlin, Oslo</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div id="SourceQ42" class="tab-pane fade text-center">
                                                    <br />
                                                    <div class="text-center">
                                                        <p><b>Click all the possible text and images within the source to find extra information.</b></p>
                                                    </div>
                                                    <div class="row">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td>
                                                                    <img src="Image/Q4.0.PNG" id="imgWorldQ4" />
                                                                </td>
                                                                <td rowspan="2">
                                                                    <img id="imgWorldMapQ4" src="Image/WhiteWorld.png" />
                                                                </td>
                                                            </tr>
                                                            <tr style="margin-left: 10%;">
                                                                <td>
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(1);">Antarctica</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(2);">Auckland</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(3);">Baikonur</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(4);">Berlin</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(5);">Hadar</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(6);">Lima</p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(7);">Oslo</p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="CustomPTag img-rounded" style="background-color: crimson; font-size: xx-large;" onclick="return ShowWorldMapQ4(8);">San Francisco</p>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 4a</b> (20 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                You are a researcher for a media company that wants to produce a documentary. Here is the brief for the documentary:
                                            </p>
                                            <div class="text-center">
                                                <img src="Image/Q4.PNG" />
                                            </div>
                                            <p class="CustomFontSize">
                                                Prepare and <b>justify</b> your route for the documentary. In your justification you must:
                                            <ul class="CustomFontSize">
                                                <li>visit at least four locations from the ones provided in the map, one of which will be the starting point Hadar</li>
                                                <li>indicate the budget, time and distance required for your proposal and attempt to stay within the conditions set by the media company</li>
                                                <li>provide a theme for the documentary</li>
                                                <li>make connections between the locations</li>
                                                <li>explain how the locations contribute to the purpose of the documentary</li>
                                                <li>where necessary, provide reasons for going outside of the conditions set by the media company.</li>
                                            </ul>
                                            </p>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion17')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                            </div>
                                            <br />
                                        </div>

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 4b</b> (16 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Explain</b> how you have prepared an effective travel route. In your answer, you must include the following considerations:
                                               <ul class="CustomFontSize">
                                                   <li>Given the conditions and brief, how does your route and justification combine mathematics and individuals and societies to meet the purpose of the documentary?</li>
                                                   <li>What information did you provide to the audience and why?</li>
                                                   <li>Why would people want to watch your documentary?</li>
                                               </ul>
                                            </p>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion18')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item" id="divQuestion5">
                            <div style="margin: 20px">
                                <h3><b>Question - 5</b> (10 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ5" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ52">Source 8</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ52" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Q8.jpg" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                You work for a national space programme and have been asked to create an action plan to assess the viability of a human settlement on Mars. 
                                                <br />
                                                <b>Formulate three</b> research questions and the method you would use to research each question. In your answer you must:
                                              <ul class="CustomFontSize">
                                                  <li>consider both mathematics and individuals and societies</li>
                                                  <li>consider the characteristics of good research questions</li>
                                                  <li>include an appropriate research method to address each question</li>
                                                  <li>consider relevant information from the pre-release material.</li>
                                              </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize" style="text-align: center"><b>To what extent is it viable to settle on Mars?</b></p>
                                        </div>
                                        <br />
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research question 1</p>
                                                <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion19');" onfocusout="return StopAutoSave('txtQuestion19');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <br />
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research method 1</p>
                                                <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion20');" onfocusout="return StopAutoSave('txtQuestion20');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <br />
                                            <br />
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research question 2</p>
                                                <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion21');" onfocusout="return StopAutoSave('txtQuestion21');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <br />
                                            <br />
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research method 2</p>
                                                <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion22');" onfocusout="return StopAutoSave('txtQuestion22');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <br />
                                            <br />
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research question 3</p>
                                                <asp:TextBox ID="txtQuestion23" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion23');" onfocusout="return StopAutoSave('txtQuestion23');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <br />
                                            <br />
                                            <div class="col-md-12">
                                                <p class="CustomFontSize">Research method 3</p>
                                                <asp:TextBox ID="txtQuestion24" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion24');" onfocusout="return StopAutoSave('txtQuestion24');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion6">
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b> (20 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div>
                                            <p class="CustomFontSize">
                                                For this question, you should refer to <b>Source 9</b>. The cartoon strip sets out an internal monologue for motivations to explore. 
                                            </p>
                                        </div>
                                        <div id="divmainContentQ6" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source61">Source 9</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source61" class="tab-pane fade in active">
                                                    <div class="CustomFontSize">
                                                        “Let’s explore” is an internal monologue between imagination and reason and it considers motivations for exploration.
                                                    </div>
                                                    <div class="text-center">
                                                        <img src="Image/Q9.jpg" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 6a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            Imagination and reason are both motivations for exploration. Match the major scientific and technical innovations to <b>either</b> imagination <b>or</b> reason. <b>Outine</b> your reasoning.<br />
                                        </div>
                                        <div class="text-center">
                                            <img src="Image/Q6.PNG" />
                                        </div>
                                        <br />
                                        <h3>
                                            <p class="text-center"><b>Select Below option for Imagination and Reason</b></p>
                                        </h3>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><b>Imagination</b></p>
                                                <asp:CheckBoxList ID="txtQuestion29" runat="server" RepeatLayout="OrderedList">
                                                    <asp:ListItem Value="Sun Compass">Sun Compass</asp:ListItem>
                                                    <asp:ListItem Value="Waka">Waka</asp:ListItem>
                                                    <asp:ListItem Value="Vostok 1">Vostok 1</asp:ListItem>
                                                    <asp:ListItem Value="Google Earth">Google Earth</asp:ListItem>
                                                </asp:CheckBoxList>
                                            </div>
                                            <div class="col-md-6">
                                                <p><b>Reason</b></p>
                                                <asp:CheckBoxList ID="txtQuestion30" runat="server" RepeatLayout="OrderedList">
                                                    <asp:ListItem Value="Sun Compass">Sun Compass</asp:ListItem>
                                                    <asp:ListItem Value="Waka">Waka</asp:ListItem>
                                                    <asp:ListItem Value="Vostok 1">Vostok 1</asp:ListItem>
                                                    <asp:ListItem Value="Google Earth">Google Earth</asp:ListItem>
                                                </asp:CheckBoxList>
                                            </div>
                                        </div>
                                        <br />
                                        <p class="CustomFontSize"><b>Explain the reasoning in the boxes given below.</b></p>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p class="CustomFontSize">Imagination</p>
                                                <asp:TextBox ID="txtQuestion25" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion25');" onfocusout="return StopAutoSave('txtQuestion25');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                            <div class="col-md-6">
                                                <p class="CustomFontSize">Reason</p>
                                                <asp:TextBox ID="txtQuestion26" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion26');" onfocusout="return StopAutoSave('txtQuestion26');" Height="250px" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 6b</b> (16 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize"><b>Evaluate</b> the role of imagination and reason in exploration. In your answer you must:</p>
                                            <ul class="CustomFontSize">
                                                <li>consider the benefits and limitations of imagination in deciding to explore</li>
                                                <li>consider the benefits and limitations of reason in deciding to explore</li>
                                                <li>include a conclusion about the importance of deciding to explore, based on the arguments presented</li>
                                                <li>use <b>Source 9</b> in your evaluation. </li>
                                            </ul>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <asp:TextBox ID="txtQuestion27" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion27')" class="btn btn-primary">Save</button>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion27.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion7">
                            <div style="margin: 20px">
                                <h3><b>Question - 7</b> (10 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="text-center">
                                            <img src="Image/Q7.PNG" />
                                        </div>
                                        <div class="CustomFontSize">
                                            Choose <b>one</b> major scientific and technical innovation from the timeline. <b>To what extent</b> does your chosen innovation demonstrate progress in exploration? In your answer you must:
                                            <ul>
                                                <li>refer to the global context focus “adaptation, ingenuity and progress”</li>
                                                <li>use evidence from the pre-release material to support your argument</li>
                                                <li>write a conclusion about how your choice demonstrates progress.</li>

                                            </ul>
                                            <div class="text-center">
                                                <asp:TextBox ID="txtQuestion28" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion28')" class="btn btn-primary">Save</button>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion28.ClientID%>');</script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion8">
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
                                <li id="li1" class="active liNav" data-target="#myCarousel" data-slide-to="0" onclick="return Top();"><a href="#" class="liNavA">Que 1</a></li>
                                <li id="li2" class="liNav" data-target="#myCarousel" data-slide-to="1" onclick="return Top();"><a href="#" class="liNavA">Que 2</a></li>
                                <li id="li3" class="liNav" data-target="#myCarousel" data-slide-to="2" onclick="return Top();"><a href="#" class="liNavA">Que 3</a></li>
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Que 4</a></li>
                                <li id="li5" class="liNav" data-target="#myCarousel" data-slide-to="4" onclick="return Top();"><a href="#" class="liNavA">Que 5</a></li>
                                <li id="li6" class="liNav" data-target="#myCarousel" data-slide-to="5" onclick="return Top();"><a href="#" class="liNavA">Que 6</a></li>
                                <li id="li7" class="liNav" data-target="#myCarousel" data-slide-to="6" onclick="return Top();"><a href="#" class="liNavA">Que 7</a></li>
                                <li id="li8" class="liNav" data-target="#myCarousel" data-slide-to="7" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
            <div id="divExamFinish" class="text-center" runat="server">
                <strong>Your Exam is over
                </strong>
            </div>

            <div id="ShowModalPopup" clientidmode="Static" runat="server" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>
                                <asp:Label ID="lblTitle" runat="server" Text="Map"></asp:Label>
                            </b></h4>
                        </div>
                        <div class="modal-body text-center" style="padding-bottom: 0px">
                            <img id="imgPopUp" src="" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
