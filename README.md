# Mongoose compliant-paranoia

[![Build Status](https://travis-ci.org/axiomzen/mongoose-compliant-paranoia.png?branch=master)](https://travis-ci.org/axiomzen/mongoose-compliant-paranoia)

A super light and transparent way to prevent rails's active record **deleted_at** field from messing your queries from getting "deleted" documents by being aware of it.

Meant to work with both mongoid and the active record plugin (#TODO link both)

Tested with mongoose 3.6.12

Inspiration from [https://github.com/Gottox/mongoose-cache]

## how to dev

`npm i`

Put coffee to run with

```
coffee -w -b -o lib/ coffee/
```

run tests with `npm test`
