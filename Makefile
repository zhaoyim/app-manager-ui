RELEASE_DIR=./release
VER=1.8.0
NODE_VER=10.17.0-jessie
DOCKER_IMG_NAME=appmgr-ui:${VER}

all:
	make buildnode
	make package

buildnode:
	docker run --rm --privileged -v `pwd`:/opt --workdir /opt node:${NODE_VER} sh -c "npm install; npm run build:prod"
	
package:
	- docker rm -f appweb
	- docker rmi -f ${DOCKER_IMG_NAME}
	docker build -t ${DOCKER_IMG_NAME} -f ./Dockerfile .
	
run:
	appc logon -u admin -x Admin123
	- appc unreg -n appweb -f
	# use host mode for nginx reverse proxy redirect to 6060/8500
	appc reg -n appweb -e APP_DOCKER_OPTS="--net=host -v /opt/appmanager/ssl/server.pem:/etc/nginx/conf.d/server.crt:ro -v /opt/appmanager/ssl/server-key.pem:/etc/nginx/conf.d/server.key:ro" -c "nginx -g 'daemon off;'" -d ${DOCKER_IMG_NAME} -f
tar:
	docker save appmgr-ui:${VER} -o ./appmgr-ui.${VER}.tar
	tar czvf appmgr-ui.${VER}.tar.gz appmgr-ui.${VER}.tar

dev:
	git pull
	make
	make run
	
clean:
	-docker rm -f appweb
	-docker rmi -f ${DOCKER_IMG_NAME}
	rm -rf ./*.tar ./*.gz
	#rm -rf ./node_modules
