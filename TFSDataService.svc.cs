using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using BLKPI;
using Model;
using TFSClassLibrary;
using System.Web;

namespace KPISystem
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class TFSDataService
    {
        [OperationContract]
        public List<TFSData> GetTfsData()
        {
            try
            {
                return BaseClass.GetTfsData();
            }
            catch (Exception ex)
            {
                BasePage.WriteLog(ex.ToString());
                throw;
            }
        }

        [OperationContract]
        public List<MonthlyKPIData> GetMonthlyKPI(int year, int month)
        {
            return BaseClass.GetMonthlyKPI(year, month);
        }

        [OperationContract]
        public List<MKPI> GetYearlyKPI(int year)
        {
            BLUserKPI bk = new BLUserKPI();
            return bk.GetUserKPIDateForChart(year);
        }
    }
    [DataContract]
    public class TFSData
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public double Estimate { get; set; }
        [DataMember]
        public double CompleteWork { get; set; }
        [DataMember]
        public double WorkLoad { get; set; }
    }
    [DataContract]
    public class MonthlyKPIData
    {
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public double Score { get; set; }
        [DataMember]
        public int Rank { get; set; }
        [DataMember]
        public int Year { get; set; }
        [DataMember]
        public int Month { get; set; }

    }

}