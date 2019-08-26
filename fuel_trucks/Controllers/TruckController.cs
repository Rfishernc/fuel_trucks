using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using fuel_trucks.Connections;
using fuel_trucks.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace fuel_trucks.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TruckController : ControllerBase
    {
        readonly TruckConnection _connection;

        public TruckController(TruckConnection connection)
        {
            _connection = connection;
        }

        [HttpPut] public ActionResult UpdateTruckStatus (TruckUpdateRequest request)
        {
            var truckOrders = _connection.UpdateTruckStatus(request);
            return Accepted(truckOrders);
        }
    }
}