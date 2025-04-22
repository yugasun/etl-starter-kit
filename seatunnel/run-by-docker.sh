export network="seatunnel_seatunnel_network"
export master_url="172.16.0.2:5801"

# you need update yourself master container ip to `ST_DOCKER_MEMBER_LIST`
docker run --name seatunnel_client \
    --network $network \
    -e ST_DOCKER_MEMBER_LIST=$master_url \
    --rm \
    apache/seatunnel \
    ./bin/seatunnel.sh  -c config/v2.batch.config.template


# you need update yourself master container ip to `ST_DOCKER_MEMBER_LIST`
docker run --name seatunnel_client \
    --network $network \
    -e ST_DOCKER_MEMBER_LIST=$master_url \
    --rm \
    apache/seatunnel \
    ./bin/seatunnel.sh  -l