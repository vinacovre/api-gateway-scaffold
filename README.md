# API Gateway Scaffold [![CircleCI](https://circleci.com/gh/vinacovre/api-gateway-scaffold/tree/master.svg?style=svg)](https://circleci.com/gh/vinacovre/api-gateway-scaffold/tree/master)

Template for an API Gateway in Node.js using Express.js for routing, CircleCI and Jenkins for CI&CD, and containerized with Docker and K8s

## Code Architecture

The code is organized in the following order:

1. **Routes**: expose API calls using [Express.js](https://expressjs.com/) framework. Must only communicate with controllers.

2. **Controllers**: validate input from API calls and handle HTTP errors and responses. They call business rules by communicating with the services.

3. **Services**: hold business logic. They communicate with clients or other services and respond to the controllers.

4. **Clients**: make external communications. They communicate with third-party APIs, databases, SDKs, and respond to the services.

5. **Bin**: hold files for running up the server.

6. **Docs**: hold documentation files (except the README).

7. **Lib**: hold files that can be reused inside the project, such as middleware, toolkit, and configuration.

## Working Locally

### Start application

You can start the API locally by running:

```bash
  make start
```

### Running Tests

Run the lint verification with the command:

```bash
  make lint
```

You can run both unit (no tests provided, since it's a template) and integration tests with:

```bash
  make test
```

Remember that for running tests the docker image must have already been created beforehand with either `make start` or `make build` commands.
