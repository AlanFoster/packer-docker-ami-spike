FROM python:3.7.3-alpine3.9

WORKDIR /app

RUN pip install pipenv
COPY Pipfile Pipfile.lock ./
RUN pipenv install --deploy --dev --ignore-pipfile --system

COPY . .

CMD ["python3", "main.py"]
