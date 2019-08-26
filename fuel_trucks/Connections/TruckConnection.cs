using fuel_trucks.Models;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Dapper;

namespace fuel_trucks.Connections
{
    public class TruckConnection
    {
        readonly string _connectionString;
        readonly IOptions<DbConfiguration> _dbConfig;
        public TruckConnection(IOptions<DbConfiguration> dbConfig)
        {
            // builds ConnectionString from appsettings.json
            _connectionString = dbConfig.Value.ConnectionString;
            _dbConfig = dbConfig;
        }

        public Truck UpdateTruckStatus(TruckUpdateRequest request)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                var truckId = request.TruckId;
                var currentStop = request.StopId;

                UpdateFueling(connection, request);

                var truckString = @"Select OperatingRegionId
                                    From Truck
                                    Where Truck.Id = @TruckId";
                var regionId = connection.QueryFirst<int>(truckString, new { truckId });

                var fuelingEvents = new DispatchConnection(_dbConfig).GetTodaysPendingFuelingEvents(regionId);

                // Calls an external mapping API using HttpClient, gets travel times to 
                RouteTruck(fuelingEvents, currentStop);
                
                var truckOrdersQueryString = @"Select [Stop].Location
                                               From Truck
                                               Join [Stop] on [Stop].Id = Truck.StopId
                                               Where Truck.Id = @TruckId";
                var truckOrders = connection.QueryFirst<Truck>(truckOrdersQueryString, new { truckId });
                return truckOrders;
            }
            throw new Exception("Could not update truck status");
        }

        public void UpdateFueling(SqlConnection connection, TruckUpdateRequest request)
        {
            foreach (Tank tank in request.FuelTanks)
            {
                var tankId = tank.Id;
                var stopId = request.StopId;
                var queryString = @"Declare @OldFuelLevel decimal(6, 2)
                                        Set @OldFuelLevel = (Select FuelLevel
                                        From Tank
                                        Where Tank.Id = @TankId)

                                        Declare @EventId int
                                        Set @EventId = (Select FE.Id
                                        From [Stop]
                                        Join FuelingEvent as FE on FuelingEvent.StopId = [Stop].Id
                                            AND DatePart(dayofyear, FE.ScheduledTime) = DatePart(dayofyear, GetDate())
                                            AND DatePart(year, FE.ScheduledTime) = DatePart(year, GetDate())
                                        Where [Stop].Id = @StopId                                                               

                                        Update Tank
                                        Set FuelLevel = @CurrentFuelLevel
                                        Where Tank.Id = @TankId

                                        Update FuelingEvent
	                                        Set ActualNeed = @OldFuelLevel - @CurrentFuelLevel,
		                                        DeliveryTime = GetDate()
                                        Where FuelingEvent.Id = @EventId";
                var tankUpdate = connection.QueryFirst<int>(queryString, new { tankId, stopId });
            }
        }

        public void RouteTruck(IEnumerable<FuelingEvent> fuelingEvents, int currentStop)
        {

        }
    }
}
