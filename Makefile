setup-dev: setup-python setup-pre-commit

setup-python:
	pip install --force-reinstall -r requirements-dev.txt

setup-pre-commit:
	pre-commit install

lint:
	pre-commit run --all-files

generate-toc:
	markdown-toc -i README.md --maxdepth 3
