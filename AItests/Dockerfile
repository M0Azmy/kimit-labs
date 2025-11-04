# ---- Builder Stage ----
FROM python:3.9-alpine AS builder

# Set the working directory
WORKDIR /app

# Install build essentials for compiling dependencies
RUN apk add --no-cache build-base

# Create a virtual environment
RUN python -m venv /opt/venv

# Activate the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Final Stage ----
FROM python:3.9-alpine

# Create a non-root user and group
RUN addgroup -S appuser && adduser -S -G appuser appuser

# Set the working directory
WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder /opt/venv /opt/venv

# Copy the application code
COPY . .

# Set the path to include the virtual environment's bin directory
ENV PATH="/opt/venv/bin:$PATH"

# Change ownership of the app directory
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Expose the application port (default is 8888)
EXPOSE 8888

# Set the command to run the application
CMD ["python", "hello.py"]
