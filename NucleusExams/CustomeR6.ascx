<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomeR6.ascx.cs" Inherits="NucleusExams.CustomeR6" %>
<script>
    function RemoveClass() {
        document.getElementById("divTitle").removeAttribute("class", "highlight");
        document.getElementById("spanWho1").removeAttribute("class", "highlight");
        document.getElementById("spanWho2").removeAttribute("class", "highlight");
        document.getElementById("spanWhat1").removeAttribute("class", "highlight");
        document.getElementById("spanWhat2").removeAttribute("class", "highlight");
        document.getElementById("spanWhen1").removeAttribute("class", "highlight");
        document.getElementById("spanWhen2").removeAttribute("class", "highlight");
        document.getElementById("spanWhere1").removeAttribute("class", "highlight");
        document.getElementById("spanWhere2").removeAttribute("class", "highlight");
        document.getElementById("divWhy").removeAttribute("class", "highlight");
        document.getElementById("divHow").removeAttribute("class", "highlight");
    }

    function SetTitle() {
        RemoveClass();
        document.getElementById("divTitle").setAttribute("class", "highlight");
    }
    function SetWho() {
        RemoveClass();
        document.getElementById("spanWho1").setAttribute("class", "highlight");
        document.getElementById("spanWho2").setAttribute("class", "highlight");
    }
    function SetWhat() {
        RemoveClass();
        document.getElementById("spanWhat1").setAttribute("class", "highlight");
        document.getElementById("spanWhat2").setAttribute("class", "highlight");
    }
    function SetWhen() {
        RemoveClass();
        document.getElementById("spanWhen1").setAttribute("class", "highlight");
        document.getElementById("spanWhen2").setAttribute("class", "highlight");
    }
    function SetWhere() {
        RemoveClass();
        document.getElementById("spanWhere1").setAttribute("class", "highlight");
        document.getElementById("spanWhere2").setAttribute("class", "highlight");
    }
    function SetWhy() {
        RemoveClass();
        document.getElementById("divWhy").setAttribute("class", "highlight");
    }
    function SetHow() {
        RemoveClass();
        document.getElementById("divHow").setAttribute("class", "highlight");
    }
</script>
<table>
    <tr>
        <td>
            <div style="margin: 5px!important; background-color: lightgray!important">
                <b>
                    <h4>This media is interactive</h4>
                </b>
                <div class="row" style="margin: 20px">
                    <div class="col-md-3">
                        <a class="button" onclick="return SetTitle();">Title</a>
                    </div>
                    <div class="col-md-3">
                        <a class="button" onclick="return SetWho();">Who</a>
                    </div>
                    <div class="col-md-3">
                        <a class="button" onclick="return SetWhat();">What</a>
                    </div>
                    <div class="col-md-3">
                        <a class="button" onclick="return SetWhen();">When</a>
                    </div>
                </div>
                <br />
                <div class="row" style="margin: 20px">
                    <div class="col-md-3">
                        <a class="button" onclick="return SetWhere();">Where</a>
                    </div>
                    <div class="col-md-3">
                        <a class="button" onclick="return SetWhy();">Why</a>
                    </div>
                    <div class="col-md-3">
                        <a class="button" onclick="return SetHow();">How</a>
                    </div>
                    <div class="col-md-3">
                    </div>
                </div>
                <br />
                <div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <div id="spanWho1">
                                <b>
                                    <h2>REFU - SHELTER</h2>
                                </b>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-6">
                            <img src="Image/Source5.1.jpg" width="100%" />
                        </div>
                        <div class="col-md-6">

                            <div class="CustomFontSize">
                                <div id="divTitle">
                                    <h3><b>Refugees</b></h3>

                                    Everyone deserves a home<br />
                                    <br />
                                </div>

                                At  <span id="spanWho2">Refu-shelter</span> <span id="spanWhat1">we want to ensure all displaced people have a roof over their head and can live with dignity.</span>
                                <span id="spanWhere1">Globally</span> the United Nations Refugee Agency is <span id="spanWhen1">currently</span> witnessing the highest level of refugees on record(see below).
                                                                This stress on the agency means that it is getting harder to provide suitable shelter and resources for refugees.    
                            </div>
                            <br />


                        </div>
                    </div>
                    <br />
                    <div class="CustomFontSize">The information illustrates the current plight of displaced people :</div>
                    <br />
                    <img src="Image/Source5.2.jpg" width="100%" />
                    <br />
                    
                    <div class="CustomFontSize"><span id="spanWhat2">Data</span> taken from <span id="spanWhere2"><a>http://www.unhcr.org/uk/figures-at-a-glance.html</a></span> correct as <span id="spanWhen2">2016</span></div>
                    <br />
                    <img src="Grade10/IDUMay2019/Image/Source5.3.jpg" width="100%" />
                    <div class="CustomFontSize" id="divHow">You can help by donating the cause by choosing a donatiohn button below.</div>
                    <br />
                    <img src="Image/Source5.4.jpg" width="100%" />
                    <br />
                    <div class="row">
                        <div class="col-md-6">
                            <img src="Image/Source5.5.PNG" width="100%" height="75%" />
                        </div>
                        <div class="col-md-6">

                            <div class="CustomFontSize" id="divWhy" style="margin: 10px!important">
                                <b>
                                    <h3>why should you donate ?</h3>
                                    <br />

                                </b>
                                <div style="margin: 20px">
                                    with the increasing number of refugees globally, it is vital that their basic human rights are met whilst they are seeking
                                                                    asylum or waiting to return to their homes. Without your donations, water-based diseases will flourish in refugee camps, children will
                                                                    miss out on key literacy and numeracy skills, and whole families will live without the protection and warmth of a shelter. So 
                                                                    please donate now and share your donation to inspire others to do the same, and provide a safer and more dignified life for refugees
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
