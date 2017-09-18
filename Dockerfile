FROM resin/rpi-raspbian

MAINTAINER Pierre Veelen <pierre@pvln.nl>

# ==========================================
# START OF INSTALLING UTILITIES AND DEFAULTS
# ==========================================

RUN sudo apt-get update && sudo apt-get install -y \
    apt-utils \
    nano \
    ssh && \
    sudo apt-get upgrade && \
    sudo apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	 
# =============================
# END OF UTILITIES AND DEFAULTS
# =============================

# =========================
# START OF INSTALLING MYSQL
# =========================
#
# Inspiration: https://stackoverflow.com/questions/32145650/how-to-set-mysql-username-in-dockerfile/32146887#32146887
#
ARG MY_MYSQL_SERVER_ROOT_PASSWORD='def-root'


#DEBUG
#=====
# save info to file
RUN echo $MY_MYSQL_SERVER_ROOT_PASSWORD > /root/MY_MYSQL_SERVER_ROOT_PASSWORD.txt

#RUN { \ echo mysql-server-5.5 mysql-server/root_password password $MY_MYSQL_SERVER_ROOT_PASSWORD; \
#        echo mysql-server-5.5 mysql-server/root_password_again password $MY_MYSQL_SERVER_ROOT_PASSWORD; \
#    } | sudo debconf-set-selections \
#    && sudo apt-get update && sudo apt-get install -y \
#        mysql-server && \
#    sudo apt-get clean && \ 
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#  Install mysql-server and cleanup afterwards
#
RUN { \
        echo mysql-server-5.5 mysql-server/root_password password 'root'; \
        echo mysql-server-5.5 mysql-server/root_password_again password 'root'; \
    } | sudo debconf-set-selections \
    && sudo apt-get update && sudo apt-get install -y \
        mysql-server && \
    sudo apt-get upgrade && \
	sudo apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# TODO: include mysql_secure_installation in container 
#
#RUN sudo apt-get update && \
#    sudo mysql_secure_installation && \
#    sudo apt-get clean && \ 
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Mountable datafolder path
# VOLUME ["/var/lib/mysql"]
	
	
#TEST
#====
# Copy MySQL test scripts to home directory
#
ADD ./site/scripts/mysql /root/mysql
RUN chmod -R +x /root/mysql/*.sh

# =======================
# END OF INSTALLING MYSQL
# =======================


# =======================
# ENTRYPOINT & CMD
# =======================
# Cancel pre-defined start-up instruction and allow us to use our own.
#ENTRYPOINT []

ADD ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash","entrypoint.sh"]
 
CMD /bin/bash
