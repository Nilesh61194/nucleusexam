<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IDU_G10_May_2019.aspx.cs" Inherits="NucleusExams.Grade10.IDUMay2019.IDU_G10_May_2019" ValidateRequest="false" EnableViewState="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IDU Grade 10 May 2019</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <script src="../../ckeditor4/ckeditor.js"></script>
    <style>
        .ulNav {
            list-style-type: none;
            margin: 0;
            overflow: hidden;
            background-color: #333333;
            margin-left: 25%;
            margin-right: 25%;
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

        /*.button {
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
        }*/

        .highlight {
            border-style: solid;
            border-color: darkorange;
            border-width: 5px;
        }

        .CustomFontSize {
            text-align: justify;
            font-size: larger;
        }

        .button {
            font-size: 10px;
            text-align: center;
            cursor: pointer;
            outline: none;
            color: white;
            background-color: #111111;
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px #ff6a00;
        }

            .button:hover {
                background-color: #b200ff;
                color: white;
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

        function StopAutoSaveTextBox(id) {
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
            //debugger;

            var current = $('div.item.active').attr("id");
            SaveOnNavigationByDivID(current);
            //  SaveForNextQuestion();
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }


        function SaveOnNavigationByDivID(id) {
            console.log("All answer is saved of div of :- " + id);

            if (id == "divQuestion1") {
                var TextboxID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6"];
                var i;
                for (i = 0; i <= TextboxID.length - 1; i++) {
                    callSave(TextboxID[i]);
                }

                var answer = CKEDITOR.instances["txtQuestion7"].getData();
                var ControlID = "txtQuestion7";
                if (value != "") {
                    SaveAnswer(ControlID, answer);
                }
            }

            else if (id == "divQuestion2") {
                var CKEdiorID = ["txtQuestion8", "txtQuestion9", "txtQuestion10", "txtQuestion11", "txtQuestion12", "txtQuestion13", "txtQuestion14"];
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
                var CKEdiorID = ["txtQuestion15"];
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
                var CKEdiorID = ["txtQuestion16"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            else if (id == "divQuestion5") {
                var CKEdiorID = ["txtQuestion17", "txtQuestion18"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            else if (id == "divQuestion6") {
                var CKEdiorID = ["txtQuestion19"];
                var i;
                for (i = 0; i <= CKEdiorID.length - 1; i++) {
                    var id = CKEdiorID[i];
                    var value = CKEDITOR.instances["" + id + ""].getData();
                    if (value != "") {
                        SaveAnswer(id, value);
                    }
                }
            }
            else if (id == "divQuestion7") {
                var CKEdiorID = ["txtQuestion20"];
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

        // save fuction 

        function callSave(control) {
            debugger;
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
                    clearInterval(myVarCKE);
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

            var TextboxID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6"];
            var k;
            for (k = 0; k <= TextboxID.length - 1; k++) {
                callSave(TextboxID[k]);
            }

            var CKEdiorID = ["txtQuestion7", "txtQuestion8", "txtQuestion9", "txtQuestion10", "txtQuestion11", "txtQuestion12", "txtQuestion13", "txtQuestion14",
                               "txtQuestion15", "txtQuestion16", "txtQuestion17", "txtQuestion18", "txtQuestion19", "txtQuestion20"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                if (value != "") {
                    SaveAnswer(id, value);
                }

            }
        }

        //function allanswersave() {
        //    SaveAnswerAllTime();
        //}

        function SaveAnswer(ControlID, value) {
            debugger;
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
                        console.log(ControlID);
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
                        document.getElementById("txtQuestion1").value = Row[0]["Answer"];
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion2") return item });
                    if (Row.length > 0) {
                        document.getElementById("txtQuestion2").value = Row[0]["Answer"];

                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion3") return item });
                    if (Row.length > 0) {
                        document.getElementById("txtQuestion3").value = Row[0]["Answer"];

                    }
                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion4") return item });
                    if (Row.length > 0) {
                        document.getElementById("txtQuestion4").value = Row[0]["Answer"];
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion5") return item });
                    if (Row.length > 0) {
                        document.getElementById("txtQuestion5").value = Row[0]["Answer"];
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion6") return item });
                    if (Row.length > 0) {
                        document.getElementById("txtQuestion6").value = Row[0]["Answer"];
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

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion11") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion11'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion12") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion12'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion13") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion13'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion14") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion14'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion15") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion15'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion16") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion16'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion17") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion17'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion18") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion18'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion19") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion19'].setData(Row[0]["Answer"]);
                    }

                    Row = data.filter(function (item) { if (item["QID"] == "txtQuestion20") return item });
                    if (Row.length > 0) {
                        CKEDITOR.instances['txtQuestion20'].setData(Row[0]["Answer"]);
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
                            <a class="fa fa-tools fa-2x" href="http://idprm.ibo.org/m19.html#/English" target="_blank"></a>
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
                                <h3><b>Question - 1</b> (10 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div id="divmainContent" style="overflow: auto; height: 600px; margin: 10px!important;">
                                        <div class="CustomFontSize">
                                            <b>This media is interactive</b><br />
                                            Click on the Source buttons to revel the research findings.
                                        </div>
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a data-toggle="tab" href="#Q1Home">Home</a></li>
                                            <li><a data-toggle="tab" href="#Q1SourceA">Source A</a></li>
                                            <li><a data-toggle="tab" href="#Q1SourceB">Source B</a></li>
                                            <li><a data-toggle="tab" href="#Q1SourceC">Source C</a></li>
                                            <li><a data-toggle="tab" href="#Q1SourceD">Source D</a></li>
                                        </ul>

                                        <div class="tab-content">
                                            <div id="Q1Home" class="tab-pane fade in active" style="background-color: #305c8a; min-height: 600px!important">
                                                <img src="Image/Source1H1.jpg" width="100%" />
                                                <div>
                                                    <div class="CustomFontSize" style="margin: 20px!important">
                                                        <p style="color: white">You have been asked to investigate the following debatable question :</p>
                                                        <br />
                                                        <h3 style="color: white"><b>To what extent should there be limits to freedom of expression on the internet ?</b></h3>
                                                        <br />
                                                        <br />
                                                        <p style="color: white">On the top-hand side are four sources you found on the internet to support your research</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="Q1SourceA" class="tab-pane fade">
                                                <img src="Image/Source1A.jpg" width="100%" />
                                            </div>
                                            <div id="Q1SourceB" class="tab-pane fade">
                                                <img src="Image/Source1B.jpg" width="100%" />
                                            </div>
                                            <div id="Q1SourceC" class="tab-pane fade">
                                                <img src="Image/Source1C.jpg" width="100%" />
                                            </div>
                                            <div id="Q1SourceD" class="tab-pane fade">
                                                <img src="Image/Source1D.jpg" width="100%" />
                                            </div>
                                        </div>
                                    </div>

                                    <div style="margin: 10px!important;" class="CustomFontSize">
                                        <b>Source A: </b>
                                        <br />
                                        International Baccalaureate Organization 2019. Tree Top High<br />
                                        <b>Source B: </b>
                                        <br />
                                        International Baccalaureate Organization 2019. World news<br />
                                        <b>Source C: </b>
                                        <br />
                                        Global internet freedom, adapted from https://thenetmonitor.org<br />
                                        <b>Source D: </b>
                                        <br />
                                        International Baccalaureate Organization 2019. Rotter Z, (2018), Disagree with what you are saying: a treaty on freedom of thought and speech
                                    </div>
                                    <hr />
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
                                                    <input type="text" onkeypress="return event.keyCode!=13;" id="txtQuestion1" style="width: 100%" onfocus="return startAutoSave('txtQuestion1');" onblur="return StopAutoSaveTextBox('txtQuestion1');" />
                                                </div>
                                                <div class="col-md-6" style="padding: 10px!important">
                                                    <p style="background-color: lightseagreen; color: white; font-weight: bold" class="text-center">Unlimited freedom of speech</p>
                                                    <input type="text" onkeypress="return event.keyCode!=13;" id="txtQuestion2" style="width: 100%" onfocus="return startAutoSave('txtQuestion2');" onblur="return StopAutoSaveTextBox('txtQuestion2');" />
                                                </div>
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
                                                <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion3');" onfocusout="return StopAutoSaveTextBox('txtQuestion3');" Height="250px" Width="100%"></asp:TextBox>

                                                <br />
                                                <h4><b>Purpose of the source A </b></h4>
                                                <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion4');" onfocusout="return StopAutoSaveTextBox('txtQuestion4');" Height="300px" Width="100%"></asp:TextBox>
                                            </div>
                                            <div class="col-lg-6">
                                                <h4><b>Source C</b><br />
                                                    Origin of Source C
                                                </h4>
                                                <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion5');" onfocusout="return StopAutoSaveTextBox('txtQuestion5');" Height="250px" Width="100%"></asp:TextBox>
                                                <br />
                                                <h4><b>Purpose of the source C</b></h4>
                                                <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" onfocus="return startAutoSave('txtQuestion6');" onfocusout="return StopAutoSaveTextBox('txtQuestion6');" Height="300px" Width="100%"></asp:TextBox>
                                            </div>

                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1c</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Justify</b> one limitation of Source C.

                                        <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion2">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2</b> (10 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divQ2Content" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Q2R2">Reference 2 transcript</a></li>
                                                <li><a data-toggle="tab" href="#Q2R3">Reference 3</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Q2R2" class="tab-pane fade in active">
                                                    <div class="CustomFontSize" style="margin: 5px;">
                                                        The transcript is for the video from Reference 2 which is available in the pre-release material.<br />
                                                        <b>Video script:</b><br />
                                                        Nudge!<br />
                                                        How to convince people to make different decisions.<br />
                                                        People don't always act rationally. Most of the time people act irrationally, but they do this in a predictable way.<br />
                                                        We can use this knowledge to influence the decisions people make with a nudge.<br />
                                                        There are three types of nudging techniques:<br />
                                                        <ul>
                                                            <li>Anchoring</li>
                                                            <li>Defaulting</li>
                                                            <li>Framing</li>
                                                        </ul>
                                                        <b>Anchoring</b><br />
                                                        Is the number of refugees in the world more or less than 50 million?<br />
                                                        What if you were asked this question in a different way?<br />
                                                        Is the number of refugees in the world more or less than 2 million?<br />
                                                        Studies have shown that people who are asked the first question respond with a higher number than those asked the second question.<br />
                                                        <br />
                                                        <b>Defaulting</b><br />
                                                        Setting up a default is a simple nudge.<br />
                                                        Automatic sign ups or default payment renewals make decisions easy, and most people just go along with it.<br />
                                                        <br />
                                                        <b>Framing
                                                        </b>
                                                        <br />
                                                        The way in which a situation is portrayed can influence people’s thinking.<br />
                                                        5000 refugees in a city will die from a disease if you do nothing. You have two options:<br />
                                                        If you choose the first option, 2000 people will be saved.<br />
                                                        If you choose the second option, there is a 40 % chance that 5000 people will be saved and a 60 % chance that no one will be saved.<br />
                                                        Research shows that the majority of people will choose the first option, even though the outcome is identical.<br />
                                                        <br />

                                                        Source: International Baccalaureate Organization 2019. A video on nudge theory
                                                    </div>
                                                </div>
                                                <div id="Q2R3" class="tab-pane fade">
                                                    <div class="CustomFontSize" style="margin: 5px;">
                                                        Online funding or sponsorship websites such as Kiva in the US and JustGiving in the UK make a point of displaying not only the 
                                                        amount of money raised so far, but also how this equates to the desired target in percentage terms.
                                                        <br />
                                                        This allows donors to see themselves in the powerful position of tipping the balance – rounding up a current total to a heftier sum – and there’s no 
                                                        denying the satisfaction to be had from taking someone’s total raised so far from say, $455, to a mighty $500 and in so doing pushing the percentage 
                                                        ever closer to the 100 % mark.
                                                        <br />
                                                        This technique is illustrated in the image below where the target amount is $4000 and the percentage achieved is 21 %.<br />

                                                        <img src="Image/Source3.jpg" width="100%" />
                                                        <br />
                                                        Their results were impressive – <b>increasing the percentage already raised from 10 % to 67 % led to improved response rates:</b> 3.7 % vs 8.2 % of the <u>solicited</u>
                                                        individuals. And not only do more individuals respond, but the size of donations increases as well.
                                                        <br />
                                                        <br />
                                                        <div class="row text-center">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <table border="1" class="text-center" style="width: 100%">
                                                                    <tr>
                                                                        <td><b>Percentage of target achieved</b></td>
                                                                        <td><b>Average donation in $</b></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>10
                                                                        </td>
                                                                        <td>15
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>33
                                                                        </td>
                                                                        <td>26
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>67
                                                                        </td>
                                                                        <td>40
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>

                                                        </div>
                                                        <br />
                                                        They also found that people gave fewer small donations when a large percentage had 
                                                        already been achieved, and large gifts (defined as over $20) were more frequent.
                                                        <br />
                                                        <br />
                                                        Source: Adapted from https://fundraising.co.uk
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            The data from the nudge theory in <b>reference 3</b> can be represented in scatter plot in order to look for patterns and make predictions.<br />
                                            <b>Construct</b> a scatter diagram to represent the percentage of monetary target achieved against the average size of donation. .
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>x axis label :</b>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize">
                                            <b>y axis label :</b>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2b</b> (1 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>State </b>the relationship between the percentage of monetary target achieved and the average size of donation.
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2c</b> (1 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Estimate </b>the average size of the donation for 50 % of the target achieved.
                                            <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2d</b> (1 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Suggest </b>a reason why you would not predict the size of the donation for 80 % of the target achieved.
                                            <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
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
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        </div>

                                    </div>

                                </div>
                            </div>
                            <div>
                            </div>
                        </div>

                        <div class="item" id="divQuestion3">
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divQ3Content" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Q3R2">Reference 2 transcript</a></li>
                                                <li><a data-toggle="tab" href="#Q3R3">Reference 3</a></li>
                                                <li><a data-toggle="tab" href="#Q3R5">Reference 5</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Q3R2" class="tab-pane fade in active">
                                                    <div class="CustomFontSize" style="margin: 5px;">
                                                        The transcript is for the video from Reference 2 which is available in the pre-release material.<br />
                                                        <b>Video script:</b><br />
                                                        Nudge!<br />
                                                        How to convince people to make different decisions.<br />
                                                        People don't always act rationally. Most of the time people act irrationally, but they do this in a predictable way.<br />
                                                        We can use this knowledge to influence the decisions people make with a nudge.<br />
                                                        There are three types of nudging techniques:<br />
                                                        <ul>
                                                            <li>Anchoring</li>
                                                            <li>Defaulting</li>
                                                            <li>Framing</li>
                                                        </ul>
                                                        <b>Anchoring</b><br />
                                                        Is the number of refugees in the world more or less than 50 million?<br />
                                                        What if you were asked this question in a different way?<br />
                                                        Is the number of refugees in the world more or less than 2 million?<br />
                                                        Studies have shown that people who are asked the first question respond with a higher number than those asked the second question.<br />
                                                        <br />
                                                        <b>Defaulting</b><br />
                                                        Setting up a default is a simple nudge.<br />
                                                        Automatic sign ups or default payment renewals make decisions easy, and most people just go along with it.<br />
                                                        <br />
                                                        <b>Framing
                                                        </b>
                                                        <br />
                                                        The way in which a situation is portrayed can influence people’s thinking.<br />
                                                        5000 refugees in a city will die from a disease if you do nothing. You have two options:<br />
                                                        If you choose the first option, 2000 people will be saved.<br />
                                                        If you choose the second option, there is a 40 % chance that 5000 people will be saved and a 60 % chance that no one will be saved.<br />
                                                        Research shows that the majority of people will choose the first option, even though the outcome is identical.<br />
                                                        <br />

                                                        Source: International Baccalaureate Organization 2019. A video on nudge theory
                                                    </div>
                                                </div>
                                                <div id="Q3R3" class="tab-pane fade">
                                                    <div class="CustomFontSize" style="margin: 5px;">
                                                        Online funding or sponsorship websites such as Kiva in the US and JustGiving in the UK make a point of displaying not only the 
                                                        amount of money raised so far, but also how this equates to the desired target in percentage terms.
                                                        <br />
                                                        This allows donors to see themselves in the powerful position of tipping the balance – rounding up a current total to a heftier sum – and there’s no 
                                                        denying the satisfaction to be had from taking someone’s total raised so far from say, $455, to a mighty $500 and in so doing pushing the percentage 
                                                        ever closer to the 100 % mark.
                                                        <br />
                                                        This technique is illustrated in the image below where the target amount is $4000 and the percentage achieved is 21 %.<br />

                                                        <img src="Image/Source3.jpg" width="100%" />
                                                        <br />
                                                        Their results were impressive – <b>increasing the percentage already raised from 10 % to 67 % led to improved response rates:</b> 3.7 % vs 8.2 % of the <u>solicited</u>
                                                        individuals. And not only do more individuals respond, but the size of donations increases as well.
                                                        <br />
                                                        <br />
                                                        <div class="row text-center">
                                                            <div class="col-md-3">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <table border="1" class="text-center" style="width: 100%">
                                                                    <tr>
                                                                        <td><b>Percentage of target achieved</b></td>
                                                                        <td><b>Average donation in $</b></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>10
                                                                        </td>
                                                                        <td>15
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>33
                                                                        </td>
                                                                        <td>26
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>67
                                                                        </td>
                                                                        <td>40
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>

                                                        </div>
                                                        <br />
                                                        They also found that people gave fewer small donations when a large percentage had 
                                                        already been achieved, and large gifts (defined as over $20) were more frequent.
                                                        <br />
                                                        <br />
                                                        Source: Adapted from https://fundraising.co.uk
                                                    </div>
                                                </div>
                                                <div id="Q3R5" class="tab-pane fade">
                                                    <div style="margin: 5px!important; background-color: lightgray!important">
                                                        <b>
                                                            <h4>This media is interactive</h4>
                                                        </b>
                                                        <div class="row" style="margin: 20px">
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetTitle();">Title</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWho();">Who</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhat();">What</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhen();">When</a>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="row" style="margin: 20px">
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhere();">Where</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhy();">Why</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetHow();">How</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div>
                                                            <div class="row">
                                                                <div class="col-md-12 text-center">
                                                                    <div id="spanWho1">
                                                                        <b>
                                                                            <h2>REFU - SHELTER</h2>
                                                                        </b>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <img src="Image/Source5.1.jpg" width="100%" />
                                                                </div>
                                                                <div class="col-md-6">

                                                                    <div class="CustomFontSize">
                                                                        <div id="divTitle">
                                                                            <h3><b>Refugees</b></h3>

                                                                            Everyone deserves a home<br />
                                                                            <br />
                                                                        </div>

                                                                        <div style="margin-right: 20px">
                                                                            At  <span id="spanWho2">Refu-shelter</span> <span id="spanWhat1">we want to ensure all displaced people have a roof over their head and can live with dignity.</span>
                                                                            <span id="spanWhere1">Globally</span> the United Nations Refugee Agency is <span id="spanWhen1">currently</span> witnessing the highest level of refugees on record(see below).
                                                                This stress on the agency means that it is getting harder to provide suitable shelter and resources for refugees.   
                                                                        </div>
                                                                    </div>
                                                                    <br />


                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="CustomFontSize">The information illustrates the current plight of displaced people :</div>
                                                            <br />
                                                            <img src="Image/Source5.2.jpg" width="100%" />
                                                            <br />
                                                            <div class="CustomFontSize"><span id="spanWhat2">Data</span> taken from <span id="spanWhere2"><a>http://www.unhcr.org/uk/figures-at-a-glance.html</a></span> correct as <span id="spanWhen2">2016</span></div>
                                                            <br />
                                                            <img src="Image/Source5.3.jpg" width="100%" />
                                                            <div class="CustomFontSize" id="divHow">You can help by donating the cause by choosing a donatiohn button below.</div>
                                                            <br />
                                                            <img src="Image/Source5.4.jpg" width="100%" />
                                                            <br />
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <img src="Image/Source5.5.PNG" width="100%" height="75%" />
                                                                </div>
                                                                <div class="col-md-6">

                                                                    <div class="CustomFontSize" id="divWhy" style="margin: 10px!important">
                                                                        <b>
                                                                            <h3>why should you donate ?</h3>
                                                                            <br />

                                                                        </b>
                                                                        <div style="margin: 20px">
                                                                            with the increasing number of refugees globally, it is vital that their basic human rights are met whilst they are seeking
                                                                    asylum or waiting to return to their homes. Without your donations, water-based diseases will flourish in refugee camps, children will
                                                                    miss out on key literacy and numeracy skills, and whole families will live without the protection and warmth of a shelter. So 
                                                                    please donate now and share your donation to inspire others to do the same, and provide a safer and more dignified life for refugees
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <hr />
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
                                            below the canvas. <b><a href="https://www.autodraw.com" target="_blank" style="color: Highlight!important; text-decoration: underline">Click here for drawing and add screenshot in answer area given below</a></b>

                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item" id="divQuestion4">

                            <div style="margin: 20px">
                                <h3><b>Question - 4</b> (12 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ4" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ4R7">Reference 7</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ4R7" class="tab-pane fade in active">
                                                    <div class="text-center CustomFontSize">
                                                        <img src="Image/Source7.jpg" width="100%" />
                                                        <br />
                                                        Source: International Baccalaureate Organization 2019. Social media feeds
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <hr />
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
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item" id="divQuestion5">
                            <div style="margin: 20px">
                                <h3><b>Question - 5</b> (20 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divQ5Content" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Q5R2">Reference 2 transcript</a></li>
                                                <li><a data-toggle="tab" href="#Q5R4">Reference 4 transcript</a></li>
                                                <li><a data-toggle="tab" href="#Q5R5">Reference 5</a></li>
                                                <li><a data-toggle="tab" href="#Q5R6">Reference 6</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Q5R2" class="tab-pane fade in active">

                                                    <div class="CustomFontSize" style="margin: 5px;">
                                                        The transcript is for the video from Reference 2 which is available in the pre-release material.<br />
                                                        <b>Video script:</b><br />
                                                        Nudge!<br />
                                                        How to convince people to make different decisions.<br />
                                                        People don't always act rationally. Most of the time people act irrationally, but they do this in a predictable way.<br />
                                                        We can use this knowledge to influence the decisions people make with a nudge.<br />
                                                        There are three types of nudging techniques:<br />
                                                        <ul>
                                                            <li>Anchoring</li>
                                                            <li>Defaulting</li>
                                                            <li>Framing</li>
                                                        </ul>
                                                        <b>Anchoring</b><br />
                                                        Is the number of refugees in the world more or less than 50 million?<br />
                                                        What if you were asked this question in a different way?<br />
                                                        Is the number of refugees in the world more or less than 2 million?<br />
                                                        Studies have shown that people who are asked the first question respond with a higher number than those asked the second question.<br />
                                                        <br />
                                                        <b>Defaulting</b><br />
                                                        Setting up a default is a simple nudge.<br />
                                                        Automatic sign ups or default payment renewals make decisions easy, and most people just go along with it.<br />
                                                        <br />
                                                        <b>Framing
                                                        </b>
                                                        <br />
                                                        The way in which a situation is portrayed can influence people’s thinking.<br />
                                                        5000 refugees in a city will die from a disease if you do nothing. You have two options:<br />
                                                        If you choose the first option, 2000 people will be saved.<br />
                                                        If you choose the second option, there is a 40 % chance that 5000 people will be saved and a 60 % chance that no one will be saved.<br />
                                                        Research shows that the majority of people will choose the first option, even though the outcome is identical.<br />
                                                        <br />

                                                        Source: International Baccalaureate Organization 2019. A video on nudge theory
                                                    </div>
                                                </div>

                                                <div id="Q5R4" class="tab-pane fade">
                                                    <div class="CustomFontSize">
                                                        The transcript is for the video from Reference 4 which is available in the pre-release material.<br />
                                                        <b>Video script:</b><br />
                                                        <br />
                                                        So you’re ready to start crowdfunding. If you want people to donate to your cause, you need to 
                                                        give them all the information they’ll need to be convinced to give you their money.<br />
                                                        Here are seven requirements you should include in your appeal:<br />
                                                        A catchy title and image<br />
                                                        Who are you?<br />
                                                        What are you raising money for? Be clear.<br />
                                                        When will your project happen? Illustrate the urgency or a timeline.<br />
                                                        Where will your project happen? Is it a local or a global issue?<br />
                                                        How can people take action? Through donating and sharing on social media.<br />
                                                        Why are you raising money? Why does this matter? Who will benefit from it? What do people who donate get out of it?<br />
                                                        The number one rule is to be real. If you believe in your cause, you have a good chance of convincing others to do so as well. 
                                                        Your appeal should maximize your passion for your project and explain why it pays to participate.<br />
                                                        Keep it short, simple and to the point. Create an “elevator pitch”. Pretend a potential donor has just stepped into an elevator 
                                                        with you and you have the short ride to convince him or her to invest in your cause. Create a brief, persuasive speech, 20 to 30 seconds 
                                                        long when read aloud. Then use formatting tools such as bold, italics and text size to emphasize your points. Photos and video also
                                                         help sell your message and help people connect to you and your cause personally.<br />
                                                        <br />
                                                        Source: International Baccalaureate Organization 2019. Crowdfunding video
                                                    </div>
                                                </div>
                                                <div id="Q5R5" class="tab-pane fade">
                                                    <div style="margin: 5px!important; background-color: lightgray!important">
                                                        <b>
                                                            <h4>This media is interactive</h4>
                                                        </b>
                                                        <div class="row" style="margin: 20px">
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetTitle2();">Title</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWho2();">Who</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhat2();">What</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhen2();">When</a>
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div class="row" style="margin: 20px">
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhere2();">Where</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetWhy2();">Why</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <a class="button" onclick="return SetHow2();">How</a>
                                                            </div>
                                                            <div class="col-md-3">
                                                            </div>
                                                        </div>
                                                        <br />
                                                        <div>
                                                            <div class="row">
                                                                <div class="col-md-12 text-center">
                                                                    <div id="spanWho3">
                                                                        <b>
                                                                            <h2>REFU - SHELTER</h2>
                                                                        </b>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <img src="Image/Source5.1.jpg" width="100%" />
                                                                </div>
                                                                <div class="col-md-6">

                                                                    <div class="CustomFontSize">
                                                                        <div id="divTitle1">
                                                                            <h3><b>Refugees</b></h3>

                                                                            Everyone deserves a home<br />
                                                                            <br />
                                                                        </div>

                                                                        <div style="margin-right: 20px">
                                                                            At  <span id="spanWho4">Refu-shelter</span> <span id="spanWhat3">we want to ensure all displaced people have a roof over their head and can live with dignity.</span>
                                                                            <span id="spanWhere3">Globally</span> the United Nations Refugee Agency is <span id="spanWhen3">currently</span> witnessing the highest level of refugees on record(see below).
                                                                This stress on the agency means that it is getting harder to provide suitable shelter and resources for refugees.   
                                                                        </div>
                                                                    </div>
                                                                    <br />


                                                                </div>
                                                            </div>
                                                            <br />
                                                            <div class="CustomFontSize">The information illustrates the current plight of displaced people :</div>
                                                            <br />
                                                            <img src="Image/Source5.2.jpg" width="100%" />
                                                            <br />
                                                            <div class="CustomFontSize"><span id="spanWhat4">Data</span> taken from <span id="spanWhere4"><a>http://www.unhcr.org/uk/figures-at-a-glance.html</a></span> correct as <span id="spanWhen4">2016</span></div>
                                                            <br />
                                                            <img src="Image/Source5.3.jpg" width="100%" />
                                                            <div class="CustomFontSize" id="divHow1">You can help by donating the cause by choosing a donatiohn button below.</div>
                                                            <br />
                                                            <img src="Image/Source5.4.jpg" width="100%" />
                                                            <br />
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <img src="Image/Source5.5.PNG" width="100%" height="75%" />
                                                                </div>
                                                                <div class="col-md-6">

                                                                    <div class="CustomFontSize" id="divWhy1" style="margin: 10px!important">
                                                                        <b>
                                                                            <h3>why should you donate ?</h3>
                                                                            <br />

                                                                        </b>
                                                                        <div style="margin: 20px">
                                                                            with the increasing number of refugees globally, it is vital that their basic human rights are met whilst they are seeking
                                                                    asylum or waiting to return to their homes. Without your donations, water-based diseases will flourish in refugee camps, children will
                                                                    miss out on key literacy and numeracy skills, and whole families will live without the protection and warmth of a shelter. So 
                                                                    please donate now and share your donation to inspire others to do the same, and provide a safer and more dignified life for refugees
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="Q5R6" class="tab-pane fade">
                                                    <img src="Image/Source6.jpg" width="100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
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
                                            <b><a href="https://www.autodraw.com" target="_blank" style="color: Highlight!important; text-decoration: underline">Click here for drawing and add screenshot in answer area given below</a></b>
                                            <br />
                                            <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
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

                                            <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion6">
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b> (12 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divQ6Content" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Q6R1">Reference 1</a></li>
                                                <li><a data-toggle="tab" href="#Q6R8">Reference 8</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div class="CustomFontSize">
                                                    <b>This media is interactive</b><br />
                                                    Click on the Source buttons to revel the research findings.
                                                </div>
                                                <div id="Q6R1" class="tab-pane fade in active">
                                                    <div id="divmainQ6Content" style="overflow: auto; height: 600px; margin: 10px!important;">
                                                        <ul class="nav nav-tabs">
                                                            <li class="active"><a data-toggle="tab" href="#Q6Home">Home</a></li>
                                                            <li><a data-toggle="tab" href="#Q6SourceA">Source A</a></li>
                                                            <li><a data-toggle="tab" href="#Q6SourceB">Source B</a></li>
                                                            <li><a data-toggle="tab" href="#Q6SourceC">Source C</a></li>
                                                            <li><a data-toggle="tab" href="#Q6SourceD">Source D</a></li>
                                                        </ul>

                                                        <div class="tab-content">
                                                            <div id="Q6Home" class="tab-pane fade in active" style="background-color: #305c8a; min-height: 600px!important">
                                                                <img src="Image/Source1H1.jpg" width="100%" />
                                                                <div>
                                                                    <div class="CustomFontSize" style="margin: 20px!important">
                                                                        <p style="color: white">You have been asked to investigate the following debatable question :</p>
                                                                        <br />
                                                                        <h3 style="color: white"><b>To what extent should there be limits to freedom of expression on the internet ?</b></h3>
                                                                        <br />
                                                                        <br />
                                                                        <p style="color: white">On the top-hand side are four sources you found on the internet to support your research</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="Q6SourceA" class="tab-pane fade">
                                                                <img src="Image/Source1A.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q6SourceB" class="tab-pane fade">
                                                                <img src="Image/Source1B.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q6SourceC" class="tab-pane fade">
                                                                <img src="Image/Source1C.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q6SourceD" class="tab-pane fade">
                                                                <img src="Image/Source1D.jpg" width="100%" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="Q6R8" class="tab-pane fade">
                                                    <img src="Image/Source8.jpg" width="100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="CustomFontSize">
                                            <b>To what extent</b> can someone know the truth if they only receive their information from one source? In your answer, you must include: 
                                            <ul>
                                                <li>a justification of when it is appropriate to only use one source</li>
                                                <li>a justification of when it is not appropriate to only use one source </li>
                                                <li>evidence from the pre-release material to support your arguments </li>
                                                <li>a conclusion.</li>
                                            </ul>
                                            <br />
                                            <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divQuestion7">
                            <div style="margin: 20px">
                                <h3><b>Question - 7</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divQ7Content" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Q7R1">Reference 1</a></li>
                                                <li><a data-toggle="tab" href="#Q7R7">Reference 7</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Q7R1" class="tab-pane fade in active">
                                                    <div class="CustomFontSize">
                                                        <b>This media is interactive</b><br />
                                                        Click on the Source buttons to revel the research findings.
                                                    </div>
                                                    <div id="divmainQ7Content" style="overflow: auto; height: 600px; margin: 10px!important;">
                                                        <ul class="nav nav-tabs">
                                                            <li class="active"><a data-toggle="tab" href="#Q7Home">Home</a></li>
                                                            <li><a data-toggle="tab" href="#Q7SourceA">Source A</a></li>
                                                            <li><a data-toggle="tab" href="#Q7SourceB">Source B</a></li>
                                                            <li><a data-toggle="tab" href="#Q7SourceC">Source C</a></li>
                                                            <li><a data-toggle="tab" href="#Q7SourceD">Source D</a></li>
                                                        </ul>

                                                        <div class="tab-content">
                                                            <div id="Q7Home" class="tab-pane fade in active" style="background-color: #305c8a; min-height: 600px!important">
                                                                <img src="Image/Source1H1.jpg" width="100%" />
                                                                <div>
                                                                    <div class="CustomFontSize" style="margin: 20px!important">
                                                                        <p style="color: white">You have been asked to investigate the following debatable question :</p>
                                                                        <br />
                                                                        <h3 style="color: white"><b>To what extent should there be limits to freedom of expression on the internet ?</b></h3>
                                                                        <br />
                                                                        <br />
                                                                        <p style="color: white">On the top-hand side are four sources you found on the internet to support your research</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div id="Q7SourceA" class="tab-pane fade">
                                                                <img src="Image/Source1A.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q7SourceB" class="tab-pane fade">
                                                                <img src="Image/Source1B.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q7SourceC" class="tab-pane fade">
                                                                <img src="Image/Source1C.jpg" width="100%" />
                                                            </div>
                                                            <div id="Q7SourceD" class="tab-pane fade">
                                                                <img src="Image/Source1D.jpg" width="100%" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="Q7R7" class="tab-pane fade CustomFontSize">
                                                    <img src="Image/Source7.jpg" width="100%" />
                                                    <br />
                                                    Source: International Baccalaureate Organization 2019. Social media feeds
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="CustomFontSize">
                                            <b>Evaluate</b> how freedom of speech is important to facilitate social change from your perspective. In your answer, you must include :
                                        <br />
                                            <ul>
                                                <li>strengths of freedom of speech </li>
                                                <li>limitations of freedom of speech </li>
                                                <li>an example from your “service as action” experience</li>
                                                <li>a conclusion. </li>
                                            </ul>
                                            <br />
                                            <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion20.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="divFinish">
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
                    <br />
                    <div class="row">
                        <div class="col-md-12" style="width: 100%!important">
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
        </div>
        <div id="divExamFinish" class="text-center" runat="server">
            <strong>Your Exam is over
            </strong>
        </div>

    </form>
</body>
</html>
<script>
    function RemoveClass() {
        document.getElementById("divTitle").removeAttribute("class", "highlight");
        document.getElementById("spanWho1").removeAttribute("class", "highlight");
        document.getElementById("spanWho2").removeAttribute("class", "highlight");
        document.getElementById("spanWhat1").removeAttribute("class", "highlight");
        document.getElementById("spanWhat2").removeAttribute("class", "highlight");
        document.getElementById("spanWhen1").removeAttribute("class", "highlight");
        document.getElementById("spanWhen2").removeAttribute("class", "highlight");
        document.getElementById("spanWhere1").removeAttribute("class", "highlight");
        document.getElementById("spanWhere2").removeAttribute("class", "highlight");
        document.getElementById("divWhy").removeAttribute("class", "highlight");
        document.getElementById("divHow").removeAttribute("class", "highlight");
    }

    function SetTitle() {
        RemoveClass();
        document.getElementById("divTitle").setAttribute("class", "highlight");
    }
    function SetWho() {
        RemoveClass();
        document.getElementById("spanWho1").setAttribute("class", "highlight");
        document.getElementById("spanWho2").setAttribute("class", "highlight");
    }
    function SetWhat() {
        RemoveClass();
        document.getElementById("spanWhat1").setAttribute("class", "highlight");
        document.getElementById("spanWhat2").setAttribute("class", "highlight");
    }
    function SetWhen() {
        RemoveClass();
        document.getElementById("spanWhen1").setAttribute("class", "highlight");
        document.getElementById("spanWhen2").setAttribute("class", "highlight");
    }
    function SetWhere() {
        RemoveClass();
        document.getElementById("spanWhere1").setAttribute("class", "highlight");
        document.getElementById("spanWhere2").setAttribute("class", "highlight");
    }
    function SetWhy() {
        RemoveClass();
        document.getElementById("divWhy").setAttribute("class", "highlight");
    }
    function SetHow() {
        RemoveClass();
        document.getElementById("divHow").setAttribute("class", "highlight");
    }





    function RemoveClass2() {
        document.getElementById("divTitle1").removeAttribute("class", "highlight");
        document.getElementById("spanWho3").removeAttribute("class", "highlight");
        document.getElementById("spanWho4").removeAttribute("class", "highlight");
        document.getElementById("spanWhat3").removeAttribute("class", "highlight");
        document.getElementById("spanWhat4").removeAttribute("class", "highlight");
        document.getElementById("spanWhen3").removeAttribute("class", "highlight");
        document.getElementById("spanWhen4").removeAttribute("class", "highlight");
        document.getElementById("spanWhere3").removeAttribute("class", "highlight");
        document.getElementById("spanWhere4").removeAttribute("class", "highlight");
        document.getElementById("divWhy1").removeAttribute("class", "highlight");
        document.getElementById("divHow1").removeAttribute("class", "highlight");
    }

    function SetTitle2() {
        RemoveClass2();
        document.getElementById("divTitle1").setAttribute("class", "highlight");
    }
    function SetWho2() {
        RemoveClass2();
        document.getElementById("spanWho3").setAttribute("class", "highlight");
        document.getElementById("spanWho4").setAttribute("class", "highlight");
    }
    function SetWhat2() {
        RemoveClass2();
        document.getElementById("spanWhat3").setAttribute("class", "highlight");
        document.getElementById("spanWhat4").setAttribute("class", "highlight");
    }
    function SetWhen2() {
        RemoveClass2();
        document.getElementById("spanWhen3").setAttribute("class", "highlight");
        document.getElementById("spanWhen4").setAttribute("class", "highlight");
    }
    function SetWhere2() {
        RemoveClass2();
        document.getElementById("spanWhere3").setAttribute("class", "highlight");
        document.getElementById("spanWhere4").setAttribute("class", "highlight");
    }
    function SetWhy2() {
        RemoveClass2();
        document.getElementById("divWhy1").setAttribute("class", "highlight");
    }
    function SetHow2() {
        RemoveClass2();
        document.getElementById("divHow1").setAttribute("class", "highlight");
    }
</script>
