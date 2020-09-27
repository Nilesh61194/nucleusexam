<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Math_G9_T2Preview.aspx.cs" Inherits="NucleusExams.Grade9.Math.Math_G9_T2Preview" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Math G-9 T2</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../ckeditor4/ckeditor.js"></script>
    <style>
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
        <asp:HiddenField ID="hfCheckboxValue" runat="server" />
        <div class="container" ng-app="" runat="server" id="divAll">
            <div class="row col-md-12 col-lg-12 ">
                <div class="float-left col-md-6 col-lg-6">
                    <img src="../../Images/Logo/FS_Logo.png" /><br />

                </div>
                <div class="col-md-6 col-lg-6" style="text-align: end">
                    <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="lblGradeSection" runat="server" ClientIDMode="Static"></asp:Label><br />
                </div>
            </div>
            <div id="div1" class="text-center" runat="server">
                <div class="row">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-4">
                        <strong>
                            <asp:Label ID="lblExamSubject" Font-Bold="true" runat="server"></asp:Label></strong>
                    </div>
                    <div class="col-md-4" style="text-align: right!important;">
                        <a class="fa fa-calculator fa-2x" onclick="return OpenWindow('https://www.desmos.com/testing/ibmyp/scientific');" href="#"></a>
                        <a class="fa fa-pencil-ruler fa-2x" href="https://www.desmos.com/calculator" target="_blank"></a>
                    </div>
                </div>
            </div>
            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
                <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                    <!-- Indicators data-ride="carousel" -->

                    <!-- Wrapper for slides -->
                    <div>
                        <div>
                            <div style="margin: 20px">
                                <h4><b>Question 1</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span><b>a)</b> AB is a chord in the circle having the center O and radius 8 cm.<br />
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                                <b>i)  Sketch</b> and shade the situation given above.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                            <span><b>ii)  Find </b>the area covered by the major sector created by AB if the minor angle made by AB at center of circle is 60º.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>

                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                            <span><b>b)  Construct</b> Venn Diagram to represent the following set.</span><br />
                                            ( A’ ∪ B’ )’                                              <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>

                            <div style="margin: 20px;">
                                <h4><b>Question 2</b></h4>

                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>Sergio is taking two summer classes at the local college. One course is ‘pass/fail’ (those are the only two grades) while the other course has a grading system of A, B, C, F (with F being the only failing grade).</span>
                                            <br />
                                            <span><b>a)  Organize </b>the data using appropriate mathematical strategy</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>

                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
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
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span>2) Sergio passes exactly one class.
                                            </span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>

                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div>
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
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>

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
                                        <div>
                                            <asp:TextBox ID="txtQuestion8" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <b>b)  Find</b> the angle APC if angle PCO = 68°
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion9" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>
                                        </div>

                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <b>C)  Calculate</b> the area of sector COD if the angle ODC = 21°.
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine" Enabled="false"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
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
