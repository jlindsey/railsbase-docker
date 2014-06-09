Docker Rails Base
=================
Base image for Rails apps.

Contents
--------
* Automatically start whatever app server you like with Foreman.
* Configurable startup scripts to `bundle install` and `rake db:migrate`.
* Runs any user-defined startup scripts without needing to edit any Dockerfile.
* Bundles the app code in on build, copying it to `/app`.

Setup
-----
This container requires that your Rails app follow a certain set of conventions:

* Your app should have a `Procfile` defining at least your app server startup command. See the [Foreman 
  docs][1] for more information.
* If you need any special behavior on pre-start (ie. before the app server actually boots Rails), you should 
  create a `config/pre-start/` directory. Any files matching `*.sh` in this path will be copied to the proper 
  location for startup scripts and made executable when the image is being compiled. This path is 
  configurable: see below.
* Any uploads or other persistent static content should be saved in `public/system`, as this is marked as a 
  Volume.

In general, it's recommended to place scripts for anything that you would normally have a tool like Capistrano 
do on deploy in the `config/pre-start/` directory. For example, cache cleaning or the like.

[1]: http://ddollar.github.io/foreman/

Configuration
-------------
Allows configuration via several environment variables which you can set at startup or
override in your own derivative Dockerfiles.

* `SHOULD_BUNDLE_INSTALL`: Set to `1` by default; set to `0` to skip the bundle startup script.
* `SHOULD_DB_MIGRATE`: Set to `1` by default; set to `0` to skip the database migration startup script.
* `SHOULD_PRECOMPILE_ASSETS`: Set to `1` by default; set to `0` to skip asset precompilation startup script.
* `APP_PRE_START_SCRIPTS_LOCATION`: Location of any user-defined pre-start scripts. Set to 
  `/app/config/pre-start` by default (ie. in `config/pre-start/` relative to your Rails root).
* `RAILS_ENV`: Set to `production` by default.


