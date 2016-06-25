using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.DataVisualization;
using System.Windows.Forms.DataVisualization.Charting;

namespace KPISystem
{
    public partial class chartKPI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Chart1.Series["Series_kPI"].Points.AddXY("1", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("2", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("3", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("4", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("5", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("6", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("7", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("8", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("9", 33);
            this.Chart1.Series["Series_kPI"].Points.AddXY("10", 33);
        }

        protected void Chart1_Load(object sender, EventArgs e)
        {

        }
    }
}