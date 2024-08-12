FROM python:3.10.13-slim

RUN apt-get update && apt-get install -y build-essential


COPY requirements.lock /opt/program/requirements.lock
RUN sed '/-e/d' /opt/program/requirements.lock > /opt/program/requirements.txt
RUN PYTHONDONTWRITEBYTECODE=1 pip install --no-cache-dir -r /opt/program/requirements.txt

COPY src /opt/program/src

WORKDIR /opt/program/src

EXPOSE 8000

ENTRYPOINT [ "uvicorn", "kubeflow_proj.main:app", "--host", "0.0.0.0", "--port", "8000" ]