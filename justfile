set dotenv-load := true

default:
    @just -f {{ justfile() }} --list --list-heading $'Available commands:\n'

# List available GeoServer Docker image tags matching a regex.
list-images regex='^2\.28':
    skopeo list-tags docker://docker.osgeo.org/geoserver | jq -r '.Tags[]' | grep -E '{{regex}}'

# Start GeoServer locally on http://localhost:8080.
dev:
    docker compose up -d

# Follow logs from the GeoServer container.
logs:
    docker compose logs -f

# Run a command inside the GeoServer container.
exec +command:
    #!/usr/bin/env bash
    set -euo pipefail
    if [ -t 0 ]; then
      docker compose exec -it geoserver {{command}}
    else
      docker compose exec geoserver {{command}}
    fi

# Stop and remove the GeoServer container.
down:
    docker compose down
