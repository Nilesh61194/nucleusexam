<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tools2.aspx.cs" Inherits="NucleusExams.DemoPages.Tools2" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <div class="row" style="align-content: center!important;">
            <div class="col-lg-3"></div>
            <div class="col-lg-6">
                <telerik:RadImageEditor RenderMode="Lightweight" AllowedSavingLocation="Server" ID="RadImageEditor1" CanvasMode="Automatic" runat="server" Width="75%" Height="580px">
                    <Tools>
                        <telerik:ImageEditorToolGroup>
                            <telerik:ImageEditorToolStrip Text="Undo" CommandName="Undo" />
                            <telerik:ImageEditorToolStrip Text="Redo" CommandName="Redo" />
                            <telerik:ImageEditorTool Text="Pencil" CommandName="Pencil" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Draw Circle" CommandName="DrawCircle" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Draw Rectangle" CommandName="DrawRectangle" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Line" CommandName="Line" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Add Text" CommandName="AddText" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Reset" CommandName="Reset" />
                        </telerik:ImageEditorToolGroup>
                    </Tools>
                </telerik:RadImageEditor>
            </div>
            <div class="col-lg-3"></div>
        </div>

        <asp:Timer ID="tc" runat="server" Interval="10000" OnTick="tc_Tick"></asp:Timer>

       <%-- <asp:UpdatePanel ID="up" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Literal ID="litmsg" runat="server" ></asp:Literal>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="tc" EventName="tick" />
            </Triggers>
        </asp:UpdatePanel>--%>
    </form>
</body>
</html>
