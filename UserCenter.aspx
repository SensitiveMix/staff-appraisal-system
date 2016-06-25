<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserCenter.aspx.cs" Inherits="KPISystem.UserCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/Calendar4.js"></script>
    <script>
        function setTitle() {
            $("#MainContent_register").val($("#MainContent_register").val().replace("15:00", ""));
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>User Center</h1>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <%--    <h3>Work Performance Score History
    </h3>--%>
    <p>
        <div style="margin: 0 0 0 300px">
            <table>
                <tr>
                    <td>
                        <%--<asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp;
						<asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                        </asp:DropDownList>--%>
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td>UserName:</td>
                    <td>
                        <asp:TextBox ID="tb_name" runat="server" ForeColor="Black"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>RealName:</td>
                    <td>
                        <asp:TextBox ID="tb_RealName" runat="server" ForeColor="Black"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>EmailAdress:</td>
                    <td>
                        <asp:TextBox ID="tb_Email" runat="server" ForeColor="Black"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>RegisterTime:</td>
                    <td>
                        <input type="text" id="register" onclick="MyCalendar.SetDate(this); " runat="server" /></td>
                </tr>
                <tr>
                    <td>LastLogin:</td>
                    <td>
                        <asp:TextBox ID="tb_lastLogin" runat="server" ForeColor="Black"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Status:</td>
                    <td>
                        <asp:DropDownList ID="ddl_status" runat="server">
                            <asp:ListItem>Active</asp:ListItem>
                            <asp:ListItem>Degrade</asp:ListItem>
                        </asp:DropDownList>
                </tr>
                <tr>
                    <td>GroupID:</td>
                    <td>
                        <asp:DropDownList ID="ddl_group" runat="server" Height="22px" Width="74px">
                            <asp:ListItem>Admin</asp:ListItem>
                            <asp:ListItem>User</asp:ListItem>
                            <asp:ListItem>Guest</asp:ListItem>
                        </asp:DropDownList>
                </tr>

                <tr>
                    <td runat="server" id="memo" visible="false">Leave Reason:</td>
                    <td>
                        <asp:TextBox ID="MemoTB" runat="server" Visible="false" ForeColor="Black"></asp:TextBox></td>
                </tr>

                <tr style="height: 80px; text-align: center">
                    <td>
                        <asp:Button ID="manage" Text="Manage" runat="server" OnClick="btn_ManageCilck" /></td>
                    <td style="text-align: center">
                        <asp:Button ID="Close" Text="Close" runat="server" OnClick="btn_CloseCilck" /></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%"
                            CssClass="GridViewStyle">
                            <FooterStyle CssClass="GridViewFooterStyle" />
                            <RowStyle CssClass="GridViewRowStyle" />
                            <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                            <PagerStyle CssClass="GridViewPagerStyle" />
                            <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                            <HeaderStyle CssClass="GridViewHeaderStyle" />
                            <Columns>
                                <asp:BoundField DataField="UserName" HeaderText="User" />

                                <asp:BoundField DataField="Score" HeaderText="Score" />
                            </Columns>
                        </asp:GridView>
                </tr>
            </table>
        </div>
    </p>
</asp:Content>
