FROM ubuntu:latest

ENV PATH="/usr/lib/postgresql/10/bin:${PATH}"
ENV PATH="/usr/local/bin:${PATH}"
ENV PYTHONPATH="/ENV/lib/python2.7/site-packages:${PYTHONPATH}"

RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -y python-pip postgresql && \
    apt-get install make && \
    apt-get install gcc

RUN apt-get install -y postgresql-server-dev-10

COPY ENV /ENV
COPY main.py /main.py

RUN pip install psycopg2 -t ENV/lib/python2.7/site-packages

ADD http://ephemeralpg.org/code/ephemeralpg-2.5.tar.gz /ENV

RUN tar -xzf /ENV/ephemeralpg-2.5.tar.gz -C /ENV && rm /ENV/ephemeralpg-2.5.tar.gz
RUN pg_tmp=$(find /ENV -maxdepth 2 -type d -name '*ephemeralpg*') && make install -C $pg_tmp

RUN chown -R postgres:postgres /main.py
RUN chmod 777 /main.py

# Switch USER to non-root to run BasicTest
USER postgres

CMD [ "sh", "-c", "python main.py" ]