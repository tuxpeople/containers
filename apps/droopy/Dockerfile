FROM registry.access.redhat.com/ubi9/python-311:9.6-1754318683

# Install required utilities as root, then switch to non-root user
RUN dnf install -y file && \
    dnf clean all

USER 1001

COPY ./apps/droopy/root/ /

# Download and verify droopy script
RUN curl -fsSL https://raw.githubusercontent.com/gurnec/Droopy/improve-ssl-security/droopy -o /tmp/droopy && \
    # Verify the download is a Python script and has expected content
    file /tmp/droopy | grep -q "Python script" && \
    grep -q "droopy" /tmp/droopy && \
    chmod 755 /tmp/droopy && \
    mv /tmp/droopy /app/droopy

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
