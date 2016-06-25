using BLKPI;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KPISystem
{
    public partial class WorkPerformance : BasePage
    {
        string month = DateTime.Now.Month.ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["month"] != null)
                {
                    month = Request.QueryString["month"].ToString();
                    Session["month"] = month;
                }
                InitPage();
            }
        }

        void InitPage()
        {
            ddlYear.DataSource = Enumerable.Range(1, 10).Select(y => (DateTime.Now.Year - 2) + y).ToList();
            ddlYear.DataBind();
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();

            ddlMonth.DataSource = Enumerable.Range(1, 12).ToList();
            ddlMonth.DataBind();

            ddlMonth.SelectedValue = month;
            Bind();
        }

        void Bind()
        {
            BLUsers user = new BLUsers();
            var LoginUser = Session["user"] == null ? Page.User.Identity.Name : Session["user"].ToString();
            gvWorkPerformance.DataSource = user.GetUnScoreUser(LoginUser, int.Parse(ddlYear.SelectedValue), int.Parse(ddlMonth.SelectedValue));

            gvWorkPerformance.DataBind();
            btnSubmit.Enabled = gvWorkPerformance.Rows.Count > 0;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            BLUsers user = new BLUsers();
            var LoginUser = Session["user"] == null ? Page.User.Identity.Name : Session["user"].ToString();
            var currentUserId = user.GetUserId(LoginUser);
            var list = gvWorkPerformance.Rows.OfType<GridViewRow>().Select(row => new MWorkPerformance
            {
                UserID = int.Parse(row.Cells[0].Text),
                OperateUserID = currentUserId,
                Month = int.Parse(ddlMonth.SelectedValue),
                Year = int.Parse(ddlYear.SelectedValue),
                Score = float.Parse((row.FindControl("ddl") as DropDownList).SelectedValue)
            }).ToList();
            BLWorkPerformance bw = new BLWorkPerformance();
            if (bw.InsertScore(list))
              //  Response.Redirect("UserCenter.aspx");
                this.Response.Write("<script>alert('打分成功！');window.location.href='WorkPerformance.aspx';</script>");
            else Alert("failed.");

        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind();
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            Bind();
            Session["month"] = ddlMonth.SelectedValue;
        }
    }
}