+++
date = '2025-11-06T09:49:41-05:00'
draft = false
title = 'Rudimentary Poking Around and Monitoring the HAOS database'
+++

So I have been spending too much time with Home Assistant as of late. I find it much more polished since I first starting messing around with it a couple of years ago. I've managed to find all the levers I need to really start building some stuff out. Some of the things I've done so far are:
  * Move from using a Raspberry Pi 4 running Home Assistant OS (HAOS) to a dedicated Mini-PC running a HAOS VM managed by ProxMox
  * Visualize useful weather trends for multiple zones using the Statistics Graph Card and Apex Charts
  * Setup automatic backups to my Samba share
  * Use the ESPHome add-on to more easily setup a BME688 air quality sensor attached to a Raspberry Pi Pico W
  * and other things...

With the new sensors has come a sharp uptick in DB usage size. 

![My image alt text](./haos-db-size-increase.png)

So I did a search and came across this page which I will review, https://community.home-assistant.io/t/how-to-keep-your-recorder-database-size-under-control/295795.

In general, I'd like to better understand the Home Assistant Database Model, so this is a very good angle into that.

Here in that article it links to some [2021 release notes](https://www.home-assistant.io/blog/2021/06/02/release-20216/#disable-polling-updates-on-any-integration), which suggest disabling polling the UI and then scheduling your own automation with the update_entity service. This is good to note.

Reading on, I see this query to get the size of tables and indexes (ix_), which identifies states and statistics as the large tables.
```
--
SELECT
  SUM(pgsize) bytes,
  name
FROM dbstat
GROUP BY name
ORDER BY bytes DESC
``` 

```
bytes,name
71880704,states
44195840,statistics
22736896,ix_states_context_id_bin
18169856,ix_states_metadata_id_last_updated_ts
15900672,ix_statistics_statistic_id_start_ts
15765504,ix_states_last_updated_ts
13680640,ix_statistics_start_ts
12619776,statistics_short_term
12038144,ix_states_old_state_id
11206656,ix_states_attributes_id
...
```

This next query shows that the 5 minute stats are the most common event type
```
-- Updated query Dec 2023 (Confirmed to work Apr 2025)
SELECT
  COUNT(*) as cnt,
  COUNT(*) * 100 / (SELECT COUNT(*) FROM events) AS cnt_pct,
  event_types.event_type
FROM events
INNER JOIN event_types ON events.event_type_id = event_types.event_type_id
GROUP BY event_types.event_type
ORDER BY cnt ASC

cnt 	cnt_pct 	event_type
...
868 	14 	component_loaded
1130 	19 	service_registered
2939 	50 	recorder_5min_statistics_generated 
```

And running for states shows that my pico sensors are taking up 30% of the records in states
```
-- Updated query Dec 2023 (Confirmed to work Apr 2025)
SELECT
  COUNT(*) AS cnt,
  COUNT(*) * 100 / (SELECT COUNT(*) FROM states) AS cnt_pct,
  states_meta.entity_id
FROM states
INNER JOIN states_meta ON states.metadata_id=states_meta.metadata_id
GROUP BY states_meta.entity_id
ORDER BY cnt ASC

28485 	3 	sensor.processor_temperature
35951 	4 	sensor.processor_use
41063 	5 	sensor.picow_sensor_bme68x_sec2_iaq
41100 	5 	sensor.picow_sensor_bme68x_sec2_co2_equivalent
41103 	5 	sensor.picow_sensor_bme68x_sec2_breath_voc_equival ...
41162 	5 	sensor.picow_sensor_bme68x_sec2_temperature
41469 	5 	sensor.picow_sensor_bme68x_sec2_pressure
41795 	5 	sensor.picow_sensor_bme68x_sec2_humidity
56991 	7 	sensor.memory_free 
```

Here is immediately shown the main problem sensors. All the `picow_sensor_bme68x...` are taking up 30% of the records in this table. These are new ESPHome Add-on sensors which I added only a few days ago. After a little poking the database it seemed like we are getting a reading every 3 seconds for these sensors. The documentation shows there to be an option to "throttle". I set this parameter to 60 seconds for each of my sensors as seen below and this has helped the problem.
```
  - platform: bme68x_bsec2
    temperature:
      name: "BME68x Sec2 Temperature"
      filters:
        - throttle: 60s
    pressure:
      name: "BME68x Sec2 Pressure"
      filters:
        - throttle: 60s
    humidity:
      name: "BME68x Sec2 Humidity"
      filters:
        - throttle: 60s
    iaq:
      name: "BME68x Sec2 IAQ"
      filters:
        - throttle: 60s
      id: iaqx
    co2_equivalent:
      name: "BME68x Sec2 CO2 Equivalent"
      filters:
        - throttle: 60s
    breath_voc_equivalent:
      name: "BME68x Sec2 Breath VOC Equivalent"
      filters:
        - throttle: 60s

```

I am going to stop here for the moment, but clearly there is some more optimizations to be done. Some of the other custom sensors probably need tuning and better polling or disabling+automation may be the answer to that. I will continue to monitor this DB size in my Home Assistant dashboard. I guess it would be good to create an alert if it crosses a certain threshold (like 500MB) or if it changes by 50MB in 10 days or something.