<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MathExtPreview.aspx.cs" Inherits="NucleusExams.Grade10.Math.MathExtPreview" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>Math Ext Grade 10</title>
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

        table, th, td {
            border: 1px solid black;
            text-align: center !important;
        }


        .divAnswer {
            border-style: solid;
            padding: 5px;
        }
    </style>

</head>
<body>
    <script>


        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }


        // save fuction 
        function SaveAnswerAllTime() {

            var CKEdiorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7", "txtQuestion8",
                            "txtQuestion9", "txtQuestion10", "txtQuestion11", "txtQuestion15", "txtQuestion16",
                            "txtQuestion17", "txtQuestion18", "txtQuestion19", "txtQuestion20", "txtQuestion21", "txtQuestion22", "txtQuestion24",
                            "txtQuestion25", "txtQuestion26", "txtQuestion27", "txtQuestion29", "txtQuestion30"];
            var i;
            for (i = 0; i <= CKEdiorID.length - 1; i++) {
                var id = CKEdiorID[i];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }

            var RadEditorID = ["txtQuestion12", "txtQuestion13", "txtQuestion14", "txtQuestion23", "txtQuestion28"];
            var k;
            for (k = 0; k <= RadEditorID.length - 1; k++) {
                var id = RadEditorID[k];
                var value = $telerik.findEditor("" + id + "").get_html();
                SaveAnswer(id, value);
            }
        }


    </script>
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
                                <h3><b>Criterion A</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>1. Stars are spread out through space at many different distances from our own Sun and from each other in a 3-dimensional Cartesian system 
                                                with their respective coordinates given in the table below.Our own Sun is at the origin of this coordinate system, and all distances are given
                                                 in light-years.</span>
                                            <span style="float: right!important">(Level 1-2)</span>
                                            <br />
                                            <br />
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>State</b> the distances of each of these stars from the Sun in light-years to complete the 1st column in the table below.</span>
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. You moved to the North Star, Polaris. <b>State</b> the distances of each of these stars from Polaris in light-years to complete the 2nd column in the table below</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c. <b>Identify</b> the closest star to Polaris.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>2. Fractals are geometric constructions that are self-similar. This means that any part of a fractal looks like the overall fractal. Most fractals can be generated by repeating a simple set of rules.<br />
                                                <br />
                                                For example, the figures alongside show a fractal called as Sierpinski’s triangle.
                                            </span>
                                            <span style="float: right!important">(Level 3-4)</span>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col-md-6" style="padding: 50px;">
                                                <img src="Image/Q2.2.png" width="90%" /><br />
                                                Figure 1 
                                            </div>
                                            <div class="col-md-6" style="padding: 50px;">
                                                <img src="Image/Q2.1.png" width="90%" /><br />
                                                Figure 2
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. Describe the transformation that maps &#9651;OAE onto &#9651;ECD and &#9651;ABC</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Describe</b> the transformation that maps &#9651; OBD onto &#9651; OAE</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>c. <b>Describe</b> the transformation that maps &#9651; OBD onto &#9651; ECD and &#9651; ABC</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>d. <b>Find</b> the coordinates of the image of all the vertices of Figure 2 when it undergoes a rotation about E through -(3π/2).</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>e. <b>Describe</b> the transformation that maps &#9651; ABC onto &#9651; AEC</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>3. The two functions shown on the graph are f(x)=x<sup>2</sup>  and  g(x)=5(x-2)<sup>2</sup></span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Level 5-6)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q3.png" />
                                            <br />
                                            The graph of g(x) can be obtained from the graph of f(x) using two transformations.
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>Describe</b> each of the two transformations.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <p>
                                                The graph of g(x) is translated by a vector
                                            <img src="Image/Q3A.PNG" />
                                                to give the graph of h(x).
                                                <br />
                                                The point P(1,1) and Q(-2,4) on the graph of f(x) is translated onto the point P’ and Q’ on the graph of h(x)
                                            </p>
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Organize</b> the information in a logical structure to <b>calculate</b> the coordinates of the point P’ and Q’.</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>4. PQRS is a parallelogram. The point T divides the line PQ in the ratio 1:3, and U, V, and W are the midpoints of SR, PS, and QR respectively.<br />
                                            </span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(Level 7-8)</span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/Q4A.PNG" /><br />
                                            <br />
                                            <img src="Image/Q4.png" />
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>a. <b>Organize</b> the information in a logical structure to find
                                            <img src="Image/Q4B.PNG" />
                                                in terms of a and b</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>b. <b>Show that
                                            <img src="Image/Q4C.PNG" />
                                                = 0.5(5a + 2b)</b></span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>

                            <div style="margin: 20px;">
                                <h3><b>Criterion B</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>This question looks at the number of grey tiles and the number of white tiles in a sequence of square patterns.<br />
                                                All the tiles are the same size and each is a square.<br />
                                                The grey tiles and white tiles make borders around a single grey tile.<br />
                                                The single grey tile is the first grey border.<br />
                                                The first white border is 8 white tiles surrounding the grey tile.<br />
                                                The second grey border is 16 grey tiles surrounding the 8 white tiles.<br />
                                                <br />
                                                <div class="text-center">
                                                    <img src="Image/Q5.1.png" />
                                                </div>
                                                <br />
                                                5. On the grid given, complete the diagram to <b>construct</b> the second white border. 
                                                <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b><b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b><b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                            </span>

                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion12" runat="server" class="divAnswer">
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>6. On the grid given, complete the diagram to <b>construct</b> the third grey border.</span>
                                            <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion13" runat="server" class="divAnswer">
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>7. On the grid given, complete the diagram to <b>construct</b> the third white border.</span>
                                            <b><a onclick="return VennWindow('VennDiagramMathExt.aspx');" href="#">Click here to edit image and add screenshot in answer area given below</a></b>
                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion14" runat="server" class="divAnswer">
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>8. <b>Use</b> your answers to previous questions to <b>state</b> the missing values in the table for the patterns that finish with a white border.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion15" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion15.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>9. <b>Predict</b> the missing numbers and write down in the table.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion16" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion16.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>10. <b>Describe</b> in your own words, three patterns you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion17" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion17.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>11. <b>Derive</b> as a general rule the three patterns you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion18" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion18.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>12. <b>Verify</b> your general rules you have discovered from table 1.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion19" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion19.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>13. <b>Justify</b> your general rules for the predicted values in table 2.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion20" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion20.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>14. <b>Explain</b> the general rule to find the total number of grey tiles in any pattern, n, that finishes with the white border through lines of reasoning that are complete, coherent and concise.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion21" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion21.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h3><b>Criterion D</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>A committee wants to conduct a rowing championship competition in the city of Aberdeen in the month of January 2019.<br />
                                                You need to advise the committee on the appropriate time to conduct the race.<br />
                                                Following is the image from the rule book of International Rowing Federation(FISA):<br />
                                            </span>
                                        </div>
                                        <br />
                                        <div class="text-center">
                                            <img src="Image/CB1.png" />
                                            <br />
                                            <img src="Image/CB2.png" />
                                            <br />
                                            Source: http://www.worldrowing.com/uploads/files/Appendix_1_-_Courses_Bye-Laws.pdf
                                        </div>
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>The heights of water in Aberdeen were measured every two hours on 1st January 2019.
                                                <br />
                                                <br />
                                                The high and low tides on that day were also recorded along with it. All the data is shown in the tables below, which is rounded up to 2 decimal places.</span>
                                            <br />
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 20%">Time(hours after midnight)</td>
                                                    <td style="width: 9%">0</td>
                                                    <td style="width: 9%">2</td>
                                                    <td style="width: 9%">3</td>
                                                    <td style="width: 9%">4</td>
                                                    <td style="width: 9%">6</td>
                                                    <td style="width: 9%">8</td>
                                                    <td style="width: 9%">9</td>
                                                    <td style="width: 9%">10</td>
                                                    <td style="width: 9%">12</td>
                                                </tr>
                                                <tr>
                                                    <td>Height(m)</td>
                                                    <td>2.45</td>
                                                    <td>3.88</td>
                                                    <td>4.10</td>
                                                    <td>3.84</td>
                                                    <td>2.45</td>
                                                    <td>1.00</td>
                                                    <td>0.80</td>
                                                    <td>1.02</td>
                                                    <td>2.45</td>
                                                </tr>
                                                <tr>
                                                    <td>Time(hours after midnight)</td>
                                                    <td>14</td>
                                                    <td>15</td>
                                                    <td>16</td>
                                                    <td>18</td>
                                                    <td>20</td>
                                                    <td>21</td>
                                                    <td>22</td>
                                                    <td>24</td>
                                                    <td>-</td>
                                                </tr>
                                                <tr>
                                                    <td>Height(m)</td>
                                                    <td>3.88</td>
                                                    <td>4.1</td>
                                                    <td>3.84</td>
                                                    <td>2.45</td>
                                                    <td>1.00</td>
                                                    <td>0.80</td>
                                                    <td>1.02</td>
                                                    <td>2.44</td>
                                                    <td>-</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>15. <b>Identify</b> the relevant elements that you need to take into consideration to model the height of water against time.
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion22" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion22.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>16. <b>Plot</b> the data sets on the graphing tool.</span>
                                            <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion23" runat="server" class="divAnswer">
                                            </div>
                                            <br />
                                            <div style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span class="CustomFontSize">17. <b>Identify</b> the appropriate principal axis of your graph.</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion24" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion24.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span class="CustomFontSize">18. <b>Select and apply</b> an appropriate mathematical strategy to <b>derive</b> the model of the height of water against time. </span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion25" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion25.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span>19. <b>Write down</b> the range of your model.</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion26" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion26.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span>20. <b>Estimate</b> the height of the water at 06:30.</span>
                                                <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion27" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion27.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span>21. <b>Suggest</b> the committee by estimating the appropriate time to conduct the race.</span>
                                                <u><b><a onclick="return VennWindow('https://www.desmos.com/calculator');" href="#">Desmos</a></b></u>
                                            </div>
                                            <br />
                                            <div>
                                                <div id="txtQuestion28" runat="server" class="divAnswer">
                                                </div>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span>22. <b>Justify</b> the factors that have influenced the degree of accuracy of your estimated appropriate time to conduct the race.</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion29" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion29.ClientID%>');</script>
                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span class="fa fa-paper-plane"></span>
                                                <span>23. <b>Justify</b> if your solution to the estimated appropriate time to conduct the race is reliable in a real-life context.</span>
                                            </div>
                                            <br />
                                            <div>
                                                <asp:TextBox ID="txtQuestion30" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion30.ClientID%>');</script>
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
