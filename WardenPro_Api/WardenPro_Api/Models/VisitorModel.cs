using System;
using WardenPro_Api.Database;

namespace WardenPro_Api.Models
{
    public class VisitorModel
    {
        public VisitorModel()
        {
            
        }

        public VisitorModel(Visitor visitor)
        {
            Id = visitor.Id;
            Firstname = visitor.Firstname;
            Lastname = visitor.Lastname;
            Middlename = visitor.Middlename;
            Phone = visitor.Phone;
            Email = visitor.Email;
            DateBirth = visitor.DateBirth;
            PassportNumber = visitor.PassportNumber;
            PassportSerial  = visitor.PassportSerial;
            Login = visitor.Login;
            Organization = visitor.Organization;
            Note = visitor.Note;
            ImageSource = visitor.ImageSource;
            PassportPdfSource = visitor.PassportPdfSource;
            IsVisitorInBlackList = visitor.VisitorBlackList != null;
        }

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