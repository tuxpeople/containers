FROM python:3.13-alpine

# Create non-root user
RUN addgroup -S appuser && \
    adduser -S -h /app -D -s /bin/false appuser -G appuser

WORKDIR /app

# Install dependencies as root
COPY ./apps/bildergallerie/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files and change ownership
COPY ./apps/bildergallerie .
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

EXPOSE 8080
CMD ["python", "app.py"]
