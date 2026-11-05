FROM python:3.15-alpine

COPY ./apps/droopy/root/ /

# Create non-root user and app directory
RUN addgroup -S droopy && \
    adduser -S -h /app -D -s /bin/false droopy -G droopy && \
    mkdir -p /app /uploads && \
    chown -R droopy:droopy /app /uploads

# Upstream has not changed this branch since 2023; pin the commit so the
# build is reproducible (python:alpine has no curl anyway)
ADD --chmod=755 --chown=droopy:droopy \
    https://raw.githubusercontent.com/gurnec/Droopy/4aec4b2e8464c3466cc4d85a1ecf0fc248dc2cce/droopy \
    /app/droopy

# Python 3.13 removed the cgi module that droopy still imports
# renovate: datasource=pypi depName=legacy-cgi
ARG LEGACY_CGI_VERSION=2.6.4
RUN pip install --no-cache-dir "legacy-cgi==${LEGACY_CGI_VERSION}"

USER droopy

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
