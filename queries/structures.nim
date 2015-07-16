#--------------------
# Control structures
#--------------------

proc args*(r: RethinkClient, args: MutableDatum): RqlQuery =
  ## `r.args` is a special term that’s used to splice an array of arguments into another term
  ast(r, ARGS, args)

proc binary*(r: RethinkClient, data: BinaryData): RqlQuery =
  ## Encapsulate binary data within a query.
  ast(r, BINARY, data)

proc expr*[T, U, V](r: T, x: U): V =
  ## Construct a ReQL JSON object from a native object

  #TODO does this really works as expected
  when x is RqlQuery:
    result = x
  else:
    result = r.datumTerm(@x)

proc js*(r: RethinkClient, js: string, timeout = 0): RqlQuery =
  ## Create a javascript expression.
  ast(r, JAVASCRIPT, js)
