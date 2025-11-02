FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install -r requirments.txt

EXPOSE 5000

CMD ["python", "flask-app.py"]

# Estimated size for this image is 1.01GB
