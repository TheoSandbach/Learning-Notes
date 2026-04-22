# Access Control

[Link to PortSwigger Academy Learning Path]([Server-side vulnerabilities - PortSwigger](https://portswigger.net/web-security/learning-paths/server-side-vulnerabilities-apprentice))

---

### 1. What is Access Control?

Access control is placing constrains on who or what is authorized to access data or perform actions. In the context of web security, this is closely linked with authentication and session management:

- Access control is whether a user can perform an action

- Authentication is whether a user is who they say they are

- Session management is ensuring requests are attributed to the correct user

Access control decisions have to be made manually, so there are lots of potential errors that may create vulnerabilities.

---

### 2. Vertical Privilege Escalation

Vertical Privilege Escalation is a user gaining access to an action they are not permitted to access, such as a non-admin user being able to run admin only actions.

---

### 3. Unprotected Functionality

Vertical privilege escalation occurs when an app doesn't adequately protect sesnsitive functions, such as admin functions being accessible by simple browsing to an admin URL on the website (something like `/admin`). Wordlists may be used to search for exposed URLs on the website that either provide sensitive functionality or disclose where sensitive functionality may be accessed from.

One method for concealment of sensitive functionality is "security by obscurity", for example using a less predictable URL, such as `/admin-28a1`. However, this is still not necessarily secure, as there are a few other ways this URL might still be found. One such example might be a JS script visible to all users may state the URL.

---

### 4. Parameter-based access control methods

Sometimes an application will store access rights as a variable in a user-controllable location upon login, including but not limited to a hidden field, cookie, or preset query string parameter.

Access decisions are then made by the application based on the stored value.

This is insecure because the user can alter their access rights by altering this value, possibly enabling them to access admin functions.

---

### 
