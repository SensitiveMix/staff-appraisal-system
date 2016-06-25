using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;
using Model;

namespace KPISystem
{
    public partial class WeeklyMeeting : BasePage
    {
        DateTime dt = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, 9, 30, 0);  //DateTime.Parse("3/15/2013 15:00");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string time = dt.ToString("yyyy-MM-dd HH:mm");
                if (Request.QueryString["time"] != null)
                {
                    time = Request.QueryString["time"];
                    dt = DateTime.Parse(time);
                    if (Request.QueryString["flag"] == null || Request.QueryString["flag"].ToString().ToLower() != "view")
                    {
                        BLMeeting bm = new BLMeeting();
                        if (bm.IsMeetingExists(dt))
                        {
                            this.MeetingTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                            btnSubmit.Visible = false;
                            btnReset.Visible = false;
                            Div1.Visible = false;
                            lblWarning.Visible = true;
                            user.Visible = false;
                            lblWarning.Text = "<span class=\"label\"><br /><br />The meeting which start time is " + dt.ToString("yyyy-MM-dd HH:mm") + " is already exists.</span>";
                            smail.Visible = false;
                            return;
                        }
                        else
                        {
                            Div1.Visible = true;
                            lblWarning.Visible = false;
                            btnSubmit.Visible = true;
                            btnReset.Visible = true;
                            user.Visible = true;

                        }

                    }
                }
                setSession(time);
                BindDate();
                smail.Visible = !btnSubmit.Visible;
            }

        }

        #region Bind Data
        void BindDate()
        {
            BindHosters();
            BLMeeting blMeeting = new BLMeeting();
            MWeeklyMeeting m = blMeeting.CreateMeeing(dt);

            ViewState["meeting"] = m;
            ViewState["Users"] = m.MeetingUsers;

            this.MeetingTime = m.StartTime;
            this.MeetingTitle = m.Title;
            ddlHoster.SelectedValue = m.HosterId.ToString();
            ddlNextHoster.SelectedValue = m.OperaterId.ToString();


            gvUsers.DataSource = m.MeetingUsers;
            gvUsers.DataBind();

            gvScore.DataSource = m.DetailScore;
            gvScore.DataBind();
            if (Request.QueryString["flag"] != null && Request.QueryString["flag"].ToString() == "View")
                SetControlsReadOnly();
        }

        void BindHosters()
        {
            BLUsers user = new BLUsers();
            var list = user.GetAllHosters();
            ddlHoster.DataSource = list;
            ddlHoster.DataBind();

            ddlNextHoster.DataSource = list;
            ddlNextHoster.DataBind();
        }

        void BindUsers()
        {
            gvUsers.DataSource = ((List<MUser>)ViewState["Users"]);
            gvUsers.DataBind();
        }

        #endregion

        protected void gvUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvUsers.PageIndex = e.NewPageIndex;
            BindUsers();
            setSession(this.MeetingTime);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            BindDate();
            setSession(this.MeetingTime);
        }

        string time = "";
        public string MeetingTime
        {
            get
            {

                for (int i = 0; i < Request.Form.Count; i++)
                {
                    if (Request.Form.Keys[i].ToString().Contains("time1"))
                        time = Request.Form[i];
                }
                return time;
            }
            set
            {
                time = value;
            }
        }

        public string WeekIndex { get; set; }

        public string MeetingTitle { get; set; }

        public string LinkString
        {
            get
            {
                //var users = new string[] { "v-jinhta@microsoft.com", "v-keyuan@microsoft.com", "v-peaxia@microsoft.com", "v-pixie@microsoft.com", "v-wenli@microsoft.com", "v-lic@microsoft.com", "v-haiyan@microsoft.com" };
                if (ViewState["Users"] != null)
                {
                    var users = (ViewState["Users"] as List<MUser>).Select(m => m.Email).ToArray();
                    string toUser = string.Join(";", users);
                    string html = "mailto:" + toUser + @"?subject=" + this.MeetingTitle + "&body=\r\n";
                    return html;
                }
                else
                {
                    smail.Visible = false;
                    return "";
                }
            }
        }

        void CheckInput()
        {
            DateTime dtStart;
            if (!DateTime.TryParse(MeetingTime, out dtStart))
            {
                Alert("start time is null or not time formate.");
                return;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            CheckInput();
            var meet = (MWeeklyMeeting)ViewState["meeting"];
            this.MeetingTitle = "Weekly task review " + this.MeetingTime;
            meet.Title = MeetingTitle;
            meet.Start = DateTime.Parse(MeetingTime);
            meet.HosterId = Convert.ToInt32(ddlHoster.SelectedValue);
            meet.OperaterId = Convert.ToInt32(ddlNextHoster.SelectedValue);
            meet.MeetingUsers = ViewState["Users"] as List<MUser>;
            var detail = gvScore.Rows.Cast<GridViewRow>()
                                .Select(r => new MeetingScore
                                            {
                                                CriteriaID = int.Parse(r.Cells[0].Text),
                                                Score = double.Parse(((DropDownList)r.FindControl("ddlScore")).SelectedValue),
                                            });
            meet.End = DateTime.Now;
            meet.DetailScore = detail.ToList();
            meet.Status = MeetingStatus.Submit;
            meet.WeekIndex = int.Parse(meet.Start.ToString("yyyyMMdd"));
            BLMeeting bm = new BLMeeting();
            if (meet.MeetingID > 0)
                bm.UpdateMeeting(meet);
            else
            { 
                bm.CreateMeeing(meet);
            }
            SetControlsReadOnly();
            setSession(this.MeetingTime);

        }

        void SetControlsReadOnly()
        {
            ddlHoster.Visible = false;
            lblHoster.Visible = true;
            lblHoster.Text = ddlHoster.SelectedItem.Text;
            ddlNextHoster.Visible = false;
            lblNextHoster.Visible = true;
            lblNextHoster.Text = ddlNextHoster.SelectedItem.Text;
            divTime.Visible = false;
            divTime.Style["Display"] = "None";
            lblMeetingTime.Text = MeetingTime;
            lblMeetingTime.Visible = true;
            btnReset.Visible = false;
            btnSubmit.Visible = false;
            //btnSendEmail.Visible = true;

            gvScore.HeaderRow.Cells[0].Visible = false;
            lblTotal.Visible = true;
            double total = 0;
            foreach (GridViewRow row in gvScore.Rows)
            {
                DropDownList ddl = row.FindControl("ddlScore") as DropDownList;
                Label lbl = row.FindControl("lblScore") as Label;
                if (ddl != null)
                {
                    ddl.Visible = false;
                    lbl.Visible = true;
                    lbl.Text = string.Format(" {0} 分", ddl.SelectedValue);
                    total += double.Parse(ddl.SelectedValue);
                }
                row.Cells[0].Visible = false;
            }
            lblTotal.Text = string.Format("Total: {0} 分", total);
            gvUsers.AllowPaging = false;
            BindUsers();
            gvUsers.HeaderRow.Cells[3].Visible = false;
            foreach (GridViewRow row in gvUsers.Rows)
            {
                row.Cells[3].Visible = false;
            } 
            smail.Visible = !btnSubmit.Visible;

        }

        void setSession(string time)
        {
            //int weekindex = BaseClass.GetWeekIndex(DateTime.Parse(time));
            WeekIndex = DateTime.Parse(time).ToString("yyyyMMdd"); //string.Format("{0}{1}", DateTime.Now.Year, weekindex.ToString().PadLeft(2, '0'));
            Session["startWeek"] = WeekIndex;
            Session["endWeek"] = WeekIndex;
        }

        protected void gvScore_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            var ddl = e.Row.FindControl("ddlScore") as DropDownList;
            if (ddl != null)
            {
                var meet = (MWeeklyMeeting)ViewState["meeting"];
                var score = meet.DetailScore.ToList()[e.Row.RowIndex].Score;
                ddl.SelectedValue = ((int)score).ToString();
            }
        }

        protected void lbtnRemove_Click(object sender, EventArgs e)
        {
            var users = ViewState["Users"] as List<MUser>;
            GridViewRow row = ((sender as LinkButton).Parent.Parent) as GridViewRow;
            int userID = int.Parse(row.Cells[0].Text);
            users.Remove(users.Single(u => u.ID == userID));
            ViewState["Users"] = users;
            BindUsers();
            setSession(this.MeetingTime);
        }

        protected void lbtnOutlookMeeting_Click(object sender, EventArgs e)
        {
            var meet = (MWeeklyMeeting)ViewState["meeting"];
            var toUserEmail = meet.MeetingUsers.Where(u => u.ID != meet.HosterId).Select(m => m.Email).ToList();
            EmailHelper.CreateOutlookMeetingRequest(toUserEmail, meet.Start);
        }
    }
}