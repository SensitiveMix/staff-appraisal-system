<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamContribution.aspx.cs" Inherits="KPISystem.TeamContribution" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script src="Scripts/jquery.boxy.js"></script>
    <script src="Scripts/Calendar4.js"></script>
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">Team Contributions</label>
                            </h1>
                        </hgroup>
                    </td>
                    <td style="text-align: right;">
                        <p><a href="TeamContributionDetail.aspx" ID="b" visible="false" runat="server"  title="Team Contributions" style="color: blue">New </a></p>
                    </td>
                </tr>
            </table>

        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UPContrbution" runat="server">
        <ContentTemplate>
            <div style="width: 98%; text-align: center; background-color: lightblue;height:181px;">
                <p style="font-size: 30px; color: white; text-align: left"><strong>Search</strong></p>
                <asp:Label ID="Lb_title" CssClass="LBT" runat="server" Height="30px" Text="Title:"></asp:Label>
                <asp:TextBox ID="TB_title" runat="server" Width="214px" BorderColor="Black" Height="15px"></asp:TextBox>
                <asp:Label ID="Lb_type" CssClass="LBType" runat="server" Height="30px" Text="Type:"></asp:Label>
                <asp:DropDownList ID="DDL_type" CssClass="ddlType" runat="server" Width="89px" Style="margin-bottom: 7px" ForeColor="Black" Height="27px">
                </asp:DropDownList>
                <asp:Label ID="LB_user" CssClass="LBUser" runat="server" Height="30px" Text="User:"></asp:Label>
                <asp:TextBox ID="TB_user" runat="server" Width="105px" BorderColor="Black" Height="15px"></asp:TextBox>
                <br />
                <asp:Label ID="Lb_date" runat="server" Height="30px" Text="Date:"></asp:Label>
                <asp:TextBox ID="TB_date" CssClass="date" runat="server" Width="92px" BorderColor="Black" onclick="MyCalendar.SetDate(this); " Height="15px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Height="30px" Text="~"></asp:Label>
                <asp:TextBox Text="" ID="TB_dateLater" runat="server" CssClass="dateLater" Width="92px" BorderColor="Black" onclick="MyCalendar.SetDate(this);" Height="15px"></asp:TextBox>
        <asp:Button ID="Btn_search" CssClass="search" runat="server" Height="32px" BorderColor="White" OnClick="Search_Click" Text="Search" Width="84px" />
            </div>
            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:GridView ID="gvTeamContributions" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="GridViewStyle" AllowPaging="True" OnPageIndexChanging="GridViewRowIndexChange" PageSize="20">
                            <FooterStyle CssClass="GridViewFooterStyle" />
                            <RowStyle CssClass="GridViewRowStyle" />
                            <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                            <PagerStyle CssClass="GridViewPagerStyle" />
                            <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                            <HeaderStyle CssClass="GridViewHeaderStyle" />
                            <Columns>
                                <asp:BoundField HeaderText="Title" DataField="Title" />
                                <asp:BoundField HeaderText="UserName" DataField="UserName" />
                                <asp:BoundField HeaderText="Type" DataField="Type" />
                                <asp:BoundField HeaderText="SubmitDate" DataField="Date" />
                                <asp:BoundField HeaderText="Description" DataField="Description" Visible="false" />
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnOperateMeeting" runat="server" CommandName="view" CommandArgument='<%# Eval("teamContributionId")%>' OnClick="lbtnTeamContributionInfo_Click" ForeColor="Blue" Text="view"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        $(function () {
            $(".boxy").boxy();
        });
        function setTitle() {
            $(".date").val($(".date").val().replace("15:00", ""));
            $(".dateLater").val($(".dateLater").val().replace("15:00", ""));
        }

    </script>
    <style>
        .LBType {
            margin-left: 100px;
        }

        .LBUser {
            margin-left: 100px;
        }

        .dateLater {
            margin-right: 285px;
        }

        .search {
            margin-right: 300px;
            margin-left:106px;
        }

        .ddlType {
            border: 1px solid;
        }
        
    </style>
</asp:Content>
