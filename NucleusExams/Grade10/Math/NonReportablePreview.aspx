<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NonReportablePreview.aspx.cs" Inherits="NucleusExams.Grade10.Math.NonReportablePreview" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo Paper</title>
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

        .divAnswer {
            border-style: solid;
            border-width: thin;
            padding: 5px;
        }

        .Question {
            background-color: #C4E3F3 !important;
        }
    </style>
</head>
<body>
    <script>

        function OpenWindow() {
            //Open the Popup window
            //Change the pagename here
            window.open('https://www.desmos.com/scientific', '_blank', 'height=450,width=500,scrollbars=0,location=1,toolbar=0,margin-left=50%');
            return false;
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
            args += "width=" + 900 + "," + "height=" + 850 + ","
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

        function Top(id) {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
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
                    <div>
                        <div>
                            <div style="margin: 20px">
                                <h3>Question - 1</h3>
                                <div style="border-style: solid; border-width: 1px;" class="Question">

                                    <p style="margin: 10px!important;">
                                        <b>Draw</b> the following image by translating the shape to specified units.
                                    <br />
                                        a.  1 unit up, 7 unit left, 4 units down , 9 units right. <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">Click here</a></b>
                                        <br />
                                        <img src="Image/Maths_Q1_1.png" width="100%" />
                                    </p>
                                </div>
                                <br />
                                <div id="txtQuestion1" runat="server" class="divAnswer">
                                </div>
                                <br />
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            b.  Could the instructions be simplified so that transformation can be completed in fewer steps? <b>Explain.</b>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion2" runat="server" class="divAnswer">
                                </div>

                                <br />
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        c . <b>Write down</b> the translation using correct notation.
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion3" runat="server" class="divAnswer">
                                </div>
                            </div>
                        </div>


                        <div>

                            <div style="margin: 20px;">
                                <h3>Question - 2</h3>
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            Plot the shape with vertices (1,8), (-3, -5), (-4,7) an (-6,-2) Then plot the image of this shape after following
                                             transformation. (x,y) ------> (x-2, y-4) .<br />
                                            Also, <b>State</b> the coordinates of the image.  <b><a onclick="return VennWindow('https://www.geogebra.org/graphing');" href="#">Click here</a></b>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div>
                                    <div id="txtQuestion4" runat="server" class="divAnswer"></div>
                                </div>
                            </div>
                        </div>
                        <div>

                            <div style="margin: 20px">
                                <h3>Question - 3</h3>
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            Given the translation (x, y) -----> (x-4, y+1), Find the preimage of the following image points                                                                 
                                        </p>
                                        <ol type="">
                                            <li>(5,9)</li>
                                            <li>(-2,0)</li>
                                        </ol>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion5" runat="server" class="divAnswer">
                                </div>
                            </div>
                        </div>
                        <div>

                            <div style="margin: 20px">
                                <h3>Question - 4</h3>
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            <b>Write down</b> the reflection of each of the given points in the following reflection lines.
                                            <a onclick="return ResetTable()" style="font-weight: 100;" href="#">Reset</a>
                                            <%--<button id="btnResetTable" value="Reset" onclick="return ResetTable();" class="btn small "></button>--%>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion6" runat="server" class="divAnswer">
                                </div>
                            </div>
                        </div>
                        <div>

                            <div style="margin: 20px">
                                <h3>Question - 5</h3>
                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            It seems that even superheroes love to use transformations to create their logos.
                                            <br />

                                            a. For each of the logo <b>describe</b>
                                            the transformation that each have been used to create it. 
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion7" runat="server" class="divAnswer">
                                </div>

                                <br />

                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            b. <b>Draw</b> reflection lines on the logos wherever appropriate. <b><a onclick="return VennWindow('VennDiagramImage.aspx');" href="#">Click here</a></b>
                                            <img src="Image/Maths_Q5.PNG" width="100%" height="130px" />
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion8" runat="server" class="divAnswer"></div>
                                <br />

                                <div style="border-style: solid; border-width: 1px;" class="Question">
                                    <div style="margin: 10px!important;">
                                        <p>
                                            c. The above logos are based on transformations. What is about transformations that is pleasing to look at? 
                                            How you can connect it with Global context. <b>Explain.</b>
                                        </p>
                                    </div>
                                </div>
                                <br />
                                <div id="txtQuestion9" runat="server" class="divAnswer">
                                    <br />
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
