# Build stage with dev tools
# Chainguard only publishes `latest` tags for free; pin the digest so Renovate
# proposes base image updates as PRs that have to pass CI.
FROM cgr.dev/chainguard/python:latest-dev@sha256:157a562dbc225a2a9039dbd8249cbf704202260ba27bf525f24e47a3a685050f AS build

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
