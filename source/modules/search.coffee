lunr = require 'lunr'
# idx = undefined

# resetIndex = (files) ->
# 	idx = lunr ->
# 		this.field 'file'
# 		this.field 'path'
# 		this.field 'type'

# 		this.add file for file in files

# search = (query) ->
# 	idx.search query


class Idx
	constructor: (@index) ->

	resetIndex: (files)  ->
		@index = lunr ->
			this.ref 'path'
			this.field 'file'
			this.field 'type'

			this.add file for file in files

	search: (query) ->
		console.log '-- query: ', query
		console.log '--index: ', @index
		res = @index.search query
		console.log res
		res

module.exports = Idx