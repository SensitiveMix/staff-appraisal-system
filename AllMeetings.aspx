<%@ Page Title="All Meetings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AllMeetings.aspx.cs" Inherits="KPISystem.AllMeetings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">All Meetings </label> 
                            </h1>
                        </hgroup>
                    </td> 
                    <td style="text-align: right;">
                        <asp:LinkButton runat="server" ForeColor="Blue" ToolTip="Will create a meeting which start time is now" ID="lbtnNew" Text=" New " PostBackUrl="~/WeeklyMeeting.aspx" OnClientClick="return confirm('do you want to create a new meeting?');"></asp:LinkButton>
                    </td>
                    
                </tr>
            </table>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <table style="width: 100%">
        <tr>
            <td style="text-align: right;">
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gvMeeting" runat="server" AutoGenerateColumns="false" AllowPaging="true"  Width="100%" OnRowDataBound="gvMeeting_DataBound" OnPageIndexChanging="gvMeeting_PageIndexChanging" CssClass="GridViewStyle" PageSize="20">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="MeetingID" />
                        <asp:BoundField HeaderText="Title" DataField="Title" />
                        <asp:BoundField HeaderText="Start Time" DataField="StartTime" />
                        <asp:BoundField HeaderText="End Time" DataField="EndTime" />
                        <asp:BoundField HeaderText="Hoster" DataField="HosterName" />
                        <asp:BoundField HeaderText="Score" DataField="TotalScore" />
                        <asp:BoundField HeaderText="Week" DataField="WeekIndex" />
                        <asp:TemplateField HeaderText="">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnOperateMeeting" runat="server" OnClick="lbtnOperateMeeting_Click" ForeColor="Blue" Text='<%#Eval("OperateTitle") %>'></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnDeleteMeeting" runat="server" OnClick="lbtnDeleteMeeting_Click" ForeColor="Blue" Text='Delete' OnClientClick="return confirm('Are you sure to delete this meeting?');"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
