
fileSystem = require './fileSystem.js'
userInterface = require './userInterface.js'

main = ->
	try
		userInterface.bindDocument window
		folderPath = fileSystem.getUsersHomeFolder()
		filesInFolder = await fileSystem.getFilesInFolder folderPath
		inspectedFiles = await fileSystem.inspectAndDescribeFiles folderPath, filesInFolder
		userInterface.displayFiles inspectedFiles
			
	catch e
		console.error e
	
do main