default: rebuild

build:
	sudo docker build -t "ss" .

rebuild:
	sudo docker image rm -f ss
	sudo docker container rm ss

	sudo docker build -t "ss" .

run:
	sudo docker run -d  -v /work/upload_files:/opt/upload_files --network="host" -p 10804:10804 --name ss ss

start:
	sudo docker start ss

stop:
	sudo docker stop ss

shell:
	# sudo docker run -it  -v /work/appkmonitor/files:/opt/app/files -p 8888:8888 --name ss ss
	docker exec -it ss ash

log:
	docker logs ss

none:
	docker rmi $(docker images --filter "dangling=true" -q)

post1:
	curl -X POST -F "file=@./xxxx.file" http://10.11.67.39:8888/uploadfile

post2:
	curl -X POST -F "file=@./xxxx.file" http://10.11.67.39:8888/uploadfile

post3:
	curl -H "Content-Type:application/json" -X POST --data '{"apkurl":"tgac.apk", "bundle":"tgac_bundle.txt", "tag":"tgac_trunk"}' http://10.11.67.39:8888/uploadurl

post4:
	curl -H "Content-Type:application/json" -X POST --data '{"apkurl":"tgac.apk", "bundle":"tgac_bundle.txt", "tag":"tgac_trunk", "bundlenumber":104}' http://10.11.67.39:8888/uploadurl

ddev:
	vuepress dev docs
	
doc:
	rm -rf flaskapp/static && vuepress build docs --dest flaskapp/static
	#python3 flaskapp/__init__.py

dev:
	python3 flaskapp/__init__.py

up:
	git pull origin master