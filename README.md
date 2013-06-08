Filled-In Tick Stats
====================

API to get stats about tick entries filled out.


API
---

* Totals

    GET /

Returns : JSON hash of names, hours

    {Ian Vaughan: 10}


## Setup

    bundle install

### Set env

    export TICK_PASS="password"

### Run

    rackup


### Heroku setup

    heroku config:set TICK_USER="user@email.com
    heroku config:set TICK_PASS="password"
    heroku config:set TICK_LABEL="TickSpot"
