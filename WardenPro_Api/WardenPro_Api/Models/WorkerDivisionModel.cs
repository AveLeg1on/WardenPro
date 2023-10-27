using System.Collections.Generic;
using System.Linq;
using WardenPro_Api.Database;

namespace WardenPro_Api.Models
{
    public class WorkerDivisionModel
    {
        public WorkerDivisionModel()
        {
            
        }

        public WorkerDivisionModel(Division division)
        {
            Id = division.Id;
            Name = division.Name;
            Workers = division.Workers.ToList().ConvertAll(worker => new WorkerModel(worker));
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public List<WorkerModel> Workers { get; set; }
    }
}