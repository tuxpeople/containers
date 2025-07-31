FROM registry.access.redhat.com/ubi9/python-311:9.6-1753967630

USER 1001

COPY ./apps/droopy/root/ /
ADD --chmod=755 --chown=1001 https://raw.githubusercontent.com/gurnec/Droopy/improve-ssl-security/droopy /app

WORKDIR /app

EXPOSE 8000

ENTRYPOINT ["python3", "/app/droopy"]
CMD ["-d", "/uploads"]
