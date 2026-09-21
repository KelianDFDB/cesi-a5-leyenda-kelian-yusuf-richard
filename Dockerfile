FROM tensorflow/tensorflow:latest-jupyter
WORKDIR /workspace
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt