FROM centos/systemd

# Add shiny server
RUN yum -y install epel-release && \
  yum -y update && \
  yum-complete-transaction

RUN yum -y install R git wget httpd

RUN R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"

RUN wget --no-verbose https://download3.rstudio.org/centos6.3/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/centos6.3/x86_64/shiny-server-$VERSION-x86_64.rpm" -O ss-latest.rpm && \
    yum -y install --nogpgcheck ss-latest.rpm && \
    rm -f version.txt ss-latest.rpm && \
    . /etc/environment

# Protect server installation

# Exclude action outside web directory

#VOLUME /srv/shiny-server/

EXPOSE 3838

#COPY shiny-server.sh /usr/bin/shiny-server.sh

#CMD ["/usr/bin/shiny-server.sh"]
