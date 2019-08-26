using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using System.Data.SqlClient;
using fuel_trucks.Models;

namespace fuel_trucks.Connections
{
    public class DispatchConnection
    {
        readonly string _connectionString;
        public DispatchConnection(IOptions<DbConfiguration> dbConfig)
        {
            // builds ConnectionString from appsettings.json
            _connectionString = dbConfig.Value.ConnectionString;
        }

        public IEnumerable<Truck> GetTrucks(int regionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var queryString = @"Select Truck.Id, Truck.StopId, Truck.OperatingRegionId  
                                    From Truck
                                    Where Truck.OperatingRegionId = @RegionId";
                var trucks = connection.Query<Truck>(queryString, new { regionId });

                var truckIds = new List<int>();
                foreach (Truck truck in trucks)
                {
                    truckIds.Add(truck.Id);
                }

                var tankQueryString = @"Select *
                                        From Tank
                                        Where Tank.TruckId IN @truckIds";
                var tanks = connection.Query<Tank>(tankQueryString, truckIds);

                foreach (Tank tank in tanks)
                {
                    foreach (Truck truck in trucks)
                    {
                        if (tank.TruckId == truck.Id)
                        {
                            truck.FuelTanks.Add(tank);
                        }
                    }
                }

                return trucks;
            }
            throw new Exception("Could not update truck status");
        }

        public IEnumerable<Stop> GetStops(int regionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var queryString = @"Select *
                                    From [Stop]
                                    Where [Stop].OperatingRegionId = @RegionId";
                var stops = connection.Query<Stop>(queryString, new { regionId });
                return stops;
            }
            throw new Exception("Could not update truck status");
        }

        public IEnumerable<FuelingEvent> GetTodaysFuelingEvents(int regionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var queryString = @"Select FE.StopId, FE.ScheduledTime, FE.DeliveryTime, FE.EstimatedNeed, FE.ActualNeed, FE.FuelType, FE.SchedulingStatus
                                    From [Stop]
                                    Join FuelingEvent as FE on FE.StopId = [Stop].Id
                                    Where [Stop].OperatingRegionId = @RegionId 
                                        AND DatePart(dayofyear, FE.ScheduledTime) = DatePart(dayofyear, GetDate())
                                        AND DatePart(year, FE.ScheduledTime) = DatePart(year, GetDate())";
                var fEvents = connection.Query<FuelingEvent>(queryString, new { regionId });
                return fEvents;
            }
            throw new Exception("Could not update truck status");
        }

        public IEnumerable<FuelingEvent> GetTodaysPendingFuelingEvents(int regionId)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var queryString = @"Select FE.StopId, FE.ScheduledTime, FE.DeliveryTime, FE.EstimatedNeed, FE.ActualNeed, FE.FuelType, FE.SchedulingStatus
                                    From [Stop]
                                    Join FuelingEvent as FE on FE.StopId = [Stop].Id
                                    Where [Stop].OperatingRegionId = @RegionId 
                                        AND [Stop].EnRouteStatus = 0
                                        AND DatePart(dayofyear, FE.ScheduledTime) = DatePart(dayofyear, GetDate())
                                        AND DatePart(year, FE.ScheduledTime) = DatePart(year, GetDate())";
                var fEvents = connection.Query<FuelingEvent>(queryString, new { regionId });
                return fEvents;
            }
            throw new Exception("Could not update truck status");
        }
    }
}
