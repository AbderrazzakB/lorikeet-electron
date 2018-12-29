
fileSystem 	= require './fileSystem.js'
Idx 		= require './search.js'
idx 		= new Idx();
document 	= undefined

###*
 * Display file in the user interface
 * @param {object} file
 * @return {*}
###
displayFile= (file) ->
	mainArea = document.getElementById 'main-area'
	template = document.querySelector '#item-template'
	clone = document.importNode template.content, true
	clone.querySelector '.item'
		.setAttribute 'data-type', file.type
	clone.querySelector '.item'	
		.setAttribute 'data-path', file.path
	clone.querySelector 'img'
		.src = "images/#{file.type}-icon.svg"
	clone.querySelector '.filename'
		.innerText = file.file
	mainArea.appendChild clone

###*
 * Display user folder path in the user interface
 * @param {string} folderPath
 * @return {*}
###
displayFolderPath = (folderPath) ->
	document.getElementById('current-folder').innerText = folderPath
		
###*
 * Clear the mean area where the folders displayed
 * @return {*}
###
clearView = ->
	mainArea = document.getElementById 'main-area'
	firstChild = mainArea.firstChild
	while firstChild
		mainArea.removeChild firstChild
		firstChild = mainArea.firstChild

###*
 * Display the folder to the user interface
 * @param {Array} files
 * @return {*}
###
displayFiles = (files) ->
	displayFile file for file in files
			
###*
 * bind the document object to the window if not exist
 * @param {object} window
 * @return {*}
###
bindDocument = (window) ->
	document = window.document unless document

###*
 * Load directories in a given folder path
 * @param {string} folderPath
 * @return {function}
###
loadDirectory = (folderPath) ->
	(window) ->
		document = window.document unless document
		displayFolderPath(folderPath)
		fileSystem.getFilesInFolder(folderPath)
		.then (files) ->
			clearView()
			fileSystem.inspectAndDescribeFiles(folderPath, files)
			.then (results) ->
				idx.resetIndex results
				displayFiles results
			.catch (error) ->
				console.error """Unhandled error happened when we tried to 
					inspect your directories """, error
		.catch (error) ->
			console.error """Unhandled error happened when we tried to 
					get files from your directories """, error

filterResult = (results) ->
	validFilePaths = results.map (result) ->
		return result.ref
	items = document.getElementsByClassName 'item'

	for item in items
		filePath = item.getAttribute 'data-path'
		if validFilePaths.indexOf filePath isnt -1
			item.style = null
		else
			item.style = 'display: none'

resetFilter = ->
	item.style = null for item in document.getElementsByClassName 'item'

dblclickOnDirectory =  ->
	mainArea = document.getElementById 'main-area'
	mainArea.ondblclick = (event) ->
		target = event.target.closest '.item'
		return unless target
		return unless mainArea.contains target
		if target.getAttribute('data-type') is 'file'
			return 
		else if target.getAttribute('data-type') is 'directory'
			folderPath = target.getAttribute('data-path') 
			loadDirectory(folderPath)(window)	
	return

keyupOnSearch = ->
	search = document.getElementById 'search'
	search.onkeyup = (event) ->
		query = event.target.value
		# resetFilter() unless query
		res = idx.search query

module.exports = {
	bindDocument
	loadDirectory
	dblclickOnDirectory
	keyupOnSearch
	idx
}
	