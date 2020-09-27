<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AddQuestion.aspx.cs" Inherits="NucleusExams.AddQuestion" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="assets/js/sweetalert-dev.js"></script>
    <link href="Content/popup.css" rel="stylesheet" />
    <script>
        var IsRights = false;
        function GetQuestionType(id) {
            var x = document.getElementById("tblOptions");
            var y = document.getElementById("tblUpdateOptions");
            if (id == "DropDown" || id == "CheckBox" || id == "RadioButton") {

                if (document.getElementById("hfQuestionID").value == "0") {
                    x.style.display = "block";
                }
                else {
                    y.style.display = "block";
                }

            }
            else {
                x.style.display = "none";
                y.style.display = "none";
            }
        }

        function hideAddQuestion() {
            var div = document.getElementById("divAddQuestion");
            div.style.display = "none";
        }
        function ClearValue() {
            debugger;
            document.getElementById('btnSaveQuestion').value = "SAVE";
            $telerik.findEditor("txtQuestion").set_html("")
            document.getElementById("txtQuestionMarks").value = "1";
            $("#ddlQuestionType").val("Select Type");
            var d = document.getElementById("tblOptions");
            if (window.getComputedStyle(d).display !== "none") {
                $("#tblOptions TBODY").empty();
                d.style.display = "none";
            }

            var x = document.getElementById("tblUpdateOptions");
            if (window.getComputedStyle(x).display !== "none") {
                $("#tblUpdateOptions TBODY").empty();
                x.style.display = "none";
            }



            //document.getElementById("btnSaveQuestion").style.visibility = "visible";
            //document.getElementById("btnUpdateQuestion").style.visibility = "hidden";


            document.getElementById("hfQuestionID").value = 0;

            <%--            var masterTable = $find("<%# gvQuestion.ClientID%>").get_masterTableView();
            masterTable.rebind();--%>
            document.getElementById('<%=btnUpdateQuestion.ClientID %>').click();



        }

        function chkval() {

            CheckRights(document.getElementById('hfExamID').value);
            if (IsRights) {
                var errmsg = "";
                var IsError = true;
                if ($telerik.findEditor("txtQuestion").get_html() == "") {
                    errmsg = errmsg + "Please enter question. \n";
                    IsError = false;
                }
                if (document.getElementById("txtQuestionMarks").value == "") {
                    errmsg = errmsg + "Please enter question marks. \n";
                    IsError = false;
                }
                if (document.getElementById("ddlQuestionType").selectedOptions[0].innerHTML == "Select Type") {
                    errmsg = errmsg + "Please select question type. \n";
                    IsError = false;
                }

                if (IsError) {
                    return IsError;
                }
                else {

                    swal({
                        title: "Asterisk(*) fields are mandatory",
                        text: errmsg,
                        type: "error"
                    });
                    //alert(errmsg);
                    return false;
                }
            }
            else {
                errorAccess();
                return false;
            }
        }

        function CheckRights(ExamID) {
            debugger;

            $.ajax({
                url: "/api/Exam/CheckEditRightsOnExambyExamIDStaffID",
                type: "GET",
                contentType: "application/json;charset=utf-8",
                data: { "ExamID": ExamID, "CreatedBy": $("#hfloggedInStaffID").val() },
                dataType: "json",
                async: false,

                success: function (r) {
                    if (r) {
                        debugger;
                        console.log(r)
                        //return true;
                        IsRights = true;
                    }

                    //}
                    //else {
                    //    return false;
                    //}

                },
                error: function (x, e) {
                    console.log(x.responseText);

                    //alert("Something went wrong!");
                }
            });

        }


        function SaveQuestion() {
            debugger;

            var Que = {};
            Que.StaffID = document.getElementById('hfloggedInStaffID').value;
            Que.ExamID = document.getElementById('hfExamID').value;
            Que.QuestionType = document.getElementById("ddlQuestionType").selectedOptions[0].innerHTML;
            Que.QuestionMarks = document.getElementById("txtQuestionMarks").value;
            Que.Question = $telerik.findEditor("txtQuestion").get_html();
            $.ajax({
                url: "<%#Page.ResolveUrl("/api/Question/InsertQuestion")%>",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(Que),
                dataType: "json",
                success: function (response) {
                    if (response > 0) {
                        swal({
                            title: "Success",
                            text: "Question is Saved.",
                            type: "success"
                        });

                        //alert("Question is Saved..." + response);
                        var d = document.getElementById("tblOptions");
                        if (window.getComputedStyle(d).display !== "none") {
                            debugger;
                            saveOption(response);

                        }
                        ClearValue();

                    } else {

                        swal({
                            title: "error",
                            text: "Something went wrong!",
                            type: "error"
                        });
                        //alert("Question is not Save ...!\n Something went wrong!");
                    }
                },

                error: function (x, e) {
                    console.log(x.responseText);
                    swal({
                        title: "error",
                        text: "Something went wrong!",
                        type: "error"
                    });
                    //alert("Question is not Save ...!\n Something went wrong!");
                }
            });

        }

        function UpdateQuestion() {
            //   debugger;
            var Que = {};
            Que.QuestionID = document.getElementById('<%# hfQuestionID.ClientID%>').value;
            Que.StaffID = document.getElementById('hfloggedInStaffID').value;
            Que.ExamID = document.getElementById('hfExamID').value;
            Que.QuestionType = document.getElementById("ddlQuestionType").selectedOptions[0].innerHTML;
            Que.QuestionMarks = document.getElementById("txtQuestionMarks").value;
            Que.Question = $telerik.findEditor("txtQuestion").get_html();
            $.ajax({
                url: "<%#Page.ResolveUrl("/api/Question/UpdateQuestion")%>",
                type: "POST",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(Que),
                dataType: "json",
                success: function (response) {
                    if (response > 0) {
                        swal({
                            title: "Success",
                            text: "Question is Updated.",
                            type: "success"
                        });
                        //alert("Question is Updated..." + response);
                        ClearValue();

                    } else {
                        //alert("Question is not Updated ...!\n Something went wrong!");
                        swal({
                            title: "error",
                            text: "Something went wrong!",
                            type: "error"
                        });
                    }
                },
                error: function (x, e) {
                    console.log(x.responseText);
                    //alert("Question is not Save ...!\n Something went wrong!");
                    swal({
                        title: "error",
                        text: "Something went wrong!",
                        type: "error"
                    });
                }
            });
        }

        function AddQuestion() {
            if (chkval()) {
                var qID = document.getElementById("hfQuestionID").value;
                if (qID == 0) {
                    SaveQuestion();
                }
                else {
                    UpdateQuestion();
                }
                return false;
            }
            else {
                return false;
            }
        }

        function DeleteQuestion() {
            debugger;
            var result = confirm('Are you sure you want to delete ?');
            if (!result) {
                return false;
            }
            return true;

        }

        function EditValues(id, value, IsAnswer) {
            document.getElementById("hfOptionID").value = id;
            document.getElementById("txtFooterOption").value = value;
            document.getElementById("txtFooterIsAnswer").checked = IsAnswer;
            document.getElementById('btnFooterAdd').value = "Update";
            return false;
        }


        function DeleteValues(id) {
            debugger;
            var result = confirm('Are you sure you want to delete ?');
            if (result) {
                var Option = {};
                Option.OptionID = id;
                $.ajax({
                    url: "<%#Page.ResolveUrl("/api/Question/DeleteOption")%>",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(Option),
                    dataType: "json",
                    success: function (r) {
                        if (r > 0) {
                            swal({
                                title: "Success",
                                text: "" + r + " record(s) deleted.",
                                type: "success"
                            });
                            //alert(r + " record(s) deleted.");
                        }
                        else {
                            //alert("Delete is not complete ...!\n Something went wrong!");
                            swal({
                                title: "error",
                                text: "Something went wrong!",
                                type: "error"
                            });
                        }
                        bindOptionValues();
                        ClearFooter();

                    },
                    error: function (x, e) {
                        console.log(x.responseText);
                        //alert("Delete is not complete ...!\n Something went wrong!");
                        swal({
                            title: "error",
                            text: "Something went wrong!",
                            type: "error"
                        });
                    }
                });

            }
        }


        function bindOptionValues() {
            var tblSave = document.getElementById("tblOptions");
            var tblUpdate = document.getElementById("tblUpdateOptions");
            tblSave.style.display = "none";
            tblUpdate.style.display = "block";

            $("#tblUpdateOptions TBODY").empty();

            debugger;
            $.ajax({
                url: "<%#Page.ResolveUrl("/api/Question/GetOptionValuesByQuestionID")%>",
                type: "GET",
                contentType: "application/json;charset=utf-8",
                data: { "QuestionID": document.getElementById("hfQuestionID").value },
                dataType: "json",
                success: function (response) {

                    var JsonArray = JSON.parse(response);

                    var content = "";

                    $(JsonArray).each(function (i, data) {
                        content += "<tr><td style='display: none'>" + data.OptionID + "</td>";
                        content += "<td>" + data.OptionValue + "</td>";
                        content += "<td>" + data.IsRightAnswer + "</td>";
                        content += "<td><input type='button' id='btn" + i + "' onclick='EditValues(\"" + data.OptionID + "\",\"" + data.OptionValue + "\"," + data.IsRightAnswer + ");' value='Edit' /></td>";
                        content += "<td><input type='button' id='btn" + i + "' onclick='DeleteValues(\"" + data.OptionID + "\")' value='Delete' /></td>";
                        //content += "<td><input type='button' id='btn" + i + "' onclick='AddOutPut(\"" + OC + "\",\"" + ColName + "\",\"" + 'chk' + custID + "\", " + custID + ")' /></td>";
                        content += "</tr>"
                    });

                    $('#tblUpdateOptions TBODY').append(content);
                },

                error: function (x, e) {
                    console.log(x.responseText);
                    swal({
                        title: "error",
                        text: "Option Values not found...!\n Something went wrong!",
                        type: "error"
                    });
                    //alert("Option Values not found...!\n Something went wrong!");
                }
            });

        }

        function errorAccess() {
            swal({
                title: "error",
                text: "You don't have edit rights.",
                type: "error"
            });
        }
        function SetTarget() {
            document.forms[0].target = "_blank";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSaveQuestion">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gvQuestion">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div class="row">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="row" id="divAll" runat="server">
        <asp:HiddenField ID="hfloggedInStaffID" ClientIDMode="Static" runat="server" Value="0" />
        <asp:HiddenField ID="hfExamID" ClientIDMode="Static" runat="server" Value="0" />
        <asp:HiddenField ID="hfQuestionID" ClientIDMode="Static" runat="server" Value="0" />
        <asp:HiddenField ID="hfOptionID" ClientIDMode="Static" runat="server" Value="0" />
        <div class="col-lg-12">
            <div class="card-box">
                <h4 class="card-title">Exam Details</h4>
                <div class="row">
                    <label class="col-md-1"><b>Exam Name</b></label>
                    <div class="col-md-1">
                        <asp:Label ID="lblExamName" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>
                    <label class="col-md-1"><b>Grade</b></label>
                    <div class="col-md-1">
                        <asp:Label ID="lblGrade" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>
                    <label class="col-md-1"><b>Exam Date</b></label>
                    <div class="col-md-1">
                        <asp:Label ID="lblExamDate" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>
                    <label class="col-md-1"><b>Exam Duration</b></label>
                    <div class="col-md-1">
                        <asp:Label ID="lblExamDuration" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>
                    <label class="col-md-1"><b>Exam Code</b></label>
                    <div class="col-md-1">
                        <asp:Label ID="lblExamCode" runat="server" ClientIDMode="Static"></asp:Label>
                    </div>
                    <div class="col-md-1">
                        <asp:Button ID="btnExamPreview" Text="Exam Preview" runat="server" OnClick="btnExamPreview_Click" OnClientClick="SetTarget();" />
                    </div>
                </div>
            </div>
            <div class="card-box" id="divAddQuestion">
                <h4 class="card-title">Add Question</h4>
                <div class="row">
                    <div class="col-md-7">
                        <b>Question *</b>
                        <telerik:RadEditor RenderMode="Lightweight" Skin="MetroTouch" Style="margin-top: 7px;" Height="300px" DialogHandlerUrl="~/Telerik.Web.UI.DialogHandler.axd"
                            TableLayoutCssFile="~/content/css/RadTables.css" NewLineBr="false" ContentAreaCssFile="~/content/css/RadEditor.css?V-2" EditModes="Design" EmptyMessage="Enter your question here..."
                            Width="100%" runat="server" ID="txtQuestion" ClientIDMode="Static">
                            <ImageManager ViewMode="Thumbnails" ViewPaths="~/Images" UploadPaths="~/Images" SearchPatterns="*.gif,*.jpg,*.jpeg,*.png,*.bmp" />
                            <Tools>
                                <telerik:EditorToolGroup Tag="Formatting">
                                    <telerik:EditorTool Name="Bold" />
                                    <telerik:EditorTool Name="Italic" />
                                    <telerik:EditorTool Name="Underline" />
                                    <telerik:EditorSeparator />

                                    <telerik:EditorTool Name="InsertOrderedList" />
                                    <telerik:EditorTool Name="InsertUnorderedList" />
                                    <telerik:EditorSeparator />
                                    <telerik:EditorSplitButton Name="ForeColor">
                                    </telerik:EditorSplitButton>
                                    <telerik:EditorSplitButton Name="BackColor">
                                    </telerik:EditorSplitButton>
                                    <telerik:EditorSeparator />
                                    <telerik:EditorDropDown Name="FontName">
                                    </telerik:EditorDropDown>
                                    <telerik:EditorDropDown Name="RealFontSize">
                                    </telerik:EditorDropDown>
                                </telerik:EditorToolGroup>
                                <telerik:EditorToolGroup Tag="Alignment">
                                    <telerik:EditorTool Name="JustifyLeft" />
                                    <telerik:EditorSeparator />
                                    <telerik:EditorTool Name="JustifyCenter" />
                                    <telerik:EditorSeparator />
                                    <telerik:EditorTool Name="JustifyRight" />
                                    <telerik:EditorSeparator />
                                    <telerik:EditorTool Name="JustifyFull" />
                                    <telerik:EditorSeparator />
                                    <telerik:EditorTool Name="InsertHorizontalRule" />
                                </telerik:EditorToolGroup>
                                <telerik:EditorToolGroup Tag="ImageManager">
                                    <telerik:EditorTool Enabled="true" Name="ImageManager" />
                                    <telerik:EditorTool Enabled="true" Name="InsertLink" />
                                </telerik:EditorToolGroup>
                                <telerik:EditorToolGroup Tag="YouTube">
                                    <telerik:EditorTool Name="InsertExternalVideo" ImageUrl="~/Images/YouTube.png" Text="Youtube Video"></telerik:EditorTool>
                                </telerik:EditorToolGroup>
                            </Tools>
                            <Content>
                            </Content>
                            <TrackChangesSettings CanAcceptTrackChanges="False" />
                        </telerik:RadEditor>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group row">
                            <div class="col-md-3">
                                <label class="col-form-label"><b>Question Marks *</b></label>
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox runat="server" ID="txtQuestionMarks" CssClass="form-control" Text="1" ClientIDMode="Static">                                  
                                </asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <label class="col-form-label"><b>Question Type *</b></label>
                            </div>
                            <div class="col-md-3">
                                <asp:DropDownList ID="ddlQuestionType" runat="server" ClientIDMode="Static" CssClass="form-control" onchange="GetQuestionType(this.options[this.selectedIndex].value);">
                                    <asp:ListItem>Select Type</asp:ListItem>
                                    <asp:ListItem>TextBox</asp:ListItem>
                                    <asp:ListItem>MediumTextBox</asp:ListItem>
                                    <asp:ListItem>Editor</asp:ListItem>
                                    <asp:ListItem>DropDown</asp:ListItem>
                                    <asp:ListItem>CheckBox</asp:ListItem>
                                    <asp:ListItem>RadioButton</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group row" id="divOption">
                            <div class="col-md-12">
                                <table id="tblOptions" style="display: none" class="table table-border text-center" cellpadding="0" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 150px">Option Value</th>
                                            <th style="width: 150px">IsAnswer ?</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td>
                                                <input type="text" id="txtOption" /></td>
                                            <td class="text-center">
                                                <input type="checkbox" id="txtIsAnswer" /></td>
                                            <td class="text-left">
                                                <input type="button" id="btnAdd" value="Add" /></td>
                                        </tr>
                                    </tfoot>
                                </table>
                                <table id="tblUpdateOptions" class="table table-border text-center" style="display: none">
                                    <thead>
                                        <tr>
                                            <th style="display: none">OptionID</th>
                                            <th style="width: 150px">Option Value</th>
                                            <th style="width: 150px">IsAnswer ?</th>
                                            <th>Edit</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td>
                                                <input type="text" id="txtFooterOption" /></td>
                                            <td class="text-center">
                                                <input type="checkbox" id="txtFooterIsAnswer" /></td>
                                            <td class="text-left">
                                                <input type="button" id="btnFooterAdd" value="Add" onclick="return SaveUpdateOption();" /></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <br />
                <div class="row">
                    <div class="col-md-6 text-right">
                        <asp:Button ID="btnSaveQuestion" runat="server" ClientIDMode="Static" Text="SAVE" CssClass="btn btn-primary" OnClientClick="return AddQuestion();" />
                        <asp:Button ID="btnUpdateQuestion" runat="server" ClientIDMode="Static" Text="UPDATE" CssClass="btn btn-primary" Style="display: none" OnClick="btnUpdateQuestion_Click" />
                    </div>
                    <div class="col-md-6 text-left">
                        <asp:Button ID="btnCancelQuestion" runat="server" Text="CANCEL" OnClientClick="return ClearAll();" ClientIDMode="Static" CssClass="btn btn-danger" />
                    </div>
                </div>
            </div>
            <div class="card-box">
                <h4 class="card-title">Question Details</h4>
                <div class="row">
                    <div class="col-md-12">
                        <telerik:RadGrid ID="gvQuestion" RenderMode="Lightweight" runat="server" DataSourceID="dsrcQuestion" AllowMultiRowSelection="True" Skin="Bootstrap" Width="100%"
                            PageSize="10" AllowPaging="true" PagerStyle-Position="Top" PagerStyle-AlwaysVisible="true"
                            DataKeyNames="ExamID" AllowAutomaticDeletes="true" OnItemCommand="gvExamMaster_ItemCommand">
                            <GroupingSettings CaseSensitive="false"></GroupingSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ExamID" ShowHeader="True" DataSourceID="dsrcQuestion">
                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="Sr No" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Question" HeaderStyle-Width="50%">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblGradeName" runat="server" Text='<%# Eval("Question") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Type" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblExamName" runat="server" Text='<%# Eval("QuestionType") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Marks" HeaderStyle-Width="3%">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblQuestionMarks" runat="server" Text='<%# Eval("QuestionMarks") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Options" HeaderStyle-Width="27%">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblDuration" runat="server" Text='<%# Eval("Options") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Edit" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditQuestion" CommandArgument='<%# Eval("QuestionID") %>' />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="5%">
                                        <ItemTemplate>
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:if(!confirm('This action will delete the selected customer. Are you sure?')){return false;}"
                                                CommandName="DeleteQuestion" CommandArgument='<%# Eval("QuestionID") %>' />

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                </Columns>
                            </MasterTableView>

                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsrcQuestion" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                            SelectCommand="select ROW_NUMBER() over (order by QM.QuestionID) as SrNo,QuestionID,ExamID,QuestionType,QuestionMarks,Question,
                            STUFF((SELECT N', '+ CAST([OptionValue] AS VARCHAR(255)) FROM EA_OptionMaster OM 
                            WHERE OM.QuestionID = QM.QuestionID FOR XML PATH ('')), 1, 2, '') AS Options from 
                            EA_QuestionMaster QM where QM.ExamID=@hdnExamIDGrid">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hfExamID" Name="hdnExamIDGrid" PropertyName="value" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                </div>
            </div>

        </div>

    </div>
    <script type="text/javascript">
        function saveOption(QuestionId) {
            var options = new Array();
            var d = new Date();

            $("#tblOptions TBODY TR").each(function () {
                var row = $(this);
                var option = {};
                option.ExamID = document.getElementById('hfExamID').value;
                option.OptionValue = row.find("TD").eq(0).html();
                option.IsRightAnswer = row.find("TD").eq(1).html();
                option.EntryBy = document.getElementById('hfloggedInStaffID').value;
                option.QuestionID = QuestionId;
                option.EntryDate = d.toLocaleDateString();
                options.push(option);
            });

            //Send the JSON array to Controller using AJAX.
            $.ajax({
                type: "POST",
                url: "/api/Question/InsertOptions",
                data: JSON.stringify(options),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    if (r > 0) {
                        //swal({
                        //    title: "Success",
                        //    text: "" + r + " record(s) inserted.",
                        //    type: "success"
                        //});
                        console.log(r + "records of option values inserted.")
                        //alert(r + " record(s) inserted.");
                    }
                    else {

                        swal({
                            title: "error",
                            text: "Option Values not inserted...!\n Something went wrong!",
                            type: "error"
                        });
                        //alert("Option Values not inserted...!\n Something went wrong!");
                    }

                },
                error: function (x, e) {
                    console.log(x.responseText);
                    //alert("Option Values not inserted...!\n Something went wrong!");
                    swal({
                        title: "error",
                        text: "Option Values not inserted...!\n Something went wrong!",
                        type: "error"
                    });
                }
            });
        }

        $("body").on("click", "#btnAdd", function () {
            //Reference the Name and Country TextBoxes.
            var txtOption = $("#txtOption");
            var txtIsAnswer = $("#txtIsAnswer");

            if (txtOption.val() != "") {


                //Get the reference of the Table's TBODY element.
                var tBody = $("#tblOptions > TBODY")[0];

                //Add Row.
                var row = tBody.insertRow(-1);

                //Add Name cell.
                var cell = $(row.insertCell(-1));
                cell.html(txtOption.val());

                //Add Country cell.
                cell = $(row.insertCell(-1));

                var IsAnswer = document.getElementById("txtIsAnswer").checked;
                //alert(IsAnswer);
                cell.html(IsAnswer.toString());

                //Add Button cell.
                cell = $(row.insertCell(-1));
                var btnRemove = $("<input />");
                btnRemove.attr("type", "button");
                btnRemove.attr("onclick", "Remove(this);");
                btnRemove.val("Remove");
                cell.append(btnRemove);

                //Clear the TextBoxes.
                txtOption.val("");
                //txtIsAnswer.val("");
                document.getElementById("txtIsAnswer").checked = false;
            }
            else {
                swal({
                    title: "Alert",
                    text: "Please enter option value.",
                    type: "error"
                });
                //alert('Please enter option value.');
            }
        });

        function Remove(button) {
            //Determine the reference of the Row using the Button.
            var row = $(button).closest("TR");
            var name = $("TD", row).eq(0).html();
            if (confirm("Do you want to delete: " + name)) {
                //Get the reference of the Table.
                var table = $("#tblOptions")[0];

                //Delete the Table row using it's Index.
                table.deleteRow(row[0].rowIndex);
            }
        };


        //function DeleteQuestion(id) {
        //    alert(id);
        //}


        function SaveUpdateOption() {

            if (document.getElementById("txtFooterOption").value != "") {

                //   debugger;
                var options = new Array();
                var d = new Date();
                var Option = {};
                Option.OptionID = document.getElementById('hfOptionID').value;
                Option.ExamID = document.getElementById('hfExamID').value;
                Option.OptionValue = document.getElementById("txtFooterOption").value;
                Option.IsRightAnswer = document.getElementById("txtFooterIsAnswer").checked;
                Option.EntryBy = document.getElementById('hfloggedInStaffID').value;
                Option.QuestionID = document.getElementById('hfQuestionID').value;
                Option.EntryDate = d.toLocaleDateString();
                options.push(Option);

                //  debugger;
                if (document.getElementById('hfOptionID').value != 0) {
                    $.ajax({
                        type: "POST",
                        url: "/api/Question/UpdateOption",
                        data: JSON.stringify(Option),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            bindOptionValues();
                            ClearFooter();
                            swal({
                                title: "Success",
                                text: "" + r + " record(s) updated.",
                                type: "success"
                            });
                            //alert(r + " record(s) updated.");

                        },
                        error: function (x, e) {

                            swal({
                                title: "error",
                                text: "Something went wrong!",
                                type: "error"
                            });
                            //alert('Update value is failed...\n Try Again.');
                            console.log(x.responseText);
                        }
                    });
                }
                else {
                    $.ajax({

                        type: "POST",
                        url: "/api/Question/InsertOptions",
                        data: JSON.stringify(options),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            //    debugger;

                            bindOptionValues();
                            ClearFooter();
                            swal({
                                title: "Success",
                                text: "" + r + " record(s) inserted.",
                                type: "success"
                            });
                            //alert(r + " record(s) inserted.");
                        },
                        error: function (x, e) {
                            swal({
                                title: "error",
                                text: "Something went wrong!",
                                type: "error"
                            });
                            //alert('Value insert is failed...\n Try Again.');
                            console.log(x.responseText);
                        }

                    });
                }
            }
            else {
                swal({
                    title: "error",
                    text: "Please enter option value.",
                    type: "error"
                });
                //alert("Please enter option value.");
            }

        }


        function ClearFooter() {

            document.getElementById("hfOptionID").value = "0";
            document.getElementById("txtFooterOption").value = "";
            document.getElementById("txtFooterIsAnswer").checked = false;
            document.getElementById("btnFooterAdd").value = "Save";
        }


        function ClearAll() {
            ClearFooter();
            $telerik.findEditor("txtQuestion").set_html("")
            document.getElementById("txtQuestionMarks").value = "1";
            document.getElementById("hfQuestionID").value = 0;
            $("#ddlQuestionType").val("Select Type");
            var x = document.getElementById("tblOptions");
            x.style.display = "none";
            var y = document.getElementById("tblUpdateOptions");
            y.style.display = "none";
            document.getElementById('btnSaveQuestion').value = "SAVE";
            return false;
        }

        function DeleteMsg() {
            swal({
                title: "Success",
                text: "delete successfully.",
                type: "success"
            });
            //alert('delete successfully.');
        }

        function ErrorMsg() {
            swal({
                title: "error",
                text: "Something went wrong.",
                type: "error"
            });
            //alert('Something went wrong');
        }
    </script>
</asp:Content>
