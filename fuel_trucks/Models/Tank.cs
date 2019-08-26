using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace fuel_trucks.Models
{
    public class Tank
    {
        public int Id { get; set; }
        public int TruckId { get; set; }
        public double Capacity { get; set; }
        public double FuelLevel { get; set; }
        public string FuelType { get; set; }
    }
}
