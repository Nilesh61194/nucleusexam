<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImageEditor.aspx.cs" Inherits="NucleusExams.Grade10.DemoPaper.ImageEditor" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous" />
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
        <div class="row" style="align-content: center!important;">
            <div class="col-lg-2"></div>

            &nbsp;&nbsp;&nbsp;<asp:Button ID="btnReset" runat="server" Text="Reset" OnClientClick="return val();" OnClick="btnReset_Click" />
            <div class="col-lg-8">
                <telerik:RadImageEditor RenderMode="Lightweight" AllowedSavingLocation="Server" ID="RadImageEditor1" CanvasMode="Automatic" runat="server" Width="80%" Height="680px"
                    ImageUrl="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABAAAAAQAAQAAAABXZhYuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAd2KE6QAAAAHdElNRQfhCAgIMheEuIGnAAACGUlEQVR42u3OIQEAAAACIP+f1hkWWEB6FgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF3YIvvHeNWBhB3AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE3LTA4LTA4VDA4OjUwOjIyKzAwOjAwm/yKPgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNy0wOC0wOFQwODo1MDoyMiswMDowMOqhMoIAAAAASUVORK5CYII=">
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
            <div class="col-lg-2"></div>
        </div>
    </form>
</body>
</html>
