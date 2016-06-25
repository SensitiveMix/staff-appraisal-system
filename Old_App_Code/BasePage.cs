using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace KPISystem
{
    public class BasePage : Page
    {
        public void Alert(string msg)
        {
            if (!string.IsNullOrEmpty(msg))
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert(" + msg + ");", true);
        }

        public void AlertAndRedict(string msg, string url)
        {
            if (!string.IsNullOrEmpty(msg))
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "alert(" + msg + ");window.location='" + url + "';", true);
        }
        public static void WriteLog(string log)
        {
            try
            {
                File.WriteAllText("c:\\kpilog" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".txt", log);
            }
            catch
            {

            }

        }


    }
}