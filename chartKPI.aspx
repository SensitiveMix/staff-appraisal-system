<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="chartKPI.aspx.cs" Inherits="KPISystem.chartKPI" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="358px" Width="910px">
        <Series>
            <asp:Series Name="Series_kPI" BorderWidth="2" ChartType="Line" MarkerColor="Red" MarkerStyle="Circle" XValueType="Int32"></asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series2">
                <Points>
                    <asp:DataPoint YValues="10" />
                    <asp:DataPoint YValues="20" />
                    <asp:DataPoint YValues="30" />
                    <asp:DataPoint YValues="40" />
                    <asp:DataPoint YValues="50" />
                    <asp:DataPoint YValues="60" />
                    <asp:DataPoint YValues="70" />
                    <asp:DataPoint YValues="80" />
                </Points>
            </asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series3">
                <Points>
                    <asp:DataPoint YValues="10" XValue="1" />
                    <asp:DataPoint YValues="20" XValue="2" />
                    <asp:DataPoint YValues="30" XValue="3" />
                    <asp:DataPoint YValues="40" XValue="4" />
                    <asp:DataPoint YValues="50"  XValue="5" />
                    <asp:DataPoint YValues="60" XValue="6" />
                    <asp:DataPoint YValues="70" XValue="7" />
                    <asp:DataPoint YValues="80" XValue="8" />
                </Points>
            </asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series4">
                <Points>
                    <asp:DataPoint YValues="1" />
                    <asp:DataPoint YValues="2" />
                    <asp:DataPoint YValues="3" />
                    <asp:DataPoint YValues="4" />
                    <asp:DataPoint YValues="5" />
                    <asp:DataPoint YValues="6" />
                    <asp:DataPoint YValues="7" />
                    <asp:DataPoint YValues="8" />
                </Points>
            </asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series5">
                <Points>
                    <asp:DataPoint YValues="1" />
                    <asp:DataPoint YValues="2" />
                    <asp:DataPoint YValues="3" />
                    <asp:DataPoint YValues="4" />
                    <asp:DataPoint YValues="5" />
                    <asp:DataPoint YValues="6" />
                    <asp:DataPoint YValues="7" />
                    <asp:DataPoint YValues="8" />
                </Points>
            </asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series6">
                <Points>
                    <asp:DataPoint YValues="1" />
                    <asp:DataPoint YValues="2" />
                    <asp:DataPoint YValues="3" />
                    <asp:DataPoint YValues="4" />
                    <asp:DataPoint YValues="5" />
                    <asp:DataPoint YValues="6" />
                    <asp:DataPoint YValues="7" />
                    <asp:DataPoint YValues="8" />
                </Points>
            </asp:Series>
            <asp:Series BorderWidth="2" ChartArea="CA_kPI" ChartType="Line" MarkerStyle="Circle" Name="Series7">
                <Points>
                    <asp:DataPoint YValues="1" />
                    <asp:DataPoint YValues="2" />
                    <asp:DataPoint YValues="3" />
                    <asp:DataPoint YValues="4" />
                    <asp:DataPoint YValues="5" />
                    <asp:DataPoint YValues="6" />
                    <asp:DataPoint YValues="7" />
                    <asp:DataPoint YValues="8" />
                </Points>
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="CA_kPI" BorderWidth="2"></asp:ChartArea>
        </ChartAreas>
        <Titles>
            <asp:Title Name="PSP Team KPI">
            </asp:Title>
        </Titles>
    </asp:Chart>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
</asp:Content>
