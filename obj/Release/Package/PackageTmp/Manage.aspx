<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Manage.aspx.cs" Inherits="KPISystem.Manage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="Scripts/Calendar4.js"></script>
    <style type="text/css">
        .GV_style {
            text-align: center;
            align-items: center;
        }

        .DDL_rule {
            border: none;
        }

        #lbtnKPI {
            border-color: whitesmoke;
        }

            #lbtnKPI:before {
                background-color: rgba(131, 196, 220, 1);
            }

            #lbtnKPI:hover {
                background-color: skyblue;
            }

            #lbtnKPI:after {
                background-color: gray;
            }

        #bg {
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index: 1001;
            -moz-opacity: 0.7;
            opacity: .70;
            filter: alpha(opacity=70);
        }




        #show {
            display: none;
            position: absolute;
            top: 25%;
            left: 35%;
            width: 33%;
            height: 48%;
            padding: 8px;
            border: 8px solid #E8E9F7;
            background-color: white;
            z-index: 1002;
            overflow: auto;
        }
    </style>
    <script>
        function showdiv() {

            document.getElementById("bg").style.display = "block";

            document.getElementById("show").style.display = "block";

            document.getElementById("bg").style.height = document.body.scrollHeight + "px";

        }

        function hidediv() {

            document.getElementById("bg").style.display = 'none';

            document.getElementById("show").style.display = 'none';

        }
        function setTitle() {
            $("#MainContent_register").val($("#MainContent_register").val().replace("15:00", ""));
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">Team Management</label>
                            </h1>
                        </hgroup>
                    </td>
                    <td style="text-align: right;">
                        <%-- <asp:LinkButton runat="server" CssClass="lb_new" ForeColor="white" Font-Size="Large" ID="lbtnKPI" Text=" New User " OnClientClick="showdiv()"></asp:LinkButton>--%>
                        <input type="button" id="lbtnKPI" onclick="showdiv()" value="New" />
                    </td>
                </tr>
            </table>

        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="bg">
    </div>

    <div id="show">
        <p style="text-align: right; margin-top: 0; padding-top: 0" onclick="hidediv()" runat="server">X</p>
        <div>

            <table id="tb_show" align="center">
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
                    <td>GroupID:</td>
                    <td>
                        <asp:DropDownList ID="ddl_group" runat="server">
                            <asp:ListItem>Admin</asp:ListItem>
                            <asp:ListItem>User</asp:ListItem>
                            <asp:ListItem>Guest</asp:ListItem>
                        </asp:DropDownList>
                </tr>
                <tr style="height: 80px; text-align: center">
                    <td>
                        <asp:Button ID="Save" Text="save" runat="server" OnClick="btn_SaveCilck" /></td>
                    <td style="text-align: center">
                        <button id="Cancel" onclick="hidediv();" type="button" runat="server">close</button></td>
                </tr>
            </table>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <div style="text-align: center; align-content: center;">
                <div style="text-align: right">
                    <asp:DropDownList ID="ddl_rule" CssClass="DLL_rule" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddl_rule_SelectedIndexChanged">
                        <asp:ListItem>Active</asp:ListItem>
                        <asp:ListItem>Degrade</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <asp:GridView ID="gv_Manage" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="GV_style" OnRowDeleting="gvManage_RowDataDelete" OnRowDataBound="gvManage_RowDataBound" OnSelectedIndexChanged="gv_Manage_SelectedIndexChanged">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <%--<asp:BoundField HeaderText="ID" DataField="ID" />--%>
                        <asp:BoundField HeaderText="UserName" DataField="Name" />
                        <asp:BoundField HeaderText="RealName" DataField="RealName" />
                        <asp:BoundField HeaderText="EmailAddress" DataField="Email" />
                        <%--          <asp:BoundField HeaderText="UserStatus" DataField="_status" />--%>
                        <asp:BoundField HeaderText="RegisterTime" DataField="RegisterTime" ReadOnly="true" />
                        <asp:BoundField HeaderText="LastLogin" DataField="LastLogin" ReadOnly="true" />

                   <%--     <asp:BoundField HeaderText="Leave Reason" DataField="memo" ReadOnly="true" />--%>
                        <%--<asp:CommandField HeaderText="Delete" ShowDeleteButton="True" />--%>
                         <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnManage" runat="server" CommandName="view" CommandArgument='<%# Eval("ID")%>' OnClick="lbtnManageInfo_Click" ForeColor="Blue" Text="view"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
