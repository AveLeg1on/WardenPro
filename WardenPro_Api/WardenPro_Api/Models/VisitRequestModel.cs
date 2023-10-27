using System;
using System.Collections.Generic;
using System.Linq;
using WardenPro_Api.Database;

namespace WardenPro_Api.Models
{
    public class VisitRequestModel
    {
        public VisitRequestModel()
        {
            
        }

        public VisitRequestModel(VisitRequest request)
        {
            Id = request.Id;
            Purpose = request.Purpose;
            TypeId = request.TypeId;
            GroupName = request.GroupName;
            IsApproved = request.IsApproved;
            RejectReason = request.RejectReason;
            DesiredDateEnd = request.DesiredDateEnd;
            DesiredDateStart = request.DesiredDateStart;
            VisitDate = request.VisitDate;
            ArrivedSecurityDate = request.ArrivedSecurityDate;
            ArrivedWorkerDate = request.ArrivedWorkerDate;
            LeftSecurityDate = request.LeftSecurityDate;
            LeftWorkerDate = request.LeftWorkerDate;
            Worker = new WorkerModel(request.Worker);
            Visitors = request.Visitors.ToList().ConvertAll(visitor => new VisitorModel(visitor));
        }

        public int Id { get; set; }
        public string Purpose { get; set; }
        public Nullable<int> TypeId { get; set; }
        public string GroupName { get; set; }
        public bool IsApproved { get; set; }
        public string RejectReason { get; set; }
        public Nullable<System.DateTime> DesiredDateStart { get; set; }
        public Nullable<System.DateTime> DesiredDateEnd { get; set; }
        public Nullable<System.DateTime> VisitDate { get; set; }
        public Nullable<System.DateTime> ArrivedSecurityDate { get; set; }
        public Nullable<System.DateTime> LeftSecurityDate { get; set; }
        public Nullable<System.DateTime> ArrivedWorkerDate { get; set; }
        public Nullable<System.DateTime> LeftWorkerDate { get; set; }

        public WorkerModel Worker { get; set; }
        public List<VisitorModel> Visitors { get; set; }
    }
}