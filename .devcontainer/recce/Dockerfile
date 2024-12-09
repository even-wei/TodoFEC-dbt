FROM mcr.microsoft.com/vscode/devcontainers/python:3.12

COPY pyproject.toml .
COPY poetry.lock .

RUN pip install poetry && poetry install
