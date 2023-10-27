using System;

namespace WardenPro_VisitRequest_WPF.Models
{
    public class VisitorModel
    {

        public int Id { get; set; }
        public string Firstname { get; set; }
        public string Middlename { get; set; }
        public string Lastname { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public Nullable<System.DateTime> DateBirth { get; set; }
        public int PassportSerial { get; set; }
        public int PassportNumber { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Organization { get; set; }
        public string Note { get; set; }
        public string ImageSource { get; set; }
        public string PassportPdfSource { get; set; }

        public bool IsVisitorInBlackList { get; set; }
    }
}