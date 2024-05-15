# [![logBee](https://github.com/logBee-net/logBee-app/assets/39127098/d1436229-983d-41e7-bcff-7288601bf2d0)](https://logbee.net)

logBee is a logging aggregator, exceptions tracking and Application Performance Monitoring server. <br/>
It provides an intuitive user-interface, allowing developers to access the information and other useful metrics in real-time.

The application can be used [online](https://logbee.net), can be installed locally or it can run as a Docker container.

## Technology

- Built on .NET6
- Working on Windows, Linux and [Docker](Docker/README.md)
- Uses MongoDB 6.0 or Azure Cosmos DB (when hosted on Microsoft Azure)

## Artifacts

logBee artifacts can be downloaded from here: <br/>
<https://github.com/logBee-net/logBee-app/releases>

Installation and configuration guide can be found here: <br/>
[https://logBee.net/Docs/on-premises.index.html](https://logBee.net/Docs/on-premises.index.html)

### Latest versions

[logBee.Frontend-v1.0.5](https://github.com/logBee-net/logBee-app/releases/tag/logBee.Frontend-v1.0.5)

[logBee.Backend-v1.0.1](https://github.com/logBee-net/logBee-app/releases/tag/logBee.Backend-v1.0.1)

```none
docker pull catalingavan/logbee.frontend:1.0.5
docker pull catalingavan/logbee.backend:1.0.1
```

## Integrations

### .NET

- [Serilog.Sinks.LogBee](https://github.com/catalingavan/serilog-sinks-logbee)
- [KissLog.Sdk](https://github.com/catalingavan/KissLog.Sdk)

### REST

You can create logs by consuming the REST endpoint provided by logBee.

```
POST http://localhost:44088/request-logs
{
  "organizationId": "_OrganizationId_",
  "applicationId": "_ApplicationId_",
  "startedAt": "2024-03-11T14:36:31.108Z",
  "durationInMilliseconds": 41,
  "httpProperties": {
    "absoluteUri": "http://localhost/catalog/createProduct?locale=en",
    "method": "POST",
    "response": {
      "statusCode": 200
    }
  },
  "logs": [
    {
      "logLevel": "Information",
      "message": "Creating product..."
    }
  ]
}
```

## User interface

<table><tr><td>
    <img alt="User interface" src="https://github.com/logBee-net/logBee-app/assets/39127098/44c8686b-bc24-4c4e-9fd8-155da9826a08" />
</td></tr></table>
