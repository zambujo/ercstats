build:
	docker build --file=./Dockerfile --tag=ercstats .

run: build
	docker run -d -p 8787:8787 \
		-e DISABLE_AUTH=true \
		--name='ercstats' \
		-v ${HOME}:/home/rstudio/hostdata \
		ercstats;

	sleep 3;
	firefox 127.0.0.1:8787;

stop:
	docker stop ercstats

start:
	docker start ercstats

remove: stop
	docker rm ercstats