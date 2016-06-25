using BLKPI;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using TFSClassLibrary;
using KPIClassLibary;

namespace KPISystem
{
    public class BaseClass
    {

        KPIDbContext db = new KPIDbContext();
        public static string StartWeek { get { return HttpContext.Current.Session["startWeek"] == null ? DateTime.Now.ToString("yyyyMM01") : HttpContext.Current.Session["startWeek"].ToString(); } }
        public static string EndWeek { get { return HttpContext.Current.Session["endWeek"] == null ? DateTime.Now.ToString("yyyyMM01") : HttpContext.Current.Session["endWeek"].ToString(); } }

        public static List<TFSData> GetTfsData()
        {
            try
            {

                TFSHelper th = new TFSHelper();
                DateTime dt;
                BLUsers bl = new BLUsers();
                DateTime.TryParseExact(EndWeek, "yyyyMMdd", null, DateTimeStyles.None, out dt);

                var disableUsers = bl.GetAllDisabledUsers();

                //var buglist = th.QueryAllWorkItmesByMonth(dt.ToString("yyyyMM"));
                var buglist = th.QueryAllWorkItmes(StartWeek, EndWeek);
                var result = buglist.GroupBy(b => b.Owner).Where(x => !disableUsers.Contains(x.Key)).OrderByDescending(g => g.Sum(x => x.CompletedWork))
                                    .Select(g => new TFSData { UserName = g.Key, Estimate = g.Sum(x => x.Estimate), CompleteWork = g.Sum(x => x.CompletedWork) })
                                    .ToList();

                return result;
            }
            catch (Exception ex)
            {
                BasePage.WriteLog(ex.ToString());
                throw;
            }
        }


        /// <summary>
        /// TFS WorkLoad (50%):  Top  30% get 3 score.
        ///                      Last 30% get 1 soce.
        ///                      Others   get 2 score.
        ///                      KPI= score * 50%   
        ///                      
        /// Team Contribuitions(20%): full score : 3
        ///                      1 score for each one                       
        ///                      KPI +=  score * 20%            
        /// 
        /// Work Performance (15%): full score : 3
        ///                      KPI += score * 15%   
        ///                         
        /// Weekly Meeting(15%): Full Score:  9
        ///                      KPI += score/3 * 15%
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <returns></returns>
        public static List<MonthlyKPIData> GetMonthlyKPI(int year, int month)
        {
            var tfsData = GetTfsData().OrderByDescending(t => t.CompleteWork).Select((t, i) => new { workload = t, Rank = i + 1 });
            BLUsers bu = new BLUsers();
            var userList = bu.GetAllUsers().ToList();
            int topUserCount = (int)Math.Round(userList.Count() * 0.3); //30% user got 3 score
            int bottomUserCount = userList.Count() - topUserCount * 2;
            var scores = (from u in userList
                          join t in tfsData
                          on u.RealName equals t.workload.UserName into left
                          from t in left.DefaultIfEmpty()
                          select new MonthlyKPIData
                          {
                              UserName = u.Name,
                              Score = t == null ? 0 : t.Rank <= topUserCount ? 3 * 0.5 :
                                         (topUserCount < t.Rank && t.Rank <= (topUserCount + bottomUserCount)) ? 2 * 0.5 : 1 * 0.5
                          }).ToList();
            BLTeamContribution bt = new BLTeamContribution();
            var teamContribution = bt.GetTeamContribution(year, month).GroupBy(t => t.UserName).Select(g => new { g.Key, Count = g.Count() });
            foreach (var item in teamContribution)
            {
                var kpi = scores.Single(s => s.UserName == item.Key);
                if (item.Count <= 3)
                    kpi.Score += item.Count * 0.2;
                else
                    kpi.Score += 3 * 0.2;
            }
            BLMeeting bm = new BLMeeting();
            var meeting = bm.GetAllMeetings(year, month);
            foreach (var item in meeting)
            {
                var kpi = scores.Single(s => s.UserName == item.HosterName);
                kpi.Score += (item.TotalScore / 3) * 0.15;
            }

            BLWorkPerformance bw = new BLWorkPerformance();
            var workPerformance = bw.GetReport(year, month);
            foreach (var item in workPerformance)
            {
                var kpi = scores.Single(s => s.UserName == item.UserName);
                kpi.Score += item.Score * 0.15;
            }

            scores = scores.OrderByDescending(s => s.Score)
                          .Select((s, index) => new MonthlyKPIData { UserName = s.UserName, Score = s.Score, Rank = index + 1, Year = year, Month = month })
                          .ToList();

            return scores;

        }

        /// <summary>
        /// Insert Month KPI into database
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public bool InsertKpi(List<MonthlyKPIData> list)
        {
            var insertKPI = list.Select(l => new UserKPI
            {
                Score = l.Score,
                Year = l.Year,
                Month = l.Month,
                Rank = l.Rank,
                User = db.Users.Find(db.Users.Where(k => k.UserName == l.UserName).Select(k => k.ID).FirstOrDefault())
            }
                ).ToList();
            insertKPI.ForEach(s => db.UserKPIs.Add(s));
            db.SaveChanges();
            return true;

        }

        /// <summary>
        /// Check Month does it exist in databse
        /// </summary>
        /// <param name="month"></param>
        /// <param name="year"></param>
        /// <returns>
        /// true :not exist
        /// false :exist
        /// </returns>
        public bool checkKpi(int month, int year)
        {
            var sqlMonth = db.UserKPIs.Where(k => k.Month == month && k.Year == year).Select(k => k.ID).ToList();
            if (sqlMonth.Count == 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }


        /// <summary>
        /// Every Week start with Monday for Chinese RPC Culture
        /// Week index start with 1
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static int GetWeekIndex(DateTime dt)
        {
            DateTime dtFirstDayOfYear = new DateTime(dt.Year, 1, 1);
            int firstDayIndex = (int)dtFirstDayOfYear.DayOfWeek;
            //if first day is sunday
            firstDayIndex = firstDayIndex == 0 ? 7 : firstDayIndex;
            int firstwWeekTotalDays = 7 - firstDayIndex + 1;

            TimeSpan ts = dt.Date - dtFirstDayOfYear.Date;
            int totalDays = ts.Days + 1 - firstwWeekTotalDays;
            double weekIndex = 1.0;
            if (totalDays > 0)
            {
                double weeknum = Math.Ceiling((double)totalDays / 7);
                weekIndex += weeknum;
            }
            return (int)weekIndex;
        }

    }
}