
fileSystem = require './modules/fileSystem.js'
userInterface = require './modules/userInterface.js'

main = ->
	try
		userInterface.bindDocument window
		usersHomePath = fileSystem.getUsersHomeFolder()
		await userInterface.loadDirectory(usersHomePath)(window)
		userInterface.dbclickOnDirectory(usersHomePath)
	catch e
		console.error e
	
do main