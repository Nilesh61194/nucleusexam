<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IH.aspx.cs" Inherits="NucleusExams.Grade10.IH.IH" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IH Grade 10</title>
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
            swal("Error", msg, "error");
        }


        // save fuction 
        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8", "txtQuestion9", "txtQuestion10",
                            "txtQuestion11", "txtQuestion12", "txtQuestion13", "txtQuestion14", "txtQuestion15", "txtQuestion16", "txtQuestion17", "txtQuestion18", "txtQuestion19"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
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
                                <h3><b>Question - 1</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Source A</b>
                                        <img src="Image/Source_A.jpg" width="100%" />
                                        <small>(Source :- Oxford Geography 2, 4th Edition)</small>
                                        <br />
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a ) Using <b>Source A, Identify</b> 3 countries, where the population is growing at  1-2% per year.</span>
                                            <span style="float: right!important">(Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) Using <b>Source A and MYP knowledge, List</b> 3 reasons why growth rates in some places is high?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand i)<br />
                                                (Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Source B</b>
                                        <br />
                                        <p class="CustomFontSize">Below, are the population pyramids of Japan, over the years.</p>
                                        <img src="Image/Source_B.jpg" width="100%" />
                                        <small>(Source:- Cambridge, Geography for the IB Diploma)</small><br />
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Question 2:</b> Using Source C and your knowledge from the MYP studies, answer the following questions:-</span><br />
                                            <span>a ) <b>Suggest</b> why each population pyramid is divided into three sections.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand i)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) <b>Distinguish</b> between the three pyramids.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand i)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c ) <b>Examine</b> the reasons for the considerable changes between the three pyramids.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand iv)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Source C</b><br />
                                        <div id="divmainContentQ3" style="overflow: auto; height: 600px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source31">Image 1</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ32">Image 2</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ33">Image 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ34">Image 4</a></li>
                                            </ul>

                                            <div class="tab-content text-center">
                                                <div id="Source31" class="tab-pane fade in active">
                                                    <img src="Image/Source_C1.jpg" style="max-height: 500px!important" /><br />
                                                    <a>https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>
                                                <div id="SourceQ32" class="tab-pane fade">
                                                    <img src="Image/Source_C2.png" /><br />
                                                    <a>https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>
                                                <div id="SourceQ33" class="tab-pane fade">
                                                    <img src="Image/Source_C3.png" /><br />
                                                    <a>https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>

                                                <div id="SourceQ34" class="tab-pane fade">
                                                    <img src="Image/Source_C4.png" /><br />
                                                    <a>https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">a ) <b>Discuss</b> the purpose and significance of a new initiative by the United Nations Human Rights Office, titled “Standards of Conduct for Business on tackling discrimination against LGBTI people”.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion C, strand  i)<br />
                                                (Criterion C, strand  ii)<br />
                                                (Criterion D, strand  iv)</span><br />
                                            <br />
                                            <p style="text-align: justify" class="CustomFontSize">
                                                Your answer must include:- 
                                                <ul class="CustomFontSize">
                                                    <li>Why does discrimination at workplace needs to be addressed.</li>
                                                    <li>Consider socio-cultural and political factors that affect LGBTQ community at workplace. </li>
                                                    <li>Give two implications of this step  by UNHCR. </li>
                                                    <li>Explain at least least three significance of this step by UNHRC</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">b ) You are the chairman the UNHRC,  and you have been given the responsibility to implement that will include and support  the 
                                                LGBTQIA+ community in the corporate world. For this task, you will have to research about data and present your facts and data to the UN. But,
                                                 before you begin your research, you must have  a focused research question, and then the rest.
                                                <br />
                                                <br />
                                                Based on the given source and your MYP understanding:-
                                                <br />
                                                1. <b>Formulate</b> a Research question.  <span style="float: right!important; background-color: #9fd8fb;">(Criterion B, strand i)</span>
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize">2. <b>Formulate</b> two sub-RQ, which will include the two key issues you going to address.
                                                <br />
                                                (The Sub-RQ, can be WH- question) </span><span style="float: right!important; background-color: #9fd8fb;">(Criterion B, strand i)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize">3. <b>Justify</b> the relevance of the research question.</span><span style="float: right!important; background-color: #9fd8fb;">(Criterion B, strand i)</span>
                                        </div>
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
                                <h3><b>Question - 4</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Source B</b>
                                        <br />
                                        <img src="Image/Source_D.png" width="100%" style="max-height: 800px!important" />
                                        <br />
                                        <a>http://www.ilo.org/global/topics/labour-migration/news-statements/WCMS_436140/lang--en/index.htm</a>
                                        <br />
                                        <br />
                                        <p class="CustomFontSize" style="background-color: #9fd8fb;"><b>Answer the following questions based on the above source:</b></p>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a ) <b>Identify</b> which group of countries has the highest number of migrant workers?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) <b>Identify</b> which group of countries has the lowest number of migrant workers?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c ) <b>List</b> the possible pull and push factors for migrant workers? (3 each)</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand i)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 5</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b class="CustomFontSize">Source E : The demographic transition model</b>
                                        <br />
                                        <img src="Image/Source_E.jpg" width="100%" />
                                        <br />
                                        <a>https://www.slideshare.net/SitiMutiahAliUmar/demographic-transition-model-of-uk-and-india</a>
                                        <br />
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">A - <b>Explain</b> why population is stable in stage 1 and stage 4?.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion D, strand i)</span><br />
                                            <p style="text-align: justify" class="CustomFontSize">
                                                Your answer must include:- 
                                                <ul class="CustomFontSize">
                                                    <li>Two reasons.</li>
                                                    <li>Give one example (country) for each stage.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtQuestion13" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion13.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize" style="font-weight: 700;">B - Describe how stage 5 is different from the other 4 stages</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion A, strand ii)
                                                <br />
                                                (Criterion D strand iv)</span><br />

                                            <p style="text-align: justify" class="CustomFontSize">
                                                Your answer must include:- 
                                                <ul class="CustomFontSize">
                                                    <li>Description of the stage 5 and other 4 stages.</li>
                                                    <li>3 unique features about stage 5.</li>
                                                    <li>Give one example (country) for each stage.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize" style="font-weight: 700;">C - Explain why there is more natural increase in the stage 2 and 3.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion D, strand  ii)
                                                <br />
                                                (Criterion C, strand i)</span><br />
                                            <p style="text-align: justify" class="CustomFontSize">
                                                Your answer must include:- 
                                                <ul class="CustomFontSize">
                                                    <li>2  reasons each</li>
                                                    <li>Give causes of less death rate and more birth rate in stage 2.</li>
                                                    <li>Give causes of decline in the birth rate for stage 3.</li>
                                                    <li>Give one example (country) for each stage.</li>
                                                    <li>Reiterate, your stand on the reasons of more natural increase in stage 2 and 3.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b class="CustomFontSize">Source-  G </b>
                                        <br />
                                        <a>https://www.thehindu.com/news/national/we-have-lost-our-identity-say-people-of-kashmir-as-government-scraps-article-370/article28824520.ece</a>
                                        <br />
                                        <div class="text-center">
                                            <p class="CustomFontSize" style="text-align: justify;">
                                                <h3>We have lost our identity, say people of Kashmir as government scraps Article 370</h3>
                                            </p>
                                        </div>
                                        <div>
                                            <p class="CustomFontSize" style="text-align: justify; padding-left: 100px; padding-right: 100px;">
                                                People of Kashmir on Monday (August 05) expressed apprehensions about a new cycle of 
                                                violence in the Valley, with many saying that scrapping of Article 370, which gave special status to the State, could lead to change in its
                                                 Muslim-majority identity.<br />
                                                <br />
                                                “We are shocked by the decision and it left us disappointed because our sentiments were attached with this Article... its 
                                                scrapping means that the State will lose its Muslim-majority character,” said 50-year-old Farooq Ahmad Shah, a resident of 
                                                Srinagar who was visiting Jammu.<br />
                                                <br />
                                                “How long they will keep us under house arrest?” asked Arshid Warsi, a man in his 20s from the Valley who was also visiting the city.<br />
                                                <br />
                                                Revoking Article 370 does not mean “we cannot express our resentment”, he said.<br />
                                                <br />
                                                For businessman Jaleel Ahmad Bhat, the uncertainty in the Valley meant closure of his establishment indefinitely and loss of bread and butter.<br />
                                                <br />
                                                “We don’t know how the situation will develop after the curfew-like restrictions are withdrawn. We feel we are heading for worst of times,” 
                                                he said.<br />
                                                <br />
                                                He expressed disappointment over snapping of phone and internet connectivity and said people in the Valley have totally been disconnected from 
                                                the outside world.<br />
                                                <br />
                                                “My two children are studying outside the State and there is no contact with them. I know they will be worried about the situation here and 
                                                I also don’t know how they are doing,” Mr. Bhat, who was in Jammu, said.<br />
                                                <br />
                                                Fatima Bano, a middle-aged entrepreneur, said she has been praying for normalcy ever since she came to know about the government’s decision 
                                                to revoke Article 370.<br />
                                                <br />
                                                Written by PTI, Published on The Hindu, August 05, 2019. India 
                                            </p>
                                        </div>
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize" style="font-weight: 700;">Do the OPVL of the given source as an IB student.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion D, strand iii)</span>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Origin</b></h4>
                                                </div>
                                                <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                            </div>

                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Purpose</b></h4>
                                                </div>
                                                <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Value</b></h4>
                                                </div>
                                                <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Limitations</b></h4>
                                                </div>
                                                <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                            </div>
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
