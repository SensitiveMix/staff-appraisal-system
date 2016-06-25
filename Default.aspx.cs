using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;
using TFSClassLibrary;
using System.Data;
using System.Collections;

namespace KPISystem
{
    public partial class _Default : BasePage
    {
        public string LinkString
        {
            get
            {
                var users = new string[] { "v-jinhta@microsoft.com", "v-keyuan@microsoft.com", "v-peaxia@microsoft.com", "v-pixie@microsoft.com", "v-wenli@microsoft.com", "v-lic@microsoft.com", "v-haiyan@microsoft.com" };
                string toUser = string.Join(";", users);
                string html = "mailto:" + toUser + @"?subject=Test&body='Test body'";
                return html;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {



            // var t = HttpContext.Current.User.Identity.Name;
            // Alert(t);
            // Alert(Context.User.Identity.Name);
            //// Alert(Context.User.Identity.Name);
            try
            {
                //System.Data.Objects.EntityFunctions.
                //System.Data.Objects.SqlClient.SqlFunctions.da

                //TFSHelper th = new TFSHelper();
                //var buglist = th.QueryAllWorkItmes("201310", "201313");
                //var result = buglist.GroupBy(b => b.Owner)
                //                   .Select(g => new TFSData { UserName = g.Key, Estimate = g.Sum(x => x.Estimate), CompleteWork = g.Sum(x => x.CompletedWork) })
                //                   .ToList();
                BLUserKPI bk = new BLUserKPI();
                gv.DataSource = bk.GetUserKPIDateForChart(2013);
                gv.DataBind();
                //Alert(Context.User.Identity.Name);
                //BLMeeting m = new BLMeeting();
                //int s = m.GetWeekIndex(new DateTime(2013, 1, 14));
                //BLUsers buser = new BLUsers();
                //buser.GetAllUserGroup();
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert('" + s + "');", true);
            }
            catch (Exception ex)
            {
                Alert(ex.ToString());

            }

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
           // Alert("123");
            try
            {
                var users = new string[] { "v-jinhta@microsoft.com", "v-keyuan@microsoft.com", "v-peaxia@microsoft.com", "v-pixie@microsoft.com", "v-wenli@microsoft.com", "v-lic@microsoft.com", "v-haiyan@microsoft.com" };
                EmailHelper.CreateOutlookMeetingRequest(users.ToList(), new DateTime(2013,4,19,15,0,0));
            }
            catch (Exception ex)
            {
                Alert(ex.ToString());

            }
        }

        public class MyCompare : IEqualityComparer<DataRow>
        {
            public bool Equals(DataRow t1, DataRow t2)
            {
                return (t1.Field<int>("id") == t2.Field<int>("id"));
            }
            public int GetHashCode(DataRow t)
            {
                return t.ToString().GetHashCode();
            }
        }
    }
}