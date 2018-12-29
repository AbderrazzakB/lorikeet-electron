
fileSystem = require './modules/fileSystem.js'
userInterface = require './modules/userInterface.js'
search = require './modules/search.js'

main = ->
	try
		userInterface.bindDocument window
		usersHomePath = fileSystem.getUsersHomeFolder()
		await userInterface.loadDirectory(usersHomePath)(window)
		userInterface.dblclickOnDirectory(usersHomePath)
		userInterface.keyupOnSearch()
	catch e
		console.error e
	
do main