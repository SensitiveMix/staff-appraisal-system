using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;

namespace KPISystem
{
    public partial class AllMeetings : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeetings();
            }
        }

        void BindMeetings()
        {
            BLMeeting bm = new BLMeeting();
            gvMeeting.DataSource = bm.GetAllMeetings();
            gvMeeting.DataBind();
            if (!IsAdmin)
            {
                if (gvMeeting.HeaderRow != null)
                    gvMeeting.HeaderRow.Cells[gvMeeting.HeaderRow.Cells.Count - 1].Visible = false;
                foreach (GridViewRow item in gvMeeting.Rows)
                {
                    item.Cells[item.Cells.Count - 1].Visible = false;
                }
            }
        }

        protected void gvMeeting_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMeeting.PageIndex = e.NewPageIndex;
            BindMeetings();
        }

        protected void lbtnOperateMeeting_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = sender as LinkButton;
            GridViewRow row = lbtn.Parent.Parent as GridViewRow;
            string time = row.Cells[2].Text;
            string meetingId = row.Cells[0].Text;
            Response.Redirect(string.Format("WeeklyMeeting.aspx?time={0}&flag={1}&id=", time, lbtn.Text, meetingId));
        }


        public bool IsAdmin { get { return Session["IsAdmin"] == null ? false : Convert.ToBoolean(Session["IsAdmin"]); } }

        protected void lbtnDeleteMeeting_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = sender as LinkButton;
            GridViewRow row = lbtn.Parent.Parent as GridViewRow;
            int meetingId = int.Parse(row.Cells[0].Text);
            BLMeeting bm = new BLMeeting();
            if (bm.DeleteMeeting(meetingId))
                BindMeetings();
            else Alert("Delete meeting failed.");
        }

        protected void gvMeeting_DataBound(object sender,GridViewRowEventArgs e)
        {
            if(e.Row.RowType==DataControlRowType.DataRow)
            {
              //  e.Row.Cells[0].Visible = false;
            }
        }
    }
}