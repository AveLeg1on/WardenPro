using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Description;
using WardenPro_Api.Database;
using WardenPro_Api.Models;

namespace WardenPro_Api.Controllers
{
    [RoutePrefix("api/Divisions")]
    public class DivisionsController : ApiController
    {
        private readonly WardenProEntities _database = WardenProEntities.GetInstance();

        [HttpGet]
        [Route("WorkerDivisions")]
        [ResponseType(typeof(List<WorkerDivisionModel>))]
        public IHttpActionResult GetWorkerDivision()
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            return Ok(_database.Divisions.ToList().ConvertAll(division => new WorkerDivisionModel(division)));
        }
    }
}
