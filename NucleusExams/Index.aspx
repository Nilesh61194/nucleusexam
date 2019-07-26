<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="NucleusExams.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Index Demo</title>
    <script src="ckeditor4/ckeditor.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="txt1" runat="server" TextMode="MultiLine"></asp:TextBox>
            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txt1.ClientID%>');</script>
        </div>
    </form>
</body>
</html>
