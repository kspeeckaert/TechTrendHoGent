SELECT System.Timestamp() AS timestamp
      ,ID as ean
      ,IoTHub.ConnectionDeviceId as device_type
      ,CASE IoTHub.ConnectionDeviceId
        WHEN 'Electricity' THEN AVG(L1_Cons)
        WHEN 'Gas' THEN AVG(current_cons)
        ELSE NULL
       END as avg_value
FROM [hub-hogent] 
TIMESTAMP BY timestamp
WHERE IoTHub.ConnectionDeviceId IN ('Gas', 'Electricity')
GROUP BY ID
        ,IoTHub.ConnectionDeviceId
        ,HoppingWindow(second, 60, 5)
