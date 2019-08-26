using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace fuel_trucks.Models
{
    public class Truck
    {
        public int Id { get; set; }
        public int OperatingRegionId { get; set; }
        public int StopId { get; set; }
        public List<Tank> FuelTanks { get; set; } = new List<Tank>();
    }
}
