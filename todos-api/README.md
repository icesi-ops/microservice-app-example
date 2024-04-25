# TODOs API

This service is written in NodeJS, it provides CRUD operations over TODO entries.
It keeps all the data in memory. CREATE and DELETE operations are logged by
sending appropriate message to a Redis queue. The messages are then processed by
`log-message-processor`.

- `GET /todos` - list all TODOs for a given user
- `POST /todos` - create new TODO
- `DELETE /todos/:taskId` - delete a TODO by ID

TODO object looks like this:
```
{
    id: 1,
    userId: 1,
    content: "Create new todo"
}
```
Log message looks like this:
```
{
    opName: CREATE,
    username: username,
    todoId: 5,
}
```

## Configuration

The service scans environment for variables:
- `TODO_API_PORT` - the port the service takes.
- `JWT_SECRET` - secret value for JWT token processing. Must be the same amongst all components.
- `REDIS_HOST` - host of Redis
- `REDIS_PORT` - port of Redis
- `REDIS_CHANNEL` - channel the processor is going to listen to

## Building

```
npm install
```
## Running
```
JWT_SECRET=PRFT TODO_API_PORT=8082 
```

## Usage
In case you need to test this API, you can use it as follows:
```
 curl -X POST -H "Authorization: Bearer $token" http://127.0.0.1:8082/todos -d '{"content": "deal with that"}'
```
where `$token` is the response you get from [Auth API](/auth-api). 

## Dependencies
Here you can find the software required to run this microservice, as well as the version we have tested. 
|  Dependency | Version  |
|-------------|----------|
| Node        | 8.17.0   |
| NPM         | 6.13.4   |