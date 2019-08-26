using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace fuel_trucks.Models
{
    public class FuelingEvent
    {
        public int Id { get; set; }
        public int StopId { get; set; }
        public string FuelType { get; set; }
        public double EstimatedNeed { get; set; }
        public double ActualNeed { get; set; }
        public DateTime ScheduledTime { get; set; }
        public DateTime DeliveryTime { get; set; }
        public bool SchedulingStatus { get; set; }
    }
}
