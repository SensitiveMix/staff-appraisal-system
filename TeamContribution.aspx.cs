using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLKPI;
using System.Collections;

namespace KPISystem
{

    public partial class TeamContribution : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["login_user"] != null)
                {
                    string username = Session["login_user"].ToString().Trim();
                    BLUsers user = new BLUsers();
                    if (user.GetGroupID(username) == 1)
                    {
                        b.Visible = true;
                    }
                }

                ListType();
                Bind();
                TB_date.Text = DateTime.Now.ToString("yyyy-MM-01");
                TB_dateLater.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }

        }


        #region Dynamic binding typeEnum to droplist
        /// <summary>
        /// Define type enum
        /// </summary>
        public enum typeStatus
        {
            ALL = 0,
            Document = 1,
            Video = 2,
            Training = 3,
            others = 4

        }

        /// <summary>
        /// Define type_Droplist attribute
        /// </summary>
        private void ListType()
        {
            DDL_type.Items.Clear();
            DDL_type.DataSource = ListTypeForEnum();
            DDL_type.DataValueField = "value";
            DDL_type.DataTextField = "text";
            DDL_type.DataBind();
        }

        /// <summary>
        /// Dynamic Binding enum to typedroplist
        /// </summary>
        /// <returns></returns>
        public static IList ListTypeForEnum()
        {
            ArrayList list = new ArrayList();
            foreach (int i in Enum.GetValues(typeof(typeStatus)))
            {
                ListItem listitem = new ListItem(Enum.GetName(typeof(typeStatus), i), i.ToString());
                list.Add(listitem);
            }
            return list;
        }

        #endregion



        /// <summary>
        /// Paging
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void GridViewRowIndexChange(object sender, GridViewPageEventArgs e)
        {
            gvTeamContributions.PageIndex = e.NewPageIndex;
            //Bind DataSource
            Search_Click(null, null);
        }

        void Bind()
        {
            BLTeamContribution bt = new BLTeamContribution();
            gvTeamContributions.DataSource = bt.GetTeamContribution();
            gvTeamContributions.DataBind();
        }
        /// <summary>
        /// View Function btn
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public void lbtnTeamContributionInfo_Click(object sender, EventArgs e)
        {
            string resumeId = (((LinkButton)sender).CommandArgument.ToString());
            Response.Redirect(string.Format("TeamContributionDetail.aspx?id={0}", resumeId));
        }


        /// <summary>
        /// Search Function
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Search_Click(object sender, EventArgs e)
        {
            var Title = TB_title.Text.Trim();
            var Type = DDL_type.SelectedItem.Text.ToString();
            var AddBy = TB_user.Text.Trim();
            var BeginDate = TB_date.Text.Trim();
            var EndDate = TB_dateLater.Text.Trim();
            if (string.Compare(Type.ToUpper(), "ALL") == 0)
            {
                Type = "";
            }
            BLTeamContribution bt = new BLTeamContribution();
            gvTeamContributions.DataSource = bt.GetTeamContribution(AddBy, Type, Title, BeginDate, EndDate);
            gvTeamContributions.DataBind();
        }

    }
}