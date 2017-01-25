# Elasticsearch Curator

[![Build Status](https://travis-ci.org/mlaccetti/docker-elasticsearch-curator.svg?branch=master)](https://travis-ci.org/mlaccetti/docker-elasticsearch-curator)

An tiny Alpine-based container that allows one to use the Elasticsearch `curator` command. By default, runs in a loop sleeping for the `INTERVAL_IN_HOURS`, then running cleanup again.  However, you can pass in a new `CMD` - prefix with `-` to simply append arguments to the `curator` command, or execute a completely different argument (e.g. `/bin/bash`).

Available in two different flavours:

## 3.5

Used to connect to Elasticsearch 1.x, 2.x and the AWS Elasticsearch 1.x/2.x instances.

## 4.5

Used to connect to Elasticsearch 2.x and 5.x.

## Running

### Default Values

```
ELASTICSEARCH_HOST=elasticsearch
ELASTICSEARCH_CURATOR_ARGS=
INTERVAL_IN_HOURS=24
OLDER_THAN_IN_DAYS=30
```

### Examples

**Specifying the host**

```
docker run -d -e "ELASTICSEARCH_HOST=my.random.host" mlaccetti/elasticsearch-curator
```

**Using TLS and Authentication**

```
docker run -d -e "ELASTICSEARCH_HOST=my.random.host" -e "ELASTICSEARCH_CURATOR_ARGS=--use-ssl --http_auth username:password" mlaccetti/elasticsearch-curator
```

## Building

### Default Values

```
ELASTICSEARCH_CURATOR_VERSION=4.2.5
ELASTICSEARCH_CURATOR_CLI=curator_cli
```

### Example

```
docker build --build-arg ELASTICSEARCH_CURATOR_VERSION=3.5.1 --build-arg ELASTICSEARCH_CURATOR_CLI=curator -t mlaccetti/elasticsearc-curator:3.5.1 .
```
