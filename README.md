# logBee app

## About

logBee is a logging, exceptions tracking and Application Performance Monitoring server. <br/>
It provides a powerful and easy to use user-interface, allowing for viewing and analyzing the data in real time.

logBee ingests data via REST interfaces, making it compatible with any programming language and platform.

[logBee.net](https://logBee.net), the public instance of logBee, currently processes about 200 logs per second and a total of 50 million logs per month.

### Technology

- Built on .NET6
- Working on Windows, Linux and [Docker](Docker/README.md)
- Uses MongoDB 6.0 or Azure Cosmos DB (as it can be hosted on Microsoft Azure)

## Artifacts

logBee artifacts can be downloaded from here: <br/>
<https://github.com/logBee-net/logBee-app/releases>

Installation and configuration guide can be found here: <br/>
[https://logBee.net/Docs/on-premises.index.html](https://logBee.net/Docs/on-premises.index.html)

### Latest versions

[logBee.Frontend-v0.0.1](https://github.com/logBee-net/logBee-app/releases/tag/logBee.Frontend-v0.0.1)

[logBee.Backend-v0.0.3](https://github.com/logBee-net/logBee-app/releases/tag/logBee.Backend-v0.0.3)

```none
docker pull catalingavan/logbee.frontend:0.0.1
docker pull catalingavan/logbee.backend:6.0.1
```

## Saving logs

- .NET applications can use the [KissLog.Sdk](https://github.com/KissLog-net/KissLog.Sdk) library which automatically sends all the logs and metrics to logBee

- Submitting logs using the REST interface

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
    <img alt="User interface" src="https://github.com/KissLog-net/KissLog-server/assets/39127098/8944691a-3f6e-4946-9a73-85390a867b87" />
</td></tr></table>

