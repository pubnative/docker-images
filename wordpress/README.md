# wordpress

Version of wordpress Docker image with msmtp installed and configured as PHP
sendmail binary. The container (implicitly) expects /etc/msmtprc to exists and
configure msmtp to send emails (with default account to work with PHP
sendmail/WP).

## Build

`make build`

## push

`make push`

## Both

`make all`
