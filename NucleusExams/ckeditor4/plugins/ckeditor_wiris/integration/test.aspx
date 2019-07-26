<%@ Page Language="C#" AutoEventWireup="false" CodeFile="test.aspx.cs" Inherits="plugin_web.test" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo Wiris</title>
    <script src="../../../ckeditor.js"></script>
    <script src="WIRISplugins.js?viewer=image"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine"></asp:TextBox>
            <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=DescriptionTextBox.ClientID%>');</script>
        </div>
    </form>
</body>
</html>
