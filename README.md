Filled-In Tick Stats
====================

API to get stats about tick entries filled out.


API
---

* Totals

    GET /

Returns : JSON hash of names, hours

	{Ian Vaughan: 10}



Setup

    bundle install

Set env

    export TICK_PASS="password"

Run

    rackup



heroku config:set TICK_USER="ivaughan@globalpersonals.co.uk"
heroku config:set TICK_PASS="password"
heroku config:set TICK_LABEL="TickSpot"



$  heroku addons:add heroku-postgresql:dev
Adding heroku-postgresql:dev on secret-hamlet-7830... done, v13 (free)
Attached as HEROKU_POSTGRESQL_COPPER_URL
Database has been created and is available
 ! This database is empty. If upgrading, you can transfer
 ! data from another database with pgbackups:restore.
Use `heroku addons:docs heroku-postgresql:dev` to view documentation.

$ heroku pg:wait

$ heroku config
=== secret-hamlet-7830 Config Vars
HEROKU_POSTGRESQL_COPPER_URL: postgres://zvznmtvgdnxeqt:9dub4Mhe8VVguHfiGT64pLvFJK@ec2-107-22-169-108.compute-1.amazonaws.com:5432/d2be3kpqhmh7v8


$ heroku pg:promote HEROKU_POSTGRESQL_COPPER_URL
