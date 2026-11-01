# Build a virtualenv using Chainguard's Python dev image
# Includes pip, build tools, and everything needed for building Python packages
# Chainguard only publishes `latest` tags for free; pin the digest so Renovate
# proposes base image updates as PRs that have to pass CI.
FROM cgr.dev/chainguard/python:latest-dev@sha256:8a5780972067cfba4592b10e786a889807ed876c1100f89410fd0ed4e398992c AS build
# pygit2 has no wheels for every Python release, so build it against Wolfi's libgit2
USER root
RUN apk add --no-cache libgit2-dev
USER nonroot
RUN python -m venv /home/nonroot/venv && \
    /home/nonroot/venv/bin/pip install --upgrade pip setuptools wheel

# Build the virtualenv as a separate step: Only re-execute this step when requirements.txt changes
FROM build AS build-venv
COPY ./apps/python-base/requirements.txt /requirements.txt
RUN /home/nonroot/venv/bin/pip install --disable-pip-version-check -r /requirements.txt

# Copy the virtualenv into minimal Chainguard Python runtime image
FROM cgr.dev/chainguard/python:latest@sha256:35d6025b288eb1c40ae631db77ed6cdd26c6f51d898428d8fc9989db7f29e784
# libgit2 and the libraries it needs that the runtime image does not ship
COPY --from=build-venv /usr/lib/libgit2.so* /usr/lib/libpcre2-8.so* /usr/lib/libssh2.so* /usr/lib/
COPY --from=build-venv /home/nonroot/venv /home/nonroot/venv
ENV PATH="/home/nonroot/venv/bin:$PATH"
ENTRYPOINT ["python"]
