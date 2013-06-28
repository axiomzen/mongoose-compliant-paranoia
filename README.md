# Mongoose compliant-paranoia

Prevent rails's active record **deleted_at** field from messing your queries by being aware of it.

Meant to work with both mongoid and the active record plugin (#TODO link both)

Tested with mongoose 3.6.12

Inspiration from [https://github.com/Gottox/mongoose-cache]

## how to dev

`npm i`

Put coffee to run with

```
coffee -o lib/ coffee/
```

run tests with `npm test`
