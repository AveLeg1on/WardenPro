using System;

namespace WardenPro_Security_WPF.Models
{
    public class WorkerModel
    {

        public int Id { get; set; }
        public string FIO { get; set; }
        public string Division { get; set; }
        public string Department { get; set; }
        public Nullable<int> AuthCode { get; set; }

    }
}