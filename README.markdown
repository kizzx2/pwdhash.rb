# PwdHash.rb

Generates PwdHash passwords from the command line.

## What is this?

This is a simple Ruby command line tool to generate hashed passwords, using PwdHash's algorithm.

PwdHash was written as a browser plugin, but sometimes we'd like to extend its use to desktop applications too. e.g. IM clients, Dropbox, etc. just to name a few.

## What is PwdHash?

[Standford PwdHash][pwdhash] helps you create theft-resistant passwords for each realm (domain name). In the case that your email password gets stolen, the attacker won't be able to log in your PayPal account to transfer all your money, even though you only have to remember one password for all logins. The [USENIX Security Symposium 2005 paper][paper](PDF) explains it in details.

## Example/Usage

    $ pwdhash google.com
    Password for google.com:
    5NBoCKraALBs

    $ pwdhash google.com | xcilp # Put generated password to X clipboard
    $ pwdhash google.com | putclip # Or in cygwin
