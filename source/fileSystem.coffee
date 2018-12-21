osenv      = require 'osenv'
fs         = require 'fs'
path       = require 'path'

inspectAndDescribeFile = (filePath) ->
	new Promise (resolve, reject) =>
		result =
			file: path.basename filePath
			path: filePath, 
			type: ''
		
		fs.stat filePath, (err, stat) =>
			reject err if err
			result.type = 
				if stat.isFile() then 'file'
				else if stat.isDirectory() then 'directory'
			resolve result
				
loadDirectory = ->


module.exports =

	getUsersHomeFolder: ->
		osenv.home()

	getFilesInFolder: (folderPath) ->
		new Promise (resolve, reject) =>
			fs.readdir folderPath, (err, files) ->
				reject err if err
				resolve files

	inspectAndDescribeFiles: (folderPath, files) ->
		new Promise (resolve, reject) ->
			results = []
			for key, file of files
				resolveFilePath = path.resolve folderPath, file
				result = inspectAndDescribeFile resolveFilePath
				results.push await result

			resolve await results