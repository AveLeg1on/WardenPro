using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web.Http;
using System.Web.Http.Description;
using WardenPro_Api.Database;
using WardenPro_Api.Models;

namespace WardenPro_Api.Controllers
{
    [RoutePrefix("api/VisitRequests")]
    public class VisitRequestController : ApiController
    {
        private readonly WardenProEntities _database = WardenProEntities.GetInstance();

        [HttpGet]
        [ResponseType(typeof(List<VisitRequestModel>))]
        public IHttpActionResult GetVisitRequests()
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            return Ok(_database.VisitRequests.ToList().ConvertAll(p => new VisitRequestModel(p)));
        }


        [HttpPut]
        [ResponseType(typeof(VisitRequestModel))]
        public IHttpActionResult PutVisitRequest([FromBody] VisitRequestModel model)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            if (model == null)
                return BadRequest("Модель заявки пустая");

            VisitRequest request = _database.VisitRequests.Find(model.Id);

            if (request == null) return NotFound();

            StringBuilder errors = new StringBuilder();

            if (model.Purpose == null)
                errors.AppendLine("Укажите цель визита");

            if (model.Worker == null || _database.Workers.Find(model.Worker.Id) == null)
                errors.AppendLine("Сотрудник принимающей стороны не найден");
            if (_database.VisitRequestTypes.Find(model.TypeId) == null)
                errors.AppendLine("Неверный тип заявки");

            if (model.DesiredDateStart == null)
                errors.AppendLine("Неверная желеаемая дата начала действия пропуска");
            if (model.DesiredDateEnd == null || model.DesiredDateEnd < model.DesiredDateStart || model.DesiredDateEnd > model.DesiredDateStart.Value.AddDays(15))
                errors.AppendLine("Неверная желеаемая дата окончания действия пропуска");

            if (errors.Length > 0)
            {
                return BadRequest(errors.ToString());
            }
            
            request.ArrivedSecurityDate = model.ArrivedSecurityDate;
            request.ArrivedWorkerDate = model.ArrivedWorkerDate;
            request.DesiredDateEnd = model.DesiredDateEnd;
            request.DesiredDateStart = model.DesiredDateStart;
            request.GroupName = model.GroupName;
            request.LeftSecurityDate = model.LeftSecurityDate;
            request.LeftWorkerDate = model.LeftWorkerDate;
            request.IsApproved = model.IsApproved;
            request.Purpose = model.Purpose;
            request.RejectReason = model.RejectReason;
            request.TypeId = model.TypeId;
            request.VisitDate = model.VisitDate;
            request.WorkerId = model.Worker.Id;

            request.Visitors.Clear();

            foreach (var item in model.Visitors)
            {
                Visitor entity = _database.Visitors.FirstOrDefault(
                    p => p.Email == item.Email ||
                    (p.PassportSerial == item.PassportSerial && p.PassportNumber == item.PassportNumber)
                    );

                if (entity != null)
                {
                    request.Visitors.Add(entity);
                    continue;
                }

                errors = new StringBuilder();

                if (string.IsNullOrWhiteSpace(item.Firstname))
                    errors.AppendLine("Укажите Фамилию");

                if (string.IsNullOrWhiteSpace(item.Middlename))
                    errors.AppendLine("Укажите Имя");

                if (string.IsNullOrWhiteSpace(item.Email))
                    errors.AppendLine("Укажите почту");
                else
                {
                    if (!new EmailAddressAttribute().IsValid(item.Email))
                        errors.AppendLine("Некорректный формат почты");
                }


                if (item.PassportNumber < 100000 || item.PassportNumber > 999999)
                    errors.AppendLine("Укажите номер паспорта");
                if (item.PassportSerial < 1000 || item.PassportSerial > 9999)
                    errors.AppendLine("Укажите серию паспорта");

                if (item.DateBirth == null || item.DateBirth > DateTime.Now.AddYears(-16))
                    errors.AppendLine("Укажите дату рождения гражданина старше 16 лет");

                if (string.IsNullOrWhiteSpace(item.Note))
                    errors.AppendLine("Укажите примечание");

                if (errors.Length > 0)
                    return BadRequest(errors.ToString());

                entity = new Visitor()
                {
                    DateBirth = item.DateBirth,
                    Email = item.Email,
                    Firstname = item.Firstname,
                    Lastname = item.Lastname,
                    ImageSource = item.ImageSource,
                    Middlename = item.Middlename,
                    Note = item.Note,
                    Organization = item.Organization,
                    PassportNumber = item.PassportNumber,
                    PassportPdfSource = item.PassportPdfSource,
                    PassportSerial = item.PassportSerial,
                    Password = item.Password,
                    Phone = item.Phone
                };

                entity.Login = entity.Email.Substring(0, entity.Email.IndexOf('@'));

                entity = _database.Visitors.Add(entity);
                request.Visitors.Add(entity);
            }

