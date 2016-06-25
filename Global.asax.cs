using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using KPISystem;
using System.Data.Entity;
using KPIClassLibary;
using Model;

namespace KPISystem
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();


            Database.SetInitializer(new MyContextInitializer());
            //KPIDbContext db = new KPIDbContext();
            //db.Database.Initialize(true);
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }
    }
    public class MyContextInitializer : DropCreateDatabaseIfModelChanges<KPIDbContext>
    {
        protected override void Seed(KPIDbContext context)
        {
            base.Seed(context);
            var grouplist = new List<UserGroup>
                {
                   new UserGroup  {  GroupName = "Admin" },
                   new UserGroup  {  GroupName = "User" },
                   new UserGroup  {  GroupName = "Guest" },
                };
            grouplist.ForEach(g => context.UserGroups.Add(g));
            context.MeetingTypes.Add(new MeetingType { TypeName = EnumMeetingType.WeeklyMeeting.ToString(), Description = "Weekly Meeting : begin at 9:30 every Monday." });
            context.SaveChanges();

            var admin = context.UserGroups.Find(1);
            var user = context.UserGroups.Find(2);

            var users = new string[] { "v-jinhta", "v-monlin", "v-calwan", "v-damonl", "v-qiafu", "v-feding", "v-jacsun", "v-jiapji" };
            var realNames = new string[] { "Tim.Tang", "Monica.lin", "Calvin", "Damon Liu", "qian fu", "Feng Ding", "sunqi", "jiapingjiang" };

            var userlist = users.Select((u, i) => new User
            {
                UserName = u,
                RealName = realNames[i],
                Password = "123",
                EmailAddress = string.Format("{0}@microsoft.com", u),
                Status = (int)UserStatus.Active,
                Group = user,
                LastLogin = DateTime.Now,
                RegisterTime = DateTime.Now
            }).ToList();

            userlist.ForEach(l => context.Users.Add(l));
            context.SaveChanges();

            var hoster = users.Select((u, index) => new MeetingHoster { Hoster = context.Users.Find(index + 1), Status = (int)HosterStatus.Active }).ToList();
            hoster.ForEach(h => context.MeetingHosters.Add(h));

            var mType = context.MeetingTypes.Find(1);
            var rules = new List<ScoringCriteria>
            {
                 new ScoringCriteria{ meetingType=mType, Name=@"会前提醒更新Task,<br /> 准备好会议室,设备,文档OneNote(Task 统计图表),<br />会议准时开始", 
                                      FullScore=3.0,  Description=@"1分 - 会议没有准时开始.<br /> 2分 - 会议准时开始，但有的没准备好.<br />3分 - 每项都做到了,会议正常开始."},
                 new ScoringCriteria{ meetingType=mType, Name="控制好会议的时间 (1小时内结束).", FullScore=3.0, 
                                      Description=@"1分 - 1.5小时后结束<br /> 2分 - 1 -1.5小时内结束<br />3分 - 1小时内结束 "},
                 new ScoringCriteria{ meetingType=mType, Name="及时记录会议中要做的事情和存在的问题至OneNote.", FullScore=3.0,
                                      Description=@"1分 - 如果在他人提醒下才知道记录(提醒三次以上)<br />2分 - 如果在他人提醒下才知道记录(提醒两次)<br /> 3分 - 主动记录会议中的问题和事情"},
            };
            rules.ForEach(r => context.ScoringCriterias.Add(r));
            context.SaveChanges();

        }
    }
}
