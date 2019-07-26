<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignToStudent.aspx.cs" Inherits="NucleusExams.AssignToStudent" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/popup.css" rel="stylesheet" />
    <script src="assets/js/sweetalert-dev.js"></script>
    <script>
        function AssignSuccess() {
            Clear();
            swal({
                title: "Success",
                text: "Assign successfully",
                type: "success"
            });
        }

        function EnableExam() {
            Clear();
            swal({
                title: "Success",
                text: "Exam enable successfully",
                type: "success"
            });
        }


        function error() {
            Clear();
            swal({
                title: "error",
                text: "Something happen wrong ... try again",
                type: "error"
            });
        }

        function DisableExam() {
            Clear();
            swal({
                title: "Success",
                text: "Exam disable successfully",
                type: "success"
            });
        }

        function DeleteStudent() {
            Clear();
            swal({
                title: "Success",
                text: "Delete assign exam to student successfully",
                type: "success"
            });
        }

        function ChkExam() {
            if ($('#ddlExam').val() == "Select Exam" || $('#ddlExam').val() == null) {
                swal('Exam is Required');
                return false;
            }
        }

        function Clear() {
            debugger;
            $('#ddlAcademicYear').val("Select Academic Year");
            $('#ddlGrade').val("Select Grade");
            $('#ddlExam').val("Select Exam");

          <%--  var Student = $find('<%= ddlStudent.ClientID %>');
            Student.clearItems();
            
            var Section = $find('<%= ddlSection.ClientID %>');
            Section.clearItems();--%>
            //Section.set_emptyMessage("Select Section");

            //$('#ddlStudent').prop('selected', false);
            //$('#ddlSection').prop('selected', false);
            $('#hfExamID').val("");
            $('#grvShowAssignedStudentList').empty();
        }

        function ChkVal() {
            var Iserror = true;
            var ErrorMsg = "";

            debugger;
            if ($('#ddlAcademicYear').val() == "Select Academic Year") {
                ErrorMsg = ErrorMsg + "Academic Year is Required";
                Iserror = false;
            }

            if ($('#ddlGrade').val() == "Select Grade" || $('#ddlGrade').val() == null) {
                ErrorMsg = ErrorMsg + "\n Grade is Required";
                Iserror = false;
            }


            if ($('#ddlExam').val() == "Select Exam" || $('#ddlExam').val() == null) {
                ErrorMsg = ErrorMsg + "\n Exam is Required";
                Iserror = false;
            }

            if ($('#ddlSection').val() == "") {
                ErrorMsg = ErrorMsg + "\n Section is Required";
                Iserror = false;
            }

            if ($('#ddlStudent').val() == "") {
                ErrorMsg = ErrorMsg + "\n Student is Required";
                Iserror = false;
            }

            if (ErrorMsg != "") {
                swal(ErrorMsg);
                return false;
            }
            else {
                return true;
            }
        }
    </script>
    <telerik:RadAjaxManagerProxy runat="server" ID="RadAjaxManagerProxy1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="grvShowAssignedStudentList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlSection">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>



        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnShowStudent">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divAll" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="row" id="divAll" runat="server">

        <asp:HiddenField ID="hfloggedInStaffID" ClientIDMode="Static" runat="server" Value="720" />

        <div class="col-lg-12">
            <div class="card-box">
                <asp:UpdatePanel ID="upSetSession" runat="server">
                    <ContentTemplate>

                        <h4 class="card-title">Assign to student</h4>
                        <div class="form-group row">
                            <label class="col-form-label-sm col-md-1">Academic Year </label>
                            <div class="col-md-5">
                                <asp:DropDownList ID="ddlAcademicYear" runat="server" OnSelectedIndexChanged="ddlAcademicYear_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label-sm col-md-1">Grade </label>
                            <div class="col-md-5">
                                <asp:DropDownList ID="ddlGrade" runat="server" OnSelectedIndexChanged="ddlGrade_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label-sm col-md-1">Exam</label>
                            <div class="col-md-5">
                                <asp:DropDownList ID="ddlExam" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlExam_SelectedIndexChanged" ClientIDMode="Static"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label-sm col-md-1">Section</label>
                            <div class="col-md-5">
                                <telerik:RadComboBox Width="100%" Filter="Contains" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" CheckBoxes="true"
                                    EmptyMessage="Select Section" ID="ddlSection" ClientIDMode="Static" OnCheckAllCheck="ddlSection_CheckAllCheck" OnItemChecked="ddlSection_ItemChecked" runat="server">
                                </telerik:RadComboBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label-sm col-md-1">Student</label>
                            <div class="col-md-5">
                                <telerik:RadComboBox Width="100%" Filter="Contains" ClientIDMode="Static" EnableCheckAllItemsCheckBox="true" CheckBoxes="true"
                                    EmptyMessage="Select Student" ID="ddlStudent" runat="server">
                                </telerik:RadComboBox>
                            </div>
                        </div>

                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlAcademicYear" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="ddlGrade" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="ddlExam" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="ddlSection" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="form-group row">
                    <div class="col-md-2 text-center">
                        <asp:Button CssClass="form-control" ID="btnAssign" runat="server" OnClientClick="return ChkVal();" ClientIDMode="Static" Text="Assign Exam" OnClick="btnAssign_Click" />
                    </div>
                    <div class="col-md-2 text-center">
                        <asp:Button CssClass="form-control" ID="btnShowStudent" OnClick="btnShowStudent_Click" runat="server" OnClientClick="return ChkExam();" ClientIDMode="Static" Text="Show Student" />
                    </div>
                    <div class="col-md-2 text-center">
                        <input type="button" class="form-control" id="btnClear" onclick="return Clear();" runat="server" value="Clear" />
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-2 text-center">
                        <asp:Button CssClass="form-control" ID="btnEnableExam" runat="server" OnClientClick="return ChkVal();" ClientIDMode="Static" Text="Enable" OnClick="btnEnableExam_Click" />
                    </div>
                    <div class="col-md-2 text-center">
                        <asp:Button CssClass="form-control" ID="btnDisableExam" OnClick="btnDisableExam_Click" runat="server" OnClientClick="return ChkVal();" ClientIDMode="Static" Text="Disable" />
                    </div>
                    <div class="col-md-2 text-center">
                        <asp:Button CssClass="form-control" ID="btnDeleteAssign" OnClick="btnDeleteAssign_Click" runat="server" OnClientClick="return ChkVal();" ClientIDMode="Static" Text="Remove Assignment" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div>
        <asp:UpdatePanel ID="upnlShowStudentList" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:HiddenField ID="hfExamID" ClientIDMode="Static" runat="server" Value="720" />
                <telerik:RadGrid ID="grvShowAssignedStudentList" ClientIDMode="Static" RenderMode="Lightweight" runat="server" DataSourceID="dsrcExamMaster" Skin="Bootstrap" AllowFilteringByColumn="true" AllowSorting="true">
                    <MasterTableView TableLayout="Fixed">
                        <Columns>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>

                <asp:SqlDataSource ID="dsrcExamMaster" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                    SelectCommand="select S.FirstName + ' ' + S.LastName As FullName ,M.ISExamEnable, M.ISExamFinish, CASE When  M.ActualStartTime IS NULL Then 'Not Start Yet' Else FORMAT(M.ActualStartTime ,'dd/MMM/yyyy'' at'' hh:mm tt') End As ActualStartTime,(CASE When  M.ActualEndTime IS NULL Then 'Not Finish Yet' Else FORMAT(M.ActualEndTime ,'dd/MMM/yyyy'' at'' hh:mm tt') End) As ActualEndTime from EA_StudentEnrollment M join Student S on M.StudentID = S.StudentID Where M.ExamID=@hdnExamIDGrid order by FullName">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfExamID" Name="hdnExamIDGrid" PropertyName="value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <%--<telerik:RadGrid runat="server" ClientIDMode="Static" Skin="Bootstrap" ID="grvShowAssignedStudentList" AllowFilteringByColumn="true"
                    AllowSorting="true" DataSourceID="dsrcStudentList">
                    <MasterTableView TableLayout="Fixed">
                        <Columns>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="dsrcStudentList" runat="server" ConnectionString='<%$ ConnectionStrings:InventoryConnectionString %>'
                    SelectCommand="select S.FirstName + ' ' + S.LastName As FullName ,M.ISExamEnable, M.ISExamFinish, CASE When  M.ActualStartTime IS NULL Then 'Not Start Yet' Else FORMAT(M.ActualStartTime ,'dd/MMM/yyyy'' at'' hh:mm tt') End As ActualStartTime,(CASE When  M.ActualEndTime IS NULL Then 'Not Finish Yet' Else FORMAT(M.ActualEndTime ,'dd/MMM/yyyy'' at'' hh:mm tt') End) As ActualEndTime from EA_StudentEnrollment M join Student S on M.StudentID = S.StudentID Where M.ExamID=@hdnExamIDGrid order by FullName">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfExamID" Name="hdnExamIDGrid" PropertyName="value" />
                    </SelectParameters>
                </asp:SqlDataSource>--%>
            </ContentTemplate>
            <Triggers></Triggers>
        </asp:UpdatePanel>
    </div>

    <div>
    </div>
</asp:Content>
