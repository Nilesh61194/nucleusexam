<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IHPreview.aspx.cs" Inherits="NucleusExams.Grade10.IH.IHPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>IH Grade 10</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
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

        .divAnswer {
            border-style: solid;
            padding: 5px;
            overflow-wrap: break-word;
        }
    </style>
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
                    <asp:Label ID="lblGradeSection" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
            <div id="div1" class="row text-center" runat="server">
                <div class="col-md-12">
                    <strong>
                        <asp:Label ID="lblExamSubject" Font-Bold="true" runat="server"></asp:Label></strong>
                </div>
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
                        <div>
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
                                        <div id="txtQuestion1" runat="server" class="divAnswer"></div>
                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) Using <b>Source A and MYP knowledge, List</b> 3 reasons why growth rates in some places is high?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand i)<br />
                                                (Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <br />
                                        <div id="txtQuestion2" runat="server" class="divAnswer"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>

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
                                            <span>a ) <b>Suggest</b> why each population pyramid is divided into three sections.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand i)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion3" runat="server" class="divAnswer"></div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) <b>Distinguish</b> between the three pyramids.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand i)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion4" runat="server" class="divAnswer"></div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c ) <b>Examine</b> the reasons for the considerable changes between the three pyramids.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion D, strand iv)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion5" runat="server" class="divAnswer"></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h3><b>Question - 3</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Source C</b><br />
                                        <div id="divmainContentQ3" style="overflow: auto; height: 550px;">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#Source31">Image 1</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ32">Image 2</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ33">Image 3</a></li>
                                                <li><a data-toggle="tab" href="#SourceQ34">Image 4</a></li>
                                            </ul>

                                            <div class="tab-content text-center">
                                                <div id="Source31" class="tab-pane fade in active">
                                                    <img src="Image/Source_C1.jpg" style="max-height: 500px!important" /><br />
                                                    <a href="#">https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>
                                                <div id="SourceQ32" class="tab-pane fade">
                                                    <img src="Image/Source_C2.png" /><br />
                                                    <a href="#">https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>

                                                </div>
                                                <div id="SourceQ33" class="tab-pane fade">
                                                    <img src="Image/Source_C3.png" /><br />
                                                    <a href="#">https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>

                                                <div id="SourceQ34" class="tab-pane fade">
                                                    <img src="Image/Source_C4.png" /><br />
                                                    <a href="#">https://www.unfe.org/wp-content/uploads/2017/09/UN-Standards-of-Conduct-Summary.pdf</a>
                                                </div>
                                            </div>
                                            <br />
                                        </div>
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize">a ) Discuss the purpose and significance of a new initiative by the United Nations Human Rights Office, titled “Standards of Conduct for Business on tackling discrimination against LGBTI people”.</span>
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
                                        <div id="txtQuestion6" runat="server" class="divAnswer"></div>
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
                                        <div id="txtQuestion7" runat="server" class="divAnswer"></div>

                                        <br />
                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize">2. <b>Formulate</b> two sub-RQ, which will include the two key issues you going to address.
                                                <br />
                                                (The Sub-RQ, can be WH- question) </span><span style="float: right!important; background-color: #9fd8fb;">(Criterion B, strand i)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion8" runat="server" class="divAnswer"></div>
                                        <br />

                                        <div style="background-color: #9fd8fb;">
                                            <span class="CustomFontSize">3. <b>Justify</b> the relevance of the research question.</span><span style="float: right!important; background-color: #9fd8fb;">(Criterion B, strand i)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion9" runat="server" class="divAnswer"></div>

                                    </div>

                                </div>

                            </div>
                        </div>
                        <div>

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
                                        <p class="CustomFontSize" style="background-color: #9fd8fb;"><b>Answer the following questions based on the above source:</b></p>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a ) <b>Identify</b> which group of countries has the highest number of migrant workers?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion10" runat="server" class="divAnswer"></div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b ) <b>Identify</b> which group of countries has the lowest number of migrant workers?</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand ii)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion11" runat="server" class="divAnswer"></div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c ) <b>List</b> the possible pull and push factors for migrant workers? (3 each)</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Criterion A, strand i)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion12" runat="server" class="divAnswer"></div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
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
                                        <div style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span class="CustomFontSize" style="font-weight: 700;">A - Explain why population is stable in stage 1 and stage 4?.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;" class="CustomFontSize">(Criterion D, strand i)</span><br />
                                            <p style="text-align: justify" class="CustomFontSize">
                                                Your answer must include:- 
                                                <ul class="CustomFontSize">
                                                    <li>Two reasons.</li>
                                                    <li>Give one example (country) for each stage.</li>
                                                </ul>
                                            </p>
                                        </div>
                                        <div id="txtQuestion13" runat="server" class="divAnswer"></div>
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
                                        <div id="txtQuestion14" runat="server" class="divAnswer"></div>

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
                                        <div id="txtQuestion15" runat="server" class="divAnswer"></div>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h3><b>Question - 6</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b class="CustomFontSize">Source-  G </b>
                                        <br />
                                        <a target="_blank" href="#">https://www.thehindu.com/news/national/we-have-lost-our-identity-say-people-of-kashmir-as-government-scraps-article-370/article28824520.ece</a>
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
                                                <div id="txtQuestion16" runat="server" class="divAnswer"></div>

                                            </div>

                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Purpose</b></h4>
                                                </div>
                                                <div id="txtQuestion17" runat="server" class="divAnswer"></div>

                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Value</b></h4>
                                                </div>
                                                <div id="txtQuestion18" runat="server" class="divAnswer"></div>

                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="text-center" style="background-color: #999999;">
                                                    <h4><b>Limitations</b></h4>
                                                </div>
                                                <div id="txtQuestion19" runat="server" class="divAnswer"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
