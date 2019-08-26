using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using fuel_trucks.Connections;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace fuel_trucks.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DispatchController : ControllerBase
    {
        readonly DispatchConnection _connection;

        public DispatchController(DispatchConnection connection)
        {
            _connection = connection;
        }

        [HttpGet("trucks/{region}")]
        public ActionResult GetTrucks(int regionId)
        {
            var trucks = _connection.GetTrucks(regionId);
            return Accepted(trucks);
        }

        [HttpGet("stops/{region}")]
        public ActionResult GetStops(int regionId)
        {
            var stops = _connection.GetStops(regionId);
            return Accepted(stops);
        }

        [HttpGet("events/{region}")]
        public ActionResult GetTodaysFuelingEvents(int regionId)
        {
            var fuelingEvents = _connection.GetTodaysFuelingEvents(regionId);
            return Accepted(fuelingEvents);
        } 
    }
}