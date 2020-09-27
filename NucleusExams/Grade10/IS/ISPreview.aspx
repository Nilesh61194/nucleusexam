<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ISPreview.aspx.cs" Inherits="NucleusExams.Grade10.IS.ISPreview" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>Physical World Preview</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/popup.css" rel="stylesheet" />
    <script src="../../assets/js/sweetalert-dev.js"></script>
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="../../ckeditor4/ckeditor.js"></script>
    <link href="../../Content/kendo.default-v2.min.css" rel="stylesheet" />

    <script src="../../Scripts/jquery.min.kendo.js" type="text/javascript"></script>

    <script src="../../Scripts/jszip.min.js" type="text/javascript"></script>

    <script src="../../Scripts/kendo.all.min.js" type="text/javascript"></script>

    <script>

        function getPDF(selector) {
            debugger;

            var file = document.getElementById("lblExamSubject").innerText +"_"+ document.getElementById("lblStudentHeaderName").innerText + "_" + document.getElementById("lblGradeSection").innerText;
            kendo.drawing.drawDOM($(selector)).then(function (group) {
                kendo.drawing.pdf.saveAs(group, "" + file + ".pdf");
            });
        }



    </script>

    <%--<script>
        // Import DejaVu Sans font for embedding

        // NOTE: Only required if the Kendo UI stylesheets are loaded
        // from a different origin, e.g. cdn.kendostatic.com
        kendo.pdf.defineFont({
            "DejaVu Sans": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans.ttf",
            "DejaVu Sans|Bold": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Bold.ttf",
            "DejaVu Sans|Bold|Italic": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Oblique.ttf",
            "DejaVu Sans|Italic": "https://kendo.cdn.telerik.com/2016.2.607/styles/fonts/DejaVu/DejaVuSans-Oblique.ttf",
            "WebComponentsIcons": "https://kendo.cdn.telerik.com/2017.1.223/styles/fonts/glyphs/WebComponentsIcons.ttf"
        });
    </script>--%>

    <!-- Load Pako ZLIB library to enable PDF compression -->

    <script src="../../Scripts/modernizr-2.6.2.js"></script>

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
        }

        .divAnswer {
            border-style: solid;
            padding: 5px;
            overflow-wrap: break-word;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("img").css('width', "99%")
        });
    </script>
