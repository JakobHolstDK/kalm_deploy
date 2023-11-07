docker network create systemservice >/dev/null  2>&1
DID=$(docker ps |grep consul |awk '{ print $1 }' )
docker stop $DID
docker rm consul


docker run \
   -d \
   -p 8500:8500 \
   -p 8600:8600/udp \
   --name=consul \
   --net=systemservice \
    hashicorp/consul agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0
