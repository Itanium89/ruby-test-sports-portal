FROM ruby:3.0.2-alpine3.13

ARG UID

# Create a user account manually rather than using:
# adduser -D -u $UID -h /home/dev dev
# This is necessary to support $UIDs > 256000 on alpine/busybox.
RUN echo "dev:x:$UID:$UID::/home/dev:" >> /etc/passwd \
    && echo "dev:!:$(($(date +%s) / 60 / 60 / 24)):0:99999:7:::" >> /etc/shadow \
    && echo "dev:x:$UID:" >> /etc/group \
    && mkdir /home/dev && chown dev: /home/dev


RUN apk add --no-cache build-base libmcrypt libmcrypt-dev libxml2-dev libzip-dev git openssh-client openssh curl \
     pcre-dev postgresql-dev postgresql-client nodejs nodejs-npm tzdata yarn

# Run FPM as the dev user for easy permission management.
USER dev
WORKDIR /var/www

RUN gem install debase rails ruby-debug-ide rspec rspec-rails rspec-rails-matchers pg --pre

ENTRYPOINT ["/var/www/docker/app/entrypoint.sh"]
EXPOSE 3000
# Configure the main process to run when running the image
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]