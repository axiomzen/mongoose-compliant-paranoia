
path = 'deleted_at'

###
  this.install mongoose
  
  see test/
###
exports.install = (mongoose) ->

  # mongoose.set('debug', true)

  originalCast = mongoose.Query::cast

  mongoose.Query::cast = (model,obj) ->
    if @op != 'remove'
      obj || (obj = @_conditions)
      @where(path, {$exists: false})
    originalCast(model,obj)

  true


###
  schema.plugin this.plugin

  see test/
###
exports.plugin = (schema, options) ->
  newField = {}
  newField[path] = Date
  schema.add newField

  index = {}
  index[path] = 1
  schema.index index, {unique: false}
