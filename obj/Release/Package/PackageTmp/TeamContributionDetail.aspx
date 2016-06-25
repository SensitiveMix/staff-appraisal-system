<%@ Page Title="Team Contribution Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamContributionDetail.aspx.cs" Inherits="KPISystem.TeamContributionDetail" %>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script src="Scripts/Calendar4.js"></script>
    <script>
        $(function () {
            $("#btnCancel").click(function () { history.go(-1) });
            $("#MainContent_btnAdd").click(function () {
                if (!$("#MainContent_txtTitle").val()) {
                    alert('title can not be null');
                    $("#MainContent_txtTitle").focus();
                    return false;
                }
            });
            $("#MainContent_btnAddAndSave").click(function () {
                if (!$("#MainContent_txtTitle").val()) {
                    alert('title can not be null');
                    $("#MainContent_txtTitle").focus();
                    return false;
                }
            });
        });
        function setTitle() {
            $("#MainContent_txtDate").val($("#MainContent_txtDate").val().replace("15:00", ""));
        }
    </script>
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1>
                    <label id="mtitle">Team Contribution Detail</label>
                </h1>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table style="width: 665px; height: 283px;">
            <tr>
                <td class="auto-style2">Title: </td>
                <td>
                    <asp:TextBox runat="server" ID="txtTitle" MaxLength="200" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td class="auto-style2">SubmitDate: </td>
                <td>
                    <input type="text" name="time1" id="txtDate" style="width: 150px" onclick="MyCalendar.SetDate(this); " runat="server" />
                </td>
            </tr>

            <tr>
                <td class="auto-style2">Type: </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlType" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Owner: </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlUsers" AutoPostBack="false" DataTextField="Name" DataValueField="ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Description: </td>
                <td>
                    <asp:TextBox runat="server" ID="txtDescription" MaxLength="200" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Button Text="Add" BorderColor="White" runat="server" ID="btnAdd" OnClick="btnAdd_Click" />
                </td>
                <td>
                    <asp:Button Text="Continue" runat="server" ID="btnAddAndSave" OnClick="btnAddAndSave_Click" Width="73px" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:Button Text="Cancel" runat="server" ID="btnCancel1" OnClick="btn_Cancel" />

                <td class="auto-style1">
            </tr>
        </table>
    </div>

</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .auto-style1 {
            width: 28px;
        }

        .auto-style2 {
            width: 97px;
        }
    </style>
</asp:Content>

