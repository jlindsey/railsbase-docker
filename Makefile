default:
	docker build -t jlindsey/railsbase-docker .

clean:
	docker rmi -f jlindsey/railsbase-docker

.PHONY: default clean

