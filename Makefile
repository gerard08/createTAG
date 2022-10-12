KEYWORD=TAG: 

run: build
	docker run --rm keyword-release-action $(KEYWORD)

build:
	docker build --tag keyword-release-action .

test:
	bash entrypoint.sh $(KEYWORD)