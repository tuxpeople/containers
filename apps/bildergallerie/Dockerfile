FROM python:3.9-slim
WORKDIR /app
COPY ./apps/bildergallerie/requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8080
CMD ["python", "app.py"]
