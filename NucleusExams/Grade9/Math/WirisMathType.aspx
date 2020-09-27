<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WirisMathType.aspx.cs" Inherits="NucleusExams.Grade9.Math.WirisMathType" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="../../Scripts/bootstrap.min-3.4.0.js"></script>
    <script src="../../ckeditor4/ckeditor.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <h3><b>Write equation for practise in below textbox</b></h3>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center">
                        <asp:TextBox ID="txtQuestion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                        <%--<button type="button" style="margin-top: 5px!important" onclick="return SaveEditorAns('txtQuestion1')" class="btn btn-primary">Save</button>--%>
                        <script type="text/javascript" lang="javascript">CKEDITOR.replace('<%=txtQuestion1.ClientID%>');</script>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
