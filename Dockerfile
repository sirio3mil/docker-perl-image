FROM centos:latest
ENV container docker
MAINTAINER "Reynier de la Rosa" <reynier.delarosa@outlook.es>

RUN yum -y update
RUN yum -y install epel-release \
                   wget
RUN yum -y groupinstall "Development Tools"
RUN yum -y install freedts \
                   freetds-devel \
                   spawn-fcgi \
                   fcgi-devel \
                   perl \
                   perl-SOAP-Lite \
                   perl-Switch \
                   perl-DBI \
                   perl-Env \
                   perl-CGI-Session \
                   perl-Tie-IxHash \
                   perl-Crypt-CBC \
                   perl-Spreadsheet-WriteExcel \
                   perl-Excel-Writer-XLSX \
                   perl-Crypt-RC4
RUN yum clean all 
RUN wget https://driesrpms.eu/redhat/el7/en/x86_64/dries.all/RPMS/perl-Class-Multimethods-1.70-1.2.el7.rf.noarch.rpm
RUN wget https://driesrpms.eu/redhat/el7/en/x86_64/dries.all/RPMS/perl-Quantum-Superpositions-2.02-1.2.el7.rf.noarch.rpm
RUN wget https://www.dropbox.com/s/v0rsimkkuykik9l/perl-DBD-Sybase-1.16-1.el7.centos.x86_64.rpm 
RUN rpm -Uvh perl-Class-Multimethods-1.70-1.2.el7.rf.noarch.rpm
RUN rpm -Uvh perl-Quantum-Superpositions-2.02-1.2.el7.rf.noarch.rpm
RUN rpm -Uvh perl-DBD-Sybase-1.16-1.el7.centos.x86_64.rpm

RUN wget http://github.com/gnosek/fcgiwrap/tarball/master -O fcgiwrap.tar.gz
RUN tar zxvf fcgiwrap.tar.gz
RUN cd gnosek-fcgiwrap-99c942c && autoreconf -i && ./configure && make && make install 

RUN adduser nginx && usermod -aG wheel nginx

RUN echo -e 'OPTIONS="-u nginx -g wheel -p 9090 -P /var/run/spawn-fcgi.pid -- /usr/local/sbin/fcgiwrap"' >> /etc/sysconfig/spawn-fcgi
 
EXPOSE 9090

ADD container-files/script/* /tmp/script/
RUN chmod +x /tmp/script/bootstrap.sh

ENTRYPOINT ["/tmp/script/bootstrap.sh"]
