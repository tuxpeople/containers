FROM registry.access.redhat.com/ubi9/python-311:9.6-1754318683

USER 1001

COPY ./apps/droopy/root/ /

# Download and verify droopy script
RUN curl -fsSL https://raw.githubusercontent.com/gurnec/Droopy/improve-ssl-security/droopy -o /tmp/droopy && \
    # Verify the download has expected Python content
    head -1 /tmp/droopy | grep -q "python" && \
    grep -q "droopy" /tmp/droopy && \
    # Verify the file is not empty and has reasonable size
    [ -s /tmp/droopy ] && \
    [ $(stat -c%s /tmp/droopy) -gt 1000 ] && \
    chmod 755 /tmp/droopy && \
    mv /tmp/droopy /app/droopy

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
