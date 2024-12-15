FROM node:20-bookworm

RUN npx -y playwright install-deps firefox

USER root
RUN mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

RUN pip install robotframework
RUN pip install robotframework-browser

RUN rfbrowser init firefox