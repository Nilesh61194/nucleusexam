<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="NucleusExams.Home" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--<link href="Content/responsive.css" rel="stylesheet" />--%>
    <link href="Content/popup.css" rel="stylesheet" />
    <script src="assets/js/sweetalert-dev.js"></script>
    <script>
        var captcha;
        function generateCaptcha(flag) {
            if (flag == true) {

                captcha = Math.floor(Math.random() * 90000000) + 10000000;

                document.getElementById("txtExamCode").value = captcha;
            }
            else {
                document.getElementById("txtExamCode").value = '';
            }
        }

        function Generate() {
            if (document.getElementById('chkCode').checked) {
                generateCaptcha(true);
            } else {
                generateCaptcha(false);
            }
        }

        function ChkVal() {

            var Iserror = false;
            var cnt = "";
            var ErrorMsg = "";
            debugger;
            if ($('#ddlGrade').val() == "Select Grade") {
                ErrorMsg = ErrorMsg + "Grade is Required"
            }
            if ($('#txtExamName').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Exam Name is Required"
            }

            if ($('#txtExamURL').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Exam URL is Required"
            }

            if ($('#txtSubjectName').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Subject Name is Required"
            }
            if ($('#txtExamDuration').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Exam Duration is Required"
            }
            if ($('#txtExamDate').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Exam Date is Required"
            }
            if ($('#txtExamURL').val().toString().trim() == "") {
                ErrorMsg = ErrorMsg + "\n Exam URL is Required"
            }

            return ErrorMsg;
        }

        function updateval() {

            var errormsg = ChkVal();
            if (errormsg != "") {
                swal(errormsg);
                return false;
            }
            else {
                return true;
            }
        }

        function AddExam() {

            var errormsg = ChkVal();
            if (errormsg == "") {
                debugger;

                var Exm = {};
                Exm.ExamName = $("#txtExamName").val();
                Exm.GradeID = $('#ddlGrade').val();
                Exm.SubjectName = $("#txtSubjectName").val();
                Exm.Duration = $("#txtExamDuration").val();
                Exm.CreatedBy = $("#hfloggedInStaffID").val();
                Exm.ISExamCode = $("#chkCode").prop("checked");
                Exm.ExamCode = $("#txtExamCode").val();
                Exm.ExamDate = $("#txtExamDate").val();
                Exm.ExamURL = $("#txtExamURL").val();

                $.ajax({
                    url: "<%=Page.ResolveUrl("/api/Exam/insertExamMaster")%>",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(Exm),
                    dataType: "json",
                    success: function (response) {
                        if (response) {
                            Clear();
                            SaveSuccess();
                        }
                        else {
                            swal("Error", "Exam is not Save ...!", "error");
                        }
                    },

                    error: function (x, e) {
                        swal('Failed');
                        swal(x.responseText);
                        swal(x.status);

                    }
                });
            }
            else {
                swal("", errormsg, "error");
            }


        }


        function UpdateExam() {

            var errormsg = ChkVal();
            if (errormsg == "") {
                debugger;

                var Exm = {};
                Exm.ExamID = $("#hfExamID").val();
                Exm.ExamName = $("#txtExamName").val();
                Exm.GradeID = $('#ddlGrade').val();
                Exm.SubjectName = $("#txtSubjectName").val();
                Exm.Duration = $("#txtExamDuration").val();
                Exm.CreatedBy = $("#hfloggedInStaffID").val();
                Exm.ISExamCode = $("#chkCode").prop("checked");
                Exm.ExamCode = $("#txtExamCode").val();
                Exm.ExamDate = $("#txtExamDate").val();
                Exm.ExamURL = $("#txtExamURL").val();

                $.ajax({
                    url: "<%=Page.ResolveUrl("/api/Exam/updateExamMaster")%>",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(Exm),
                    dataType: "json",
                    success: function (response) {
                        debugger;
                        if (response) {
                            Clear();
                            $("#btnCreate").hide();
                            $("#btnUpdate").show();
                            UpdateSuccess();

                        }
                        else {
                            swal("Error", "Exam is not update ...!", "error");
                        }
                    },

                    error: function (x, e) {
                        swal('Failed');
                        swal(x.responseText);
                        swal(x.status);

                    }
                });
            }
            else {
                swal("", errormsg, "error");
            }


        }



        function SaveSuccess() {
            setTimeout(function () {
                swal({
                    title: "Success",
                    text: "Exam saved successfully",
                    type: "success"
                }, function () {
                    window.location.reload();
                });
            }, 1000);
        }


        function UpdateSuccess() {
            Clear();
            swal({
                title: "Success",
                text: "Exam Update successfully",
                type: "success"
            });
        }


        function DeleteSuccess() {
            swal({
                title: "Success",
                text: "Exam deleted successfully",
                type: "success"
            });
        }

        function confirmActive() {
            if (confirm("Are you sure you want to do this?") == true)
                return true;
            else
                return false;
        }

        function Clear() {
            $("#txtExamName").val("");
            $('#ddlGrade').val("Select Grade");
            $("#txtSubjectName").val("");
            $("#txtExamDuration").val("");
            $("#hfloggedInStaffID").val("");
            $("#hfExamID").val("");
            $("#chkCode").prop('checked', false);
            $("#txtExamCode").val("");
            $("#txtExamDate").val("");
            $("#txtExamURL").val("");
            var btnUpdate = document.getElementById("btnUpdate");
            btnUpdate.style.display = 'none';
            var btnCreate = document.getElementById("btnCreate");
            btnCreate.style.display = 'block';
        }



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="row">
        <asp:HiddenField ID="hfloggedInStaffID" ClientIDMode="Static" runat="server" Value="720" />
        <asp:HiddenField ID="hfExamID" ClientIDMode="Static" runat="server" Value="720" />
        <div class="col-lg-12">
            <div class="card-box">
                <h4 class="card-title">Create Exam</h4>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Grade</label>
                    <div class="col-md-5">
                        <asp:DropDownList ID="ddlGrade" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Exam Name </label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" clientidmode="Static" runat="server" id="txtExamName">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Subject Name</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" runat="server" id="txtSubjectName" clientidmode="Static">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Link</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" runat="server" id="txtExamURL" clientidmode="Static">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Exam Date</label>
                    <div class="col-md-5">
                        <input type="date" class="form-control" runat="server" id="txtExamDate" clientidmode="Static" />
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Exam Duration</label>
                    <div class="col-md-5">
                        <input type="number" runat="server" class="form-control" id="txtExamDuration" clientidmode="Static" />
                    </div>
                </div>


                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Exam Code</label>
                    <div class="col-md-4">
                        <input type="number" runat="server" class="form-control" id="txtExamCode" clientidmode="Static" />
                    </div>
                    <div class="col-md-4">
                        <input type="checkbox" style="height: 40px; width: 60px;" runat="server" onclick="Generate();" name="checkbox" id="chkCode" clientidmode="Static">
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-3 text-center">
                        <input type="button" class="form-control" id="btnCreate" runat="server" clientidmode="Static" value="Save" onclick="AddExam();" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="form-control" Text="Update" Style="display: none;" ClientIDMode="Static"
                            OnClick="btnUpdate_Click" OnClientClick="return updateval();" />
                        <%--<input type="button" class="form-control" id="btnUpdate" runat="server" value="Save" onclick="UpdateExam();" />--%>
                    </div>
                    <div class="col-md-3 text-center">
                        <input type="button" class="form-control" clientidmode="Static" id="Button1" runat="server" value="Clear" onclick="Clear();" />
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-12">
                        <%-- <asp:UpdatePanel ID="upnGrid" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>--%>

                        <telerik:RadGrid ID="gvExamMaster" RenderMode="Lightweight" runat="server" DataSourceID="dsrcExamMaster" AllowMultiRowSelection="True" Skin="Bootstrap" Width="100%"
                            PageSize="10" AllowPaging="true" PagerStyle-Position="Top" PagerStyle-AlwaysVisible="true"
                            DataKeyNames="ExamID" AllowAutomaticDeletes="true" OnItemDataBound="gvExamMaster_ItemDataBound" OnDeleteCommand="gvExamMaster_DeleteCommand"
                            OnItemCommand="gvExamMaster_ItemCommand">
                            <GroupingSettings CaseSensitive="false"></GroupingSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ExamID" ShowHeader="True" DataSourceID="dsrcExamMaster">
                                <Columns>

                                    <telerik:GridTemplateColumn HeaderText="Grade Name" HeaderStyle-Width="140px">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblGradeName" runat="server" Text='<%# Eval("GradeName") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Exam Name" HeaderStyle-Width="200px">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblExamName" runat="server" Text='<%# Eval("ExamName") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Subject Name" HeaderStyle-Width="140px">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblSubjectName" runat="server" Text='<%# Eval("SubjectName") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Duration" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Exam Code" HeaderStyle-Width="120px">

                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblExamCode" runat="server" Text='<%# Eval("ExamCode") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Exam Date" HeaderStyle-Width="120px">

                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblExamDate" runat="server" Text='<%# Eval("ExamDate", "{0:dd MMM yyyy}") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Link" HeaderStyle-Width="300px">
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblExamURL" runat="server" Text='<%# Eval("ExamURL") %>'></telerik:RadLabel>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="Edit Exam" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <telerik:RadButton ID="btnEdit" Text="Edit" CommandName="EditExam" ToolTip="Edit" runat="server" CommandArgument='<%# Eval("ExamID") %>'></telerik:RadButton>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridButtonColumn HeaderText="Delete Exam" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderStyle-Width="110px"></telerik:GridButtonColumn>
                                    <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Button ID="btnExamStatus" runat="server" Text='<%# Eval("ISActive").Equals(true) ? "Active" : "Inactive" %>' CommandArgument='<%# Eval("ExamID") %>'
                                                CommandName="ExamActive" OnClientClick="return confirmActive();" />
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings AllowKeyboardNavigation="true">
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true"
                                    FrozenColumnsCount="5" />
                            </ClientSettings>
                        </telerik:RadGrid>

                        <asp:SqlDataSource ID="dsrcExamMaster" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                            SelectCommand="select ExamID,ExamName,g.GradeID,GradeName,AcademicYearID,SubjectName,Duration,CreatedBy,ISExamCode,ExamCode,ExamDate,ExamURL,ISActive,CreateDate from EA_ExamMaster em	inner join Grade g on g.GradeID= em.GradeID"></asp:SqlDataSource>
                        <%-- </ContentTemplate>
                            <Triggers>
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </div>
                </div>


            </div>
        </div>



        <div id="ExamEnableDisableModalPopup" clientidmode="Static" runat="server" style="margin-top: 10%" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Exam Enable - Disable  </h4>
                            </div>
                            <div class="modal-body" style="padding-bottom: 0px">

                                <div class="alert" id="Div2" visible="false" runat="server" style="background-color: #f2dede; margin-left: 10px; margin-right: 10px">
                                    <strong>Oh Snap!</strong>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <br />
                                    You forgot to select teacher
                                </div>
                                <asp:HiddenField ID="hdnExamID" runat="server" />
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <td>Select Studnet:
                                            </td>
                                            <td>
                                                <telerik:RadComboBox Filter="Contains" Width="100%" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" CheckBoxes="true" EmptyMessage="Select Student" ID="ddlExamEnableForStudent" runat="server"></telerik:RadComboBox>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <asp:LinkButton ID="lnkExamEnableForStudent" OnClientClick="return confirm('Are you sure you want to enable ?');" CssClass="btn btn-sm btn-primary   pull-left" runat="server" Text="Enable"></asp:LinkButton>
                                <asp:LinkButton ID="lnkExamDisnableForStudent" OnClientClick="return confirm('Are you sure you want to disable ?');" CssClass="btn btn-sm btn-danger   pull-left" runat="server" Text="Disable Exam"></asp:LinkButton>
                                <asp:LinkButton ID="lnkExamFinishForStudent" OnClientClick="return confirm('Are you sure you want to finish ?');" CssClass="btn btn-sm btn-danger   pull-right" runat="server" Text="Finish Exam"></asp:LinkButton>
                                <%--<button type="button" class="btn btn-danger pull-right" data-dismiss="modal">Close</button>--%>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="lnkExamEnableForStudent" />
                            <asp:PostBackTrigger ControlID="lnkExamDisnableForStudent" />
                            <asp:PostBackTrigger ControlID="lnkExamFinishForStudent" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
