using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;

namespace KPISystem
{
    public partial class KPI : System.Web.UI.Page
    {
        int year = DateTime.Now.Year;
        int month = DateTime.Now.Month;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["m"] != null)
                {
                    month = int.Parse(Request.QueryString["m"]);
                }

                if (Session["login_user"] != null)
                {
                    string username = Session["login_user"].ToString().Trim();
                    BLUsers user = new BLUsers();
                    if (user.GetGroupID(username) == 1)
                    {
                        lbtnKPI.Visible = true;
                        LBAdd.Visible = true;
                    }
                }

                if (!IsAdmin)
                {
                    
                }

                BLUserKPI bk = new BLUserKPI();
                var week = bk.GetMonthWeek(year, month);

                Session["startWeek"] = week.StartWeek;
                Session["endWeek"] = week.EndWeek;
                // this.CharTitle = string.Format("{0}.{1} KPI",year,month) ;// Server.HtmlDecode(string.Format("Weekly {0}-{1},{2}-{3}", week.StartWeek, week.EndWeek, week.StartDate.ToString("M/dd/yyyy"), week.EndDate.ToString("M/dd/yyyy")));
                BindMeeting();
                BindWorkPerformance();
                BindTeamContribution();
                judgeStatus();
            }
        }

        public bool IsAdmin { get { return Session["IsAdmin"] == null ? false : Convert.ToBoolean(Session["IsAdmin"]); } }

        public string CharTitle { get; set; }

        public string MonthIndex
        {
            get
            {
                return string.Format("{0}.{1}", year.ToString(), month.ToString().PadLeft(2, '0'));
            }
        }

        void BindMeeting()
        {
            BLMeeting bm = new BLMeeting();
            gvMeeting.DataSource = bm.GetAllMeetings(year, month);
            gvMeeting.DataBind();
        }
        void BindWorkPerformance()
        {
            BLWorkPerformance bw = new BLWorkPerformance();
            gvWorkPerformance.DataSource = bw.GetReport(year, month);
            gvWorkPerformance.DataBind();
        }

        void BindTeamContribution()
        {
            BLTeamContribution bt = new BLTeamContribution();
            gvContribution.DataSource = bt.GetTeamContribution(year, month);
            gvContribution.DataBind();
        }

        /// <summary>
        /// Get Group ID by Current User
        /// Admin:1  User:2  Guest:3
        /// </summary>
        /// <returns></returns>
        public int GroupID()
        {
           // string userName = Page.User.Identity.Name.Replace("FAREAST\\", "");
            string username = Session["login_user"].ToString().Trim();
            Session["user"] = username;
            BLUsers bu = new BLUsers();
            var r = bu.CheckUser(username);
            return r;
        }

        /// <summary>
        /// only Admin can add Month KPI
        /// </summary>
        public void judgeStatus()
        {
            var r = GroupID();
            if (r.Equals(1))
            {
                //LBAdd.Visible = true;
            }
            else
            {
               // LBAdd.Visible = false;
            }
        }

        /// <summary>
        /// Add month KPI into database
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["m"] != null)
            {
                month = int.Parse(Request.QueryString["m"]);
            }
            var kpiData = BaseClass.GetMonthlyKPI(year, month);
            BaseClass bl = new BaseClass();
            bool kpiIsOrNotExist = bl.checkKpi(month, year);
            var r = GroupID();
            if (kpiIsOrNotExist == true && r.Equals(1))
            {
                bl.InsertKpi(kpiData);
                this.Response.Write("<script>alert('Add Successfully！');window.window.location.href='KPI.aspx';</script>");
            }
            else
            {
                this.Response.Write("<script>alert('Month KPI has exist！');location='javascript:history.go(-1)';</script>");
            }

        }

        protected void lbtnManage_Click(object sender, EventArgs e)
        {
            Response.Redirect("Manage.aspx");
        }

    }
}