{ app } = require 'electron'
{ BrowserWindow } = require 'electron'

# Reload on each change
require('electron-reload')(__dirname)

mainWindow = undefined

app.on 'window-all-closed', ->
		app.quite() unless process.platform isnt 'darwin'

app.on 'ready', ->
		mainWindow = new BrowserWindow nodeIntegration: false
		mainWindow.loadURL "#{__dirname}/index.html"
		mainWindow.on 'closed', -> mainWindow = undefined