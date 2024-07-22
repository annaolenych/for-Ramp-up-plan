FROM python:3.12-slim

RUN pip install requests datadog

COPY nginx_status_check.py /checks.d/nginx_status_check.py

CMD ["sleep", "infinity"]
