FROM cgr.dev/chainguard/python:latest

WORKDIR /app

# Copy requirements and install dependencies
COPY ./apps/bildergallerie/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY ./apps/bildergallerie .

EXPOSE 8080
CMD ["python", "app.py"]
