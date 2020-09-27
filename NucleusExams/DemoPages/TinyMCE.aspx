<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TinyMCE.aspx.cs" Inherits="NucleusExams.DemoPages.TinyMCE" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo</title>
    <%--    79rdofjlurmckrep0gucbt0f4vh4ph1whuuoc5f38sib9fb5--%>
    <script src="https://cdn.tiny.cloud/1/79rdofjlurmckrep0gucbt0f4vh4ph1whuuoc5f38sib9fb5/tinymce/5/tinymce.min.js"></script>
    <script>tinymce.init({ selector: 'textarea' });
        tinyMCE.init({
            elements: "elm1,elm2"
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <textarea>Next, use our Get Started docs to setup Tiny!</textarea>
        </div>
    </form>
</body>
</html>
