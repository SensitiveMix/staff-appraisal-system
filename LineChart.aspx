<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LineChart.aspx.cs" Inherits="KPISystem.LineChart" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2" Height="353px" OnLoad="Chart1_Load" Width="685px">
            <Series>
                <asp:Series Name="Series1" ChartType="Line"></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    
    </div>
    </form>
</body>
</html>
