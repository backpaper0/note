FROM python:3.7.7

RUN pip install --upgrade pip && \
    pip install --upgrade mkdocs

WORKDIR /workspace

EXPOSE 8000

ENTRYPOINT ["mkdocs"]

CMD ["serve", "-a", "0.0.0.0:8000"]
