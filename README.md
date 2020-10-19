gcw-nginx
==================

nginx config for gcw.

Usage
------------

Create a config.mk that looks like this:

    USER = <username that call install stuff>
    SERVER = <server IP or fully qualified domain name>

If necessary:

  make install-nginx

Then:

    make push-up-nginx-config
