[WIP] not functional yet >:-O

# docker-cloud-print-server
Raspberry Pi Docker CUPS Printserver with Google Cloud Print Connector

## Building & Start up

Edit the `.env` file in the project root:

    CUPS_PASSWORD=Password used in the CUPS web interface
    GCP_SHARE_SCOPE=Your email address or Google groups address to share the printers with
    
Run

    docker-compose up

During the first build you will be prompted by the gcp connector to navigate to `http://google.com/device` to link the connector with your Google account (OAuth).

## Webinterface

Use the CUPS webinterface to configure your printers, it is available at `http://yourraspberryip:6631`.
    
The username for admin functions is `print`, the password is the one you specified in your `.env` file.

## Printing

Configured printers should automatically show up in your Google Cloud Print account `https://www.google.com/cloudprint#printers`.
