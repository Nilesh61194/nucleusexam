<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="MyExam.aspx.cs" Inherits="NucleusExams.MyExam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<div>
        <asp:Button ID="btnPDF" runat="server" Text="PDF" OnClick="btnPDF_Click" />
        <br />
    </div>
    <div>
        <div id="DivPrint" runat="server">
            <asp:Label ID="Label1" runat="server" Text="1. Nilesh"></asp:Label><br />
            <asp:Label ID="Label2" runat="server" Text="2. Lokhande"></asp:Label><br />
            <asp:Label ID="Label3" runat="server" Text="3. SCET"></asp:Label><br />
            <asp:Label ID="Label4" runat="server" Text="4. TCS"></asp:Label><br />
            <asp:Label ID="Label5" runat="server" Text="5. FS"></asp:Label>
        </div>
    </div>--%>
    <div class="row text-center" style="display: none">
        <div class="col-md-1">
        </div>
        <div class="col-md-2">
            <img src="Grade10/IDUG-8/i1.PNG" />
            <br />
            <br />
            <button onclick="return ShowPopUp();" class="button text-center">Greenhouse Effects</button>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-2">
            <img src="Grade10/IDUG-8/i2.PNG" />
            <br />
            <br />
            <button onclick="return ShowEarth();" class="button">Impact on biodiversity</button>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-2">
            <img src="Grade10/IDUG-8/i3.PNG" />
            <br />
            <br />
            <button onclick="return ShowCo2();" class="button">Impact of rising CO<sub>2</sub> levels</button>
        </div>
        <div class="col-md-1">
        </div>
    </div>

    <div class="row" style="display: none">
        <div class="col-md-12">
            <img src="Grade10/IDUG-8/RS0.PNG" id="imgRS" />
        </div>

        <select onchange="return callchange();" id="ddlRS">
            <option value="">Choolse Route Country</option>
            <option value="1">Surat</option>
            <option value="2">Baroda</option>
            <option value="3">Mumbai</option>
            <option value="4">USA</option>
            <option value="5">Canada</option>
            <option value="6">Daman</option>
        </select>
    </div>


    <div class="row">
        <div class="col-md-12">
            <table>
                <tr>
                    <td style="width: 50%">
                        <div class="row">
                            <img src="Grade10/IDUG-8/Q4.0.PNG" id="imgMain" />
                            <br />
                            <br />
                            <input type="button" onclick="return Change(1);" value="India" />
                            <input type="button" onclick="return Change(2);" value="China" />

                        </div>
                    </td>
                    <td style="width: 50%">
                        <img src="Grade10/IDUG-8/Q7Antarctica.PNG" id="imgSub" />
                    </td>
                </tr>
            </table>
        </div>
    </div>


    <div id="draggable" class="ui-widget-content">
        <p>Drag me around</p>
    </div>



</asp:Content>
