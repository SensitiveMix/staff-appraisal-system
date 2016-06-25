using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;

namespace KPISystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public void login(object sender, EventArgs e)
        {
            var Account = account.Value.ToString().Trim();
            var PassWord = pwd.Value.ToString().Trim();
            var codes = code.Value.ToString().Trim();

            BLUsers blUser = new BLUsers();

            if (blUser.UserIsOrExist(Account, PassWord) && codes != "" && Account != "" && PassWord != "")
            {
                Session["user"] = "Fareast\\" + Account;
                Session["login_user"] = Account;
                this.Response.Write("<script>alert('Login Success!');</script>");
                Response.Redirect(string.Format("KPI.aspx?user={0}", Account));
            }
            else
            {
                Page.RegisterStartupScript("ggg", " <script>check('" + codes + "'); </script>");
            }

        }
    }
}