build:
	docker build --rm --force-rm --file=./Dockerfile --tag=ercstats .

run: build
	docker run -d --rm -p 8787:8787 \
		-e DISABLE_AUTH=true \
		--name='ercstats' \
		ercstats;
		sleep 1;
		open http://127.0.0.1:8787; # (Mac)
		# firefox http://127.0.0.1:8787; # (Linux)

stop:
	docker stop ercstats

start:
	docker start ercstats
