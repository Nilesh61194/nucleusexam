<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testslide.aspx.cs" Inherits="NucleusExams.Paper.testslide" %>

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
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/popup.css" rel="stylesheet" />
    <script src="../assets/js/sweetalert-dev.js"></script>
    <script src="../ckeditor4/ckeditor.js"></script>
    <script src="../Scripts/Script.js"></script>
</head>
<body>
    <script>
        $(document).ready(function () {
            window.setInterval(function () {
                debugger;
                SaveAnswerAllTime();
            }, 10000);
        });

        //function StopSave() {
        //    clearInterval(10000);
        //}

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
        }



        function Top() {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
        }

        function FinishExam() {
            var retVal = confirm("Are you sure you want to finish the exam  ?");
            if (retVal == true) {
                SaveAnswerAllTime();
                document.getElementById('<%= btnFinish.ClientID %>').click();
            } else {
                return false;
            }
        }
        function SaveAnswerAllTime() {
            debugger;

            var RadEditorID = ["txtQuestion1", "txtQuestion2", "txtQuestion3", "txtQuestion4", "txtQuestion5", "txtQuestion6", "txtQuestion7",
                    "txtQuestion8", "txtQuestion9"];
            var i;
            for (i = 0; i <= RadEditorID.length - 1; i++) {
                var id = RadEditorID[i];
                var value = $telerik.findEditor("" + id + "").get_html();
                SaveAnswer(id, value);
            }

            var CKEdiorID = ["txtQuestion10", "txtQuestion11", "txtQuestion12"];
            var j;
            for (j = 0; j <= CKEdiorID.length - 1; j++) {
                var id = CKEdiorID[j];
                var value = CKEDITOR.instances["" + id + ""].getData();
                SaveAnswer(id, value);
            }
        }

        function allanswersave() {
            SaveAnswerAllTime();
        }

        function SaveAnswer(ControlID, value) {
            debugger;

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
                    alert('Failed');
                    //alert(x.responseText);
                    //alert(x.status);

                }
            });

        }
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <asp:HiddenField ID="hfStudentID" runat="server" />
        <asp:HiddenField ID="hfExamID" runat="server" />
        <div class="container" ng-app="" runat="server" id="divAll">
            <div class="row col-md-12 col-lg-12 ">
                <div class="float-left col-md-6 col-lg-6">
                    <img src="../Images/Logo/FS_Logo.png" /><br />
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

            <div class="container">
                <%--<h2>Carousel Example</h2>--%>
                <div id="myCarousel" class="carousel slide" runat="server" data-ride="carousel" data-interval="false" data-keyboard="false">
                    <!-- Indicators data-ride="carousel" -->

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
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion1" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                                <br />

                                <b>Question 1b </b><span class="float-right"><b>[Criterion A strand iii, Criterion D strands (i - iv)]</b></span><br />
                                <b>Justify </b>the language and imagery used in the poem - You’re by Sylvia Plath. 
                                    <br />


                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion2"
                                    ExternalDialogsPath="~/RadEditorDialogs/" ContentAreaCssFile="~/Content/TelerikTable.css">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                                <br />
                                <b>Question 1c </b><span class="float-right"><b>[Criterion A strands (i, ii, iii & iv), Criterion B strands (i & ii) and Criterion D strands (i - iv)]</b></span><br />
                                <b>Compare and contrast</b> the message the poets are trying to convey about love in both the poems.
                                    <br />

                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design" EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion3" ExternalDialogsPath="~/RadEditorDialogs/"
                                    ContentAreaCssFile="~/Content/TelerikTable.css">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                            </div>
                        </div>

                        <div class="item">

                            <div>

                                <h3>Question - 2</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>This question part will be assessed on Criterion A - Analysing.
                                        <br />
                                            Time recommendation for question parts 2a and 2b - 15 minutes</b><br />
                                        <br />
                                        <a style="color: black">https://goo.gl/pzaTQn</a>
                                        <br />
                                        <br />

                                        <b>Question 2a </b><span class="float-right"><b>[Criterion A strand ii]</b></span><br />
                                        <b>Identify</b> the message that the author is trying to convey in the image/excerpt.
                                    </div>
                                </div>
                                <br />


                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion4" ExternalDialogsPath="~/RadEditorDialogs/" ContentAreaCssFile="~/Content/TelerikTable.css">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>


                                <br />
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Question 2b </b><span class="float-right"><b>[Criterion A strand ii]</b></span><br />
                                        <b>Identify</b> the internal conflict of the narrator and <b>comment</b> on it.
                                    </div>
                                </div>
                                <br />

                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion5" ExternalDialogsPath="~/RadEditorDialogs/" ContentAreaCssFile="~/Content/TelerikTable.css">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3>Question - 3</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b style="border: thin;">This question part will be assessed on Criterion B Organizing strands (i & ii), Criterion C Producing Text
                                        strands (i, ii & iii) Criterion D Use of Language strands (i - iv)<br />
                                            <br />
                                            Time recommendation for question 2 - 35 minutes </b>
                                        <br />
                                        <br />
                                        <p style="border: thin;">Based on the study of the concept - <b>‘Connections’</b> and global context <b>‘Identities and Relationships’</b> during the unit of study -What binds us, blinds us, <b>create</b> an opinion piece sharing your point of view on how love is a complicated affair. Use the quote given below as a stimulus.</p>
                                    </div>
                                </div>
                                <br />
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion6" ExternalDialogsPath="~/RadEditorDialogs/" ContentAreaCssFile="~/Content/TelerikTable.css">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3>Question - 4</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>This question part will be assessed on Criterion A Analysing strand ii<br />
                                            Time recommendation for question 4 - 10 minutes                                                 
                                        </b>
                                        <br />
                                        <br />
                                        <a href="https://www.youtube.com/embed/F8IedHc7txs" target="_blank">https://www.youtube.com/embed/F8IedHc7txs</a><br />
                                        <br />
                                        Watch the documentary and <b>identify</b> the codes and conventions.
                                    </div>
                                </div>
                                <br />
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion7" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3>Question - 5</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
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


                                        <br />
                                        <b>Question 5a</b><span class="float-right"> <b>[Criterion A Analysing strand ii]</b></span><br />
                                        <b>Identify</b> the dominant tone and mood in the excerpt.
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion8" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>

                                <br />
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <b>Question 5b <span class="float-right"><b>[Criterion A Analysing strand iii]</b></span><br />
                                            Have you not seen this? Can you fail to have understood my wishes?
                                        </b>
                                        <br />
                                        <b>Examine</b> the purpose of rhetorics used by the author in the given video/excerpt.                                     
                                    </div>
                                </div>
                                <telerik:RadEditor ContentAreaMode="Div" AutoResizeHeight="true" NewLineBr="true" ContentFilters="None" RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="400px" EditModes="Design"
                                    EmptyMessage="Write Answer" Width="100%" runat="server" ID="txtQuestion9" ExternalDialogsPath="~/RadEditorDialogs/">
                                    <Tools>
                                        <telerik:EditorToolGroup Tag="Formatting">
                                            <telerik:EditorTool Name="Underline" />
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="InsertTable" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
                            </div>
                        </div>
                        <div class="item">

                            <div style="margin: 20px">
                                <h3>Question - 6</h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
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
                                </div>
                                <br />
                                <b>Question 6a </b><span class="float-right"><b>[Criterion A strand ii), Criterion B strands (i & ii)]</b></span><br />
                                <b>Interpret </b>what the author meant when he said, ‘Running was not a sport. It was a way of life.’
                                      
                                <asp:TextBox ID="txtQuestion10" runat="server" TextMode="MultiLine"></asp:TextBox>
                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion10.ClientID%>');</script>
                                <br />
                                <b>Question 6b </b><span class="float-right"><b>[Criterion A strand iii, Criterion B strands (i & ii)]</b></span><br />
                                <b>Justify  </b>your answer by providing two pieces of evidence from the text.
                                    <br />
                                <asp:TextBox ID="txtQuestion11" runat="server" TextMode="MultiLine"></asp:TextBox>
                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion11.ClientID%>');</script>
                                <br />
                                <b>Question 6c </b><span class="float-right"><b>[Criterion A strand iii, Criterion B strands (i & ii)]</b></span><br />
                                <b>Justify  </b>Write any formula in answer box 
                                    <br />
                                <asp:TextBox ID="txtQuestion12" runat="server" TextMode="MultiLine"></asp:TextBox>
                                <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion12.ClientID%>');</script>
                            </div>
                        </div>
                        <div class="item">
                            <div class="row">
                                <div class="col-lg-12 text-center">
                                    <h3><b>Are you sure you want to finish the exam ?</b>
                                        <br />
                                        <br />
                                        Click on finish button to finish exam.
                                    </h3>
                                    <input type="button" id="btnMainFinish" onclick="FinishExam();" value="Finish Exam" class="btn btn-info" />
                                    <asp:Button ID="btnFinish" runat="server" OnClientClick="btnFinish_Click" Style="display: none;" />
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
                    <ol>
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                        <li data-target="#myCarousel" data-slide-to="2"></li>
                        <li data-target="#myCarousel" data-slide-to="3"></li>
                        <li data-target="#myCarousel" data-slide-to="4"></li>
                        <li data-target="#myCarousel" data-slide-to="5"></li>
                        <li data-target="#myCarousel" data-slide-to="6"></li>
                    </ol>

                </div>
                <div id="divExamFinish" class="text-center" runat="server">
                    <strong>Your Exam is over
                    </strong>
                </div>
            </div>
        </div>
    </form>
</body>
</html>





