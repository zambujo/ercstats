build:
	docker build --rm --force-rm --file=./Dockerfile --tag=ercstats .

runonly:
	docker run -d --rm -p 8787:8787 \
		-e DISABLE_AUTH=true \
		--name='ercstats' \
		ercstats;

run: build runonly

runmac: runonly
	sleep 1;
	open http://127.0.0.1:8787;
	
runlinux: runonly
	sleep 1;
	firefox http://127.0.0.1:8787;

stop:
	docker stop ercstats

start:
	docker start ercstats
	
clean: stop
	docker remove ercstats