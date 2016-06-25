using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Outlook = Microsoft.Office.Interop.Outlook;
using System.Net.Http;
using System.IO;

namespace KPISystem
{
    public class EmailHelper
    {
        public static void SendEmail(string[] ToUsers, string subject, string body)
        {
            Outlook.Application outlookObj = new Outlook.Application();
            Outlook.MailItem option = (Outlook.MailItem)outlookObj.CreateItem(Outlook.OlItemType.olMailItem);

            option.To = string.Join(";", ToUsers);//"jinhao.tang@hisoft.com"; 

            option.Subject = subject;

            option.Body = body;

            //option.Send();
        }

        public static void CreateOutlookMeetingRequest(List<string> ToUsers, DateTime startTime)
        {
            Outlook.Application outlookObj = new Outlook.Application();
            Outlook.AppointmentItem appt = (Outlook.AppointmentItem)outlookObj.CreateItem(Outlook.OlItemType.olAppointmentItem);
            appt.Subject = "Weekly task review meeting preparetion";
            appt.MeetingStatus = Outlook.OlMeetingStatus.olMeeting;
            appt.Location = "5f meeting room";
            int weekindex = BaseClass.GetWeekIndex(startTime);
            string week = string.Format("{0}{1}", DateTime.Now.Year, weekindex.ToString().PadLeft(2, '0'));
            appt.Body = GetMeetingBody(week, startTime.ToString("yyyy-MM-dd HH:mm"));
            appt.Start = startTime;
            appt.End = startTime.AddHours(1.5);
            ToUsers.ForEach(s => appt.Recipients.Add(s));

            //Outlook.Recipient recipRequired =
            //    appt.Recipients.Add("v-jinhta@microsfot.com");
            //recipRequired.Type =
            //    (int)Outlook.OlMeetingRecipientType.olRequired;
            //Outlook.Recipient recipOptional =
            //    appt.Recipients.Add("Peter Allenspach");
            //recipOptional.Type =
            //    (int)Outlook.OlMeetingRecipientType.olOptional;
            //Outlook.Recipient recipConf =
            //   appt.Recipients.Add("Projector");
            //recipConf.Type =
            //    (int)Outlook.OlMeetingRecipientType.olResource;
            appt.Recipients.ResolveAll();
            appt.Display(false);
            //appt.Send();
        }

        static string GetMeetingBody(string week, string startTime)
        {
            return string.Format(@"Hello everyone,

Our weekly task review will be started on {0}, please help get your work items created and updated before meeting, thanks!

This week number: {1}

Review:
•  Update the TFS work item state to date (to create a new email to Libai and update them to the latest state, the format should be standard) 
•  We’ll quickly review tasks one by one in the first part of the meeting, please prepare 3-5 minutes for your work items:
        o	What tasks you have done, what is status of the ongoing tasks? Is the time cost reasonable, is there any blocks/issues? Need any supports?
        o	Is there any tasks remaining from last week? Need to cancel/delay? 
        o	What tasks do you plan to do this week?", startTime, week);
        }

        //    public string MakeHourEvent(string subject, string location,
        //DateTime date, string startTime, string endTime)
        //    {
        //        string filePath = string.Empty;
        //        string path = HttpContext.Current.Server.MapPath(@"\iCal\");
        //        filePath = path + subject + ".ics";
        //        var writer = new StreamWriter(filePath);
        //        writer.WriteLine("BEGIN:VCALENDAR");
        //        writer.WriteLine("VERSION:2.0");
        //        writer.WriteLine("PRODID:-//hacksw/handcal//NONSGML v1.0//EN");
        //        writer.WriteLine("BEGIN:VEVENT");
        //        string startDateTime = GetFormatedDate(date) + "T" + GetFormattedTime(startTime);
        //        string endDateTime = GetFormatedDate(date) + "T" + GetFormattedTime(endTime);
        //        writer.WriteLine("DTSTART:" + startDateTime);
        //        writer.WriteLine("DTEND:" + endDateTime);
        //        writer.WriteLine("SUMMARY:" + subject);
        //        writer.WriteLine("LOCATION:" + location);
        //        writer.WriteLine("END:VEVENT");
        //        writer.WriteLine("END:VCALENDAR");
        //        writer.Close();
        //        return filePath;
        //    }

    }
}