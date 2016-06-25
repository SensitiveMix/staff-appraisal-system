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
    public partial class Manage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bind();
            }

        }

        protected void gv_Manage_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected void gvManage_RowDataDelete(object sender, GridViewDeleteEventArgs e)
        {
            var index = gv_Manage.DataKeys[e.RowIndex].Value.ToString();
            BLUsers bl = new BLUsers();
            bl.DeleteUser(int.Parse(index));
            bind();
        }


        //protected void lbtnKPI_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("KPI.aspx?m=" + DateTime.Now.Month);
        //}

        protected void gvManage_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int i;
            //执行循环，保证每条数据都可以更新
            for (i = 0; i <= gv_Manage.Rows.Count; i++)
            {
                //首先判断是否是数据行
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    //当鼠标停留时更改背景色
                    e.Row.Attributes.Add("onmouseover", "c=this.style.backgroundColor;this.style.backgroundColor='#00A9FF'");
                    //当鼠标移开时还原背景色
                    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=c");
                }
            }
        }


        void bind()
        {
            BLUsers bl = new BLUsers();
            gv_Manage.DataSource = bl.GetActiveUsers();
            gv_Manage.DataKeyNames = new string[] { "ID" };
            gv_Manage.DataBind();
        }

        void bindDegrade()
        {
            BLUsers bl = new BLUsers();
            gv_Manage.DataSource = bl.GetDegradeUser();
            gv_Manage.DataKeyNames = new string[] { "ID" };
            gv_Manage.DataBind();
        }

        protected void ddl_rule_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddl_rule.SelectedIndex.Equals(1))
            {
                bindDegrade();
            }
            else
            {
                bind();
            }
        }


        protected void lbtnManageInfo_Click(object sender,EventArgs e)
        {
            string resumeId = (((LinkButton)sender).CommandArgument.ToString());
            Response.Redirect(string.Format("UserCenter.aspx?ID={0}", resumeId));
        }


        protected void lbtnDeleteMeeting_Click(object sender, EventArgs e)
        {
            LinkButton lbtn = sender as LinkButton;
            GridViewRow row = lbtn.Parent.Parent as GridViewRow;
            string userName = row.Cells[0].Text;
            BLMeeting bm = new BLMeeting();
            if (bm.DeleteUser(userName))
                bind();
            
        }


        protected void btn_SaveCilck(object sender, EventArgs e)
        {
            MUser user = new MUser();
            user.Name = tb_name.Text.ToString().Trim();
            user.RealName = tb_RealName.Text.ToString().Trim();
            user.Email = tb_Email.Text.ToString().Trim();

            DateTime dtDate = DateTime.Now;
            DateTime.TryParse(register.Value, out dtDate);
            user.RegisterTime = dtDate;
            user._status = 1;
            user.group_id = ddl_group.SelectedIndex + 1;

            BLUsers blUser = new BLUsers();

            if (blUser.AddNewUser(user))
            {
                bind();
                this.Response.Write("<script>alert('Add Successfully！');window.window.location.href='Manage.aspx;</script>");
            }

        }
    }
}