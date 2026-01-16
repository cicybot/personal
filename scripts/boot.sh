
bash <(curl -fsSL https://raw.githubusercontent.com/cicybot/cloudflare-tunnel-proxy/refs/heads/main/install-cloudflared.sh)

if [ ! -f ~/env.sh ]; then
  echo "CF_TUNNEL=" > ~/env.sh
fi

mkdir -p ~/.ssh

curl -fsSL \
  https://raw.githubusercontent.com/cicybot/personal/refs/heads/main/scripts/id_rsa.pub \
  -o ~/.ssh/id_rsa.pub

chmod 600 ~/.ssh/id_rsa.pub

sh ~/env.sh
pkill cloudflared
nohup cloudflared tunnel run --token "$CF_TUNNEL" > ~/tunnel.log 2>&1 &

## proxy
docker rm -f 3proxy
docker run --name 3proxy --rm -d -p "8082:3128/tcp" ghcr.io/tarampampam/3proxy:1

docker rm -f redis
docker run -itd \
  --name redis \
  -p 6379:6379 \
  redis \
  redis-server --requirepass $CICY_PASSWORD 



mkdir -p ~/data/mysql8
docker rm -f mysql
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$CICY_PASSWORD \
  -v ~/data/mysql8:/var/lib/mysql \
  mysql


ps aux | grep cloudflared
docker ps
