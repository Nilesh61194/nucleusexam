<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="NucleusExams.Home" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--<link href="Content/responsive.css" rel="stylesheet" />--%>
    <style>
        .rgDataDiv {
            height: auto !important;
        }
    </style>
    <script type="text/javascript" src="../assets/js/jquery-3.2.1.min.js"></script>
    <script src="assets/js/sweetalert-dev.js"></script>
    <link href="Content/popup.css" rel="stylesheet" />

    <script>
        var captcha;
        var IsRights = false;
        function generateCaptcha() {
            captcha = Math.floor(Math.random() * 90000000) + 10000000;
            return captcha;
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
                Exm.ISExamCode = true;
                Exm.ExamCode = generateCaptcha();
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
                            PageMethods.BindGrid();
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
                Exm.ISExamCode = true;
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

        function errorAccess() {
            swal({
                title: "error",
                text: "You don't have edit rights.",
                type: "error"
            });
        }

        function error() {
            swal({
                title: "error",
                text: "Something happen wrong ... try again",
                type: "error"
            });
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
            //$("#hfloggedInStaffID").val("");
            $("#hfExamID").val("");
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <%-- <telerik:AjaxSetting AjaxControlID="btnCreate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divALL" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            <%--<telerik:AjaxSetting AjaxControlID="gvExamMaster">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divALL" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div class="row">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="row" id="divALL" runat="server">
        <asp:HiddenField ID="hfloggedInStaffID" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfExamID" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfRightsID" ClientIDMode="Static" runat="server" />
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
                        <input type="text" class="form-control" value="https://exam.fountainheadschools.org/Paper/GetPaper" runat="server" id="txtExamURL" clientidmode="Static" disabled="disabled">
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
                        <input type="button" class="form-control btn btn-primary" id="btnCreate" runat="server" clientidmode="Static" value="Save" onclick="AddExam();" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="form-control btn btn-primary" Text="Update" Style="display: none;" ClientIDMode="Static"
                            OnClick="btnUpdate_Click" OnClientClick="return updateval();" />
                        <%--<input type="button" class="form-control" id="btnUpdate" runat="server" value="Save" onclick="UpdateExam();" />--%>
                    </div>
                    <div class="col-md-3 text-center">
                        <input type="button" class="form-control btn btn-danger" clientidmode="Static" id="Button1" runat="server" value="Clear" onclick="Clear();" />
                    </div>
                </div>



            </div>
        </div>


        <%--    <asp:UpdatePanel ID="upnGrid" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate> DataSourceID="dsrcExamMaster"--%>
        <div class="col-lg-12">
            <div class="card-box">
                <telerik:RadGrid ID="gvExamMaster" RenderMode="Lightweight" runat="server" CssClass="rgDataDiv" AllowMultiRowSelection="True" Skin="Bootstrap" Width="100%"
                    PageSize="10" AllowPaging="true" PagerStyle-Position="Top" PagerStyle-AlwaysVisible="true"
                    DataKeyNames="ExamID" AllowAutomaticDeletes="true" OnItemDataBound="gvExamMaster_ItemDataBound" OnDeleteCommand="gvExamMaster_DeleteCommand" OnPageIndexChanged="gvExamMaster_PageIndexChanged"
                    OnItemCommand="gvExamMaster_ItemCommand" OnPageSizeChanged="gvExamMaster_PageSizeChanged" MasterTableView-NoDetailRecordsText="No records found">
                    <GroupingSettings CaseSensitive="false"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="ExamID" ShowHeader="True">
                        <NoRecordsTemplate>
                            <div>
                                There are no records to display
                            </div>
                        </NoRecordsTemplate>
                        <Columns>

                            <telerik:GridTemplateColumn HeaderText="Grade Name" HeaderStyle-Font-Bold="true" HeaderStyle-Width="7%">
                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblGradeName" runat="server" Text='<%# Eval("GradeName") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Exam Name" HeaderStyle-Font-Bold="true" HeaderStyle-Width="15%">
                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblExamName" runat="server" Text='<%# Eval("ExamName") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%--<telerik:GridTemplateColumn HeaderText="Subject Name" HeaderStyle-Width="140px">
                            <ItemTemplate>
                                <telerik:RadLabel ID="lblSubjectName" runat="server" Text='<%# Eval("SubjectName") %>'></telerik:RadLabel>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>--%>
                            <telerik:GridTemplateColumn HeaderText="Duration" HeaderStyle-Font-Bold="true" HeaderStyle-Width="6%">
                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Exam Code" HeaderStyle-Font-Bold="true" HeaderStyle-Width="10%">

                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblExamCode" runat="server" Text='<%# Eval("ExamCode") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Exam Date" HeaderStyle-Font-Bold="true" HeaderStyle-Width="10%">

                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblExamDate" runat="server" Text='<%# Eval("ExamDate", "{0:dd MMM yyyy}") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Created By" HeaderStyle-Font-Bold="true" HeaderStyle-Width="10%">
                                <ItemTemplate>
                                    <telerik:RadLabel ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></telerik:RadLabel>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Add Question" HeaderStyle-Font-Bold="true" HeaderStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlAddQuestion" Target="_blank" runat="server" NavigateUrl='<%# "~/AddQuestion.aspx?ExamId=" +  Eval("ExamID") %>'>Add / View Question</asp:HyperLink>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Add Collaborative" HeaderStyle-Font-Bold="true" HeaderStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Button ID="btnCollaborative" runat="server" Text="Add Collaborative" CssClass="btn btn-sm btn-info" OnClientClick='<%# string.Format("return AddCollaborative({0})", Eval("ExamID")) %>' />
                                    <%--<input type="button" runat="server" value="Add Collaborative" onclick='return AddCollaborative('<%# %>')' id="btnCollaborative" class="btn btn-sm btn-info" />--%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderStyle-Font-Bold="true" HeaderText="Edit" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" CssClass="btn btn-sm btn-outline-primary" Text="Edit" CommandName="EditExam" ToolTip="Edit" runat="server" CommandArgument='<%# Eval("ExamID") %>'></asp:Button>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Font-Bold="true" HeaderStyle-Width="5%">
                                <ItemTemplate>
                                    <asp:Button ID="btnExamStatus" CssClass="btn btn-sm btn-outline-success" runat="server" Text='<%# Eval("ISActive").Equals(true) ? "Active" : "Inactive" %>' CommandArgument='<%# Eval("ExamID") %>'
                                        CommandName="ExamActive" OnClientClick="return confirmActive();" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridButtonColumn HeaderText="Delete" HeaderStyle-Font-Bold="true" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn" HeaderStyle-Width="8%"></telerik:GridButtonColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true"
                            FrozenColumnsCount="5" />
                    </ClientSettings>
                </telerik:RadGrid>

                <%--<asp:SqlDataSource ID="dsrcExamMaster" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                    SelectCommand="select ExamID,ExamName,g.GradeID,GradeName,AcademicYearID,SubjectName,Duration,CreatedBy,ISExamCode,ExamCode,ExamDate,ExamURL,ISActive,CreateDate from EA_ExamMaster em	inner join Grade g on g.GradeID= em.GradeID"></asp:SqlDataSource>--%>
                <%--  </ContentTemplate>
                            <Triggers>
                            </Triggers>
                        </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>
    <div id="divCollaborative" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Add Collaborative</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>

                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-1">
                            <p><b>Select Staff</b></p>
                        </div>
                        <div class="col-md-3">
                            <telerik:RadComboBox Width="100%" Filter="Contains" ClientIDMode="Static" EnableCheckAllItemsCheckBox="true" CheckBoxes="true"
                                EmptyMessage="Select Teacher" ID="ddlTeacher" DataTextField="FullName" DataValueField="StaffMasterID" runat="server" DataSourceID="dsrcStaff">
                            </telerik:RadComboBox>
                            <asp:SqlDataSource ID="dsrcStaff" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                                SelectCommand="select FullName,StaffMasterID from WorkingStaffList"></asp:SqlDataSource>
                        </div>
                        <div class="col-md-2">
                            <p><b>Is Edit Rights ?</b></p>
                        </div>
                        <div class="col-md-1">
                            <input type="checkbox" id="chkIsEdit" class="form-check" />
                        </div>
                        <div class="col-md-2">
                            <p><b>Is View Rights ?</b></p>
                        </div>
                        <div class="col-md-1">
                            <input type="checkbox" id="chkIsView" class="form-check" />
                        </div>
                        <div class="col-md-2">
                            <input type="button" value="ADD" class="btn btn-sm btn-primary" id="btnCollSave" onclick="return SaveCollaborative();" />
                            <input type="button" value="Update" class="btn btn-sm btn-primary" style="display: none;" id="btnCollUpdate" onclick="return UpdateCollaborative();" />
                            <input type="button" value="Clear" class="btn btn-sm btn-danger" onclick="return ClearCollaborative();" />
                        </div>
                    </div>
                    <div class="row">
                        <table id="tblCollaborative" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Sr No</th>
                                    <th>Name</th>
                                    <th>Edit</th>
                                    <th>View</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <script>
        function AddCollaborative(id) {
            debugger;
            CheckRights(id);

            if (IsRights) {
                $('#divCollaborative').modal('show');
                document.getElementById('hfExamID').value = id;
                BindCollaborative(id);
                ClearCollaborative();
                IsRights = false;
                return false;
            }
            else {
                errorAccess();
                return false;
            }
        }

        function UpdateCollaborative() {
            debugger;
            if (document.getElementById('chkIsView').checked || document.getElementById('chkIsEdit').checked) {
            }
            else {
                alert('Please select edit or view rights for users');
                return false;
            }

            var combo = $find("<%= ddlTeacher.ClientID%>")
            var d = new Date();
            var Collaborative = {};

            Collaborative.ExamID = document.getElementById('hfExamID').value;
            Collaborative.StaffID = combo.get_value();
            Collaborative.IsEdit = document.getElementById('chkIsEdit').checked;
            if (document.getElementById('chkIsEdit').checked) {
                Collaborative.IsView = document.getElementById('chkIsEdit').checked;
            }
            else {
                Collaborative.IsView = document.getElementById('chkIsView').checked;
            }
            Collaborative.Id = document.getElementById('hfRightsID').value;
            Collaborative.UpdateDate = d;
            Collaborative.UpdateBy = document.getElementById('hfloggedInStaffID').value;

            $.ajax({
                type: "POST",
                url: "/api/Question/UpdateCollaborativeByID",
                data: JSON.stringify(Collaborative),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (r) {
                    if (r > 0) {
                        BindCollaborative(document.getElementById('hfExamID').value);
                        ClearCollaborative();
                        alert(r + " record(s) updated.");


                    }
                    else {
                        alert("Collaborative is not updated...!\n Something went wrong!");
                    }

                },
                error: function (x, e) {
                    console.log(x.responseText);
                    alert("Collaborative is not inserted...!\n Something went wrong!");
                }
            });

        }

        function SaveCollaborative() {
            debugger;

            var checkeditems = "";
            var combo = $find("<%= ddlTeacher.ClientID%>")
            var items = combo.get_checkedItems();
            var Collaboratives = new Array();
            var d = new Date();

            if (items.length == 0) {
                alert('Please select at least one staff...');
                return false;
            }
            if (document.getElementById('chkIsView').checked || document.getElementById('chkIsEdit').checked) {
            }
            else {
                alert('Please select edit or view rights for users');
                return false;
            }

            if (items.length > 0) {
                for (i = 0; i < items.length; i++) {

                    //if (i == 0) {
                    //    radvalue = Number(parseInt(items[i]._properties._data.value));
                    //    checkeditems = checkeditems + radvalue;
                    //}
                    //else {
                    //    radvalue = Number(parseInt(items[i]._properties._data.value));
                    //    checkeditems = checkeditems + "," + radvalue;
                    //}
                    var Collaborative = {};
                    Collaborative.ExamID = document.getElementById('hfExamID').value;
                    Collaborative.StaffID = Number(parseInt(items[i]._properties._data.value));
                    Collaborative.IsEdit = document.getElementById('chkIsEdit').checked;
                    if (document.getElementById('chkIsEdit').checked) {
                        Collaborative.IsView = document.getElementById('chkIsEdit').checked;
                    }
                    else {
                        Collaborative.IsView = document.getElementById('chkIsView').checked;
                    }

                    Collaborative.EntryDate = d;
                    Collaborative.EntryBy = document.getElementById('hfloggedInStaffID').value;
                    Collaboratives.push(Collaborative);

                }

                $.ajax({
                    type: "POST",
                    url: "/api/Question/InsertCollaboratives",
                    data: JSON.stringify(Collaboratives),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (r) {
                        if (r > 0) {
                            BindCollaborative(document.getElementById('hfExamID').value);
                            ClearCollaborative();
                            alert(r + " record(s) inserted.");


                        }
                        else {
                            alert("Collaborative is not inserted...!\n Something went wrong!");
                        }

                    },
                    error: function (x, e) {
                        console.log(x.responseText);
                        alert("Collaborative is not inserted...!\n Something went wrong!");
                    }
                });
            }
            else {
                alert('Select at least one staff...');
            }




            return false;
            //  comboBox.set_text(selectedData.substring(0, selectedData.length - 1));
        }


        function BindCollaborative(id) {
            debugger;

            $.ajax({
                url: "/api/Question/GetCollaborativeDetailsByExamID",
                type: "GET",
                contentType: "application/json;charset=utf-8",
                data: { "id": id },
                dataType: "json",
                success: function (response) {

                    var JsonArray = JSON.parse(response);

                    var content = "";

                    $('#tblCollaborative TBODY').empty();

                    $(JsonArray).each(function (i, data) {
                        //content += "<tr><td style='display: none'>" + data.Id + "</td>";
                        var SrNo = parseInt(i) + 1;
                        content += "<tr><td>" + SrNo + "</td>";
                        content += "<td>" + data.FullName + "</td>";
                        content += "<td>" + data.IsEdit + "</td>";
                        content += "<td>" + data.IsView + "</td>";
                        content += "<td><input type='button' id='btn" + i + "' onclick='EditCollaborative(\"" + data.Id + "\",\"" + data.StaffID + "\"," + data.IsEdit + "," + data.IsView + ");' value='Edit' /></td>";
                        content += "<td><input type='button' id='btn" + i + "' onclick='DeleteCollaborative(\"" + data.Id + "\")' value='Delete' /></td>";
                        //content += "<td><input type='button' id='btn" + i + "' onclick='AddOutPut(\"" + OC + "\",\"" + ColName + "\",\"" + 'chk' + custID + "\", " + custID + ")' /></td>";
                        content += "</tr>"
                    });

                    $('#tblCollaborative TBODY').append(content);
                },

                error: function (x, e) {
                    console.log(x.responseText);
                    alert("Collaborative not found...!\n Something went wrong!");
                }
            });
            return false;
        }

        function EditCollaborative(id, name, edit, view) {
            //To set the value by using value
            debugger;


            var combo = $find("<%= ddlTeacher.ClientID %>");
            combo.enable();
            combo.findItemByValue(name).select();
            combo.disable();

            document.getElementById('chkIsEdit').checked = edit;
            document.getElementById('chkIsView').checked = view;
            $("#btnCollUpdate").show();
            $("#btnCollSave").hide();
            document.getElementById('hfRightsID').value = id;

        }
        function DeleteCollaborative(Id) {
            debugger;
            var result = confirm('Are you sure you want to delete ?');
            if (result) {
                var OBJ = {};
                OBJ.Id = Id;
                $.ajax({
                    url: "/api/Question/DeleteCollaborativeByID",
                    type: "POST",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(OBJ),
                    dataType: "json",
                    success: function (r) {
                        if (r > 0) {
                            BindCollaborative(document.getElementById('hfExamID').value);
                            alert(r + " record(s) deleted.");
                        }
                        else {
                            alert("Delete is not complete ...!\n Something went wrong!");
                        }

                    },
                    error: function (x, e) {
                        console.log(x.responseText);
                        alert("Delete is not complete ...!\n Something went wrong!");
                    }
                });

            }
        }


        function CheckRights(ExamID) {
            debugger;

            //var ExamObj = {};
            //ExamObj.ExamID = ExamID;
            //ExamObj.CreatedBy = $("#hfloggedInStaffID").val();

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
                    alert("Something went wrong!");
                }
            });

        }

        function ClearCollaborative() {

            document.getElementById('chkIsView').checked = false;
            document.getElementById('chkIsEdit').checked = false;
            var combo = $find("<%= ddlTeacher.ClientID%>")

            var items = combo.get_checkedItems();
            var k = 0;
            while (k < items.length) {
                items[k].uncheck();
                k++;
            }
            combo.enable();
            combo.clearSelection();

            $("#btnCollUpdate").hide();
            $("#btnCollSave").show();
            //  document.getElementById('hfloggedInStaffID').value = "0";
        }
    </script>
</asp:Content>
