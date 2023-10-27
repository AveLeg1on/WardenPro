using System;
using WardenPro_Api.Database;

namespace WardenPro_Api.Models
{
    public class WorkerModel
    {
        public WorkerModel()
        {
            
        }

        public WorkerModel(Worker worker)
        {
            Id  = worker.Id;
            FIO = worker.FIO;
            Division = worker.Division?.Name;
            Department = worker.Department?.Name;
            AuthCode = worker.AuthCode;
        }

        public int Id { get; set; }
        public string FIO { get; set; }
        public string Division { get; set; }
        public string Department { get; set; }
        public Nullable<int> AuthCode { get; set; }

    }
}