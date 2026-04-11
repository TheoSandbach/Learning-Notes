# Path Traversal

[Link to PortSwigger Academy Learning Path]([Server-side vulnerabilities - PortSwigger](https://portswigger.net/web-security/learning-paths/server-side-vulnerabilities-apprentice))

---

### 1. What is Path Traversal?

Also known as directory traversal, vulnerabilities that allow an attacker to read arbitrary files on an application server, such as code, app data, credentials, or sensitive files.

An attacker may even be able to write files to the server which may modify app data or behaviour - possibly allowing for total control of the server.

---

### 2. Reading Arbitrary Files with Path Traversal

> API - An interface with a defined set of rules, protocols, and tools that allow one software system to communicate with another, by exposing specific functionality or data in a controlled, structured way. Defines what can be asked for, how it can be asked for, and what can be returned.

If you have a website with an image, the html request for that image might be something like:

```html
<img src="/loadImage?filename=218.png">
```

Here, the loadImage URL takes the parameter filename and returns the specified file. To do this, the application appends the filename parameter value (the file name asked for) onto the directory address for where images are stored, and uses a filesystem API to return the file contents. So if images are located at `/var/www/images/`, then the application reads the contents of `/var/www/images/218.png`.

However, we can ask for whatever file we want with this request. We can navigate the file system with this request, and also put `../` within the specified address to step up a level. As such, if the request was something like:

```html
<img src="/loadImage?filename=../../../etc/passwd">
```

Then we would be stepping up through `/var/www/images/` to root of the filesystem, and navigating into the `/etc/` directory from there, requesting the passwd file. 

`/etc/passwd` is the standard file containing details for registered users on a Unix based OS. For Windows, we might instead look for the `\windows\win.ini` file.

*Note: Both `/` and `\` are valid for a Windows file structure.*
