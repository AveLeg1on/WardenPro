using System;
using System.Collections.Generic;

namespace WardenPro_Security_WPF.Models
{
    public class VisitRequestModel
    {
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