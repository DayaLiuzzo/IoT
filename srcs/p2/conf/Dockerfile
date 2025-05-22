FROM python:3.9-slim
COPY app.py /app.py
RUN pip install flask
ENV APP_NAME=default
CMD ["python", "/app.py"]