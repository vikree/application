ARG baseImageRepo
FROM python:3.11-slim-bullseye


ARG INDEX_URL
ENV PIP_INDEX_URL=$INDEX_URL

COPY requirements.txt .

RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 8080

RUN groupadd -g 1001 appgroup && useradd -G appgroup -u 1001 appuser
USER appuser

WORKDIR /app

COPY --chown=appuser:appgroup src ./src

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "./src/app.py"]