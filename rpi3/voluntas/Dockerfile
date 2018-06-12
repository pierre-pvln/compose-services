FROM pvln/rpi3-lvl1-mysql:1.0

MAINTAINER Pierre Veelen <pierre@pvln.nl>

LABEL version="1.0" maintainer="Pierre Veelen <pierre@pvln.nl>"

#
# ENTRYPOINT & CMD
# ======
# Cancel pre-defined start-up instruction and allow us to use our own.
#ENTRYPOINT []

ADD ./entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/bin/bash","entrypoint.sh"]
 
CMD /bin/bash
