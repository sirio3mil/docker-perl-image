FROM centos:latest
ENV container docker
MAINTAINER "Reynier de la Rosa" <reynier.delarosa@outlook.es>

RUN yum -y update
RUN yum -y install epel-release \
                   wget \
                   yum-utils \
                   freedts \
                   freetds-devel \
                   gcc \
                   make
RUN wget http://repository.it4i.cz/mirrors/repoforge/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN wget https://driesrpms.eu/redhat/el7/en/x86_64/dries.all/RPMS/perl-Class-Multimethods-1.70-1.2.el7.rf.noarch.rpm
RUN wget https://driesrpms.eu/redhat/el7/en/x86_64/dries.all/RPMS/perl-Quantum-Superpositions-2.02-1.2.el7.rf.noarch.rpm
RUN wget https://www.dropbox.com/s/v0rsimkkuykik9l/perl-DBD-Sybase-1.16-1.el7.centos.x86_64.rpm
RUN rpm -Uvh rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
RUN yum install -y perl \
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
 
RUN rpm -Uvh perl-Class-Multimethods-1.70-1.2.el7.rf.noarch.rpm
RUN rpm -Uvh perl-Quantum-Superpositions-2.02-1.2.el7.rf.noarch.rpm
RUN rpm -Uvh perl-DBD-Sybase-1.16-1.el7.centos.x86_64.rpm
 
EXPOSE 9090
