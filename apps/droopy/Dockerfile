FROM registry.access.redhat.com/ubi9/python-311:9.6-1754318683

COPY ./apps/droopy/root/ /

# Download and verify droopy script as root, then switch to non-root user
RUN curl -fsSL https://raw.githubusercontent.com/gurnec/Droopy/improve-ssl-security/droopy -o /tmp/droopy && \
    # Verify the download succeeded and has reasonable content
    [ -s /tmp/droopy ] && \
    [ $(wc -l < /tmp/droopy) -gt 10 ] && \
    chmod 755 /tmp/droopy && \
    mv /tmp/droopy /app/droopy && \
    chown -R 1001:1001 /app

USER 1001

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
