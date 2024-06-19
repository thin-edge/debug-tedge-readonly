
up:
    docker compose up -d --build

down:
    docker compose down

shell:
    docker compose exec tedge sh

download:
    wget -O - https://dl.cloudsmith.io/public/thinedge/tedge-dev/raw/names/tedge-arm64/versions/1.1.2-rc118+g476783c/tedge.tar.gz | tar xzvf - > arm64/tedge
    chmod +x arm64/tedge
