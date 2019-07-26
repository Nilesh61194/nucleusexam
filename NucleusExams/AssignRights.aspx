<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="AssignRights.aspx.cs" Inherits="NucleusExams.AssignRights" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/popup.css" rel="stylesheet" />
    <script src="assets/js/sweetalert-dev.js"></script>
    <script>
        function AssignSuccess() {
            swal({
                title: "Success",
                text: "Assign successfully",
                type: "success"
            });
        }

        function error() {
            swal({
                title: "error",
                text: "Something happen wrong ... try again",
                type: "error"
            });
        }

        function ValidationForStaffSelection() {
            swal({
                title: "error",
                text: "Please select at least one teacher.",
                type: "error"
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="row" id="divAll" runat="server">
        <div class="col-lg-6">
            <div class="card-box">
                <h4 class="card-title">Assign Rights to Teacher</h4>
                <div class="form-group row">
                    <label class="col-form-label-sm col-md-1">Teacher </label>
                    <div class="col-md-5">
                        <asp:UpdatePanel ID="upSetSession" runat="server">
                            <ContentTemplate>
                                <telerik:RadComboBox Width="100%" Filter="Contains" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" CheckBoxes="true"
                                    EmptyMessage="Select Section" ID="cboStaffList" ClientIDMode="Static" runat="server">
                                </telerik:RadComboBox>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cboStaffList" EventName="selectedindexchanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnStaffAssign" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-md-2">
                        <label class="col-form-label">Rights</label>
                        <asp:CheckBox ID="chkRights" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <label class="col-form-label">Admin Rights </label>
                        <asp:CheckBox ID="chkAdminRights" runat="server" />
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnStaffAssign" CssClass="btn-sm btn-primary" OnClick="btnStaffAssign_Click" Text="Assign" runat="server" />
                    </div>
                </div>
                <div class="form-group row">
                    <telerik:RadGrid ID="gvExamMaster" RenderMode="Lightweight" runat="server" DataSourceID="dsrcExamMaster" AllowMultiRowSelection="True" Skin="Bootstrap" Width="100%"
                        PageSize="20" AllowPaging="true" PagerStyle-Position="Top" PagerStyle-AlwaysVisible="true"
                        DataKeyNames="RightsID" AllowAutomaticDeletes="true" AllowFilteringByColumn="true" OnNeedDataSource="gvExamMaster_NeedDataSource">
                        <GroupingSettings CaseSensitive="false"></GroupingSettings>
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="RightsID" ShowHeader="True" DataSourceID="dsrcExamMaster">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Teacher's Name" HeaderStyle-Width="200px" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <telerik:RadLabel ID="lblTeacherName" runat="server" Text='<%# Eval("FullName") %>'></telerik:RadLabel>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Rights" HeaderStyle-Width="140px" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <telerik:RadLabel ID="lblRights" runat="server" Text='<%# Eval("ISRights") %>'></telerik:RadLabel>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Admin Rights" HeaderStyle-Width="100px" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <telerik:RadLabel ID="lblAdminRights" runat="server" Text='<%# Eval("ISAdminRights") %>'></telerik:RadLabel>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings AllowKeyboardNavigation="true">
                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true"
                                FrozenColumnsCount="25" />
                        </ClientSettings>
                    </telerik:RadGrid>

                    <asp:SqlDataSource ID="dsrcExamMaster" runat="server" ConnectionString="<%$ ConnectionStrings:InventoryConnectionString %>"
                        SelectCommand="select RightsID,FullName,ISRights,ISAdminRights from EA_StaffRights sr inner join WorkingStaffList sl on sr.StaffID=sl.StaffMasterID order by FullName"></asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
