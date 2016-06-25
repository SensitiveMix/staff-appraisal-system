<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="KPI.aspx.cs" Inherits="KPISystem.KPI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!--


                                            .-....-..
                                          `--`.` ``-.-.
                                          --`/``/.+oy--`
                                    -++:---/:+`o:+-./o-`
                                 `:ydy/.````-../:+.:s+:           ......-.....
                               ./yh+-.``````.``-shyssso/+o++//:::--/hydmdmNmhy
                             .yms:....`````````````.-::--.``````..-omNNNm.
                            -mm..o:-..``./.`````````````.`.-:/+oydmmys:
                           +Nd:-::走..../.``..--://+osyhyssyhhs+:-`
                        :yhMMy-/-...-:你-+++syyhmdddhyo+-....
                       oMh+/:--.--:o/::::/:+oshd/-`
                       dN:-:-:so++o--:/osshhhys:-``
                      oNd-/soyyyhs+//+osyoo+::-:::://-
                     :Mmy+yNNNNdo-:::-..--/.```.::``oN+
                     sMmy+ymMm/-//-```.`..-......`.-.d/
                    `NNhNdyyNho-.--.-:oo+/::::+--:-.-yh
                    .@zewenzhang.+//sddhhysydm:-...-sd-
      `-:-```..--` .odhyhmNNNNNmNddmmNmdmydddo----:omo
   ...mhyyysyooyosydso.@FrankFeng.yys+- :ddo::o:/hd.
  ...NNmNd.h/-:::++/o+yymNNNmds-         ydyoo+:/sdo
  -++myhmd.s--://+oosshdNNmds.          -dy+--///dy`
  o Nm+ymNmsyhhhddmNmmmmddo.            :do-..../d+
  :+msy.s.@onlytiancai.s/              -hmMmhdmddo`
  -.@yizero.......`````              ...dmNNmmd.
  :+NNmdm+                          ...@likexian.y+.
  ``.-/:.````                      .+NNNNNNmdhhhhdmd-
                                   -.ddd.@chuangbo.-





-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">PSP Team KPI - <%=MonthIndex %></label>
                            </h1>
                        </hgroup>
                    </td>
                    <td style="text-align: right;">
                        <asp:LinkButton runat="server" Visible="false" ForeColor="Blue" ID="lbtnKPI" Text=" Manage Users " OnClick="lbtnManage_Click"></asp:LinkButton>
                    </td>
                </tr>
            </table>

        </div>
    </section>

    <style type="text/css">
        #MainContent_LBAdd:link {
            color: black;
        }

        #MainContent_LBAdd:visited {
            color: skyblue;
        }

        #MainContent_LBAdd:hover {
            color: green;
        }

        #MainContent_LBAdd:active {
            color: skyblue;
        }
    </style>

    <script type="text/javascript">
        function onSilverlightError(sender, args) {
            var appSource = "";
            if (sender != null && sender != 0) {
                appSource = sender.getHost().Source;
            }

            var errorType = args.ErrorType;
            var iErrorCode = args.ErrorCode;

            if (errorType == "ImageError" || errorType == "MediaError") {
                return;
            }

            var errMsg = "Unhandled Error in Silverlight Application " + appSource + "\n";

            errMsg += "Code: " + iErrorCode + "    \n";
            errMsg += "Category: " + errorType + "       \n";
            errMsg += "Message: " + args.ErrorMessage + "     \n";

            if (errorType == "ParserError") {
                errMsg += "File: " + args.xamlFile + "     \n";
                errMsg += "Line: " + args.lineNumber + "     \n";
                errMsg += "Position: " + args.charPosition + "     \n";
            }
            else if (errorType == "RuntimeError") {
                if (args.lineNumber != 0) {
                    errMsg += "Line: " + args.lineNumber + "     \n";
                    errMsg += "Position: " + args.charPosition + "     \n";
                }
                errMsg += "MethodName: " + args.methodName + "     \n";
            }

            throw new Error(errMsg);
        }

        function TalkToJavaScript(data) {
            var control = document.getElementById("KPItfsData");
            control.Content.TfsPage.UpdateTitle(<%=MonthIndex %> + " TFS WorkLoad");
        }

        function SetTitle(data) {
            var control = document.getElementById("kpiChart");
            control.Content.TfsPage.UpdateTitle(<%=MonthIndex %>+" Monthly KPI");
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="Div1" style="width: 100%">
        <object id="KPItfsData" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="400px">
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
    <table style="width: 100%;">
        <tr>
            <td>
                <h3>Team Contribution:</h3>
                <asp:GridView ID="gvContribution" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="GridViewStyle">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="Title" DataField="Title" />
                        <asp:BoundField HeaderText="User Name" DataField="UserName" />
                        <asp:BoundField HeaderText="Type" DataField="Type" />
                        <asp:BoundField HeaderText="SubmitDate" DataField="Date" />
                        <asp:BoundField HeaderText="Description" DataField="Description" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <h3>Meetings:</h3>
                <asp:GridView ID="gvMeeting" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="GridViewStyle">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="Title" DataField="Title" />
                        <asp:BoundField HeaderText="Start Time" DataField="StartTime" />
                        <asp:BoundField HeaderText="End Time" DataField="EndTime" />
                        <asp:BoundField HeaderText="Hoster" DataField="HosterName" />
                        <asp:BoundField HeaderText="Score" DataField="TotalScore" />
                        <asp:BoundField HeaderText="Week" DataField="WeekIndex" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <h3>Work Performance:</h3>
                <asp:GridView ID="gvWorkPerformance" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="GridViewStyle">
                    <FooterStyle CssClass="GridViewFooterStyle" />
                    <RowStyle CssClass="GridViewRowStyle" />
                    <SelectedRowStyle CssClass="GridViewSelectedRowStyle" />
                    <PagerStyle CssClass="GridViewPagerStyle" />
                    <AlternatingRowStyle CssClass="GridViewAlternatingRowStyle" />
                    <HeaderStyle CssClass="GridViewHeaderStyle" />
                    <Columns>
                        <asp:BoundField HeaderText="User Name" DataField="UserName" />
                        <asp:BoundField HeaderText="Score" DataField="Score" />
                        <asp:TemplateField HeaderText="Operate User List">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("OperateUserList") %>' ToolTip='Red color users have not scored others yet.'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:LinkButton ID="LBAdd" OnClick="btnAdd_Click" runat="server"  CssClass="float-right" Height="16px" Visible="false" Text="add into database"></asp:LinkButton>
    <div id="silverlightControlHost">
        <h3>Total KPI:</h3>
        <object id="kpiChart" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="400px">
            <param name="source" value="ClientBin/KPIDataReport.xap" />
            <param name="onError" value="onSilverlightError" />
            <param name="background" value="white" />
            <param name="minRuntimeVersion" value="5.0.61118.0" />
            <param name="autoUpgrade" value="true" />
            <param name="InitParams" value="Page=2" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=5.0.61118.0" style="text-decoration: none">
                <img src="http://go.microsoft.com/fwlink/?LinkId=161376" alt="Get Microsoft Silverlight" style="border-style: none" />
            </a>
        </object>
        <iframe id="_sl_historyFrame" style="visibility: hidden; height: 0px; width: 0px; border: 0px"></iframe>
    </div>
</asp:Content>
