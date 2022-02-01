# based on https://hub.docker.com/r/makarius/isabelle
FROM ubuntu

# packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && \
  apt-get install -y curl less libfontconfig1 libgomp1 libwww-perl rlwrap unzip texlive-latex-recommended texlive-latex-extra texlive-fonts-extra texlive-lang-all && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

RUN curl https://isabelle.in.tum.de/dist/Isabelle2021-1_linux.tar.gz > Isabelle2021-1_linux.tar.gz && \
  tar xzf Isabelle2021-1_linux.tar.gz && \
  Isabelle2021-1/bin/isabelle build -v -o system_heaps -b HOL && \
  rm Isabelle2021-1_linux.tar.gz

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
