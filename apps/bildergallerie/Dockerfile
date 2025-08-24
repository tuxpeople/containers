FROM python:3.13-slim
WORKDIR /app
COPY ./apps/bildergallerie/requirements.txt .
RUN pip install -r requirements.txt
COPY ./apps/bildergallerie .
EXPOSE 8080
CMD ["python", "app.py"]
