# GeoServer Demo

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) — required to run GeoServer.
- [just](https://just.systems/man/en/installation.html) — command runner for the recipes in this repo. Tested with **just 1.51.0**.

## Configuration

Copy `.env.example` to `.env` to override any default value:

```shell
cp .env.example .env
```

Docker Compose picks up `.env` automatically. Edit it to change the image tag, data directory path, or enable extensions.

| Variable               | Default            | Description                                                                      |
| ---------------------- | ------------------ | -------------------------------------------------------------------------------- |
| `GEOSERVER_TAG`        | `2.28.3`           | GeoServer image tag                                                              |
| `DATA_DIR`             | `./geoserver_data` | Host path bind-mounted into the container                                        |
| `SKIP_DEMO_DATA`       | `true`             | Skip loading sample data on first startup                                        |
| `INSTALL_EXTENSIONS`   | `false`            | Set to `true` to install extensions                                              |
| `STABLE_EXTENSIONS`    | _(empty)_          | Comma-separated stable extensions (e.g. `ysld,ogcapi-features`)                  |
| `COMMUNITY_EXTENSIONS` | _(empty)_          | Comma-separated community extensions (e.g. `sec-oidc`)                           |
| `COMMUNITY_PLUGIN_URL` | _(empty)_          | Override community plugin base URL (auto-derived from tag when using `just dev`) |

### Data directory

GeoServer stores workspaces, layers, styles, and logs in a data directory. This repo includes an empty `geoserver_data/` folder that is bind-mounted into the container at `/opt/geoserver_data`.

On first run, if the folder is empty, the official image populates it with the [GeoServer sample data directory](https://docs.geoserver.org/main/en/user/installation/docker/#installation_docker_data). Your configuration then persists across container restarts.

To use your own data directory, set `DATA_DIR` in `.env` or pass it to `just`:

```shell
just dev data_dir=/path/to/your/geoserver_data
```
