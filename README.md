# MI-08 election night pages

Static copies of the results board (`board.html`) and the poller console (`index.html`). They hold no data: each page
fetches JSON from a Google Apps Script web app anonymously, so a browser signed into several Google accounts is never
sent through Google's account chooser. `?api=<web app /exec URL>` points a page at another deployment (the 2024 demo).
