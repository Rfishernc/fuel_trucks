using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace fuel_trucks.Models
{
    public class Stop
    {
        public int Id { get; set; }
        public string Location { get; set; }
        public int OperatingRegionId { get; set; }
        public bool EnRouteStatus { get; set; }
        public bool RecurringStatus { get; set; }
        public int RecurringInterval { get; set; }
    }
}
