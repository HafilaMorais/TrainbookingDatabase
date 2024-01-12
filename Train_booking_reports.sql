--List all trains and their schedules:

SELECT
  train.train_id,
  train.train_name,
  schedule.schedule_name
FROM
  train
JOIN schedule ON train.schedule_id = schedule.schedule_id;


--Count the number of trains that use each station:

SELECT
  train_station.train_station_id,
  train_station.train_station_name,
  COUNT(train_journey_station.train_id) AS number_of_trains
FROM train_station
LEFT JOIN train_journey_station ON train_station.train_station_id = train_journey_station.train_station_id
GROUP BY train_station.train_station_id, train_station.train_station_name
ORDER BY
  number_of_trains DESC;


-- Retrieve the  name, station ID, and departure time for stops at a specific station for a given train

SELECT
  train_journey_station.train_id,
  train_journey_station.train_station_id,
  train_station.train_station_name,
  train_journey_station.departure_time
FROM
  train_journey_station
JOIN train_station ON train_journey_station.train_station_id = train_station.train_station_id
WHERE
  train_journey_station.train_id = 'T1'
ORDER BY
  train_journey_station.stop_order;

  
--Find trains departing from a specific station after a certain time:

SELECT
  train.train_id,
  train.train_name,
  train_journey_station.departure_time
FROM
  train_journey_station
JOIN train ON train_journey_station.train_id = train.train_id
WHERE
  train_journey_station.train_station_id = 'TS2' -- Replace with the desired station_id
  AND train_journey_station.departure_time > '2024-01-01 09:00:00'; -- Replace with the desired time

--List the average number of stops for each schedule:

SELECT
  schedule.schedule_id,
  schedule.schedule_name,
  AVG(stop_count) AS average_stops
FROM
  schedule
LEFT JOIN train ON schedule.schedule_id = train.schedule_id
LEFT JOIN (
  SELECT
    train_id,
    COUNT(train_station_id) AS stop_count
  FROM
    train_journey_station
  GROUP BY
    train_id
) AS stops ON train.train_id = stops.train_id
GROUP BY
  schedule.schedule_id, schedule.schedule_name
ORDER BY
  average_stops DESC;


-- Show all trains with their names and the stations where they stop
SELECT
  t.train_id,
  t.train_name,
  tjs.train_station_id,
  ts.train_station_name,
  tjs.stop_order,
  tjs.departure_time
FROM
  train AS t
JOIN train_journey_station AS tjs ON t.train_id = tjs.train_id
JOIN train_station AS ts ON tjs.train_station_id = ts.train_station_id
ORDER BY
  tjs.train_id, tjs.stop_order;


select * from schedule;
