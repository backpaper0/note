FROM python:3.7.7

RUN pip install --upgrade pip && \
    pip install --upgrade mkdocs==1.1 plantuml-markdown

ADD ./plantuml /usr/local/bin/plantuml

RUN apt update && \
    apt install -y openjdk-11-jdk-headless && \
    mkdir -p /opt/plantuml && \
    curl -sL -o /opt/plantuml/plantuml.jar https://repo.maven.apache.org/maven2/net/sourceforge/plantuml/plantuml/1.2020.9/plantuml-1.2020.9.jar && \
    chmod +x /usr/local/bin/plantuml

WORKDIR /workspace

EXPOSE 8000

ENTRYPOINT ["mkdocs"]

CMD ["serve", "-a", "0.0.0.0:8000"]
