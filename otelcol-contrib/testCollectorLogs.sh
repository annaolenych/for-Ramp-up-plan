curl -X POST -w "%{http_code}" http://localhost:4318/v1/logs -H 'Content-Type: application/json' -d '
{
  "resourceLogs": [
    {
      "resource": {
        "attributes": [
          {
            "key": "service.name",
            "value": {"stringValue": "your-service-name"}
          },
          {
            "key": "service.version",
            "value": {"stringValue": "1.0"}
          },
          {
            "key": "host",
            "value": {"stringValue": "localhost"}
          }
        ]
      },
      "scopeLogs": [
        {
          "scope": {},
          "logRecords": [
            {
              "timeUnixNano": "'$(date +%s)000000000'",
              "attributes": [
                {
                  "key": "log.severity",
                  "value": {"stringValue": "INFO"}
                },
                {
                  "key": "message",
                  "value": {"stringValue": "Your log message here"}
                }
              ],
              "body": {"stringValue": "Your detailed log message here"}
            }
          ]
        }
      ]
    }
  ]
}'