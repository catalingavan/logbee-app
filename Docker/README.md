# logBee app on Docker

logBee app can run as a Docker container, thanks to [Marcio](https://github.com/zimbres) valuable contribution.

In this folder you will find all the necessary files.

```none
# starts the logBee app and all the necesarry prerequisites
C:\logBee-net\logBee-app\Docker> docker-compose up

# stops the logBee app docker containers
C:\logBee-net\logBee-app\Docker> docker-compose down

# Authentication token,
# a JWT signed with the value from frontend.logBee.json@$.Authorization.HS256Secret
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.HP79qro7bvfH7BneUy5jB9Owc_5D2UavFDulRETAl9E

# logBee.Frontend endpoint
http://localhost:44080/

# logBee.Backend endpoint
http://localhost:44088/
```

```csharp
// start sending the logs to the local logBee.Backend endpoint
app.UseKissLogMiddleware(options => {
    options.Listeners.Add(new RequestLogsApiListener(new Application("_OrganizationId_","_ApplicationId_"))
    {
        ApiUrl = "http://localhost:44088/"
    });
});
```

![logBee login](https://github.com/logBee-net/logBee-app/assets/39127098/4bf1fca5-8250-4e96-a0fe-c6fe55fc439d)

![Running docker-compose](https://github.com/logBee-net/logBee-app/assets/39127098/895ae32f-f546-4004-a66e-ed64027250b4)