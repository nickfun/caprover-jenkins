build:
	docker build -t caprover-jenkins .
run:
	docker run -p 8080:8080 caprover-jenkins