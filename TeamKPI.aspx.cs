using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using BLKPI;

namespace KPISystem
{
    public partial class TeamKPI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
           
                InitPage();
                BindKPI();
            }
        }

        //Init DDL year and month value
        void InitPage()
        {
            ddlYear.DataSource = Enumerable.Range(1, 10).Select(y => (DateTime.Now.Year - 2) + y).ToList();
            ddlYear.DataBind();
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();

            ddlBeginMonth.DataSource = Enumerable.Range(1, 12).ToList();
            ddlBeginMonth.DataBind();

            ddlEndMonth.DataSource = Enumerable.Range(1, 12).ToList();
            ddlEndMonth.DataBind();

            GetLatestMonth();
        }

        void BindKPI()
        {
            BLUserKPI bk = new BLUserKPI();
            gvKPI.DataSource = bk.GetAllUserKPIDate(DateTime.Now.Year);
            gvKPI.DataBind();
        }


        protected void lbtnKPI_Click(object sender, EventArgs e)
        {
            Response.Redirect("KPI.aspx?m=" + DateTime.Now.Month);
        }

        /// <summary>
        /// Paint Line Chart
        /// </summary>
        /// <param name="User_Id"></param>
        /// <param name="user"></param>
        public void paintLineChart(int User_Id, string user)
        {
            BLUserKPI k = new BLUserKPI();

            var userNumber = k.GetUser().ToString();

            this.KPIChart.ChartAreas["ChartArea1"].AxisY.Maximum = int.Parse(userNumber) + 2;
            this.KPIChart.ChartAreas["ChartArea1"].AxisY.IsReversed = true;
            this.KPIChart.ChartAreas["ChartArea1"].AxisX.Enabled = AxisEnabled.False;
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Enabled = AxisEnabled.True;
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Maximum = int.Parse(ddlEndMonth.SelectedValue);
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Minimum = int.Parse(ddlBeginMonth.SelectedValue);
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Interval = 1;
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Title = "Month";
            this.KPIChart.Series[user].XAxisType = AxisType.Secondary;

            var lineKPI = k.GetSingeleKpi(User_Id, int.Parse(ddlYear.SelectedValue));

            foreach (var i in lineKPI)
            {
                this.KPIChart.Series[user].Points.AddXY(i.Month, i.Rank);
            }

        }


        //KPIChart Load
        public void KPIChart_Load(object sender, EventArgs e)
        {
            BLUserKPI k = new BLUserKPI();
            var userIdAndName = k.GetUserIdAndUserName();
            paintSeries();
            foreach (var item in userIdAndName)
            {
                paintLineChart(item.ID, item.Name.ToString());
            }


        }

        void paintSeries()
        {
            BLUserKPI k = new BLUserKPI();

            var userIdAndName = k.GetUserIdAndUserName();

            foreach (var item in userIdAndName)
            {
                Series _series = new Series();
                _series.BorderWidth = 2;
                _series.ChartArea = "ChartArea1";
                _series.ChartType = SeriesChartType.Line;
                _series.Legend = "Legend1";
                _series.MarkerStyle = MarkerStyle.Star4;
                _series.ToolTip = "#SERIESNAME   Rank:#VAL";
                _series.Name = item.Name.ToString();
                this.KPIChart.Series.Add(_series);
            }
        }

        //Get Start and end Month by database exist data
        void GetLatestMonth()
        {
            BLUserKPI k = new BLUserKPI();

            var StartMonth = k.GetStartMonth(int.Parse(ddlYear.SelectedValue));
            var EndMonth = k.GetEndMonth(int.Parse(ddlYear.SelectedValue));


            ddlBeginMonth.SelectedValue = StartMonth == null ? "1" : StartMonth.Month.ToString();
            ddlEndMonth.SelectedValue = EndMonth == null ? "12" : EndMonth.Month.ToString();
        }



        #region ddl SelectedIndexChanged event
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            BLUserKPI k = new BLUserKPI();
            if (k.GetTotalMonth(int.Parse(ddlYear.SelectedValue)) < 1)
            {
                ddlBeginMonth.SelectedValue = "1";
                ddlEndMonth.SelectedValue = "12";
            }
            else
            {
                GetLatestMonth();
            }

            //Change by ddlyear.selectValue(AxixX2 range)
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Maximum = int.Parse(ddlEndMonth.SelectedValue);
            this.KPIChart.ChartAreas["ChartArea1"].AxisX2.Minimum = int.Parse(ddlBeginMonth.SelectedValue);

        }


        protected void ddlBeginMonth_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void ddlEndMonth_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        #endregion
    }
}