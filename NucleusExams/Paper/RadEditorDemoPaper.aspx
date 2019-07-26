<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RadEditorDemoPaper.aspx.cs" Inherits="NucleusExams.Paper.RadEditorDemoPaper" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo Paper</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="//cdn.ckeditor.com/4.11.4/full/ckeditor.js"></script>

    <%--<script src="../Views/ckeditor.js"></script>--%>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>

        <div class="container" ng-app="" runat="server" id="divAll">
            <div class="row col-md-12 col-lg-12 ">
                <div class="float-left col-md-6 col-lg-6">
                    <img src="https://www.fountainheadschools.org/wp-content/uploads/2018/10/FS-Logo-with-Mission-Statement_NEW.png" /><br />
                </div>
                <div class="col-md-6 col-lg-6" style="text-align: end">
                    <asp:Label ID="lblStudentHeaderName" runat="server" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="lblTimer" runat="server" ClientIDMode="Static"></asp:Label>
                </div>
            </div>
            <div id="div1" class="text-center" runat="server">
                <strong>MYP TERM 2 EXAMINATION (April 2019)
                    <br />
                    <asp:Label ID="lblGradeSubjectName" Font-Bold="true" runat="server"></asp:Label></strong>
            </div>

            <div id="divSomethingWentWrong" class="text-center" runat="server">
                <strong>Something Went Wrong
                    <br />
                    Please check your url</strong>
            </div>
            <div id="divExamError" class="text-center" runat="server">
                <strong>Exam is not started yet
                </strong>
            </div>
            <div id="divExamFinish" class="text-center" runat="server">
                <strong>Your Exam is over
                </strong>
            </div>

            <div id="divPreInstruction" runat="server">
                <div class="row table-bordered border-dark">
                    <div class="col-md-12 text-center">
                        <strong class="text-capitalize"><u>School Code: 004196</u>
                        </strong>
                    </div>
                    <div class="row col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Name of Student:</strong>
                            <asp:Label Text="{{Name}}" ID="lblSTudentName" runat="server"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Section:</strong>
                            <asp:Label ID="lblSectionName" Text="{{Section}}" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="row col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Grade:</strong>
                            <asp:Label ID="lblGradeName" runat="server" Text="{{Grade}}"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Roll No:</strong>
                            <asp:Label ID="lblRollNo" runat="server" Text="{{Roll NO}}"></asp:Label>
                        </div>
                    </div>
                    <div class="row  col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <div class="col-sm-6">
                            <strong>Subject:</strong>
                            <asp:Label ID="lblSubjectName" runat="server" Text="Language & Literature"></asp:Label>
                        </div>
                        <div class="col-sm-6">
                            <strong>Duration:</strong>
                            <asp:Label ID="lblDuration" ClientIDMode="Static" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="row  col-md-12 col-sm-12 col-lg-12" style="margin-top: 1%">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-lg-12" style="margin-top: 2%">
                        <b>Enter Access Token :</b>
                        <asp:TextBox ID="txtAccessToken" runat="server" onkeypress="return isNumberKey(event)" MaxLength="8"></asp:TextBox>
                        <asp:Button ID="btnStartExam" OnClientClick="return CheckVal();" runat="server" CssClass="btn-success float-right" Text="Start Exam" />
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <%--<h2>Carousel Example</h2>--%>
            <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="false" runat="server">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                    <li data-target="#myCarousel" data-slide-to="3"></li>
                    <li data-target="#myCarousel" data-slide-to="4"></li>
                    <li data-target="#myCarousel" data-slide-to="5"></li>
                    <li data-target="#myCarousel" data-slide-to="6"></li>

                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <div style="margin: 20px">
                            <div class="table-responsive">
                                <h3>Question - 1</h3>
                                <table class="table" border="1">
                                    <thead>
                                        <tr style="white-space: nowrap;">
                                            <td style="width: 50%;">
                                                <strong>Poem 1 - Valentine by Carol Ann Duffy</strong><br />
                                                <br />
                                                <a href="Audio/Produce.mp3" target="_blank">Audio</a>
                                            </td>
                                            <td>
                                                <strong>Poem 2 - You’re by Sylvia Plath</strong><br />
                                                <br />
                                                <a href="https://www.youtube.com/embed/SYZJq4boNLI" target="_blank">https://www.youtube.com/embed/SYZJq4boNLI</a>
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>The poem <b>‘Valentine’</b> expresses love and affection in the form of a conceit.
                                                <br />
                                                <br />
                                                Transcript:      
                                                  <br />
                                                <br />
                                                Not a red rose or a satin heart.<br />
                                                I give you an onion.<br />
                                                It is a moon wrapped in brown paper.<br />
                                                It promises light<br />
                                                like the careful undressing of love.<br />
                                                Here.<br />
                                                It will blind you with tears<br />
                                                like a lover.<br />
                                                It will make your reflection<br />
                                                a wobbling photo of grief.<br />
                                                I am trying to be truthful.<br />
                                                <br />

                                                <b>Source:</b>
                                                <br />
                                                <a style="color: black">https://www.scottishpoetrylibrary.org.uk/poem/valentine/</a>

                                            </td>
                                            <td>Clownlike, happiest on your hands,  
                                                <br />
                                                Feet to the stars, and moon-skulled,  
                                                <br />
                                                Gilled like a fish. A common-sense  
                                                <br />
                                                Thumbs-down on the dodo’s mode.  
                                                <br />
                                                Wrapped up in yourself like a spool,  
                                                <br />
                                                Trawling your dark as owls do.  
                                                <br />
                                                Mute as a turnip from the Fourth  
                                                <br />
                                                Of July to All Fools’ Day,<br />
                                                O high-riser, my little loaf.<br />
                                                <br />

                                                Vague as fog and looked for like mail.  
                                                <br />
                                                Farther off than Australia.<br />
                                                Bent-backed Atlas, our travelled prawn.  
                                                <br />
                                                Snug as a bud and at home  
                                                <br />
                                                Like a sprat in a pickle jug.  
                                                <br />
                                                A creel of eels, all ripples.  
                                                <br />
                                                Jumpy as a Mexican bean.  
                                                <br />
                                                Right, like a well-done sum.  
                                                <br />
                                                A clean slate, with your own face on.<br />
                                                <br />
                                                <b>Source -</b><br />
                                                <a style="color: black">https://www.poetryfoundation.org/poems/49010/youre</a>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                            <b>This question part will be assessed on  A - Analysing and Criterion D - Use of Language.<br />
                                Time recommendation for question parts 1a to 1c - 25 minutes</b><br />
                            <br />
                            <b>Question 1a</b><span class="float-right"> <b>[Criterion A strand ii, Criterion D strands (i - iv)]</b></span><br />
                            ‘It will blind you with tears like a lover. It will make your reflection a wobbling photo of grief.’
                                    (00:21 - 00:29)
                                    <br />

                            <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion1">
                                <Tools>
                                    <telerik:EditorToolGroup Tag="Formatting">
                                        <telerik:EditorTool Name="Underline" />
                                        <telerik:EditorTool Name="Bold" />
                                        <telerik:EditorTool Name="Italic" />
                                        <telerik:EditorTool Name="InsertTable" />
                                    </telerik:EditorToolGroup>
                                </Tools>
                            </telerik:RadEditor>

                            <%--<asp:TextBox runat="server" ID="txtQuestion1" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>--%>

                            <br />
                            <b>Identify</b> the literary technique/s used by the poet in the above lines.<br />

                            <br />

                            <b>Question 1b </b><span class="float-right"><b>[Criterion A strand iii, Criterion D strands (i - iv)]</b></span><br />
                            <b>Justify </b>the language and imagery used in the poem - You’re by Sylvia Plath. 
                                    <br />
                            <%--<asp:TextBox runat="server" ID="txtQuestion2" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>--%>


                            <br />
                            <b>Question 1c </b><span class="float-right"><b>[Criterion A strands (i, ii, iii & iv), Criterion B strands (i & ii) and Criterion D strands (i - iv)]</b></span><br />
                            <b>Compare and contrast</b> the message the poets are trying to convey about love in both the poems.
                                    <br />
                            <%--<asp:TextBox runat="server" ID="txtQuestion3" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>--%>
                        </div>
                    </div>

                    <div class="item">

                        <div style="margin: 20px">

                            <h3>Question - 2</h3>
                            <div style="border-style: solid; border-width: 1px;">
                                <b>This question part will be assessed on Criterion A - Analysing.
                                        <br />
                                    Time recommendation for question parts 2a and 2b - 15 minutes</b><br />
                                <img src="Images/q2figurea.png" class="customImage text-left" />
                                <br />
                                <a style="color: black">https://goo.gl/pzaTQn</a>
                                <br />
                                <br />

                                <b>Question 2a </b><span class="float-right"><b>[Criterion A strand ii]</b></span><br />
                                <b>Identify</b> the message that the author is trying to convey in the image/excerpt.
                            </div>
                            <br />
                            <%-- <asp:TextBox runat="server" ID="txtQuestion4" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>--%>



                            <br />
                            <div style="border-style: solid; border-width: 1px;">
                                <b>Question 2b </b><span class="float-right"><b>[Criterion A strand ii]</b></span><br />
                                <b>Identify</b> the internal conflict of the narrator and <b>comment</b> on it.
                            </div>
                            <br />

                            <%--<asp:TextBox runat="server" ID="txtQuestion5" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>--%>
                        </div>
                    </div>

                    <div class="item">

                        <div style="margin: 20px;">
                            <h3>Question - 3</h3>
                            <div style="border-style: solid; border-width: 1px;">
                                <b style="border: thin;">This question part will be assessed on Criterion B Organizing strands (i & ii), Criterion C Producing Text
                                        strands (i, ii & iii) Criterion D Use of Language strands (i - iv)<br />
                                    <br />
                                    Time recommendation for question 2 - 35 minutes </b>
                                <br />
                                <br />
                                <p style="border: thin;">Based on the study of the concept - <b>‘Connections’</b> and global context <b>‘Identities and Relationships’</b> during the unit of study -What binds us, blinds us, <b>create</b> an opinion piece sharing your point of view on how love is a complicated affair. Use the quote given below as a stimulus.</p>
                                <p style="border: thin;">
                                    <img src="Images/q3figurea.png" class="customImage text-left" />
                                    <br />
                                    <b>Source : </b><a style="color: black">https://goo.gl/6pw7bU</a>

                                </p>
                            </div>
                            <br />
                            <%--  <asp:TextBox runat="server" ID="txtQuestion6" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px" onblur="SaveAnswer(this.id,this.value)"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>--%>
                        </div>
                    </div>
                    <div class="item">

                        <div style="margin: 20px">
                            <h3>Question - 4</h3>
                            <div style="border-style: solid; border-width: 1px;">
                                <b>This question part will be assessed on Criterion A Analysing strand ii<br />
                                    Time recommendation for question 4 - 10 minutes                                                 
                                </b>
                                <br />
                                <br />
                                <a href="https://www.youtube.com/embed/F8IedHc7txs" target="_blank">https://www.youtube.com/embed/F8IedHc7txs</a><br />
                                <br />
                                Watch the documentary and <b>identify</b> the codes and conventions.
                                    
                            </div>
                            <br />
                            <%--   <asp:TextBox runat="server" ID="txtQuestion7" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>--%>
                        </div>
                    </div>
                    <div class="item">

                        <div style="margin: 20px">
                            <h3>Question - 5</h3>
                            <div style="border-style: solid; border-width: 1px;">
                                <b>This question part will be assessed on Criterion A Analysing
                                        <br />
                                    Time recommendation for question 15 minutes
                                        <br />
                                    Read the following excerpt, and watch the video to respond to the questions that follow:<br />
                                    <br />
                                </b>
                                <a href="https://www.youtube.com/embed/mOJwALkBg2M" target="_blank">https://www.youtube.com/embed/mOJwALkBg2M</a><br />
                                <br />
                                <b>Transcript:
                                        <br />
                                    <br />
                                    <p style="text-align: justify;">
                                        An excerpt (The reconciliation letter) from Jane Austen’s posthumously published novel - Persuasion
                                        The letter is written by Captain Wentworth to Anne Elliot. Anne and Wentworth have met again through 
                                        family and she has found out he won't marry Louisa Musgrove and he has found out she won't marry Sir Elliot. 
                                        Although still uncertain on whether she loves him as well, all of Wentworth's scorned feelings have come back 
                                        full force and he decides to make himself known to her once more in the most romantic letter Jane Austen has ever put down on paper.
                                    </p>
                                </b>
                                <br />
                                <br />
                                <p style="text-align: justify; border: thin;">
                                    I can listen no longer in silence. I must speak to you by such means as are within my reach. 
                                        You pierce my soul. I am half agony, half hope. Tell me not that I am too late, that such precious 
                                        feelings are gone forever. I offer myself to you again with a heart even more your own than when you 
                                        almost broke it, eight years and a half ago. Dare not say that man forgets sooner than woman, that his 
                                        love has an earlier death. I have loved none but you. Unjust I may have been, weak and resentful I have 
                                        been, but never inconstant. You alone have brought me to Bath. For you alone, I think and plan. Have you 
                                        not seen this? Can you fail to have understood my wishes? I had not waited even these ten days, could 
                                        I have read your feelings, as I think you must have penetrated mine. I can hardly write. I am every 
                                        instant hearing something which overpowers me. You sink your voice, but I can distinguish the tones of 
                                        that voice when they would be lost on others. Too good, too excellent creature! You do us justice, indeed. 
                                        You do believe that there is true attachment and constancy among men. Believe it to be most fervent, 
                                        most undeviating, in F. W.<br />
                                    <br />
                                    <br />

                                    I must go, uncertain of my fate; but I shall return hither, or follow your party, as soon as possible. 
                                        A word, a look,will be enough to decide whether I enter your father's house this evening or never.
                                </p>

                                <b>Source:</b><br />
                                <a style="color: black">https://electricliterature.com/11-of-the-best-love-letters-in-literature-both-fictional-and-not-41d0bbda6bdd</a><br />

                            </div>
                            <br />
                            <b>Question 5a</b><span class="float-right"> <b>[Criterion A Analysing strand ii]</b></span><br />
                            <b>Identify</b> the dominant tone and mood in the excerpt.
                                        <%--<asp:TextBox runat="server" ID="txtQuestion8" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                            ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion8.ClientID%>');</script>--%>



                            <br />
                            <b>Question 5b <span class="float-right"><b>[Criterion A Analysing strand iii]</b></span><br />
                                Have you not seen this? Can you fail to have understood my wishes?
                            </b>
                            <br />
                            <b>Examine</b> the purpose of rhetorics used by the author in the given video/excerpt.
                                    <br />
                            <br />
                            <%--<asp:TextBox runat="server" ID="txtQuestion9" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion9.ClientID%>');</script>--%>
                        </div>
                    </div>
                    <div class="item">

                        <div style="margin: 20px">
                            <h3>Question - 6</h3>
                            <div style="border-style: solid; border-width: 1px;">
                                <b>Read the excerpt given and answer the question that follows it.<br />
                                    This question part will be assessed on Criterion A - Analysing and Criterion B - Organizing.<br />
                                    Time recommendation for question 5 - 15 minutes     </b>
                                <br />
                                <br />
                                <b>From ‘Paradise’ by Nicholas Hogg</b><br />
                                <br />
                                <p style="text-align: justify;">
                                    My father was born at the height of clouds. He entered the world wailing, lungs pumping the mountain 
                                        air and desperate for oxygen. He lived because he had the breath of a Kalenjin, as had his father and 
                                        his grandfather before, a long line of proud and noble descendants from the ancient tribe of Highlanders
                                        from the hills of the Great Rift Valley.<br />
                                    <br />
                                    He grew up at an altitude where visiting relatives from the lowlands fainted and had to sit and take 
                                        a rest from the sky. A village where the rhythm of life was set by the stars and the moon, the sun and 
                                        the rain, a village where horseless cowboys herded the cattle, and my father and his brothers ran down 
                                        the strays barefoot.<br />
                                    <br />
                                    Like all Kalenjin boys, he ran everywhere. He ran to school. He ran home from school. He ran to gather 
                                        firewood. He ran to the river to fetch water and spilt none running back. He ran but did not race.
                                        Running was not a sport. It was a way of life.<br />
                                    <br />
                                    <b>Source:</b> <a style="color: black">https://newshortstories.wordpress.com/category/excerpts/</a>
                                </p>

                            </div>
                            <br />
                            <b>Question 6a </b><span class="float-right"><b>[Criterion A strand ii), Criterion B strands (i & ii)]</b></span><br />
                            <b>Interpret </b>what the author meant when he said, ‘Running was not a sport. It was a way of life.’
                                      <%--<asp:TextBox runat="server" ID="txtQuestion10" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                          ClientIDMode="Static" Height="200px"></asp:TextBox>
                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>--%>


                            <br />
                            <b>Question 6b </b><span class="float-right"><b>[Criterion A strand iii, Criterion B strands (i & ii)]</b></span><br />
                            <b>Justify  </b>your answer by providing two pieces of evidence from the text.
                                    <br />
                            <%--<asp:TextBox runat="server" ID="txtQuestion11" TextMode="MultiLine" Width="100%" CssClass="Multilinetext form-control"
                                ClientIDMode="Static" Height="200px"></asp:TextBox>
                           <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>--%>
                        </div>
                    </div>

                    <div class="item">
                        <img src="../Images/Home3.jpg" alt="New york" style="width: 100%;" />
                    </div>

                </div>

                <div class="row" style="align-content: center;">
                    <div class="col-lg-6"></div>
                    <!-- Left and right controls -->
                    <div class="col-lg-2">
                        <a class="left" href="#myCarousel" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right" href="#myCarousel" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                    <div class="col-lg-4"></div>
                </div>

            </div>
        </div>

    </form>
</body>
</html>
<script>
    $(document).ready(function () {
        window.setInterval(function () {
            var i;
            for (i = 1; i <= 11; i++) {
                var id = "txtQuestion" + i;
                var value = id.get_html();
                SaveAnswer(id, value);
            }

        }, 5000);

    });

    function SaveAnswer(ControlID, value) {
        var EAM = {};
        EAM.StudentID = 120;
        EAM.ExamID = 15;
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
                }
                else {
                    alert("Exam is not Save ...!");
                }
            },

            error: function (x, e) {
                alert('Failed');
                alert(x.responseText);
                alert(x.status);

            }
        });
    }
</script>
