# Mongoose compliant-paranoia

[![Build Status](https://travis-ci.org/axiomzen/mongoose-compliant-paranoia.png?branch=master)](https://travis-ci.org/axiomzen/mongoose-compliant-paranoia)

A super light and transparent way to prevent rails's mongoid **deleted_at** field from messing your queries from getting "deleted" documents by being aware of it.

Meant to work with both mongoid paranoia [extra](http://mongoid.org/en/mongoid/docs/extras.html#paranoia) and [plugin](https://github.com/simi/mongoid-paranoia)

Tested with mongoose 3.6.12

*warning*: calling mongoose `.remove()` on a doc will still delete it.

Inspiration from [mongoose-cache](https://github.com/Gottox/mongoose-cache)

## how to dev

`npm i`

Put coffee to run with

```
coffee -w -b -o lib/ coffee/
```

run tests with `npm test`

***

[![Powered by ZenHub.io](https://raw.github.com/axiomzen/zenhub-now/master/powered-by-zenhub-720.png)](https://zenhub.io)
