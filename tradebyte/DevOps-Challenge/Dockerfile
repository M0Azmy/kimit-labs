FROM python:3.9.24-slim-trixie
WORKDIR /app




# Set default environment variables

# ENV REDIS_HOST=redis
# ENV REDIS_PORT=6379
# ENV REDIS_DB=0
# ENV ENVIRONMENT=development
# ENV HOST=0.0.0.0
# ENV PORT=5000


COPY . .

RUN pip install -r requirements.txt
EXPOSE 5000


CMD ["python", "hello.py"]
