using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;

namespace KPISystem
{
    public partial class TeamContributionDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    BLTeamContribution bt = new BLTeamContribution();
                    int TeamContributionId = 0;
                    int.TryParse((Request.QueryString["id"]), out TeamContributionId);
                    var viewItem = bt.GetTeamContributionDescripution(TeamContributionId);
                    if (TeamContributionId == 0)
                    {
                        this.Response.Write("<script>alert('您查询的信息有误，请重新查询！');window.open('TeamContribution.aspx')</script>");
                    }
                    else
                    {
                        //Bind title
                        txtTitle.Text = viewItem.Title;
                        txtTitle.Enabled = false;
                        //Bind Description
                        txtDescription.Text = viewItem.Description;
                        txtDescription.Enabled = false;
                        //Bind Date
                        txtDate.Value = viewItem.Date;
                        txtDate.Disabled = true;
                        //Bind Type
                        ddlType.DataSource = Enum.GetNames(typeof(TeamContributionType));
                        ddlType.Width = 90;
                        ddlType.DataBind();
                        ddlType.Items.FindByValue(viewItem.Type).Selected = true;
                        ddlType.Enabled = false;
                        //Bind User
                        BLUsers bu = new BLUsers();
                        ddlUsers.DataSource = bu.GetAllUsers().ToList();
                        ddlUsers.DataBind();
                        ddlUsers.SelectedValue = viewItem.UserName;
                        ddlUsers.Enabled = false;
                        //Hide controls
                        btnAdd.Visible = false;
                        btnAddAndSave.Visible = false;
                        btnCancel1.Visible = false;
                    }
                }
                else
                {
                    txtDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
                    Bind();
                }
            }
        }


        void Bind()
        {
            ddlType.DataSource = Enum.GetNames(typeof(TeamContributionType));
            ddlType.DataBind();
            ddlType.SelectedIndex = 0;
            BLUsers bu = new BLUsers();
            ddlUsers.DataSource = bu.GetAllUsers().ToList();
            ddlUsers.DataBind();
            if (Session["user"] == null)
            {
                ddlUsers.SelectedIndex = 0;
            }
            else
            {
                ddlUsers.SelectedValue = Session["user"].ToString();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SwtchClickMethod("TeamContribution.aspx");
        }
        protected void btnAddAndSave_Click(object sender, EventArgs e)
        {
            SwtchClickMethod("TeamContributionDetail.aspx");
        }

        public void SwtchClickMethod(string url)
        {
            MTeamContribution team = new MTeamContribution();
            team.Title = txtTitle.Text;
            team.UserName = ddlUsers.SelectedItem.Text;
            team.Description = txtDescription.Text;
            DateTime dtDate = DateTime.Now;
            DateTime.TryParse(txtDate.Value, out dtDate);
            team.SubmitDate = dtDate;
            team.Type = ddlType.SelectedValue;
            team.AddBy = Page.User.Identity.Name;
            BLTeamContribution bt = new BLTeamContribution();
            if (bt.AddNewTeamContribution(team))
                Response.Redirect(url, true);
            else
                Alert("add new team contribution failed.");

        }
        protected void btn_Cancel(object sender, EventArgs e)
        {
            Response.Redirect("TeamContribution.aspx", true);
        }
    }
}