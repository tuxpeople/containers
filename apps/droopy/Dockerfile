FROM python:3.14-alpine

COPY ./apps/droopy/root/ /

# Create non-root user and app directory
RUN addgroup -S droopy && \
    adduser -S -h /app -D -s /bin/false droopy -G droopy && \
    mkdir -p /app /uploads && \
    chown -R droopy:droopy /app /uploads

# Download and verify droopy script as root, then switch to non-root user
RUN curl -fsSL https://raw.githubusercontent.com/gurnec/Droopy/improve-ssl-security/droopy -o /tmp/droopy && \
  # Verify the download succeeded and has reasonable content
  [ -s /tmp/droopy ] && \
  [ $(wc -l < /tmp/droopy) -gt 10 ] && \
  chmod 755 /tmp/droopy && \
  mv /tmp/droopy /app/droopy && \
  chown -R droopy:droopy /app /uploads

USER droopy

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
