FROM python:3.11-slim

WORKDIR /workspace

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "tensorflow[and-cuda]==2.21.0" jupyterlab notebook ipykernel

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888 6006