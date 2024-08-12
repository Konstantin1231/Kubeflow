FROM python:3.10.13-slim

RUN apt-get update && apt-get install -y build-essential

WORKDIR /opt/program/
COPY requirements.lock /opt/program/requirements.lock
RUN sed '/-e/d' requirements.lock > requirements.txt
RUN PYTHONDONTWRITEBYTECODE=1 pip install --no-cache-dir -r /opt/program/requirements.txt

COPY src /opt/program/src

EXPOSE 8000

ENTRYPOINT [ "uvicorn", "src.main:app", "--host", "localhost", "--port", "8000" ]