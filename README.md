# docker-cloud-print-server
Raspberry Pi Docker CUPS Printserver with Google Cloud Print Connector

## Building

    admin_pass=mypassword share_scope=mygoogleaddress@gmail.com docker-compose build
    
`admin_pass` will be the password you use to log into the CUPS webinterface. `share_scope` is your google email address or google groups address.

During one of the build steps you will be prompted by the google connector to copy a code and paste it to `http://google.com/device`.

This will link the gcp connector to your google account specified as "share_scope".

After the build is finished run the container:

     docker-compose up -d

## Webinterface

Use the CUPS webinterface to configure your printers, it is available at `http://yourraspberryip:631`.
    
The username for admin functions is `print`, the password is the one you specified during build.

Configured printers should automatically show up in your google cloud print account `https://www.google.com/cloudprint#printers`.
