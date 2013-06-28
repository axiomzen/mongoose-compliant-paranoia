mongoose = require('mongoose')
expect = require('chai').expect

antiParanoia = require '../lib'

DB_URL = "mongodb://localhost/mongoose-aint-paranoia_dev"

schema = new mongoose.Schema
  name: String
  x:
    type: Number
    default: Math.random
  deleted_at: Date
  created_at:
    type: Date
    default: Date.now

schema.plugin( antiParanoia.plugin )

conn = null
model = null

describe 'reset database', ->
  it 'should connect to DB', (done) ->
    conn = mongoose.connect DB_URL, {db: {safe: true }}, done

  it 'should drop database', (done) ->
    conn.connection.db.dropDatabase(done)

  it 'install to mongo and define the schema', ->
    antiParanoia.install( mongoose )
    model = mongoose.model "Simple", schema

  it 'should start empty', (done) ->
    model.find({}).count (err,count) ->
      expect(count).to.equal 0
      done(err)

describe 'populate', ->
  it 'make 1st sample', (done) ->
    model.create {name: 'a'}, done

  it 'make 2nd sample', (done) ->
    model.create {name: 'b'}, done

doc1 = null

describe 'assure mongoose methods work fine', ->

  it 'should count 2', (done) ->
    model.find({}).count (err,count) ->
      expect(count).to.equal 2
      done(err)

  it 'should findOne', (done) ->
    model.findOne({name:'a'}).exec (err,doc) ->
      expect(doc).to.be.an 'object'
      expect(doc.name).to.equal 'a'
      doc1 = doc
      done(err)

  it 'should findOne (method 2)', (done) ->
    model.findOne {name:'a'}, (err,doc) ->
      expect(doc).to.be.an 'object'
      expect(doc.name).to.equal 'a'
      doc1 = doc
      done(err)

  it 'should find a', (done) ->
    model.find({name:'a'}).exec (err,docs) ->
      expect(docs).to.have.length 1
      doc = docs[0]
      expect(doc).to.be.an 'object'
      expect(doc.name).to.equal 'a'
      done(err)

  it 'should find a (method 2)', (done) ->
    model.find {name:'a'}, (err,docs) ->
      expect(docs).to.have.length 1
      doc = docs[0]
      expect(doc).to.be.an 'object'
      expect(doc.name).to.equal 'a'
      done(err)

  it 'should .where a', (done) ->
    # : Mongoose: simples.find({ deleted_at: { '$exists': false }, created_at: { '$lt': new Date("Fri, 28 Jun 2013 00:01:52 GMT") }, name: 'a' }) { fields: undefined, safe: undefined }  
    model
    .where('name','a')
    .where('created_at').lt(Date.now())
    .exec (err,docs) ->
      return done(err) if err
      expect(docs).to.have.length 1
      doc = docs[0]
      expect(doc).to.be.an 'object'
      expect(doc.name).to.equal 'a'
      done(err)

describe 'should "delete" doc1', ->

  it 'do it', (done) ->
    doc1.deleted_at = new Date()
    doc1.save done

  it 'should count 1', (done) ->
    model.find({}).count (err,count) ->
      expect(count).to.equal 1
      done(err)

  it 'should not findOne', (done) ->
    model.findOne({name:'a'}).exec (err,doc) ->
      expect(doc).to.equal null
      done(err)

  it 'should not find a', (done) ->
    model.find({name:'a'}).exec (err,docs) ->
      expect(docs).to.have.length 0
      done(err)

describe 'should really remove doc1', ->

  it 'do it', (done) ->
    doc1.remove done

  it 'should count 1', (done) ->
    model.find({}).count (err,count) ->
      expect(count).to.equal 1
      done(err)

  it 'should not findOne', (done) ->
    model.findOne({name:'a'}).exec (err,doc) ->
      expect(doc).to.equal null
      done(err)

  it 'should not find a', (done) ->
    model.find({name:'a'}).exec (err,docs) ->
      expect(docs).to.have.length 0
      done(err)

describe 'should really remove doc2', ->

  it 'do it', (done) ->
    model.findOne {name:'b'}, (err,doc2) ->
      doc2.remove done

  it 'should count 0', (done) ->
    model.find({}).count (err,count) ->
      expect(count).to.equal 0
      done(err)

  it 'should not findOne', (done) ->
    model.findOne({name:'b'}).exec (err,doc) ->
      expect(doc).to.equal null
      done(err)

  it 'should not find b', (done) ->
    model.find({name:'b'}).exec (err,docs) ->
      expect(docs).to.have.length 0
      done(err)
