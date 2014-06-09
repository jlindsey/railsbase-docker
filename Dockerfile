# DOCKER-VERSION: 0.12.0
FROM jlindsey/rubybase-docker

# No docs
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc

# Install Foreman
RUN gem install foreman && rbenv rehash

# Control variables for default startup jobs
ENV SHOULD_BUNDLE_INSTALL 1
ENV SHOULD_DB_MIGRATE 1
ENV APP_PRE_START_SCRIPTS_LOCATION /app/config/pre-start

# Default to production
ENV RAILS_ENV production

# Add code
RUN mkdir /app
ONBUILD ADD . /app

# Bundle install and rake db:migrate on startup
RUN mkdir -p /etc/my_init.d
ADD 01_bundle_install.sh /etc/my_init.d/01_bundle_install.sh
ADD 02_rake_db_migrate.sh /etc/my_init.d/02_rake_db_migrate.sh

# Forman start
RUN mkdir -p /etc/service/foreman
ADD foreman_start.sh /etc/service/foreman/run
RUN chmod 0700 /etc/service/foreman/run

# Copy app-sepecific pre-start scripts on build
ADD copy_pre_start_scripts.rb /usr/local/bin/copy_pre_start_scripts.rb
ONBUILD RUN /usr/local/bin/copy_pre_start_scripts.rb

# Make sure it's all executable
ONBUILD RUN chmod 0700 /etc/my_init.d/*.sh

# Setup volumes
VOLUME ["/app", "/root/.rbenv"]

# Start
CMD ["/sbin/my_init"]

