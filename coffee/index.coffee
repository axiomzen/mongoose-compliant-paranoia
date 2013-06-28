exports.install = (mongoose) ->

  mongoose.set('debug', true)

  path = 'deleted_at'

  originalCast = mongoose.Query::cast

  mongoose.Query::cast = (model,obj) ->
    if @op != 'remove'
      obj || (obj = @_conditions)
      @where(path, {$exists: false})
    originalCast(model,obj)

  ###
  original =
    execFind: mongoose.Query::execFind
    exec:     mongoose.Query::exec
    count:    mongoose.Query::count
    findOne:  mongoose.Query::findOne

  # mongoose.Query.prototype.includeDeleted = () ->
    # null

  exec = (signature, op, cb) ->
    console.log "EXEC(#{arguments.length})", signature, typeof op, typeof cb
    # conds = @[path] || (@_conditions[path] = {})
    # conds.deleted_at = {$exists: false}
    @where(path, {$exists: false})
    if arguments.length  == 2
      original[signature].call(@, op)
    else
      original[signature].call(@, op, cb)

  mongoose.Query::execFind = (arg1, arg2) ->
    # console.log "my hacky execFind"
    if arguments.length  == 1 #|| args2 != undefined
      exec.call this, "execFind", arg1
    else
      exec.call this, "execFind", arg1, arg2

  mongoose.Query::exec = (arg1, arg2) ->
    # console.log "my hacky exec"
    if arguments.length  == 1 #|| args2 != undefined
      exec.call this, "exec", arg1
    else
      exec.call this, "exec", arg1, arg2

  mongoose.Query::count = (arg1) ->
    exec.call this, "count", arg1
  ###

  true

