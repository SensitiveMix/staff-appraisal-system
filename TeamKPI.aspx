<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TeamKPI.aspx.cs" Inherits="KPISystem.TeamKPI" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 31px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">Team KPI </label>
                            </h1>
                        </hgroup>
                    </td>
                    <td style="text-align: right;">
                        <asp:LinkButton runat="server" ForeColor="Blue" ID="lbtnKPI"  Text=" Current Month KPI " OnClick="lbtnKPI_Click"></asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <table style="width: 100%">
        <tr style="font-size: 15px;">
            <td class="auto-style1">
                <h4>KPI Line Chart:</h4>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="text-align: right">
                            <asp:DropDownList ID="ddlYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlYear_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;
                            <asp:DropDownList ID="ddlBeginMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlBeginMonth_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:Label ID="Label1" runat="server" Text="~"></asp:Label>
                            <asp:DropDownList ID="ddlEndMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEndMonth_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        &nbsp;
                        &nbsp;
                        <asp:Chart ID="KPIChart" runat="server" OnLoad="KPIChart_Load" Width="928px" Height="422px" BorderlineColor="Black" BorderlineDashStyle="Solid">
                            <%-- <Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" MarkerStyle="Cross" Name="v-jinhta" ToolTip="#SERIESNAME   Rank:#VAL" LabelToolTip="#SERIESNAME">
                                    <Points>
                                        <asp:DataPoint LabelToolTip="#SERIESNAME" YValues="0" />
                                    </Points>
                                </asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" MarkerStyle="Square" Name="v-damonl" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                                <asp:Series Name="v-jacsun" BorderWidth="2" ChartType="Line" Legend="Legend1" MarkerStyle="Triangle" ToolTip="#SERIESNAME   Rank:#VAL"></asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" MarkerStyle="Star4" Name="v-jiapji" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" MarkerStyle="Star5" Name="v-monlin" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" MarkerStyle="Star10" Name="v-qiafu" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" Name="v-feding" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                                <asp:Series BorderWidth="2" ChartArea="ChartArea1" ChartType="Line" Legend="Legend1" Name="v-ary" MarkerStyle="Star6" ToolTip="#SERIESNAME   Rank:#VAL">
                                </asp:Series>
                            </Series>--%>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisY Title="Rank" Interval="1" Maximum="8" Minimum="1" TitleFont="Microsoft Sans Serif, 9.75pt">
                                        <MajorGrid LineDashStyle="Dot" />
                                        <MajorTickMark LineColor="White" TickMarkStyle="AcrossAxis" />
                                    </AxisY>
                                    <AxisX Title="Month" Interval="1" Maximum="12" Minimum="1" TitleFont="Microsoft Sans Serif, 11.25pt" IsMarginVisible="False">
                                        <MajorGrid LineDashStyle="Dot" />
                                        <MajorTickMark LineColor="White" TickMarkStyle="AcrossAxis" />
                                    </AxisX>
                                    <AxisY2 IsReversed="True">
                                    </AxisY2>
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                            <Titles>
                                <asp:Title Name="Team KPI">
                                </asp:Title>
                            </Titles>
                        </asp:Chart>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <table style="width: 100%">
        <tr style="font-size: 16px;">
            <td class="auto-style1">
                <h5>Total Team KPI:</h5>
            </td>
        </tr>
        &nbsp;
        &nbsp;
        &nbsp;
        <tr>
            <td>
                <div id="silverlightControlHost">
                    <object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="400px">
                        <param name="source" value="ClientBin/KPIDataReport.xap" />
                        <param name="onError" value="onSilverlightError" />
                        <param name="background" value="white" />
                        <param name="minRuntimeVersion" value="5.0.61118.0" />
                        <param name="autoUpgrade" value="true" />
                        <param name="InitParams" value="Page=1" />
                        <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=5.0.61118.0" style="text-decoration: none">
                            <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style: none" />
                        </a>
                    </object>
                    <iframe id="_sl_historyFrame" style="visibility: hidden; height: 0px; width: 0px; border: 0px"></iframe>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <h3>Details:</h3>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView runat="server" ID="gvKPI" CssClass="GridViewStyle" AutoGenerateColumns="true" Width="97%">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                </asp:GridView>
            </td>
        </tr>
    </table>


</asp:Content>
