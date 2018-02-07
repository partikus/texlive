FROM ubuntu

RUN apt-get -qq update --fix-missing && \
    apt-get install --yes make texlive-full && \
    rm -rf /var/lib/apt/lists/*
