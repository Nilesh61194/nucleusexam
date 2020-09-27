<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LL.aspx.cs" Inherits="NucleusExams.Grade10.LL.LL" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Shortcut Icon" href="../../Images/Nucleus_16.png?123" />
    <title>LL Grade 10</title>
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
            text-align: justify !important;
            font-size: larger !important;
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

        function ErrorFunction(msg) {
            swal("Error", msg, "error");
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
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>This question will be assessed on Criterion A- Analysing, Criterion B- Organising and Criterion D- Use of Language.</b></span><br />

                                        </div>
                                        <br />
                                        <div id="divmainContent" style="overflow: auto; background-color: #9fd8fb;">
                                            <div>

                                                <div style="border: 1px solid black; margin: 10px;">
                                                    <p style="margin: 10px;" class="CustomFontSize">MYP topic - Media and Mass Communication</p>
                                                    <b style="margin: 10px;">Source 1</b><br />
                                                    <p class="text-center" style="font-size: large!important; margin: 10px;">
                                                        <b>Ghosts of Celestún!
                                                        </b>
                                                    </p>
                                                    <p style="font-size: large!important; margin: 10px;">
                                                        <b>Biosphere Reserve
                                                        </b>
                                                    </p>
                                                    <p class="CustomFontSize" style="margin: 10px;">
                                                        Into the mangroves and pink lagoons of Mexico's Yucatán Coast.(Gauger)<br />
                                                        <br />
                                                        The Celestún Biosphere Reserve, with its clusters of hammock islands, dense mangroves, salt salinas, 
                                                        freshwater cenotes and pink lagoons, has summoned me.<br />
                                                        <br />
                                                        I’m in Mérida, the capital of Mexico’s Yucatán state, where I am handing my ten-year-old son off to 
                                                        live with a Yucateno family for a week.<br />
                                                        <br />
                                                        That moment of sending your kid off into the unknown, is terrifying, but once he and his carry-on have 
                                                        disappeared around the corner, it’s no longer fear, but  a completely new sensation.<br />
                                                        <br />
                                                        Maybe this is a taste of how parents feel after sending their kid off to college - that deep, unsettling
                                                         feel of, huh, what now? 
                                                        <br />
                                                        <br />
                                                        A school-parent friend once told me that I had been dubbed Ghost Dad, never showing up for drop-off or 
                                                        pick-up.  But now was my time to make up for six years of absence; I could finally get to know the 
                                                        parents, all holed up together in a downtown Mérida hotel.<br />
                                                        <br />
                                                        I told the parents that in the morning, I would be heading just outside the northwest perimeter of 
                                                        Mérida, where there were some wetlands and open meadows. Would you join me?<br />

                                                    </p>
                                                    <p style="font-size: large!important; margin: 10px;">
                                                        <b>Kai Luum and the Private Lagoon
                                                        </b>
                                                    </p>
                                                    <p class="CustomFontSize" style="margin: 10px;">
                                                        Not much of a response comes through on our messaging app, and none of the dads show up at the taxi 
                                                        the next morning. I wonder: maybe I didn’t sell that well enough? 
                                                        <br />
                                                        <br />
                                                        I had almost told them that this would be the most memorable day of their entire trip.  But I held back,
                                                         not being able to promise that at all. In fact, I would be winging everything; bumbling tour guide to a 
                                                        place I’ve never been.<br />
                                                        <br />
                                                        My taxi driver, who had insisted I didn’t really want to go to the place I insist on going, gives up 
                                                        and drops me off on a quiet street near the Kai Luum ecological area.  How will you get back? He had 
                                                        asked. Maybe you'll pick me up?<br />
                                                        <br />
                                                        Almost instantly as I walk into the bounds of the park, life is everywhere: Malachite butterflies, 
                                                        dainty wildflowers, and fluorescent-colored Painted Buntings.<br />
                                                        <br />
                                                        After roaming the park for a few hours on my own, I am approached by the only other man in the park, 
                                                        Jorge, who has been honing his photography skills in Yucatán’s natural areas each weekend.<br />
                                                        <br />
                                                        We introduce ourselves, and then Jorge explains that there is a lagoon just a kilometer away.  I tell him
                                                         that I didn’t remember another body of water around here. He insists that due to its large size, there
                                                         is much more wildlife there.
                                                        <br />
                                                        <br />
                                                        I agree to join him, and hop in his car.  After we pass the kilometer mark, he tells me that the 
                                                        lagoon is just a few more kilometers away.<br />
                                                        <br />
                                                        We pull into the parking lot of a new apartment building, and park discreetly at the corner of the 
                                                        property.  In front of us is a sign: Propiedad Privada No Traspasando.<br />
                                                        <br />
                                                        “I know the sign says no entry, but this is the Yucatán.  Everybody is very friendly here! It’s no 
                                                        problem,” Jorge explains.<br />
                                                        <br />
                                                        We navigate under the sharp cow fence, and walk down a rocky and abandoned road. 
                                                         When we get to the lagoon, it is almost completely devoid of life, unlike the nearby Kai Luum park.<br />
                                                        <br />
                                                        Jorge insists that he has been to this place many times, and we should walk around the lagoon.  There may even 
                                                        be Yucatán Jays, he explains.<br />
                                                        <br />
                                                        We walk on an overgrown trail around the lagoon, looking for what is surely Southern Mexico’s most beautiful bird.  
                                                        But the sun is beating down on a windless day, and it’s getting closer to noon; that classic combination 
                                                        that makes wildlife disappear.<br />
                                                        <br />
                                                        I follow Jorge toward the other side of the lagoon.  Nothing there. We start to head back to the car, and I
                                                         remember the promise I held back from the dads: It’ll be your best day in Mexico!<br />
                                                        <br />
                                                        Jorge says, “let’s try down here.”  Again, we walk down a new overgrown trail, heading into lagoon-side dry 
                                                        forest.  There they are, six Yucatán Jays: jet black heads, yellow eye-rings, azure blue wings, long slender tails. 
                                                         They are moving as a tribe through the trees, their wingbeats flashes of brilliant blue. Instantly, the day feels glorious.<br />
                                                        <br />
                                                        After Jorge drops me off at the ecological park, a text comes through from one of the parents.  
                                                        “Haven’t heard or seen much from you in the last twenty-four hours.” He kindly invites me to join up with the group.<br />
                                                        <br />
                                                        I want to break my reputation as Ghost Dad, but at the same time, I had just answered my question - huh, what now? - and 
                                                        arrange with the taxi driver to leave Mérida entirely, heading west to the Yucatán state’s northwest coast.

                                                        <br />
                                                        <br />

                                                        <b>Source:</b> https://www.notesfromtheroad.com/neotropics/celestun-biosphere-reserve.html
                                                    </p>

                                                </div>
                                                <div style="border: 1px solid black; margin: 10px;">
                                                    <b>Source 2</b><br />
                                                    <b>Video Link:</b> <a href="https://www.youtube.com/embed/82n1PX1hVEY" target="_blank">https://www.youtube.com/watch?v=82n1PX1hVEY</a>
                                                </div>
                                            </div>
                                            <div style="border: 1px solid black; margin: 10px; background-color: #9fd8fb;">
                                                <p class="CustomFontSize">
                                                    <ul class="CustomFontSize">
                                                        <li>Q 1(a), Q 1(b), Q 1(c), Q 1(d) are for Criterion A (strands ii & iii) and Criterion D (strands i - iv)</li>
                                                        <li>Q 1(a) and Q 1(b) are based on Source 1</li>
                                                        <li>Q 1(c) and Q 1(d) are based on Source 2</li>
                                                        <li>Q 1(e) is for Criterion A strands (i, ii, iii & iv) and Criterion B strands (i & ii)</li>
                                                        <li>Q 1(e) is based on Source 1 and Source 2</li>

                                                    </ul>
                                                </p>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span>Time recommendation for Q 1(a) to Q 1(d)  - 30 minutes</span><br />
                                            <span><b>Q.1a. Comment</b> on the effect of the writer's literary choices in the following line: 'Almost instantly as I walk into the bounds of the park, life is everywhere: Malachite butterflies, dainty wildflowers, and fluorescent-coloured Painted Buntings'</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                                        </div>
                                        <br />

                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q.1b. Outline</b> two aspects of the father's character and <b>select</b> two examples from the text that show how these aspects are developed.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion2" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion2.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q.1c. Identify</b> the target audience in the advertisement. <b>Justify</b> your answer with two examples from the text.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion3" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion3.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Q.1d. Identify</b> the technique/s used by the advertisers in the clip (0.15 to 0.28) to captivate the attention of the audience.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion4" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion4.ClientID%>');</script>
                                        </div>
                                        <br />
                                        <div class="CustomFontSize" style="background-color: #9fd8fb;">
                                            <span class="fa fa-paper-plane"></span>
                                            <span><b>Time recommendation for Q 1(e)  - 20 minutes<br />
                                                Q.1e. Compare and contrast</b> how the advertiser and the blog writer persuade the audience to visit the place.</span>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion5" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion5.ClientID%>');</script>
                                        </div>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div style="margin: 20px;">
                                <h3><b>Question - 2 : (Non-Literary text)</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="background-color: #9fd8fb;">
                                            <div style="border: 1px solid black; margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    <b>Q. 2 is for Criterion B- Organising (strands i & ii), Criterion C- Producing Text (strands i, ii & iii) Criterion D- Use of Language(strands i - iv) </b>
                                                    <br />
                                                    <b>Time recommendation:  35 minutes</b>
                                                </p>
                                            </div>
                                            <div style="margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    Based on the understanding of the <b>Global context - Scientific and technical innovation,</b> the excerpt given below and the video, 
                                                    <b>create a blog (400-500 words)</b> expressing your thoughts and opinions about doing your bit for the environment.
                                                <br />
                                                    In your response include: 
                                                <ul class="CustomFontSize">
                                                    <li>Causes and effects of environmental pollution</li>
                                                    <li>Major forms of pollution</li>
                                                    <li>Ways to save our environment and Planet Earth</li>
                                                </ul>
                                                </p>
                                            </div>
                                            <div style="border: 1px solid black; margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    <b>Excerpt:</b><br />
                                                    The numbers are staggering. Given our limited landmass, and the fear it’s only going to become smaller with sea level rise and coastal 
                                                    erosion, the issue is so alarming we cannot be complacent.
                                                    <br />
                                                    <br />

                                                    In fact, urgent action is needed and that involves everyone. Yes you and me. We all have a part to play.<br />
                                                    <br />

                                                    We are referring to the alarming statistics about waste collected along the coastline and the negligent attitudes, 
                                                    which have contributed to the demise of our environment.<br />
                                                    <br />

                                                    The question is where did this rubbish come from?
                                                    <br />
                                                    <br />

                                                    The answer is quite simple. They didn’t just drop from the sky. It came from you and me, the negligent human being who has 
                                                    developed quite a bad habit of littering anywhere and everywhere over the years. It includes the silly habit of throwing
                                                     trash from moving vehicles, dumping anything and everything on the seawall after that night out and all the bad behaviour
                                                     we have seen over the years. The worry is that these bad behaviours have been passed from generation to generation so 
                                                    they have become so common.<br />
                                                    <br />
                                                    <b>Source:</b> https://www.samoaobserver.ws/category/editorial/32039
                                                    <br />
                                                    <br />
                                                    <b>Video Link:</b> <a href="https://www.youtube.com/embed/JtGsdiYdObQ" target="_blank">https://www.youtube.com/watch?v=JtGsdiYdObQ</a>
                                                </p>
                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion6" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion6.ClientID%>');</script>
                                        </div>
                                        <br />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div style="margin: 20px;">
                                <h3><b>Question - 3 : (Literary text)</b></h3>
                                <div style="border-style: solid; border-width: 1px;">
                                    <div style="margin: 10px!important;">
                                        <div style="background-color: #9fd8fb;">
                                            <div style="border: 1px solid black; margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    <b>Q.3 is for Criterion B- Organizing, strands (i & ii), Criterion C Producing Text, strands (i, ii & iii) Criterion D Use of Language, strands (i - iv) </b>
                                                    <br />
                                                    <b>Time recommendation:  35 minutes</b>
                                                </p>
                                            </div>
                                            <div style="margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    Watch this <a href="https://www.youtube.com/embed/LKBNEEY-c3s" target="_blank">illustrated excerpt</a> and read the below transcript from Sea Prayer by Khaled Hosseini containing an imagined letter in the form of a monologue from a Syrian father to his son lying asleep on his lap, on the eve marking the sea crossing to Europe to seek refuge and safety; attempt the Q.3  that follows:
                                                </p>
                                            </div>
                                            <div style="border: 1px solid black; margin: 10px;">
                                                <p class="CustomFontSize" style="margin: 10px;">
                                                    <b>Transcript:</b><br />
                                                    <i>My dear Marwan,
                                                        <br />
                                                        <br />
                                                        In the long summers of childhood, when I was a boy the age you are now, your uncles and I spread our mattress on the roof of your grandfather’s farmhouse, outside of Homs.
                                                    <br />
                                                        <br />
                                                        We woke in the morning to the stirring of olive trees in the breeze, to the bleating of your grandmother’s goat, the clanking of her cooking pots, the air cool and the sun a pale rim of persimmon to the east.
                                                    <br />
                                                        <br />
                                                        We took you there when you were a toddler. I have a sharply etched memory of your mother from that trip, showing you a herd of cows grazing in a field blown through with wild flowers. I wish you hadn’t been so young.
                                                    <br />
                                                        <br />
                                                        You wouldn’t have forgotten the farmhouse, the soot of its stone walls, the creek where your uncles and I built a thousand boyhood dams.
                                                    <br />
                                                        <br />
                                                        I wish you remembered Homs as I do, Marwan.
                                                    <br />
                                                        <br />
                                                        In its bustling Old City, a mosque for us Muslims, a church for our Christian neighbors, and a grand Souk for us all to haggle over gold pendants and fresh produce and bridal dresses. I wish you remembered the crowded lanes smelling of fried Kibbeh and the evening walks we took with your mother around Clock Tower Square.
                                                    <br />
                                                        <br />
                                                        But that life, that time, seems like a sham now, even to me, like some long dissolved rumor. First came the protests. Then the siege. The skies spitting bombs. Starvation. Burials.
                                                    <br />
                                                        <br />
                                                        These are the things you know. You know a bomb crater can be made into a swimming hole. You have learned dark blood is better news than bright. You have learned that mothers and sisters and classmates can be found, in little triangular patches of sunlit skin, shining in the dark, through narrow gaps in concrete and bricks and exposed beams.
                                                    <br />
                                                        <br />
                                                        Your mother is here tonight, Marwan, with us, on this cold and moonlit beach, among the crying babies and the women worrying in tongues we don’t speak. Afghans and Somalis and Iraqis and Eritreans and Syrians. All of us impatient for sunrise, all of us in dread of it. All of us in search of home. I have heard it said we are the uninvited. We are unwelcome. We should take our misfortune elsewhere. But I hear your mother’s voice, over the tide, and she whispers in my ear, “Oh but if they saw, my darling. Even half of what you have. If only they saw. They would say kinder things, surely.”<br />
                                                        <br />
                                                        I look at your profile in the glow of this three-quarter moon, my boy, your eyelashes like calligraphy, closed in guileless sleep. I said to you, “Hold my hand. Nothing bad will happen.”
                                                    <br />
                                                        <br />
                                                        These are only words. A father’s tricks.
                                                    <br />
                                                        <br />
                                                        It slays your father, your faith in him.
                                                        <br />
                                                        <br />
                                                        Because all I can think tonight is how deep the sea, and how vast, how indifferent. How powerless I am to protect you from it. All I can do is pray. Pray God steers the vessel true, when the shores slip out of eyeshot and we are a flyspeck in the heaving waters, keeling and titling, easily swallowed.
                                                    <br />
                                                        <br />
                                                        Because you, you are precious cargo, Marwan, the most precious there ever was.
                                                     <br />
                                                        <br />
                                                        I pray the sea knows this.<br />
                                                        Inshallah.<br />
                                                        How I pray the sea knows this.</i>
                                                    <br />
                                                    <br />
                                                    <b>Source :</b> https://www.unhcr.ca/news/sea-prayer-khaled-hosseini/ 
                                                </p>
                                            </div>
                                            <div style="margin: 10px;">
                                                <p class="CustomFontSize">
                                                    Based on the understanding of the <b>Global Context - Orientation in space and time, create</b> an <b>internal monologue (250-300 words)</b> through the perspective of Marwan,
                                                    describing your experience upon waking up and venturing into the unknown.<br />
                                                    <br />
                                                    In your response, include:
                                                    <ul class="CustomFontSize">
                                                        <li>description of who and what you see</li>
                                                        <li>your thoughts and feelings</li>
                                                        <li>sentimental vocabulary</li>
                                                    </ul>
                                                </p>
                                            </div>
                                        </div>
                                        <br />
                                        <div>
                                            <asp:TextBox ID="txtQuestion7" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion7.ClientID%>');</script>
                                        </div>
                                        <br />
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
                                <li id="li4" class="liNav" data-target="#myCarousel" data-slide-to="3" onclick="return Top();"><a href="#" class="liNavA">Finish</a></li>
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
