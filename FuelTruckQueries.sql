Select Top(10) [Stop].Id, Count(*) as TotalTrips, Sum(ActualNeed) as TotalConsumption 
From [Stop]
Join FuelingEvent on FuelingEvent.StopId = [Stop].Id 
	AND ActualNeed > 0 
	AND DeliveryTime > DateAdd(month, -12, GETDATE()) 
	AND DeliveryTime < GETDATE()
Group by [Stop].Id
Order by TotalConsumption Desc

Select [Stop].Id, AVG(ActualNeed) as AverageDelivery
From [Stop]
Join FuelingEvent on FuelingEvent.StopId = [Stop].Id 
	AND ActualNeed > 0
Group by [Stop].Id

