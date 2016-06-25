<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="TeamKPIRule.aspx.cs" Inherits="KPISystem.TeamAPIRule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 140px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <script src="Scripts/jquery.boxy.js"></script>
    <section class="featured">
        <div class="content-wrapper">
            <table style="width: 100%">
                <tr>
                    <td>
                        <hgroup class="title">
                            <h1>
                                <label id="mtitle">Team KPI Rule</label>
                            </h1>
                        </hgroup>
                    </td>
                </tr>
            </table>

        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="Styles/RuleAdd.css" />
    <section class="rulefeatured">
        <div class="div_content">
            <p>
                <strong>目的 :</strong>&nbsp;公平，公开，公正 的用于组内成员的加薪及年终奖计算
            </p>
            <ol>
                <li>月度KPI：<a href="http://hw-zanl-03/KPI.aspx?m=<%=DateTime.Now.ToString("MM")%>" target="_blank" class="li_Month">http://hw-zanl-03/KPI.aspx?m=<%=DateTime.Now.ToString("MM") %></a>
                </li>
                <li>年度KPI：<a href="http://hw-zanl-03/TeamKPI.aspx " target="_blank" class="li_Year">http://hw-zanl-03/TeamKPI.aspx</a>
                </li>
            </ol>
        </div>
        <div class="div_tableDetail">
            <p>
                <strong>详细规则：
                </strong>
            </p>
            <table class="table_style">
                <tbody>
                    <tr class="tr_one">
                        <th class="trth_one">KPI考核标准</th>
                        <th class="trth_two">所占比重</th>
                        <th class="trth_third">备注</th>
                    </tr>
                    <tr>
                        <td rowspan="1" class="trth2_one">TFS Workload</td>
                        <td class="trth2_two">50% </td>
                        <td class="trth2_third" colspan="2">取总人数的前30%的人，计3分,<br />
                            后30%的人得1分，<br />
                            中间40%的人得2分.<br />
                            目前我们有7个人，也就是:<br />
                            前1-2名得3分，<br />
                            第3-5名得2分，<br />
                            第6-7名得1分，<br />
                            <br />
                            KPI计算方式是: workload得分*50%
                        </td>

                    </tr>
                    <tr>
                        <td class="trth3_one">Team Contribution
                            <br />
                            (培训，流程改进等）<br />
                            <a href="onenote:#Contribution%20Rule&section-id={4B562D84-355F-41E6-9411-E29C58628E10}&page-id={E1725F2A-EE24-493F-A1D1-8DE0BB663D2F}&end&base-path=hw-zanl-03\WUXI-ECO\PSP_Shared\OneNotes\PSP_Project\Team.one" class="td_contribution">Contribution Rule</a>
                        </td>
                        <td class="trth3_two">20%</td>
                        <td class="trth3_third">1个文档算一分<br />
                            3个以上算三分
                            <br />
                            <br />
                            KPI计算方式是:  团队贡献得分*20%
                        </td>
                    </tr>
                    <tr>
                        <td class="trth4_one">Work Performance(相互打分)</td>
                        <td class="trth4_two">15% </td>
                        <td class="trth4_third">工作表现满分是3分<br />
                            <br />
                            KPI计算方式是:工作表现平均分*15%</td>
                    </tr>

                    <tr>
                        <td class="trth5_one"><a class="td_meeting" href="onenote:#Weekly%20Meeting&section-id={4B562D84-355F-41E6-9411-E29C58628E10}&page-id={47B394A5-EABA-46BC-9004-FD919943DBFE}&end&base-path=hw-zanl-03\WUXI-ECO\PSP_Shared\OneNotes\PSP_Project\Team.one">Weekly Meeting</a></td>
                        <td class="trth5_two">15%</td>
                        <td class="trth5_third">Weekly meeting 满分是3分
                            <br />
                            <br />
                            KPI计算方式是:   Weekly meeting 平均分*15%</td>
                    </tr>

                </tbody>
            </table>
            <p class="bottom_note"><strong>备注：</strong></p>
            <p class="note_text"><u>加强每个Task时间的把控,单个任务不允许超过<strong> 8 </strong>个小时</u></p>
        </div>
    </section>
</asp:Content>
