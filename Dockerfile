FROM eigenerserver/ubuntu:0.1.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    gcc \
    libffi-dev \
    python2.7 \
    python2.7-dev \
    libssl-dev \
    libffi-dev \
    imagemagick \
    git && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*

# Fix Let's Encrypt CA not included in Ubuntu's CA bundle
RUN apt-get update && \
    apt-get -y --no-install-recommends install --reinstall ca-certificates && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python2.7 /usr/local/bin/python

RUN curl -f https://www.getlektor.com/install.sh | \
    sed '/stdin/d;s/input = .*/return/' | \
    sh

RUN git clone https://github.com/eigener-server/lektor-bootstrap.git /project

EXPOSE 5000
COPY run.sh /usr/local/bin/run.sh 
RUN chmod +x /usr/local/bin/* 

WORKDIR ["/host/lektor/project"]

ENTRYPOINT ["/bin/bash","/usr/local/bin/run.sh"] 
CMD ["lektor", "server", "--host", "0.0.0.0"]