            try
            {
                //Автоматическое добавление в черных список
                var list = _database.Visitors.Where(p => 
                p.VisitRequests.Count(r => r.RejectReason.Contains("заведомо недостоверных данных")) > 2).ToList();
                foreach (var item in list)
                {
                    item.VisitorBlackList = new VisitorBlackList();
                }
                _database.SaveChanges();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message + ex.InnerException?.Message);
            }
            _database.Entry(request).Reload();
            return Ok(new VisitRequestModel(request));

        }


        [HttpPost]
        [ResponseType(typeof(VisitRequestModel))]
        public IHttpActionResult PostVisitRequest([FromBody] VisitRequestModel model)
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            if (model == null)
                return BadRequest("Модель заявки пустая");


            StringBuilder errors = new StringBuilder();


            if (string.IsNullOrWhiteSpace(model.Purpose))
                errors.AppendLine("Укажите цель визита");

            if (model.Worker == null || _database.Workers.Find(model.Worker.Id) == null)
                errors.AppendLine("Сотрудник принимающей стороны не найден");
            if (_database.VisitRequestTypes.Find(model.TypeId) == null)
                errors.AppendLine("Неверный тип заявки");

            if (model.DesiredDateStart == null || model.DesiredDateStart < DateTime.Now.Date || model.DesiredDateStart > DateTime.Now.AddDays(15))
                errors.AppendLine("Неверная желеаемая дата начала действия пропуска");
            if (model.DesiredDateEnd == null || model.DesiredDateEnd < model.DesiredDateStart || model.DesiredDateEnd > model.DesiredDateStart.Value.AddDays(15))
                errors.AppendLine("Неверная желеаемая дата окончания действия пропуска");

            if (errors.Length > 0)
            {
                return BadRequest(errors.ToString());
            }


            VisitRequest request = new VisitRequest()
            {
                ArrivedSecurityDate = model.ArrivedSecurityDate,
                ArrivedWorkerDate = model.ArrivedWorkerDate,
                DesiredDateEnd = model.DesiredDateEnd,
                DesiredDateStart = model.DesiredDateStart,
                GroupName = model.GroupName,
                LeftSecurityDate = model.LeftSecurityDate,
                LeftWorkerDate = model.LeftWorkerDate,
                IsApproved = model.IsApproved,
                Purpose = model.Purpose,
                RejectReason = "на рассмотрении",
                TypeId = model.TypeId,
                VisitDate = model.VisitDate,
                WorkerId = model.Worker.Id
            };


            foreach (var item in model.Visitors)
            {
                Visitor entity = _database.Visitors.FirstOrDefault(
                    p => p.Email == item.Email ||
                    (p.PassportSerial == item.PassportSerial && p.PassportNumber == item.PassportNumber)
                    );

                if (entity != null )
                {
                    request.Visitors.Add(entity);
                    continue;
                }

                errors = new StringBuilder();

                if (string.IsNullOrWhiteSpace(item.Firstname))
                    errors.AppendLine("Укажите Фамилию");

                if (string.IsNullOrWhiteSpace(item.Middlename))
                    errors.AppendLine("Укажите Имя");

                if (string.IsNullOrWhiteSpace(item.Email))
                    errors.AppendLine("Укажите почту");
                else
                {
                    if (!new EmailAddressAttribute().IsValid(item.Email))
                        errors.AppendLine("Некорректный формат почты");
                }


                if (item.PassportNumber < 100000 || item.PassportNumber > 999999)
                    errors.AppendLine("Укажите номер паспорта");
                if (item.PassportSerial < 1000 || item.PassportSerial > 9999)
                    errors.AppendLine("Укажите серию паспорта");

                if (item.DateBirth == null || item.DateBirth > DateTime.Now.AddYears(-16))
                    errors.AppendLine("Укажите дату рождения гражданина старше 16 лет");

                if (string.IsNullOrWhiteSpace(item.Note))
                    errors.AppendLine("Укажите примечание");

                if (errors.Length > 0)
                    return BadRequest(errors.ToString());

                entity = new Visitor()
                {
                    DateBirth = item.DateBirth,
                    Email = item.Email,
                    Firstname = item.Firstname,
                    Lastname = item.Lastname,
                    ImageSource = item.ImageSource,
                    Middlename = item.Middlename,
                    Note = item.Note,
                    Organization = item.Organization,
                    PassportNumber = item.PassportNumber,
                    PassportPdfSource = item.PassportPdfSource,
                    PassportSerial = item.PassportSerial,
                    Password = item.Password,
                    Phone = item.Phone
                };

                entity.Login = entity.Email.Substring(0, entity.Email.IndexOf('@'));

                entity = _database.Visitors.Add(entity);
                request.Visitors.Add(entity);
            }

            request = _database.VisitRequests.Add(request);
            try
            {
                _database.SaveChanges();

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message+ ex.InnerException?.Message);
            }
            _database.Entry(request).Reload();
            return Ok(new VisitRequestModel(request));

        }
    }
}
