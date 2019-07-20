Don't Starve Together Dedicated Server
======================================
Don't Starve Together Dedicated Server in a docker container, with persistent game data in a volume.


## Install
#### Docker Hub
Pull the latest image from Docker Hub:

```shell
docker pull wastrachan/docker-dst
```

#### Manually
Clone this repository, and run `make build` to build an image:

```shell
git clone https://github.com/wastrachan/docker-dst.git
cd docker-bind
make build
```

If you need to rebuild the image, run `make clean build`.

## Usage
### Setup / First Run
In order to start the server, the creators of Don't Starve Together require that you generate a "Cluster Token".

1. Launch Don't Starve Together on your computer
2. Press `~` to open the console
3. Type `TheNet:GenerateClusterToken()` and press enter
4. Close your game and navigate to:
    - `/My Documents/Klei/DoNotStarveTogether/cluster_token.txt` on Windows
    - `~/Documents/Klei/DoNotStarveTogether/cluster_token.txt` on MacOS
    - ` ~/.klei/DoNotStarveTogether/cluster_token.txt` on Linux
5. Copy the token from this file to `data/DoNotStarveTogether/Cluster_1/cluster_token.txt`
6. Restart the container



### Run
Run this container with the included makefile `make start`, or manually:

```shell
docker run -d --rm \
    --name dst-server \
    -v "$(pwd)/data:/dst" \
    -p 27016:27016/tcp \
    -p 10999:10999/udp \
    wastrachan/dst-server:latest \
```

### Configuration
When you first run the container, a configuration file will be created at `data/DoNotStarveTogether/cluster.ini`.
You can open and edit this file to make changes to server settings.


### Ports
The following ports are exposed and required for the game server to run:

| Port | Description
|------|------------
| 10999 (udp) | Game server port
| 27016 (tcp) | Steam service port


### Volumes
The container makes the following volumes available:

| Volume | Description
|--------|------------
| /dst   | Game data and configuration, to persist between runs


## License
The content of this project itself is licensed under the [MIT License](LICENSE).

View license information for the software contained in this image:
* [Steamcmd](https://developer.valvesoftware.com/wiki/Valve_Developer_Community:Terms_of_Use)
* [Don't Starve Together](https://www.klei.com/games/dont-starve/terms-of-service)
