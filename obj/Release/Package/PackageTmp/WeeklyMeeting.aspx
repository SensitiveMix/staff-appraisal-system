<%@ Page Title="Weekly Meeting" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WeeklyMeeting.aspx.cs" Inherits="KPISystem.WeeklyMeeting" %>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script src="Scripts/Calendar4.js"></script>

    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>
                    <label id="mtitle"><%=MeetingTitle %></label>
                </h1>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function setTitle() {
            $("#mtitle").html('Weekly task review ' + $("#txtMeetingTime").val());

            var url = window.location.href.replace(/\?time\S+/i, '');

            window.location.href = url + '?time=' + $("#txtMeetingTime").val().replace(' ', '%20');
        }

        function TalkToJavaScript(data) {

            var control = document.getElementById("tfsData");

            control.Content.TfsPage.UpdateTitle(<%=WeekIndex %> + " TFS WorkLoad");

        }


    </script>
    <table style="width: 100%">
        <tr>
            <td><span class="label">Meeting Time :</span> </td>
            <td>
                <div runat="server" id="divTime">
                    <input type="text" name="time1" id="txtMeetingTime" style="width: 150px" onclick="MyCalendar.SetDate(this); " onchange="setTitle()" value="<%=MeetingTime %>" />
                </div>
                <asp:Label runat="server" ID="lblMeetingTime" Width="140px" Visible="false"></asp:Label>
            </td>
            <td><span class="label">Hoster :</span> </td>
            <td>

                <asp:DropDownList ID="ddlHoster" runat="server" DataValueField="ID" DataTextField="Name"></asp:DropDownList>
                <asp:Label runat="server" ID="lblHoster" Visible="false"></asp:Label>
            </td>
            <td><span class="label">Next Hoster:</span> </td>
            <td>
                <asp:DropDownList ID="ddlNextHoster" runat="server" DataValueField="ID" DataTextField="Name"></asp:DropDownList>
                <asp:Label runat="server" ID="lblNextHoster" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <asp:Label Text="text" runat="server" ID="lblWarning" Visible="false" />
                <div id="silverlightControlHost">
                    <div id="Div1" style="width: 100%" runat="server">

                        <object id="tfsData" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="400px">
                            <param name="source" value="ClientBin/TFSDataReport.xap" />
                            <param name="onError" value="onSilverlightError" />
                            <param name="background" value="white" />
                            <param name="minRuntimeVersion" value="5.0.61118.0" />
                            <param name="autoUpgrade" value="true" />
                            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=5.0.61118.0" style="text-decoration: none">
                                <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style: none" />
                            </a>
                        </object>
                        <iframe id="Iframe1" style="visibility: hidden; height: 0px; width: 0px; border: 0px"></iframe>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <asp:GridView ID="gvScore" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="GridViewStyle" OnRowDataBound="gvScore_RowDataBound">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="ID" />

                        <asp:TemplateField HeaderText="Criteria Name" HeaderStyle-Width="400px">
                            <ItemTemplate>
                                <p><%# Eval("CriteriaName") %></p>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Score" FooterStyle-Width="100px">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlScore" runat="server" Width="100px">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Label runat="server" ID="lblScore" Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" HeaderStyle-Width="400px">
                            <ItemTemplate>
                                <p><%# Eval("Description") %></p>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <%--      <span class="label" runat="server" id="user" style="display: none">Meeting Users :</span>--%>
                <span class="label" runat="server" id="user"></span>
            </td>
            <td colspan="3" style="text-align: center">
                <span runat="server" id="smail"><a href="<%=LinkString %>">Send Mail</a></span>
            </td>
            <td>
                <span style="color: red">
                    <asp:Label runat="server" ID="lblTotal" Visible="false"></asp:Label></span></td>
            <td></td>
        </tr>
        <tr style="display: none">
            <td colspan="6">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="gvUsers_PageIndexChanging" AllowPaging="true" PageSize="10" Width="100%" CssClass="GridViewStyle">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="User ID" DataField="ID" />
                        <asp:BoundField HeaderText="Name" DataField="Name" />
                        <asp:BoundField HeaderText="Email" DataField="Email" />
                        <%--  <asp:BoundField HeaderText="Status" DataField="Status" />--%>
                        <asp:TemplateField HeaderText="Remove">
                            <ItemTemplate>
                                <asp:LinkButton ToolTip="Remove this user from this meeting." Text="Remove" runat="server" ID="lbtnRemove" OnClientClick="return window.confirm('Are you sure to remove this user from meeting?');" OnClick="lbtnRemove_Click" ForeColor="Blue" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr> 
            <td colspan="2" style="text-align: right">
                 <span style="display: none"> <asp:LinkButton Text="OutLook Meeting" runat="server" ID="lbtnOutlookMeeting" OnClick="lbtnOutlookMeeting_Click" /></span>
                <span style="display: none">
                    <asp:Button ID="btnReset" runat="server" Text="ReSet" OnClientClick="return confirm('Are you sure to Reset all changes?');" OnClick="btnReset_Click" /></span>
            </td>
            <td colspan="2" style="text-align: center">
                <asp:Button ID="btnSubmit" runat="server" Width="150px" Text="Sumbit" OnClick="btnSubmit_Click" OnClientClick="return confirm('Are you sure to sumbit this meeting?');" />
                <%--<asp:Button ID="btnSendEmail" runat="server" Width="150px" Text="Send Email" Visible="false" OnClientClick="alert('email is sending...');" /></td>--%>

            <td></td>
            <td></td>
        </tr>
    </table>
</asp:Content>
