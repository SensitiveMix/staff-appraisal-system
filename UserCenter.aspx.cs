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
    public partial class UserCenter : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                {
                    BLUsers user = new BLUsers();
                    int UserId = 0;
                    int.TryParse(Request.QueryString["ID"], out UserId);
                    var viewUserItem = user.GetSingeUserInfo(UserId);
                    if (UserId == 0)
                    {
                        this.Response.Write("<script>alert('User not exist！');window.open('TeamContribution.aspx')</script>");
                    }
                    else
                    {
                        foreach (var item in viewUserItem)
                        {
                            tb_name.Text = item.Name;
                            tb_name.Enabled = false;


                            tb_RealName.Text = item.RealName;
                            tb_RealName.Enabled = false;

                            tb_Email.Text = item.Email;
                            tb_Email.Enabled = false;

                            register.Value = item.RegisterTime.ToString("yyyy-MM-dd");
                            register.Disabled = true;

                            tb_lastLogin.Text = item.LastLogin.ToString("yyyy-MM-dd");
                            tb_lastLogin.Enabled = false;

                            ddl_group.SelectedIndex = item.group_id - 1;
                            ddl_group.Enabled = false;

                            ddl_status.SelectedIndex = item._status;
                            ddl_status.Enabled = false;

                            if (item._status == 1)
                            {
                                MemoTB.Text = item.LoginMachine;
                                MemoTB.Enabled = false;
                                memo.Visible = true;
                                MemoTB.Visible = true;
                            }
                        }
                    }
                }
                // Bind();
            }

        }


        protected void btn_ManageCilck(object sender, EventArgs e)
        {
            tb_name.Enabled = true;
            tb_RealName.Enabled = true;
            tb_Email.Enabled = true;
            register.Disabled = false;
            tb_lastLogin.Enabled = true;
            ddl_group.Enabled = true;
            ddl_status.Enabled = true;
            MemoTB.Enabled = true;
            this.manage.Text = "Save";
            if (this.manage.Text=="Save")
            {
                save();
            }

        }

        void save()
        {
            MUser user = new MUser();
            user.ID = int.Parse(Request.QueryString["ID"]);

            user.Name = tb_name.Text.ToString().Trim();
            user.RealName = tb_RealName.Text.ToString().Trim();
            user.Email = tb_Email.Text.ToString().Trim();

            DateTime dtDate = DateTime.Now;
            DateTime.TryParse(register.Value, out dtDate);
            user.RegisterTime = dtDate;

            DateTime dtLastLogin = DateTime.Now;
            DateTime.TryParse(register.Value, out dtLastLogin);
            user.LastLogin = dtLastLogin;

            user._status = ddl_status.SelectedIndex;

            user.group_id = ddl_group.SelectedIndex + 1;

            user.LoginMachine = MemoTB.Text.ToString().Trim();

            BLUsers blUser = new BLUsers();

            if (blUser.ModifyUserInfo(user))
            {
                //this.Response.Write("<script>alert('修改成功！');window.location.href='UserCenter.aspx';</script>");
            }
        }


        protected void btn_CloseCilck(object sender, EventArgs e)
        {
            this.manage.Text = "Manage";
            Response.Redirect("manage.aspx");
        }


        //void Bind()
        //{
        //    ddlYear.DataSource = Enumerable.Range(1, 10).Select(y => (DateTime.Now.Year - 2) + y).ToList();
        //    ddlYear.DataBind();
        //    ddlYear.SelectedValue = DateTime.Now.Year.ToString();

        //    ddlMonth.DataSource = Enumerable.Range(1, 12).ToList();
        //    ddlMonth.DataBind();
        //    ddlMonth.SelectedValue = Session["month"] == null ? DateTime.Now.Month.ToString() : Session["month"].ToString();

        //    BindReprot();
        //}

        //void BindReprot()
        //{
        //    BLWorkPerformance bw = new BLWorkPerformance();
        //    var LoginUser = Session["user"] == null ? "" : Session["user"].ToString();
        //    GridView1.DataSource = bw.GetReport(LoginUser, int.Parse(ddlYear.SelectedValue), int.Parse(ddlMonth.SelectedValue));
        //    GridView1.DataBind();
        //}


        #region DDL Index
        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            // BindReprot();
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            //BindReprot();
        }

        #endregion
    }

}
