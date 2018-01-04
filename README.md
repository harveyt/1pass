1Pass
=====

Yet another simple non-caching wrapper around the
[1Password CLI command](https://support.1password.com/command-line-getting-started/) `op`.

Warning
=======

There is no waranty with this code, you should inspect the code carefully to make sure I've not made
any mistakes or introduced security holes. You should definitely assume not to trust me or my
coding.

For more details see the [License](LICENSE).

Features
========

* Does not cache any data locally to disk, other than whatever 1Password's `op` command requires.
  For example `op` stores the email, domain and secret keys of logged in users in
  `$HOME/.op/config`.
* List and search items.
  ```
  $ 1pass -l
  MyWebsite
  GitHub
  ...
  ```
* Provides simple access to item password, username and URL.
  ```
  $ 1pass -p MyWebsite
  SecretPassword12345
  $ 1pass -u MyWebsite
  myusername
  $ 1pass -U MyWebsite
  https://www.mywebsite.local/login
  ```
* All searches and passwords, usernames and URLs are shown only to stdout.
* Allows improved login and logout session control, showing export commands for shell scripting.
  ```
  $ 1pass --terminal --login
  Master password for person@somewhere.local: xxxxx
  export OP_SESSION_username=xyz123456789xyz
  $ 1pass --logout
  unset OP_SESSION_username
  ```
* Session login master password (and email, domain, secret) can be read from various sources:
  * Environment variables such as `_1PASS_MASTER_PASSWORD`, `_1PASS_SECRET_KEY`
  * A GUI program such as `ssh-askpass`.
  * The users TTY terminal (non-echo, unless TERM is dumb).
* By default session login and logout are not performed. If the session is no longer valid the
  program will fail with an error.
  * Use `--login` to refresh session, which does not ask for password if session is still valid:
	```
	$ $(eval 1pass --login)
	$ 1pass -p MyWebsite
	SecretPassword12345
	```
  * Use `--login-valid` to detect stale session by exit value.
	```
	$ 1pass --login-valid || eval $(1pass --login)
	```
  * Mixing `--login` with item searches will mix item results and session information and thus is
    not recommended.
* Suggested aliases:
  ```
  $ alias 1pass-login='eval $(1pass --login)'
  $ alias 1pass-logout='eval $(1pass --logout)'
  ```

