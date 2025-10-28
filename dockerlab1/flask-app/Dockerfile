FROM python:3.9.24-slim-trixie  
WORKDIR /app/
COPY . .
RUN pip install -r requirments.txt
EXPOSE 5000
CMD ["python", "flask-app.py"]    