all: build run

build:
	 docker build -t kfs_dev_machine .

run:
	docker run -it --rm -v $(shell pwd)/dev:/root/dev kfs_dev_machine