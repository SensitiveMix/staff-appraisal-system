using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KPISystem
{
    public partial class LineChart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public chartCount()
        {
            LineChart chart=new LineChart();

        }

        protected void chartKpi_Load(object sender, EventArgs e)
        {
            Chart1.Titles="KPI Chart";
            
        }
    }
}