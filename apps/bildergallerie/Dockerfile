# Build stage with dev tools
FROM cgr.dev/chainguard/python:latest-dev AS build

WORKDIR /app

# Install dependencies in virtual environment
COPY ./apps/bildergallerie/requirements.txt .
RUN python -m venv /home/nonroot/venv && \
    /home/nonroot/venv/bin/pip install --no-cache-dir -r requirements.txt

# Runtime stage with minimal image
FROM cgr.dev/chainguard/python:latest

WORKDIR /app

# Copy virtual environment and application
COPY --from=build /home/nonroot/venv /home/nonroot/venv
COPY ./apps/bildergallerie .

# Set PATH to use virtual environment
ENV PATH="/home/nonroot/venv/bin:$PATH"

EXPOSE 8080
CMD ["python", "app.py"]
