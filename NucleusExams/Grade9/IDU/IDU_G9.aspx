<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IDU_G9.aspx.cs" Inherits="NucleusExams.Grade9.IDU.IDU_G9" ValidateRequest="false"%>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IDU Grade 9</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />--%>
    <link href="../../Content/all.css" rel="stylesheet" />
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

        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        // save fuction 
        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion7", "txtQuestion8", "txtQuestion9", "txtQuestion10", "txtQuestion11",
                "txtQuestion12", "txtQuestion13", "txtQuestion14"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var TextBoxID = ["txtQuestion4", "txtQuestion5", "txtQuestion6"];

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
                    console.log(x.responseText);
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

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }

        function ChangeSource(id) {
            if (id == 1) {
                document.getElementById('imgmain').src = 'Image/Source4.1.PNG';
            }
            else if (id == 2) {
                document.getElementById('imgmain').src = 'Image/Source4.2.PNG';
            }
            else if (id == 3) {
                document.getElementById('imgmain').src = 'Image/Source4.3.PNG';
            }
            else if (id == 4) {
                document.getElementById('imgmain').src = 'Image/Source4.4.PNG';
            }
            else if (id == 5) {
                document.getElementById('imgmain').src = 'Image/Source4.5.PNG';
            }
            else if (id == 6) {
                document.getElementById('imgmain').src = 'Image/Source4.6.PNG';
            }
            else if (id == 7) {
                document.getElementById('imgmain').src = 'Image/Source4.7.PNG';
            }
            else if (id == 8) {
                document.getElementById('imgmain').src = 'Image/Source4.8.PNG';
            }
            return false;
        }


        function ChangeSourceQ4(id) {
            if (id == 1) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.1.PNG';
            }
            else if (id == 2) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.2.PNG';
            }
            else if (id == 3) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.3.PNG';
            }
            else if (id == 4) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.4.PNG';
            }
            else if (id == 5) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.5.PNG';
            }
            else if (id == 6) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.6.PNG';
            }
            else if (id == 7) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.7.PNG';
            }
            else if (id == 8) {
                document.getElementById('imgmainQ4').src = 'Image/Source4.8.PNG';
            }
            return false;
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
                                <h3><b>Question - 1</b> (10 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContent" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ11">Source 1</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ12">Source 2</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ13">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ16">Source 6</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ17">Source 7</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ11" class="tab-pane fade in active">
                                                    <img src="Image/Source1.PNG" />
                                                </div>
                                                <div id="SourceQ12" class="tab-pane fade text-center">
                                                    <img src="Image/Source2.png" />
                                                </div>
                                                <div id="SourceQ13" class="tab-pane fade">
                                                    <br />
                                                    <p class="text-center" style="font-size: large!important;">
                                                        <b>Science Confirms Astrology!
                                                        </b>
                                                    </p>
                                                    <p class="CustomFontSize" style="text-align: justify; margin-left: 40px; margin-right: 40px;">
                                                        A declaration up front: I don’t believe in astrology; not even a little bit.
                                                        <br />
                                                        <br />
                                                        But I like to apply my skepticism evenly. And there’s one thing that we astrology doubters like to say that <u>sticks in my craw.</u><br />
                                                        <br />

                                                        "Only an idiot would believe that the month you are born could have any effect on your personality."<br />
                                                        <br />

                                                        Add me to the list of idiots.<br />
                                                        <br />

                                                        It all started with <u>schizophrenia</u>. Some scientists noticed that schizophrenics were more likely than others to have February birthdays. 
                                                        Also, January and March birthdays. It wasn’t a huge effect, but it was statistically significant nonetheless. And schizophrenia definitely 
                                                        affects your personality.<br />
                                                        <br />

                                                        Then scientists found the same for <u>bipolar disorder</u> - winter and early spring birthdays have it worst. They also noticed that incidence of 
                                                        these diseases was particularly low for people who were born in late summer and early <u>fall</u>. Suicidality (which closely tracks mental illness) 
                                                        appears to be strongest for April through June birthdays. Dyslexia may be strongest in the summer babies.<br />
                                                        <br />

                                                        The first thing these scientists did is the same thing you or I would do. They looked at the Southern Hemisphere. They quickly found that these
                                                         effects are reversed there. Since the seasons are reversed below the equator, it seems like weather has something to do with it. But what? 
                                                        So many things vary with the season. Disease levels, temperature, seasonal affective disorder, diet, activity level, many many organisms, pollen 
                                                        in the air, school attendance and consequent disease exposure, these things all vary with the season. Most research now focuses on temperature 
                                                        and on viral infections, especially the flu, but the mechanisms are still mysterious.<br />
                                                        <br />

                                                        OK, but what about personality traits themselves?<br />
                                                        <br />

                                                        A Japanese study found that people born December through February have lower agreeableness (this term has a precise definition to personality 
                                                        psychologists). A Swedish study found that (at least in women), February/March/April birthdays led to increased novelty-seeking behavior.
                                                         Another study reported that summer-born males are less conscientious (another term with a formal meaning).<br />
                                                        <br />

                                                        Now this doesn’t support astrology - not even close. From my limited knowledge, adjacent signs often have opposing, or at least unrelated, 
                                                        personalities, while science says that adjacent birth months are similar. And of course, no one thinks that the position of the stars in the 
                                                        sky has anything to do with it. It’s stuff happening here on earth that is the culprit.<br />
                                                        <br />

                                                        But on the other hand, when someone says there’s no possible way the month you are born could have any influence on your personality, they aren’t 
                                                        exactly correct.<br />
                                                        <br />

                                                        One final note. <u>Schizotypal personality</u> is also correlated with month of birth. And schizotypal personality (which is different from
                                                         schizophrenia) may be associated with many personality traits. One of them is interest in, and belief in, astrology. So maybe there
                                                         is something to the old joke: "I don’t believe in astrology, but then I wouldn’t. I’m a Gemini so I’m skeptical."<br />
                                                        <br />
                                                        Source: adapted from B Hayden, (2011), Science Confirms Astrology!, www.psychologytoday.com
                                                    </p>
                                                </div>
                                                <div id="SourceQ16" class="tab-pane fade text-center">
                                                    <img src="Image/Source6.jpg" /><br />
                                                    <br />
                                                    Source: adapted from https://nccih.nih.gov
                                                </div>
                                                <div id="SourceQ17" class="tab-pane fade">
                                                    <div>
                                                        <br />
                                                        <p class="text-center" style="font-size: large!important;">
                                                            <b>Your health: The history of plant medicine
                                                            </b>
                                                        </p>
                                                    </div>
                                                    <p class="CustomFontSize" style="text-align: justify; margin-left: 40px; margin-right: 40px;">
                                                        Medicinal plants have been used throughout history to heal the sick. Carbon dating from ancient Babylon (Iraq) indicates that plants 
                                                        were cultivated as medicines 60 000 years ago. It is thought that the ancient Greeks and Romans learned from these earlier 
                                                        civilisations and began to keep written records of their own discoveries at least 2500 years ago, with written records beginning 
                                                        earlier in India, China and Egypt.<br />
                                                        <br />

                                                        One of the most outstanding figures of Western medicine, the Greek physician Hippocrates, living around 400 BC and often referred 
                                                        to as the "father of modern medicine", is said to have used only food, medicinal plants and lifestyle advice to heal his patients. 
                                                        He is known for the saying "let food be your medicine, and your medicine be your food". The core principles and medicines formulated
                                                         by him and his successors read strangely modern and are increasingly validated today.<br />
                                                        <br />

                                                        If the history of human medicine was condensed into a relative period of one hour, everything except for the last minute would be 
                                                        dominated by plant medicine. Even in New Zealand, plant medicine was taught at medical schools well into the middle of the 20th century.<br />
                                                        <br />


                                                        A variety of factors including technological advances, economical and political shifts resulted in the declining use of traditional 
                                                        plant medicine in many Western societies throughout the 20th century. New discoveries of powerful synthetic medicines such as antibiotics,
                                                         and different ways of measuring the effectiveness of medicines such as randomised control trials, resulted in the marginalisation of 
                                                        traditional knowledge that had been passed down through generations of healthcare practitioners.<br />
                                                        <br />

                                                        However, because of the rise in degenerative and chronic illnesses, limited biomedical options for treating many ailments safely, 
                                                        and the threat of loss of effectiveness of Western "miracle drugs" such as antibiotics, this hiatus has been short-lived.<br />
                                                        <br />

                                                        Plant medicine is experiencing a renaissance, with scientific research into healing plants growing exponentially. The demand for 
                                                        traditional medicine is increasing worldwide, with surveys indicating that around 50 % of New Zealanders and up to 70 % of children 
                                                        use plant medicines for their healthcare needs. Herbal medicinal products enjoy high acceptance by patients, which is reflected 
                                                        internationally. In Europe, up to 86 % of people use Complementary and Alternative (CAM) healthcare.<br />
                                                        <br />

                                                        Reflecting this shift, the World Health Organisation has published a global strategy to integrate traditional medicine into public 
                                                        health services and self-health care. Because traditional medicine focuses on patient involvement and self-care, it can help to address the 
                                                        burden of lifestyle disease facing modern societies. In this way, the use of traditional medicine for promoting health and preventing disease 
                                                        may actually reduce health-care costs. In addition, medicinal plants can enhance the benefits of pharmaceutical medicine and reduce many common side effects.<br />
                                                        <br />

                                                        My own PhD thesis is part of the work being done globally to validate the evidence base of traditional knowledge. The research revolves around a 1500 page,
                                                         400-year-old Renaissance Materia Medica, a medical book of collected knowledge about medicinal plants that have influenced Western medicine. The tome 
                                                        is the most comprehensive German language encyclopedia on medicinal plants of the early modern era.<br />
                                                        <br />

                                                        So far, the empirical knowledge detailed in the Materia Medica is shown to be thorough and complete. There is very little new information about 
                                                        medicinal plants that we’ve discovered through biomedicine that the ancient physicians didn’t already know.<br />
                                                        <br />

                                                        For instance, the compounding of penicillin was first recorded by German Benedictine monks in the eighth century and the recent recreation of a 1000-year-old
                                                         medieval remedy from England for eye infections proved effective against an antibiotic-resistant superbug.<br />
                                                        <br />

                                                        The use of traditional medical knowledge can be a fruitful approach for new therapeutic approaches and drug discovery. More countries are gradually coming
                                                         to accept the contribution that traditional medicine can make to the health and wellbeing of individuals, and to the comprehensiveness of their healthcare systems.<br />
                                                        <br />

                                                        Source: adapted from S Clair, (2016), Your health: The history of plant medicine, www.nzherald.co.nz
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1a</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Suggest four</b> reasons why some people might consider the reference you have selected to be scientific.   
                                            </p>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1b</b> (2 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Identify two</b> reasons why the reference you have selected should not be considered scientific.
                                            </p>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 1c</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize">
                                            <p>
                                                <b>Explain</b> the potential consequences of accepting pseudo-scientific articles as being scientific.<br />
                                                In your answer you must include :<br />
                                                <ul>
                                                    <li>a positive consequence</li>
                                                    <li>a negative consequence.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ2" style="overflow: auto; height: 650px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ21">Source 4</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ22">Source 5</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <br />
                                                <div class="text-center">
                                                    <p><b>Click all the possible text and images within the source to find extra information.</b></p>
                                                </div>

                                                <div id="SourceQ21" class="tab-pane fade in active">
                                                    <div class="row">
                                                        <div class="col-md-2 text-center" style="margin-top: 150px;">
                                                            <ul style="list-style: none; font-weight: bold;">
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(1);">An example of Shelley's Inspiration</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(2);">Symbolism</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(3);">Space</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(4);">Scientific</li>

                                                            </ul>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <img id="imgmain" width="100%" src="Image/Source4.0.PNG" />
                                                        </div>
                                                        <div class="col-md-2 text-center" style="margin-top: 150px;">
                                                            <ul style="list-style: none; font-weight: bold;">
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(5);">Language availability</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(6);">Pivotal moment</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(7);">Plot summary</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSource(8);">History of adaptations</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="SourceQ22" class="tab-pane fade text-center">
                                                    <img src="Image/Source5.png" />
                                                </div>
                                            </div>
                                        </div>
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2a</b> (2 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Below are three quotations from the extract. <b>Select</b> which quotation is best described by the atmosphere. Write the type of atmosphere from given options next to the quotation in the boxes. Leave one box blank.
                                            </p>
                                        </div>
                                        <div class="row">
                                            <h4>
                                                <p class="text-center" style="font-weight: 900;"><b>Atmosphere :</b> (Suspenseful &nbsp;,&nbsp; Gloomy)</p>
                                            </h4>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <table style="margin-left: 50px; margin-right: 50px;" border="1">
                                                    <tr>
                                                        <td style="width: 70%">
                                                            <p style="text-align: justify" class="CustomFontSize">
                                                                With an anxiety that almost amounted to agony, I collected the instruments
                                                                of life around me, that I might infuse a spark of being into the lifeless thing
                                                                that lay at my feet.
                                                            </p>
                                                        </td>
                                                        <td style="width: 30%" class="text-center">
                                                            <asp:TextBox ID="txtQuestion4" runat="server" CssClass="txtBlank" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 70%">
                                                            <p style="text-align: justify" class="CustomFontSize">
                                                                A mummy again endued with animation could not be so hideous as that
                                                                wretch.
                                                            </p>
                                                        </td>
                                                        <td style="width: 30%" class="text-center">
                                                            <asp:TextBox ID="txtQuestion5" runat="server" CssClass="txtBlank" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 70%">
                                                            <p style="text-align: justify" class="CustomFontSize">
                                                                It was on a dreary night of November that I beheld the accomplishment of
                                                            my toils.
                                                            </p>
                                                        </td>
                                                        <td style="width: 30%" class="text-center">
                                                            <asp:TextBox ID="txtQuestion6" runat="server" CssClass="txtBlank" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2b</b> (2 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Explain</b> the effect on the audience of the literary device - Hyperbole. Use an example from the extract to support your answer.
                                            </p>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                            <br />
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 2c</b> (4 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Compare and contrast</b> the image and the extract. In your answer provide <b>one</b> similarity and <b>one</b> difference.<br />
                                            </p>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ3" style="overflow: auto; height: 500px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source31">Source 5</a></li>
                                            </ul>

                                            <div class="tab-content text-center">
                                                <div id="Source31" class="tab-pane fade in active text-center">
                                                    <img src="Image/Source5.PNG" />
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <br />
                                        <p class="CustomFontSize">
                                            <b>Critique</b> how the video’s synthesis of sciences and language and literature conveys the statement above. In your answer, you must include:<br />
                                            <ul class="CustomFontSize">
                                                <li>benefits of the synthesis</li>
                                                <li>limitations of the synthesis</li>
                                                <li>evidence from the documentary</li>
                                                <li>an evaluative conclusion.</li>
                                            </ul>
                                        </p>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3><b>Question - 4</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ4" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ41">Source 4</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ42">Source 5</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <br />
                                                <div class="text-center">
                                                    <p><b>Click all the possible text and images within the source to find extra information.</b></p>
                                                </div>
                                                <div id="SourceQ41" class="tab-pane fade in active">
                                                    <div class="row">
                                                        <div class="col-md-2 text-center" style="margin-top: 150px;">
                                                            <ul style="list-style: none; font-weight: bold;">
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(1);">An example of Shelley's Inspiration</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(2);">Symbolism</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(3);">Space</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(4);">Scientific</li>

                                                            </ul>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <img id="imgmainQ4" width="100%" src="Image/Source4.0.PNG" />
                                                        </div>
                                                        <div class="col-md-2 text-center" style="margin-top: 150px;">
                                                            <ul style="list-style: none; font-weight: bold;">
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(5);">Language availability</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(6);">Pivotal moment</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(7);">Plot summary</li>
                                                                <li class="img-thumbnail" style="background-color: #D09F6B; margin: 10px!important" onclick="return ChangeSourceQ4(8);">History of adaptations</li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="SourceQ42" class="tab-pane fade text-center">
                                                    <img src="Image/Source5.png" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Create</b> a plot outline for an alternative ending in which Dr Frankenstein grants the creature’s request for a female partner. In your plot outline, you
                                                    must include:<br />
                                                <ul class="CustomFontSize">
                                                    <li>scientific implications of granting the creature’s request </li>
                                                    <li>short- and long-term consequences on the human race</li>
                                                    <li>the new reality in this alternative ending.</li>
                                                </ul>
                                            </p>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 5</b> (24 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div id="divmainContentQ5" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ51">Source 6</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ52">Source 7</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ53">Source 8</a></li>

                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ51" class="tab-pane fade in active text-center">
                                                    <img src="Image/Source6.jpg" /><br />
                                                    <br />
                                                    Source: adapted from https://nccih.nih.gov
                                                </div>
                                                <div id="SourceQ52" class="tab-pane fade">
                                                    <div>
                                                        <br />
                                                        <p class="text-center" style="font-size: large!important;">
                                                            <b>Your health: The history of plant medicine
                                                            </b>
                                                        </p>
                                                    </div>
                                                    <p class="CustomFontSize" style="text-align: justify; margin-left: 40px; margin-right: 40px;">
                                                        Medicinal plants have been used throughout history to heal the sick. Carbon dating from ancient Babylon (Iraq) indicates that plants 
                                                        were cultivated as medicines 60 000 years ago. It is thought that the ancient Greeks and Romans learned from these earlier 
                                                        civilisations and began to keep written records of their own discoveries at least 2500 years ago, with written records beginning 
                                                        earlier in India, China and Egypt.<br />
                                                        <br />

                                                        One of the most outstanding figures of Western medicine, the Greek physician Hippocrates, living around 400 BC and often referred 
                                                        to as the "father of modern medicine", is said to have used only food, medicinal plants and lifestyle advice to heal his patients. 
                                                        He is known for the saying "let food be your medicine, and your medicine be your food". The core principles and medicines formulated
                                                         by him and his successors read strangely modern and are increasingly validated today.<br />
                                                        <br />

                                                        If the history of human medicine was condensed into a relative period of one hour, everything except for the last minute would be 
                                                        dominated by plant medicine. Even in New Zealand, plant medicine was taught at medical schools well into the middle of the 20th century.<br />
                                                        <br />


                                                        A variety of factors including technological advances, economical and political shifts resulted in the declining use of traditional 
                                                        plant medicine in many Western societies throughout the 20th century. New discoveries of powerful synthetic medicines such as antibiotics,
                                                         and different ways of measuring the effectiveness of medicines such as randomised control trials, resulted in the marginalisation of 
                                                        traditional knowledge that had been passed down through generations of healthcare practitioners.<br />
                                                        <br />

                                                        However, because of the rise in degenerative and chronic illnesses, limited biomedical options for treating many ailments safely, 
                                                        and the threat of loss of effectiveness of Western "miracle drugs" such as antibiotics, this hiatus has been short-lived.<br />
                                                        <br />

                                                        Plant medicine is experiencing a renaissance, with scientific research into healing plants growing exponentially. The demand for 
                                                        traditional medicine is increasing worldwide, with surveys indicating that around 50 % of New Zealanders and up to 70 % of children 
                                                        use plant medicines for their healthcare needs. Herbal medicinal products enjoy high acceptance by patients, which is reflected 
                                                        internationally. In Europe, up to 86 % of people use Complementary and Alternative (CAM) healthcare.<br />
                                                        <br />

                                                        Reflecting this shift, the World Health Organisation has published a global strategy to integrate traditional medicine into public 
                                                        health services and self-health care. Because traditional medicine focuses on patient involvement and self-care, it can help to address the 
                                                        burden of lifestyle disease facing modern societies. In this way, the use of traditional medicine for promoting health and preventing disease 
                                                        may actually reduce health-care costs. In addition, medicinal plants can enhance the benefits of pharmaceutical medicine and reduce many common side effects.<br />
                                                        <br />

                                                        My own PhD thesis is part of the work being done globally to validate the evidence base of traditional knowledge. The research revolves around a 1500 page,
                                                         400-year-old Renaissance Materia Medica, a medical book of collected knowledge about medicinal plants that have influenced Western medicine. The tome 
                                                        is the most comprehensive German language encyclopedia on medicinal plants of the early modern era.<br />
                                                        <br />

                                                        So far, the empirical knowledge detailed in the Materia Medica is shown to be thorough and complete. There is very little new information about 
                                                        medicinal plants that we’ve discovered through biomedicine that the ancient physicians didn’t already know.<br />
                                                        <br />

                                                        For instance, the compounding of penicillin was first recorded by German Benedictine monks in the eighth century and the recent recreation of a 1000-year-old
                                                         medieval remedy from England for eye infections proved effective against an antibiotic-resistant superbug.<br />
                                                        <br />

                                                        The use of traditional medical knowledge can be a fruitful approach for new therapeutic approaches and drug discovery. More countries are gradually coming
                                                         to accept the contribution that traditional medicine can make to the health and wellbeing of individuals, and to the comprehensiveness of their healthcare systems.<br />
                                                        <br />

                                                        Source: adapted from S Clair, (2016), Your health: The history of plant medicine, www.nzherald.co.nz
                                                    </p>
                                                </div>
                                                <div id="SourceQ53" class="tab-pane fade text-center">
                                                    <img src="Image/Source8.PNG" />
                                                </div>
                                            </div>
                                        </div>

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 5a</b> (12 marks)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Using the quotation for inspiration, <b>create</b> an article expressing your <b>point of view</b> about traditional medicine and its place in the modern world.
                                                Your article is for the <i>Young Scientist</i>, a magazine that targets students who aim to study science at university. 
                                                <br />
                                                <br />
                                                In your article, you must consider the following elements.<br />
                                                <ul class="CustomFontSize">
                                                    <li>Who is the audience and what is the purpose?</li>
                                                    <li>What is traditional medicine, where is it used and who uses it</li>
                                                    <li>What are the strengths or weaknesses of traditional medicine</li>
                                                    <li>Why is traditional medicine <b>either</b> widely used <b>or</b> disregarded?</li>
                                                    <li>How might the knowledge of medicine through space and time take us forward <b>or</b> hold us back?</li>
                                                    <li>Support your arguments with evidence from the <b>references 6, 7 and 8.</b></li>
                                                </ul>
                                            </p>
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div id="divmainContentQ51" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#SourceQ54">Source 1</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ55">Source 2</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ56">Source 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ57">Source 5</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ58">Source 9</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ59">Source 10</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="SourceQ54" class="tab-pane fade in active">
                                                    <img src="Image/Source1.PNG" />
                                                </div>
                                                <div id="SourceQ55" class="tab-pane fade text-center">
                                                    <img src="Image/Source2.png" />
                                                </div>
                                                <div id="SourceQ56" class="tab-pane fade">
                                                    <br />
                                                    <p class="text-center" style="font-size: large!important;">
                                                        <b>Science Confirms Astrology!
                                                        </b>
                                                    </p>
                                                    <p class="CustomFontSize" style="text-align: justify; margin-left: 40px; margin-right: 40px;">
                                                        A declaration up front: I don’t believe in astrology; not even a little bit.
                                                        <br />
                                                        <br />
                                                        But I like to apply my skepticism evenly. And there’s one thing that we astrology doubters like to say that <u>sticks in my craw.</u><br />
                                                        <br />

                                                        "Only an idiot would believe that the month you are born could have any effect on your personality."<br />
                                                        <br />

                                                        Add me to the list of idiots.<br />
                                                        <br />

                                                        It all started with <u>schizophrenia</u>. Some scientists noticed that schizophrenics were more likely than others to have February birthdays. 
                                                        Also, January and March birthdays. It wasn’t a huge effect, but it was statistically significant nonetheless. And schizophrenia definitely 
                                                        affects your personality.<br />
                                                        <br />

                                                        Then scientists found the same for <u>bipolar disorder</u> - winter and early spring birthdays have it worst. They also noticed that incidence of 
                                                        these diseases was particularly low for people who were born in late summer and early <u>fall</u>. Suicidality (which closely tracks mental illness) 
                                                        appears to be strongest for April through June birthdays. Dyslexia may be strongest in the summer babies.<br />
                                                        <br />

                                                        The first thing these scientists did is the same thing you or I would do. They looked at the Southern Hemisphere. They quickly found that these
                                                         effects are reversed there. Since the seasons are reversed below the equator, it seems like weather has something to do with it. But what? 
                                                        So many things vary with the season. Disease levels, temperature, seasonal affective disorder, diet, activity level, many many organisms, pollen 
                                                        in the air, school attendance and consequent disease exposure, these things all vary with the season. Most research now focuses on temperature 
                                                        and on viral infections, especially the flu, but the mechanisms are still mysterious.<br />
                                                        <br />

                                                        OK, but what about personality traits themselves?<br />
                                                        <br />

                                                        A Japanese study found that people born December through February have lower agreeableness (this term has a precise definition to personality 
                                                        psychologists). A Swedish study found that (at least in women), February/March/April birthdays led to increased novelty-seeking behavior.
                                                         Another study reported that summer-born males are less conscientious (another term with a formal meaning).<br />
                                                        <br />

                                                        Now this doesn’t support astrology - not even close. From my limited knowledge, adjacent signs often have opposing, or at least unrelated, 
                                                        personalities, while science says that adjacent birth months are similar. And of course, no one thinks that the position of the stars in the 
                                                        sky has anything to do with it. It’s stuff happening here on earth that is the culprit.<br />
                                                        <br />

                                                        But on the other hand, when someone says there’s no possible way the month you are born could have any influence on your personality, they aren’t 
                                                        exactly correct.<br />
                                                        <br />

                                                        One final note. <u>Schizotypal personality</u> is also correlated with month of birth. And schizotypal personality (which is different from
                                                         schizophrenia) may be associated with many personality traits. One of them is interest in, and belief in, astrology. So maybe there
                                                         is something to the old joke: "I don’t believe in astrology, but then I wouldn’t. I’m a Gemini so I’m skeptical."<br />
                                                        <br />
                                                        Source: adapted from B Hayden, (2011), Science Confirms Astrology!, www.psychologytoday.com
                                                    </p>
                                                </div>
                                                <div id="SourceQ57" class="tab-pane fade text-center">
                                                    <img src="Image/Source5.PNG" />
                                                </div>
                                                <div id="SourceQ58" class="tab-pane fade text-center">
                                                    <img src="Image/Source9.PNG" />
                                                </div>
                                                <div id="SourceQ59" class="tab-pane fade text-center">
                                                    <img src="Image/Source10.PNG" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <span class="fa fa-paper-plane" style="margin-left: 25px;">&nbsp;&nbsp;<b>Question 5b</b> (12 marks)</span>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize">
                                                <b>Evaluate</b> how you have used the related concepts <b>point of view</b> and <b>evidence</b> to create an article which synthesizes your knowledge of sciences
                                                    and language and literature. In your answer, you must:
                                                <br />
                                                <ul class="CustomFontSize">
                                                    <li>give benefits of point of view and evidence</li>
                                                    <li>give limitations of point of view and evidence</li>
                                                    <li>consider the balance between point of view and evidence</li>
                                                    <li>refer to your article.</li>
                                                </ul>
                                            </p>
                                            <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                                        </div>
                                        <br />
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b> (12 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">

                                        <div id="divmainContentQ6" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source61">Source 10</a></li>
                                            </ul>

                                            <div class="tab-content">
                                                <div id="Source61" class="tab-pane fade in active text-center">
                                                    <img src="Image/Source10.PNG" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <p class="CustomFontSize">
                                                Throughout this examination, you have seen how the disciplinary and interdisciplinary knowledge of natural and human landscapes and resources
                                                have changed over time.
                                                <br />
                                                <br />
                                                <b>To what extent</b> does emotion affect how scientific progress can be perceived? In your answer, you must include:<br />
                                                <b>Evaluate</b> the role of imagination and reason in exploration. In your answer you must:
                                            </p>

                                            <ul class="CustomFontSize">
                                                <li>benefits of emotion for perceiving scientific progress</li>
                                                <li>limitations of emotion for perceiving scientific progress</li>
                                                <li>evidence from the pre-release material and questions in this examination</li>
                                                <li>an evaluative conclusion.</li>
                                            </ul>
                                        </div>
                                        <br />
                                        <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 7</b> (8 Marks)</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize">
                                            <p>
                                                During an interdisciplinary unit and you will have developed your interdisciplinary understanding. <b>Discuss</b> the consequences of your understanding . In your answer, you must include : - how each discipline was synthesized .
                                            </p>
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
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

        </div>
    </form>
</body>
</html>