</head>
<body>
    <div class="row text-center">
        <div class="box-col" style="display: none">
            <h4>Select Page size</h4>
            <select id="paper" style="width: 100px;">
                <option value="size-a4" selected>A4</option>
                <option value="size-letter">Letter</option>
                <option value="size-executive">Executive</option>
            </select>
        </div>
        <div class="box-col">
            <button class="export-pdf k-button" onclick="getPDF('.pdf-page')">Download as PDF</button>
        </div>
    </div>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <asp:HiddenField ID="hfTotalDuration" runat="server" />
        <div class="pdf-page size-a4">
            <div class="container" runat="server" id="divAll">
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

                            <div id="divQuestion1">
                                <div style="margin: 20px">
                                    <h4><b>Criterion B</b></h4>
                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span><b><u>Background:</u></b> Observe the effect of original car speed upon the skid distance. The simulation involves a toy car rolling down a hill,
                                                 hitting a box, and skidding to a stop. The height from which the car is released can be modified. The speed of the car at the bottom 
                                                of the hill (prior to contact with the box) is reported. The distance that the car (and box) skid before stopping can be measured. 
                                                <br />
                                                    <br />
                                                    Dear students when you click on <a href="https://www.physicsclassroom.com/Physics-Interactives/Work-and-Energy/Stopping-Distance/Stopping-Distance-Interactive"
                                                        target="_blank"><b style="color: blue; text-decoration: underline;">INTERACTIVE</b></a> here, please maximize it by clicking on the arrow at the top on left of the window. 
                                                </span>
                                                <div class="row">
                                                    <img src="Image/INTERACTIVE.jpg" width="90%" style="margin-left: 55px!important" />
                                                </div>
                                                <br />
                                                <span><b>1. State</b> a problem or question to be tested  by a scientific investigation. <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (i) [Level: 1-2]</b>)</span>
                                                </span>
                                            </div>
                                            <br />
                                            <div class="text-center" style="display: none;">
                                                <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=TextBox1.ClientID%>');</script>
                                            </div>
                                            <div>
                                                <div id="txtQuestion1" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>

                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                                <span><b>2. Formulate </b>the hypothesis about the car’s speed and skidding distance of the car.
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (ii) [Level: 3-4]</b>)</span>
                                                </span>
                                            </div>
                                            <br />
                                            <div>
                                                <div id="txtQuestion2" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>

                                            </div>
                                            <br />

                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">

                                                <span><b>3. Design</b> a scientific investigation which includes:<br />
                                                    1) Procedure, 2) List of Materials & 3) Apparatus & Safety measures:                                           
                                                <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (iii) [Level: 7-8]</b>)</span>
                                                </span>
                                            </div>
                                            <br />
                                            <div>
                                                <div id="txtQuestion3" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="divQuestion2">

                                <div style="margin: 20px;">
                                    <h4><b>Criterion C</b></h4>

                                    <div style="border-style: solid; border-width: 1px;">
                                        <div style="margin: 10px!important;">
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <div>
                                                    <b><u>Background:</u></b> The stopping distance of a car is the distance it will need to travel till the time it will take to stop in response to some emergency.<br />
                                                    <br />
                                                    <b>1. The stopping distance consists of 2 parts: </b>
                                                    <ul>
                                                        <li>The thinking distance – the distance travelled for the time  when the driver feels the need to apply the brake and then applies the brake.
                                                        </li>
                                                        <li>The braking distance – the distance travelled by the car after brake is applied.
                                                        </li>
                                                        <li><b>Factors Affecting Stopping Distances:</b>
                                                        </li>
                                                    </ul>
                                                    <div class="row text-center">
                                                        <div class="col-md-1">
                                                        </div>
                                                        <div class="col-md-10">
                                                            <table border="1" class="text-center" style="width: 100%">
                                                                <tr>
                                                                    <td><b>Thinking Distance</b></td>
                                                                    <td><b>Braking Distance</b></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Intoxication<br />
                                                                        (Consumption of alcohol or drugs)</td>
                                                                    <td>The condition of the vehicle<br />
                                                                        (Worn tyre or poor brakes)</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Distractions<br />
                                                                        (e.g. Using a mobile phone)</td>
                                                                    <td>The condition of the road and weather
                                                                    <br />
                                                                        (e.g. a wet or icy road)</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Tiredness<br />
                                                                        (Reaction time increase when tired)</td>
                                                                    <td>The mass of the vehicle<br />
                                                                        (A heavy vehicle takes longer to stop)</td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <div class="col-md-1">
                                                        </div>

                                                    </div>
                                                    <br />
                                                    <p>
                                                        The student is given the task of a scientific investigation. Here car crash experiment is conducted at different initial speeds as shown in 
                                                    infographic below. There is one limitation for the investigation as the student cannot control the condition of the road and weather. 
                                                    The student collects and records the data for car crash experiments at different speeds as shown below:           
                                                    </p>
                                                    <div class="text-center">
                                                        <img src="Image/ImageC2.png" /><br />
                                                        <b>Graph of impact speed at 45 m (In wet-road conditions)</b><br />
                                                    </div>
                                                    <br />
                                                    Analysing the data and graph, the student formulates the hypothesis that <b>“The main factor affecting stopping distance of the 
                                                car here is the initial speed of the car.”</b>
                                                </div>
                                                <br />
                                                <span><b>1. Interpret</b> the graph and the information given above to <b>explain</b> the effects of various factors on stopping distance of the car.<span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (ii) [ Level 7-8]</b>)</span></span><br />
                                                <br />

                                            </div>

                                            <br />
                                            <div>
                                                <div id="txtQuestion4" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>

                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>2. <b>Outline</b> the validity of the hypothesis made by the student.  
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (iii) [ Level 3-4]</b>)</span></span>
                                            </div>
                                            <br />
                                            <div>
                                                <div id="txtQuestion5" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>

                                            </div>
                                            <br />
                                            <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                                <span>3. <b>State</b> improvements or extensions to the method that would benefit the scientific investigation.	
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Strand (V) [Level 1-2]</b>)</span></span>
                                            </div>
                                            <br />
                                            <div>
                                                <div id="txtQuestion6" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
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

