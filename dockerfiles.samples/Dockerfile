# No optimization 

FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install -r requirments.txt

EXPOSE 5000

CMD ["python", "flask-app.py"]

# image size ---> 1.1 GB
