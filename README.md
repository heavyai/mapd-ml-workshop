# mapd-ml-cpu

Run with docker-compose. This depends on two containers:

| Name | Use | Dockerfile location |
| --- | --- | --- |
| `mapd-core` | MapD Database | Defaults to Community Edition on Docker Hub `mapd/mapd-ce-cpu` |
| `mapd-ml-cpu` | Demo notebooks | Dockerfile in top-level of `mapd-ml-workshop` repo |

## Build

### mapd-ml-cpu Server

To build the `mapd-ml-cpu` container, clone the repo and `cd` into it.

To build the container, run:

    docker build -t mapd-ml-cpu .

### Exporting

If you need to move the containers to a new machine, run:

    docker save -o mapd-ce-cpu.tar mapd/mapd-ce-cpu
    docker save -o mapd-ml-cpu.tar mapd-ml-cpu

    gzip mapd-ce-cpu.tar
    gzip mapd-ml-cpu.tar

You will then have files which can be moved to the new machine: `mapd-ce-cpu.tar.gz`, `mapd-ml-cpu.tar.gz`. You will also want to grab the `docker-compose.yml` file.

## Run

### Setup

Uses `docker-compose`.

Next, modify the `docker-compose.yml` file to update the path containing the `/mapd-storage` volume. The default is to store this into a `mapd-storage-ml` directory in the current dir. To point elsewhere, change the line:

    volumes
      - ./mapd-storage-ml:/mapd_storage

to, for example:

    volumes
      - /home/wamsi/mapd-storage-ml:/mapd_storage

This needs to be changed for both the `mapd-core` and the `immerse-iml` services.

Import the containers if on a clean machine:

    docker load -i mapd-ce-cpu.tar.gz
    docker load -i mapd-ml-cpu.tar.gz

### Running

If running for the first time, make sure you have [docker](https://docs.docker.com/install/) installed and run it first.

    docker ps


Finally

    docker-compose up

macOS users need to provide `host.docker.internal` as hostname during setting up connections to MapD. The reason for this being no docker0 bridge on macOS.

Below is a URL for Notebooks:

    http://localhost:8888

Below is a URL for Immerse:

    http://localhost:9092

If you are setting up dockerfile in an AWS instance then the URL would be like:

    http://<Public DNS Name>:9092

You should be able to find the Public DNS name in instances section of aws console. Make sure you allow the TCP/HTTP traffic in `security group -> inbound` settings. Replace default port 80  with Port numbers 9090, 9092, and 8888.
