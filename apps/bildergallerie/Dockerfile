# Build stage with dev tools
# Chainguard only publishes `latest` tags for free; pin the digest so Renovate
# proposes base image updates as PRs that have to pass CI.
FROM cgr.dev/chainguard/python:latest-dev@sha256:8a5780972067cfba4592b10e786a889807ed876c1100f89410fd0ed4e398992c AS build

WORKDIR /app

# Install dependencies in virtual environment
COPY ./apps/bildergallerie/requirements.txt .
RUN python -m venv /home/nonroot/venv && \
    /home/nonroot/venv/bin/pip install --no-cache-dir -r requirements.txt

# Runtime stage with minimal image
FROM cgr.dev/chainguard/python:latest@sha256:35d6025b288eb1c40ae631db77ed6cdd26c6f51d898428d8fc9989db7f29e784

WORKDIR /app

# Copy virtual environment and application
COPY --from=build /home/nonroot/venv /home/nonroot/venv
COPY ./apps/bildergallerie .

# Set PATH to use virtual environment
ENV PATH="/home/nonroot/venv/bin:$PATH"

EXPOSE 8080
# The image's entrypoint is /usr/bin/python, which ignores the venv in PATH
ENTRYPOINT ["/home/nonroot/venv/bin/python"]
CMD ["app.py"]
