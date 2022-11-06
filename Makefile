VENV ?= .venv
CODE = espq


.PHONY: venv
venv:
	python -m venv $(VENV)
	$(VENV)/bin/python -m pip install --upgrade pip
	$(VENV)/bin/python -m pip install poetry
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
	$(VENV)/bin/uvicorn --port 8080 espq.main:app --reload


.PHONY: up
up:
	$(VENV)/bin/uvicorn --host 0.0.0.0 --port 8080 espq.main:app


.PHONY: up_docker
up_docker:
	docker run -it --rm -h espq --name espq -p 8080:80 /*image name*/
