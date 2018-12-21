
document = undefined

displayFile= (file) ->
		mainArea = document.getElementById 'main-area'
		template = document.querySelector '#item-template'
		clone = document.importNode template.content, true
		clone.querySelector 'img'
			.src = "images/#{file.type}-icon.svg"
		clone.querySelector '.filename'
			.innerText = file.file
		mainArea.appendChild clone

displayFolderPath = (folderPath) ->
	document.getElementById('current-folder').innerText = folderPath
		
clearView = ->
		mainArea = document.getElementById 'main-area'
		firstChild = mainArea.firstChild
		while firstChild
			mainArea.removeChild firstChild
			firstChild = mainArea.firstChild

loadDirectory = (folderPath)
	(window) ->
		document = window.document unless document
		displayFolderPath(folderPath)

module.exports =
	displayFiles: (files) ->
		displayFile file for file in files
			
	bindDocument: (window) ->
		document = window.document unless document