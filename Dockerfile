FROM python:3.11-slim
 
WORKDIR /workspace
 
RUN pip install --no-cache-dir tensorflow jupyterlab notebook ipykernel
 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
 
EXPOSE 8888 6006