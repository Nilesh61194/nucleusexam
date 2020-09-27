<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DrawingTools.aspx.cs" Inherits="NucleusExams.DemoPages.DrawingTools" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
    <script>
        function val() {
            var retVal = confirm("Are you sure you want to reset diagram  ?");
            if (retVal == false) {
                return false;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager1"></asp:ScriptManager>
        <div class="row">
            <div class="col-lg-3"></div>
            <div class="col-lg-6">
                <asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="return val();" OnClick="btnReset_Click" />
                <telerik:RadImageEditor RenderMode="Lightweight" AllowedSavingLocation="Server" ID="editor" CanvasMode="Automatic" runat="server"
                    ImageUrl="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAu4AAAImCAIAAACDxJhEAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAk5SURBVHhe7dYBDQAADMOg+ze962gCKrgBAGSpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAEKYyAECYygAAYSoDAISpDAAQpjIAQJjKAABhKgMAhKkMABCmMgBAmMoAAGEqAwCEqQwAkLU9arA0NR01ojsAAAAASUVORK5CYII=">
                    <Tools>
                        <telerik:ImageEditorToolGroup>
                            <telerik:ImageEditorToolStrip Text="Undo" CommandName="Undo" />
                            <telerik:ImageEditorToolStrip Text="Redo" CommandName="Redo" />
                            <telerik:ImageEditorTool Text="Pencil" CommandName="Pencil" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Draw Circle" CommandName="DrawCircle" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Draw Rectangle" CommandName="DrawRectangle" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Line" CommandName="Line" IsToggleButton="true" />
                            <telerik:ImageEditorTool Text="Add Text" CommandName="AddText" IsToggleButton="true" />
                        </telerik:ImageEditorToolGroup>
                    </Tools>
                </telerik:RadImageEditor>
            </div>
            <div class="col-lg-3"></div>
        </div>
    </form>
</body>
</html>
