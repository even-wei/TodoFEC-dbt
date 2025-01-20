FROM mcr.microsoft.com/vscode/devcontainers/python:3.12

COPY README.md .
COPY pyproject.toml .
COPY poetry.lock .

RUN pip install poetry && poetry install
