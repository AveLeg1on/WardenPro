﻿using System.Collections.Generic;

namespace WardenPro_VisitRequest_WPF.Models
{
    public class WorkerDivisionModel
    {

        public int Id { get; set; }
        public string Name { get; set; }

        public List<WorkerModel> Workers { get; set; }
    }
}