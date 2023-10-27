using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web.Http;
using System.Web.Http.Description;
using WardenPro_Api.Database;
using WardenPro_Api.Models;

namespace WardenPro_Api.Controllers
{
    [RoutePrefix("api/Account")]
    public class AccountController : ApiController
    {
        private readonly WardenProEntities _database = WardenProEntities.GetInstance();

        [HttpGet]
        [Route("WorkerLogin/{authCode}")]
        [ResponseType(typeof(WorkerModel))]
        public IHttpActionResult GetWorkerLogin(int authCode)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            Worker worker = _database.Workers.FirstOrDefault(p => p.AuthCode == authCode);
            if (worker == null) return NotFound();
            return Ok(new WorkerModel(worker));
        }


        [HttpPost]
        [Route("RegVisitor")]
        [ResponseType(typeof(VisitorModel))]
        public IHttpActionResult PostRegVisitor([FromBody] VisitorModel model)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            if (model == null)
                return BadRequest("Модель посетителя пустая");


            StringBuilder errors = new StringBuilder();

            if (string.IsNullOrWhiteSpace(model.Firstname))
                errors.AppendLine("Укажите Фамилию");

            if (string.IsNullOrWhiteSpace(model.Middlename))
                errors.AppendLine("Укажите Имя");

            if (string.IsNullOrWhiteSpace(model.Email))
                errors.AppendLine("Укажите почту");
            else
            {
                if (!new EmailAddressAttribute().IsValid(model.Email))
                    errors.AppendLine("Некорректный формат почты");
            }
            if (model.DateBirth == null || model.DateBirth > DateTime.Now.AddYears(-16))
                errors.AppendLine("Укажите дату рождения гражданина старше 16 лет");


            if (string.IsNullOrWhiteSpace(model.Password))
                errors.AppendLine("Укажите пароль");
           
            if (model.PassportNumber < 100000 || model.PassportNumber > 999999)
                errors.AppendLine("Укажите номер паспорта");
            if (model.PassportSerial < 1000 || model.PassportSerial > 9999)
                errors.AppendLine("Укажите серию паспорта");


            if (string.IsNullOrWhiteSpace(model.Note))
                errors.AppendLine("Укажите примечание");

            if (errors.Length > 0)
                return BadRequest(errors.ToString());

            if (_database.Visitors.FirstOrDefault(p => p.Email == model.Email) != null)
                return BadRequest("Пользователь с такой почтой уже зарегистрирован");

            if (_database.Visitors.FirstOrDefault(p => p.PassportSerial == model.PassportSerial
            && p.PassportNumber == model.PassportNumber) != null)
                return BadRequest("Пользователь с такими паспортными данными уже зарегистрирован");

            Visitor visitor = new Visitor()
            {
                DateBirth = model.DateBirth,
                Email = model.Email,
                Firstname = model.Firstname,
                Lastname = model.Lastname,
                ImageSource = model.ImageSource,
                Middlename = model.Middlename,
                Note = model.Note,
                Organization = model.Organization,
                PassportNumber = model.PassportNumber,
                PassportPdfSource = model.PassportPdfSource,
                PassportSerial = model.PassportSerial,
                Password = model.Password,
                Phone = model.Phone
            };

            visitor.Login = visitor.Email.Substring(0, visitor.Email.IndexOf('@'));

            visitor = _database.Visitors.Add(visitor);
            _database.SaveChanges();
            _database.Entry(visitor).Reload();


            return Ok(new VisitorModel(visitor));
        }
    }
}
