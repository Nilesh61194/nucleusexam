<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignToTeacher.aspx.cs" Inherits="NucleusExams.AssignToTeacher" %>

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

        function Clear() {
            $('#ddlAcademicYear').val("Select Academic Year");
            $('#ddlGrade').val("Select Grade");
            $('#ddlExam').val("Select Exam");
            $('#ddlTeacher').prop('selected', false);
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


            if ($('#ddlTeacher').val() == "") {
                ErrorMsg = ErrorMsg + "\n Teacher is Required";
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
                <h4 class="card-title">Assign to Teacher</h4>
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
                        <asp:DropDownList ID="ddlExam" runat="server" CssClass="form-control" AutoPostBack="true" ClientIDMode="Static"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Teacher</label>
                    <div class="col-md-5">
                        <telerik:RadComboBox Width="100%" Filter="Contains" ClientIDMode="Static" EnableCheckAllItemsCheckBox="true" CheckBoxes="true"
                            EmptyMessage="Select Teacher" ID="ddlTeacher" runat="server">
                        </telerik:RadComboBox>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-md-3 text-center">
                        <asp:Button CssClass="form-control" ID="btnAssign" runat="server" OnClientClick="return ChkVal();" ClientIDMode="Static" Text="Assign" OnClick="btnAssign_Click" />
                    </div>
                    <div class="col-md-3 text-center">
                        <input type="button" class="form-control" id="btnClear" onclick="return Clear();" runat="server" value="Clear" />
                    </div>
                </div>

            </div>
        </div>

    </div>
</asp:Content>
