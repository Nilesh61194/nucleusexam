<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ISPreview.aspx.cs" Inherits="NucleusExams.Grade8.IS.ISPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png" />
    <title>Unit 4 Let the energy flow</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
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
                    <asp:Label ID="lblGradeSection" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
            <div id="div1" class="row text-center" runat="server">
                <div class="col-md-12">
                    <strong>
                        <asp:Label ID="lblExamSubject" Font-Bold="true" runat="server"></asp:Label></strong>
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
                                <h4><b>Content</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Aim:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            To investigate the effect of carbon dioxide on the rate of photosynthesis
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Hypothesis:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            I predict that as we increase the concentration of carbon dioxide, the number of bubbles will decrease. This is because the amount of carbon dioxide is directly proportional to the amount of glucose formed during photosynthesis. Hence, the amount of oxygen released will decrease with the increase in the concentration of carbon dioxide.
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Method:</b></span>
                                        </div>
                                        <br />
                                        <div class="text-justify CustomFontSize">
                                            <ol>
                                                <li>Open the <a href="https://www.newpathonline.com/api_player/enus_54_6206/h7sIbz/index.html" target="_blank">simulation.</a></li>
                                                <li>Set the Light intensity: 15000 lux</li>
                                                <li>Click on the button “Prepare plant”.</li>
                                                <li>Set the CO2 concentration at 0 ppm and start the timer. Note down the no. of bubbles released in 3 mins. Perform the step twice.</li>
                                                <li>Repeat step 4 for the CO2 concentration for 300, 600 and 1200 ppm and perform it step twice.</li>
                                                <li>Record the results in the observation table.</li>
                                                <li>Plot the <a href="https://chart-studio.plot.ly/create/#/" target="_blank">graph</a> of carbon dioxide versus no. of bubbles released.</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h4><b>Que:1 Observation </b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Present</b>  collected data in an organized form.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 3-4</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion1" runat="server" class="divAnswer" style="background-color: #EBEBE4;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>

                            <div style="margin: 20px;">
                                <h4><b>Que:2 Graph</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Plot</b> the graph using <a href="https://chart-studio.plot.ly/create/#/" target="_blank">plotly</a>. Paste the screenshot of the graph in the space given below.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                        </div>
                                        <br />
                                        <div>
                                            <div id="txtQuestion2" runat="server" class="divAnswer"></div>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h4><b>Que:3 Conclusion</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Explain</b> what your data interprets on the basis of the data collected connecting it with your aim. 
                                                    <b>Discuss</b> whether the given hypothesis was valid or not, referring to the data collected. 
                                                    <b>Justify</b> the result by using your scientific knowledge of the topic.</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 5-8</b>)</span>
                                        </div>
                                        <br />
                                        <asp:TextBox ID="txtQuestion3" runat="server" Enabled="false" CssClass="divAnswer" TextMode="MultiLine" Rows="20" Width="100%"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div style="margin: 20px">
                                <h4><b>Que: 4 Evaluation</b></h4>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Discuss</b> any limitations or weaknesses of the procedure, followed by its improvements or extensions</span>
                                            <span style="float: right!important; background-color: #9fd8fb;">(<b>Level 1-2</b>)</span>
                                        </div>
                                        <br />
                                        <asp:TextBox ID="txtQuestion4" runat="server" Enabled="false" CssClass="divAnswer" TextMode="MultiLine" Rows="20" Width="100%"></asp:TextBox>
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
