<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IDU_G10.aspx.cs" Inherits="NucleusExams.Grade10.IDU.IDU_G10" ValidateRequest="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IDU Grade 10</title>
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
    </style>
    <script>
        $(document).ready(function () {
            $('#ShowModalPopup').appendTo("form");
            $('#ShowEarth').appendTo("form");
            $('#ShowCo2').appendTo("form");
            $('#WildFishingPopUp').appendTo("form");
            $('#AquaCulturePopUp').appendTo("form");
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


        // start script for open popup 
        function ShowPopUp() {
            $('#ShowModalPopup').modal('show');
            return false;
        }
        function ShowCo2() {
            $('#ShowCo2').modal('show');
            return false;
        }

        function ShowEarth() {
            $('#ShowEarth').modal('show');
            return false;
        }
        function WildFishing() {
            $('#WildFishingPopUp').modal('show');
            return false;
        }

        function AquaCulture() {
            $('#AquaCulturePopUp').modal('show');
            return false;
        }
        // end script 

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        // save fuction 
        function SaveAnswerAllTime() {


            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion14", "txtQuestion15", "txtQuestion16", "txtQuestion21",
                "txtQuestion22", "txtQuestion27", "txtQuestion29"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var TextBoxID = ["txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8", "txtQuestion9", "txtQuestion10",
                             "txtQuestion11", "txtQuestion12", "txtQuestion13", "txtQuestion17", "txtQuestion18", "txtQuestion19", "txtQuestion20",
                             "txtQuestion23", "txtQuestion24", "txtQuestion25", "txtQuestion26", "txtQuestion28"];
            var j;
            for (j = 0; j <= TextBoxID.length - 1; j++) {
                var id = TextBoxID[j];
                var value = document.getElementById(id).value;
                SaveAnswer(id, value);
            }
        }

        function allanswersave() {
            SaveAnswerAllTime();
        }

        function SaveAnswer(ControlID, value) {

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
                                <h3><b>Question - 1</b> (14 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">

                                    <div id="divmainContent" style="overflow: auto; height: 800px;">
                                        <ul class="nav nav-tabs">
                                            <li class="active"><a data-toggle="tab" href="#Source1">Source 1</a></li>
                                            <li><a data-toggle="tab" href="#Source2">Source 2</a></li>
                                        </ul>

                                        <div class="tab-content">
                                            <div id="Source1" class="tab-pane fade in active">
                                                <div class="text-center">
                                                    <h4><b>Scroll down to see buttons.</b></h4>
                                                    <img src="Image/IDu_G10_Question1.PNG" />
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-1">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <img src="Image/Question1_a_2.1.PNG" class="img-circle" />
                                                        <br />
                                                        <br />
                                                        <button onclick="return ShowPopUp();" class="button">Greenhouse Effects</button>
                                                    </div>
                                                    <div class="col-md-2">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <img src="Image/Question1_a_2.2.PNG" class="img-circle" />
                                                        <br />
                                                        <br />
                                                        <button onclick="return ShowEarth();" class="button">Impact on biodiversity</button>
                                                    </div>
                                                    <div class="col-md-2">
                                                    </div>
                                                    <div class="col-md-2">
                                                        <img src="Image/Question1_a_2.3.PNG" class="img-circle" />
                                                        <br />
                                                        <br />
                                                        <button onclick="return ShowCo2();" class="button">Impact of rising CO<sub>2</sub> levels</button>
                                                    </div>
                                                    <div class="col-md-1">
                                                    </div>
                                                </div>

                                            </div>
                                            <div id="Source2" class="tab-pane fade" style="margin: 30px; font-size: larger">
                                                <p style="text-align: justify;">
                                                    <h3><b>Guidelines for the use of animals in IB World Schools</b></h3>
                                                    <h4><b>Why have guidelines for use of animals in the classroom?</b></h4>
                                                    As respect for animals is a fundamental stepping stone in the development of respect for fellow human beings the IB animal guidelines seek to set out the parameters for the acceptable inclusion of animals in an IB World School.
                                                <br />
                                                    <br />
                                                    <h4><b>What do the guidelines apply to?</b></h4>
                                                    These guidelines apply to the treatment of all animals in IB World Schools, to all students at all levels including PYP, MYP, DP and IBCC whether assessed or non-assessed, for extended essays, the group 4 project and the MYP project. The Guidelines cover any work, be it in classrooms or school laboratories, or in the general environment, that is anywhere where IB students may be working. The Guidelines apply to:<br />
                                                    <ol>
                                                        <li>Keeping animals in schools
                                                        </li>
                                                        <li>Animal Experimentation
                                                        </li>
                                                        <li>The use of human subjects in investigations
                                                        </li>
                                                    </ol>

                                                    <h3><b>The Guidelines</b></h3>
                                                    <h4><b>Keeping live animals in the classroom</b></h4>
                                                    Caring for classroom pets can provide a variety of authentic learning contexts for students at almost every level. It presents opportunities for students to develop compassion and empathy towards other living things and take action as a result of this learning. Ultimately the decision to care for a live animal lies with the classroom teacher and time should be taken to adequately research the animal and determine a suitable diet, housing, exercise and socialization for the animal as well as how its care fits into the curriculum. The following should be carefully considered before committing to the care of a classroom pet:
                                                
                                                <ul>
                                                    <li>Student sensitivity or allergies to particular species, their food or bedding materials
                                                    </li>
                                                    <li>Type of animal (domestic rather than wild, not venomous or vicious, diurnal rather than nocturnal etc)
                                                    </li>
                                                    <li>Arrangements for housing the animal safely, comfortably, cleanly and in a manner that is not disruptive to the classroom environment
                                                    </li>
                                                    <li>Arrangements for appropriate care of the animals over weekends and holidays
                                                    </li>
                                                    <li>Long term care of the animal in cases where a future student is allergic or the animal can no longer live in the classroom
                                                    </li>
                                                </ul>

                                                    Additionally, essential agreements should be established regarding when and how the animal is to interact with students. These should ensure the health and safety for both students and the animal (e.g. students wash their hands before and after handling).
                                                
                                                <h3><b>The nature of the guidelines</b></h3>
                                                    IB animal experimentation guidelines may be more stringent than some local or national standards for experimentation in schools. Our standards for work in schools should also be more stringent than those of university and research and development committees as we are not carrying out essential, groundbreaking research. Practical work in schools has other purposes such as reinforcing concepts and teaching practical skills and techniques. Even in a practically based extended essay the work will not be fundamental, ground-breaking research.
                                                
                                                 <h3><b>Live animals in experimentation</b></h3>
                                                    Any planned and actual experimentation involving live animals must be subject to approval by the teacher following a discussion between teacher and student(s) based on the IB guidelines. This discussion should look at the 3Rs principle and the decision justified. The principles are:<br />

                                                    <ol>
                                                        <li>Replacement
                                                        </li>
                                                        <li>Refinement
                                                        </li>
                                                        <li>Reduction
                                                        </li>
                                                    </ol>


                                                    Any investigation involving animals should initially consider the replacement of animals with cells or tissues, plants or computer simulations. If the animal is essential to the investigation refinements to the investigation to alleviate any distress to the animal and a reduction in the numbers of animals involved should be made.
                                                <br />
                                                    <br />
                                                    Experiments involving animals must be based on observing and measuring aspects of natural animal behaviour. Any experimentation should not result in any cruelty to any animal, vertebrate or invertebrate. Therefore experiments that administer drugs or medicines or manipulate the environment or diet beyond that which can be regarded as humane is unacceptable in IB schools.
                                                
                                                 <h3><b>Animal dissection</b></h3>

                                                    There is no requirement in the PYP, MYP or in the DP group 4 sciences for students to witness or carry out a dissection of any animal, vertebrate or invertebrate. If teachers believe that it is an important educational experience and wish to include dissections in their scheme of work they must apply the following guidelines. The IB does not support animal dissection or the use of animal body parts in the PYP.
                                                
                                                <ul>
                                                    <li>Discuss reasons for dissections of whole animals with the students.</li>
                                                    <li>Allow any student who wishes to opt out of the dissection to do so.</li>
                                                    <li>Seek to reduce the number of dissections.</li>
                                                    <li>Seek to replace animal dissection with computer simulations and/or use animal tissue, for example, hearts and lungs obtained from butchers, abattoirs or laboratory suppliers.</li>
                                                    <li>Dissect animals obtained from an ethical source only, for example, no wild animals, animals killed on the road or endangered animals.</li>
                                                </ul>


                                                    <h3><b>Experiments involving human subjects</b></h3>

                                                    Any experimentation involving human subjects must be with their direct, legally obtained written permission and must follow the above guidelines. In addition, the investigation must not use human subjects under the age of 16 without the written consent of the parents or guardians.<br />

                                                    <ul>
                                                        <li>Subjects must provide written consent</li>
                                                        <li>The results of the investigation must be anonymous</li>
                                                        <li>Subjects must participate of their own free will</li>
                                                        <li>Subjects have the right to withdraw from the investigation at any time.</li>
                                                    </ul>

                                                    Investigations involving any body fluids must not be performed due to the risk of the transmission of blood-borne pathogens. An exception would be an investigator using their own saliva or sweat.
                                                
                                                 <h3><b>The use of secondary data</b></h3>

                                                    Secondary data acquired as a result of research that would not be in line with the above policy may be used under certain circumstances:
                                                <br />
                                                    <ul>
                                                        <li>Data acquired by professional researchers. In this case the data would be from research which is written up in academic journals and qualifies as ground breaking. Such research would have been presented to research committees for approval and be licensed.
                                                        </li>
                                                        <li>Research which was considered ethical at the time the research was conducted. Our view of animals and their welfare has moved on considerably in recent years. Much research conducted in a different culture would not be granted permission today even though at the time, it was considered acceptable. Data from such sources is acceptable.
                                                        </li>
                                                    </ul>

                                                    Some secondary data exists that was considered unethical even within the cultural and historical context of the day. Such data is not acceptable under any circumstances.
                                                
                                                   <h3><b>What happens if the guidelines are not followed?</b></h3>

                                                    Internal assessment moderators or extended essay examiners who see evidence that the guidelines are not being followed at the school, in the sample work sent for moderation or in extended essays are required to complete a problem report form (PRF) to be submitted to IB Cardiff.

                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <p style="margin: 10px!important; text-align: justify; font-size: larger">
                                        An experimental method:
                                        <br />
                                        <br />
                                        A student researcher wants to model the effect of carbon dioxide (CO<sub>2</sub>) levels on the environment. He sets up an initial experiment to investigate the effect of CO<sub>2</sub> levels on plants in a greenhouse with a fixed light source, using the apparatus shown in the three trials below. The researcher placed 10 cress plants in a pot inside each greenhouse and measured how much the plants grew in height in millimetres (mm) every day. The researcher continued the experiment for five days. The amount of CO<sub>2</sub> levels in each greenhouse is fixed to a constant by the amounts indicated in each greenhouse.
                                    </p>
                                    <br />
                                    <div style="margin-left: 10px!important; margin-right: 10px!important">
                                        <b>This media contains no audio</b><br />
                                        <br />
                                        <video width="100%" controls>
                                            <source src="Image/VideoQ1.mp4" type="video/mp4" />
                                            Your browser does not support HTML5 video.
                                        </video>
                                    </div>
                                    <br />
                                    <div style="margin: 10px!important;" class="text-center">
                                        <div>
                                            <h3><b>This media is interactive</b></h3>
                                            <br />
                                            <img src="Image/Diagram.gif" width="100%" class="text-center" />
                                        </div>
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Compare</b> the graphs generated by the three trials.<br />
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1b</b> (8 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Evaluate</b> the experimental method used in this experiment.<br />
                                            In your answer you should:
                                        <ul>
                                            <li>identify strengths and limitations in the experimental method</li>
                                            <li>suggest improvements.</li>
                                        </ul>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1c</b> (2 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <b>Suggest two</b> changes to the investigation above that would make it suitable for a scientist interested in the impact of climate change on animal life.
                                        <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2</b> (16 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                With reference to <b>Sources 3, 5</b> and <b>6</b> provided in the tabs below, select <b>two</b> different stakeholders and <b>outline</b> their different perspectives about fishing and the implications​ of overfishing. An example has been provided from a marine biologist. Implications could be taken from economic, social, political, environmental, ethical, legal or technological factors.
                                                <br />
                                                <h4><b>Example stakeholder:</b></h4>
                                                Marine biologist
                                                <h4><b>Perspective:</b></h4>
                                                Scientific data should be collected about fishing.
                                                <h4><b>Implications of overfishing:</b></h4>
                                                Scientists will have to advise policy makers based on analysis of the scientific data.
                                            </p>
                                        </div>

                                        <div id="divmainContentQ2" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ21">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ23">Source 5 Transcript</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ24">Source 6</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ21" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source3.png" width="100%" />
                                                    </div>
                                                </div>
                                                <div id="SourceQ23" class="tab-pane fade">
                                                    <img src="Image/Source5Script.jpg" width="100%" />
                                                </div>
                                                <div id="SourceQ24" class="tab-pane fade">
                                                    <img src="Image/FinalSource6.jpg" width="100%" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-lg-6">
                                                <h4><b>Stakeholder 1:</b></h4>

                                                <select id="txtQuestion4" class="CustomFontSize" runat="server">
                                                    <option value=""></option>
                                                    <option value="Consumer">Consumer</option>
                                                    <option value="Fisherman">Fisherman</option>
                                                    <option value="Corporate fishing company">Corporate fishing company</option>
                                                    <option value="Environmentalist">Environmentalist</option>
                                                    <option value="Economist">Economist</option>
                                                    <option value="Policy maker">Policy maker</option>
                                                    <option value="Historian">Historian</option>
                                                </select>

                                                <h4><b>Perspective</b></h4>

                                                <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Implications of overfishing</b></h4>

                                                <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />

                                            </div>
                                            <div class="col-lg-6">
                                                <h4><b>Stakeholder 2:</b></h4>
                                                <select id="txtQuestion7" class="CustomFontSize" runat="server">
                                                    <option value=""></option>
                                                    <option value="Consumer">Consumer</option>
                                                    <option value="Fisherman">Fisherman</option>
                                                    <option value="Corporate fishing company">Corporate fishing company</option>
                                                    <option value="Environmentalist">Environmentalist</option>
                                                    <option value="Economist">Economist</option>
                                                    <option value="Policy maker">Policy maker</option>
                                                    <option value="Historian">Historian</option>
                                                </select>
                                                <h4><b>Perspective</b></h4>

                                                <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Implications of overfishing</b></h4>

                                                <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                            </div>

                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2b</b> (12 marks)</span>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Analyse</b> the impact of fishing on the sustainability of marine life. With reference to the sources provided in the tabs, use the analysis table below to provide relevant information and reach a conclusion based on your analysis.
                                                In your answer you should:
                                                <ul class="CustomFontSize">
                                                    <li>consider a strength and weakness of fishing in terms of sustainability</li>
                                                    <li>mention an opportunity for sustainability of marine life</li>
                                                    <li>mention a threat that may affect the sustainability of marine life</li>
                                                    <li>give a conclusion.</li>
                                                </ul>

                                                <h3 class="text-center"><b>Analysis table</b></h3>
                                            </p>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <h4><b>Strength</b></h4>

                                                <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Opportunity</b></h4>

                                                <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine" Width="100%" Height="300px"></asp:TextBox><br />

                                            </div>
                                            <div class="col-lg-6">
                                                <h4><b>Weakness</b></h4>

                                                <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Threat</b></h4>
                                                <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine" Width="100%" Height="300px"></asp:TextBox><br />
                                            </div>

                                        </div>
                                        <br />
                                        <div>
                                            <b>
                                                <p class="CustomFontSize">
                                                    Conclusion about the impact of fishing on sustainability of marine life
                                                </p>
                                            </b>
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b> (25 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ3" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source31">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ33">Source 5 Transcript</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ34">Source 7</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source31" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source3.png" width="100%" />
                                                    </div>
                                                </div>
                                                <div id="SourceQ33" class="tab-pane fade">
                                                    <img src="Image/Source5Script.jpg" width="100%" />
                                                </div>
                                                <div id="SourceQ34" class="tab-pane fade">
                                                    <div class="row" style="text-align: center">
                                                        <img src="Image/Source7.PNG" />
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <button onclick="return WildFishing();" class="button">Wild Fishing</button>
                                                        </div>
                                                        <div class="col-md-2">
                                                        </div>
                                                        <div class="col-md-3">
                                                            <button onclick="return AquaCulture();" class="button">AquaCulture</button>
                                                        </div>
                                                        <div class="col-md-1">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <br />
                                        <div class="row" style="text-align: center">
                                            <img src="Image/Question7.PNG" width="90%" />
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 3a</b> (15 marks)</span>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                Using Sources <b>3, 5</b> and <b>7</b> provided in the tabs above, write an academic response to Dr Shukei Masuma’s statement in which you <b>evaluate</b> the potential impact of farmed bluefin tuna on sustainability. In your response you should:
                                                <ul class="CustomFontSize">
                                                    <li>identify relevant ways in which science is applied and used for fishing</li>
                                                    <li>identify relevant ways in which individual and collective interests impact fishing</li>
                                                    <li>identify relevant interactions and interdependence between individuals, societies and the environment</li>
                                                    <li>consider the implications of scientific innovation on sustainability of the ecosystem. </li>
                                                </ul>
                                            </p>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 3b</b> (10 marks)</span>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                Definition of the key concept <b>systems</b> from the MYP individuals and societies subject guide:
                                                <br />
                                                “Systems are sets of interacting or interdependent components. Systems provide structure and order in human, natural and built environments. Systems can be static or dynamic, simple or complex.”
                                                <br />
                                                <b>Explain</b> how you have synthesized your knowledge of both the sciences and individuals and societies in your academic response in part (a) and how this has contributed to your interdisciplinary understanding of the key concept of <b>systems</b>.
                                            </p>
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3><b>Question - 4</b> (20 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ4" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ42">Source 8 transcript</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ42" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source8VS.jpg" width="100%" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 4a</b> (4 marks)</span>
                                        </div>
                                        <p class="CustomFontSize">
                                            Referring to the information in the video, <b>identify four</b> examples that demonstrate disciplinary knowledge, two from sciences and two from individuals and societies. The video transcript is available to support your answer.
                                        </p>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <h4><b>Discipline : </b>Sciences</h4>
                                                <h4><b>Disciplinary knowledge:</b></h4>
                                                <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Discipline : </b>Individuals and societies</h4>
                                                <h4><b>Disciplinary knowledge:</b></h4>

                                                <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />

                                            </div>
                                            <div class="col-lg-6">
                                                <h4><b>Discipline : </b>Sciences</h4>
                                                <h4><b>Disciplinary knowledge:</b></h4>
                                                <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                                <br />
                                                <h4><b>Discipline : </b>Individuals and societies</h4>
                                                <h4><b>Disciplinary knowledge:</b></h4>
                                                <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox><br />
                                            </div>

                                        </div>

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 4b</b> (16 marks)</span>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>To what extent</b> does the video synthesize knowledge of <b>both</b> scientific understanding and individuals and societies to inform the viewer about sustainable living? 
                                            </p>
                                            <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion21.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 5</b> (15 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ5" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ52">Source 8 transcript</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ53">Source 9</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ52" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source8VS.jpg" width="100%" />
                                                    </div>
                                                </div>
                                                <div id="SourceQ53" class="tab-pane fade">
                                                    <img src="Image/Source9.jpg" width="100%" />
                                                </div>

                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Imagine you are a resident of the new ReGen community and you have been invited to join the community council. The council wants to provide a set of social guidelines for members of the community to follow. Your task is to <b>outline</b> the social guidelines.
                                                <br />
                                                <br />
                                                <b>The audience and purpose of the guidelines are:</b><br />
                                                <b>Audience:</b> new members of the ReGen community<br />
                                                <b>Purpose: </b>organize life within the community through establishing guiding principles, as well as what is considered as social behaviours that will have negative consequences on the community.
                                                 <br />
                                                Your social guidelines should:
                                                <ul class="CustomFontSize">
                                                    <li>include relevant scientific factors that will maintain a healthy balance of the community ecosystem</li>
                                                    <li>include positive social behaviour that will ensure the healthy balance of the community ecosystem</li>
                                                    <li>include social behaviours that may have negative consequences in the healthy balance of the community ecosystem</li>
                                                    <li>synthesize your knowledge in sciences and individuals and societies to demonstrate environmental and human systems interconnectedness</li>
                                                    <li>communicate considering the format, audience and purpose.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize" style="text-align: center"><b>Social guidelines for ReGen community</b></p>
                                            <p class="CustomFontSize">Insert title here:</p>
                                            <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion22.ClientID%>');</script>
                                            <br />
                                            <p class="CustomFontSize">Write the mission of the ReGen community here:</p>
                                            <asp:TextBox ID="txtQuestion23" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p class="CustomFontSize">Write <b>guiding principles</b> that members must follow to maintain a healthy community ecosystem here:</p>
                                                <asp:TextBox ID="txtQuestion24" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox><br />
                                            </div>
                                            <div class="col-md-6">
                                                <p class="CustomFontSize">Write <b>social behaviours</b> that will have negative consequences on the community here: </p>
                                                <asp:TextBox ID="txtQuestion25" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox><br />
                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">Give a brief <b>reasoning</b> of how guiding principles support the mission of the community here:</p>
                                            <asp:TextBox ID="txtQuestion26" runat="server" TextMode="MultiLine" Width="100%" Height="250px"></asp:TextBox><br />
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b> (16 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ6" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source61">Source 4</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source61" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source4.PNG" width="100%" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="CustomFontSize">
                                            Using the features of sustainability in <b>Source 4, evaluate</b> how sciences and individuals and societies help us to better understand the concept of sustainability. In your answer, you should consider the following:
                                            <ul>
                                                <li>the benefits of sciences and individuals and societies in understanding the concept of sustainability</li>
                                                <li>the limitations of sciences and individuals and societies in understanding the concept of sustainability</li>
                                                <li>the shared interdisciplinary understanding of the concept of sustainability</li>
                                                <li>each of the features of sustainability from <b>Source 4.</b></li>
                                            </ul>
                                            <br />
                                            <asp:TextBox ID="txtQuestion27" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion27.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 7</b> (14 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ7" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source71">Source 3</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source71" class="tab-pane fade in active">
                                                    <div class="text-center">
                                                        <img src="Image/Source3.png" width="100%" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="CustomFontSize">
                                            <b>Discuss</b> how another subject group, <b>excluding</b> sciences and individuals and societies, could help people understand the importance of sustainability.
                                            <br />
                                            In your answer, reflect on the development of your own interdisciplinary understanding by:  
                                            <ul>
                                                <li>referring to at least one source provided in this examination</li>
                                                <li>considering perspectives, arguments and/or evidence related to sustainability</li>
                                                <li>referring to questions from the examination</li>
                                                <li>referring to discussions from your classroom preparation. </li>
                                            </ul>
                                            <br />
                                            Select one other subject group from these options and write your answer in the box below:
                                            <br />
                                            <select id="txtQuestion28" class="CustomFontSize" style="margin: 10px;" runat="server">
                                                <option value=""></option>
                                                <option value="Arts">Arts</option>
                                                <option value="Design">Design</option>
                                                <option value="Physical and Heath Education">Physical and Heath Education</option>
                                                <option value="Language Acquisition">Language Acquisition</option>
                                                <option value="Mathematics">Mathematics</option>
                                                <option value="Language and literature">Language and literature</option>
                                            </select>


                                            <asp:TextBox ID="txtQuestion29" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion29.ClientID%>');</script>
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
                            <h4 class="modal-title"><b>The greenhouse effect</b></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <img src="Image/Question1_1.0.jpg" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="ShowEarth" clientidmode="Static" runat="server" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Steve Connor - Life on Earth under threat from CO2 levels, say scientists</b></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <img src="Image/Question_1_1_2.jpg" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="ShowCo2" clientidmode="Static" runat="server" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Impact of rising CO2 levels</b></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <img src="Image/Question1_1_3.jpg" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>





            <div id="WildFishingPopUp" clientidmode="Static" runat="server" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Bluefin tuna fishing</b></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <img src="Image/OptionSource7.jpg" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>


            <div id="AquaCulturePopUp" clientidmode="Static" runat="server" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title"><b>Bluefin tuna farming</b></h4>
                        </div>
                        <div class="modal-body" style="padding-bottom: 0px">
                            <img src="Image/OptionSource7.1.jpg" />
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
