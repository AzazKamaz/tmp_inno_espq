VENV ?= .venv
CODE = espq


.PHONY: venv
venv:
	python3 -m venv $(VENV)
	$(VENV)/bin/python3 -m pip install --upgrade pip
	$(VENV)/bin/python3 -m pip install poetry
	$(VENV)/bin/poetry install

.PHONY: test
test:
	$(VENV)/bin/pytest -v tests


.PHONY: ci
ci:	lint test


.PHONY: build_docker
build_docker:
	docker build -t /*image_name*/ .


.PHONY: up_dev
up_dev:
	$(VENV)/bin/poetry run dev
	

.PHONY: up
up:
	$(VENV)/bin/poetry run prod


.PHONY: up_docker
up_docker:
	docker run -it --rm -h espq --name espq -p 8080:80 /*image name*/
