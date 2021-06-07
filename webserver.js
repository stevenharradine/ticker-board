const { exec } = require('child_process');
const fs = require("fs");
const http = require("http");

const settings = JSON.parse(fs.readFileSync('settings.json'))

const host = settings['webserver-host-binding'];
const port = settings['webserver-port'];

const requestListener = function (req, res) {
	var buffer = ""
	var returnCode = 500

	if (req.url == "/" || req.url == "/index.html" ) {
		serveStaticFile (res, '/webserver/index.html', 'text/html')
	} else if (req.url == "/current_ticker.html") {
		serveStaticFile (res, '/webserver/current_ticker.html', 'text/html')
	} else if (req.url == "/override.html") {
		serveStaticFile (res, '/webserver/override.html', 'text/html')
	} else if (req.url == "/override.html/news") {
		var data = restart_ticker ("news")

		returnCode = data.returnCode
		buffer += data.buffer

		res.writeHead(returnCode);
		res.end(buffer);
	} else if (req.url == "/override.html/weather") {
		var data = restart_ticker ("weather")
		
		returnCode = data.returnCode
		buffer += data.buffer

		res.writeHead(returnCode);
		res.end(buffer);
	} else if (req.url == "/override.html/finance") {
		var data = restart_ticker ("finance")
		
		returnCode = data.returnCode
		buffer += data.buffer

		res.writeHead(returnCode);
		res.end(buffer);
	} else if (req.url == "/images/ticker.jpeg") {
		serveStaticFile (res, '/webserver/images/ticker.jpeg', 'image/jpeg')
	} else {
		serveStaticFile (res, '/webserver/errors/404.html', 'text/html')
	}
};

function restart_ticker (tickerType) {
	// whitelist input into exec function
	approvedTickerTypes = [ "news", "finance", "weather" ]
	if (approvedTickerTypes.indexOf(tickerType) < 0) {
		console.log ("error: unregistered 'tickerType'")
		return {"returnCode": 504, "buffer": "error: unregistered 'tickerType'" }
    }


	// restart the ticker
	try {
		console.log ("starting " + tickerType + " ticker . ")
		const child = exec("bash restart-ticker.sh " + tickerType, (error, stdout, stderr) => {
			if (error) {
				console.log("error: "+ error.message);
				return
			}

			if (stderr) {
				console.log("stderr: " + stderr);
				return
			}

			console.log("stdout:\n" + stdout);

		})

		console.log ("done")
		return {"returnCode": 200, "buffer": "ok" }
	} catch (error) {
		return {"returnCode": 503, "buffer": "error" }
	}
}

// source: https://stackoverflow.com/questions/44354877/how-to-serve-image-from-node-server-without-express
function serveStaticFile(res, path, contentType, responseCode) {
    if(!responseCode) responseCode = 200;

    // __dirname will resolve to the directory the executing script resides in.
    // So if your script resides in /home/sites/app.js, __dirname will resolve
    // to /home/sites.

    console.log(__dirname + path);

    fs.readFile(__dirname + path, function(err, data) {
        if(err) {
            res.writeHead(500, { 'Content-Type' : 'text/plain' });
            res.end('500 - Internal Error');
        } 
        else {
            res.writeHead( responseCode, { 'Content-Type' : contentType });
            res.end(data);
        }
    });
}

const server = http.createServer(requestListener);
server.listen(port, host, () => {
	console.log(`Server is running on http://${host}:${port}`);
});