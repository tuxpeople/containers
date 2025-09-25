# Build a virtualenv using Chainguard's Python dev image
# Includes pip, build tools, and everything needed for building Python packages
FROM cgr.dev/chainguard/python:latest-dev AS build
RUN python -m venv /home/nonroot/venv && \
    /home/nonroot/venv/bin/pip install --upgrade pip setuptools wheel

# Build the virtualenv as a separate step: Only re-execute this step when requirements.txt changes
FROM build AS build-venv
COPY ./apps/python-base/requirements.txt /requirements.txt
RUN /home/nonroot/venv/bin/pip install --disable-pip-version-check -r /requirements.txt

# Copy the virtualenv into minimal Chainguard Python runtime image
FROM cgr.dev/chainguard/python:latest
COPY --from=build-venv /home/nonroot/venv /home/nonroot/venv
ENV PATH="/home/nonroot/venv/bin:$PATH"
ENTRYPOINT ["python"]
