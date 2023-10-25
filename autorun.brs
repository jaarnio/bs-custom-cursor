sub Main()
	msgPort = CreateObject("roMessagePort")
	r = CreateObject("roRectangle", 0, 0, 1920, 1080)
	t = CreateObject("roTouchScreen")
	t.SetPort(msgPort)
	t.AddRectangleRegion(0,0,1920,1080,1)
	t.EnableCursor(true)
	t.SetCursorBitmap("cursor.png", 15,0)
	config = {
		' change URL to be your VS Code live server address
		'url: "http://192.168.1.154:8080/index.html",
		url: "file:///index.html",
		javascript_enabled: true,
		nodejs_enabled: true,
		brightsign_js_objects_enabled: true,
		storage_path: "sd:/browser_data",
		hwz_default: "z-index:-2",
		mouse_enabled: true,
		security_params: { websecurity: false },
		inspector_server: { port: 2999 }
	}
	h = CreateObject("roHtmlWidget", r, config)
	h.SetPort(msgPort)
	sleep(500)
	h.Show()
	while true
		ev = Wait(0, msgPort)
		print "---Received Event ";type(ev)
		if type(ev) = "roHtmlWidgetEvent" then
			eventData = ev.GetData()
			if type(eventData) = "roAssociativeArray" then
				if eventData.message <> invalid then
					' This waits for the fail message from the HTMLWidget and reloads the widget to refresh the DOM
					if eventData.message.load = "FAIL" then
						print "RELOADING HTML"
						h = invalid
						h = CreateObject("roHtmlWidget", r, config)
						h.SetPort(msgPort)
						sleep(100)
						h.Show()
					end if
				end if
			end if
		end if
	end while
end sub