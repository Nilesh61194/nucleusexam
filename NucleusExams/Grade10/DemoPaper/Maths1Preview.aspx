<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maths1Preview.aspx.cs" Inherits="NucleusExams.Grade10.DemoPaper.Maths1Preview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>Math Paper</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
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

        .divAnswer {
            border-style: solid;
            padding: 5px;
        }

        .Question {
            background-color: #C4E3F3 !important;
        }

        .CustomFontSize {
            text-align: justify;
            font-size: larger;
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
                                <div class="text-center">
                                    <h3><b>Criterion A: Knowing and understanding</b></h3>
                                </div>
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 1 Write down</b>  the answers of the following blanks.<span class="pull-right">(Level 1-2)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <p style="margin: 10px!important; text-align: justify; font-size: larger">
                                        <ol type="a" class="CustomFontSize">
                                            <li>A letter is randomly taken from English alphabets.
                                                The probability that the letter taken is a consonant is
                                                <asp:TextBox ID="txtQuestion1" runat="server" CssClass="txtBlank" Width="250px" Enabled="false"></asp:TextBox>.<br />
                                            </li>
                                            <li>Parallelogram has
                                                <asp:TextBox ID="txtQuestion2" runat="server" CssClass="txtBlank" Width="250px" Enabled="false"></asp:TextBox>
                                                order of rotational symmetry.<br />
                                            </li>
                                            <li>A card is randomly chosen from a deck of cards.The probability that the card chosen is a king of red colour is
                                                <asp:TextBox ID="txtQuestion3" runat="server" CssClass="txtBlank" Width="200px" Enabled="false"></asp:TextBox>.</li>
                                            <li>State the coordinates of centre of rotation that maps the object to its image in the diagram below.<asp:TextBox ID="txtQuestion4" runat="server" CssClass="txtBlank" Width="250px" Enabled="false"></asp:TextBox>. <a href=""></a>
                                            </li>
                                        </ol>
                                    </p>
                                    <div class="row text-center">
                                        <img src="Image/Question1.PNG" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px;">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger; word-wrap: break-word;">
                                    <h4><b>&nbsp;Question - 2</b>  In a stable of 42 horses, 27 are thoroughbreds ( T ) and 16 are mares ( M ). 4 horses are both thoroughbred and mare. <span class="pull-right">(Level 3-4)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>a. Organise</b> the specified information in the Venn Diagram
                                        </div>

                                        <br />

                                        <div id="txtQuestion5" runat="server" class="divAnswer">
                                        </div>

                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>b. State</b>  the probability that a randomly selected horse from the stable is
                                        </div>
                                        <div>
                                            <p class="CustomFontSize" style="background-color: #9fd8fb;">i.) thoroughbred or a mare.</p>
                                            <div id="txtQuestion6" runat="server" class="divAnswer">
                                            </div>
                                            <br />
                                            <p class="CustomFontSize" style="background-color: #9fd8fb;">ii.) thoroughbred but not a mare.</p>
                                            <div id="txtQuestion7" runat="server" class="divAnswer">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 3</b> A jar consists of 21 sweets. 12 are white and 9 are yellow. William picked two sweets one after the other to eat. <span class="pull-right">(Level 5-6)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) <b>Draw </b>a tree diagram to represent the given information.
                                        </div>
                                        <br />
                                        <div id="txtQuestion8" runat="server" class="divAnswer">
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>Find </b>the probability that one sweet is yellow and one sweet is white.
                                        </div>
                                        <br />
                                        <div id="txtQuestion9" runat="server" class="divAnswer">
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            c) <b>Find </b>the probability that none of the sweet is yellow
                                        </div>
                                        <br />
                                        <div id="txtQuestion10" runat="server" class="divAnswer">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>

                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 4</b> Find the equation of the line that is perpendicular to y = 2x + 1 and passes through the point (1, 3) which is the intersecting point of both the lines. <span class="pull-right">(Level 7-8)</span></h4>
                                </div>
                                <div id="txtQuestion11" runat="server" class="divAnswer">
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <div class="text-center">
                                    <h3><b>Criterion B: Investigating patterns</b></h3>
                                </div>
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 5</b> Nirkhi has got a $100 iTunes gift card for her birthday. She started buying songs costing $2 each using the gift card. Leftover amount in her gift card (y) after buying number of songs(x) is shown in the graph below.</h4>
                                </div>

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="text-center">
                                            <img src="Image/Question5.PNG" />
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) After observing the pattern, <b>plot</b> any two points in the above graph. <span class="pull-right">(Level 1-2)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion12" runat="server" class="divAnswer">
                                        </div>
                                        <br />
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>Construct</b> a table of values from the graph of all the plotted points. <span class="pull-right">(Level 3-4)</span>
                                        </div>
                                        <br />
                                        <div id="txtQuestion13" runat="server" class="divAnswer">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>

                            <div style="margin: 20px">
                                <div style="width: 100%; display: block; background-color: #9fd8fb; font-size: larger;">
                                    <h4><b>&nbsp;Question - 6 </b><span class="pull-right">(Level 3-4)</span></h4>
                                </div>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            a) <b>Find</b> the vertex form of the following quadratic function. 
                                        </div>
                                        <br />
                                        <asp:TextBox ID="txtQuestion14" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion14.ClientID%>');</script>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            b) <b>State</b> the axis of symmetry for both the functions.<br />
                                            <b>(i) f(x) = (x-1) (x-3)</b>
                                        </div>
                                        <br />
                                        <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        <br />

                                        <div style="width: 100%; display: block; background-color: #9fd8fb;" class="CustomFontSize">
                                            <b>(ii) g(x) = x2 + 12x + 32</b>
                                        </div>
                                        <br />
                                        <%--<div id="txtQuestion16" runat="server" class="divAnswer">
                                        </div>--%>
                                        <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        <br />
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
