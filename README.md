# vienv

`vienv` is a terminal utility that sets environment variables for both terminal _and_ GUI apps on macOS.

It assumes your shell is `zsh`.

## Install

Copy and paste in a terminal the following command
```
curl -sL https://raw.githubusercontent.com/dlejay/vienv/trunk/install.sh | sh
source ${ZDOTDIR:-$HOME}/.zshrc
```
A list of variables is installed with `vienv`.
Run `vienv` after installation to change that list to your needs.

## Usage
Edit the list of variables using
```
vienv
```
and add environment variables in the fashion
```
VARIABLE=/whatever/you/want
```
Apps need to be restarted after setting the variables.

Apps that auto-launch at login will also fail to get the new variables.

## Setting your PATH
`vienv` uses `launchctl setenv` to set the environment variables;
it is [not the right tool](https://github.com/hschmidt/EnvPane#why-cant-i-set-path-with-envpane) to set your `PATH`
for all GUI apps.

As [scriptingosx.com](https://scriptingosx.com/2019/06/moving-to-zsh-part-2-configuration-files/) says:
> On macOS, system wide changes to the PATH should be done by adding files to /etc/paths.d.

or use `.zprofile` for a local change without `sudo`.
I do not know a way to set the `PATH` also for GUI apps.

## Uninstall

### Step 1
Copy and paste in a terminal the following command
```
curl -sL https://raw.githubusercontent.com/dlejay/vienv/trunk/uninstall.sh | sh
```

### Step 2
Remove `vienv()` from your `.zshrc`.

## Background

There are several places where one can define environment variables.
* For interactive use in a terminal, `.zshrc` is a good place;
* For non-interactive terminal use, `.zprofile` is the canonical place.
Variables set in `.zprofile` can also be used by certain GUI apps like [MacVim](https://macvim-dev.github.io/macvim/);
* But for other GUI apps this is not enough.

In the case of general GUI apps, it has become very difficult to get them access environment variables;
the canonical method has changed over the years
(cf. [superuser](https://superuser.com/questions/476752/setting-environment-variables-in-os-x-for-gui-applications),
[developer.apple](https://developer.apple.com/forums/thread/74371),
[apple.stackexchange](https://apple.stackexchange.com/questions/389023/setting-gui-visible-environment-variables-with-os-catalina)).

`vienv` uses the last method known to work
(cf. [Ted Toal](https://superuser.com/questions/1609942/how-to-set-environment-variables-on-macos-using-a-gui),
[EnvPane](https://github.com/hschmidt/EnvPane), [Machina Spectulatrix](https://mansfield-devine.com/speculatrix/2019/03/quicktip-setting-paths-on-macos/)):
read a user file `environment.txt` containing the list of variables to be set
and then use `launchctl setenv` on each element of that list. The method is then made automatic by writing those instructions
in a file `~/Library/LaunchAgents/environment.plist` that shall be read and executed at each user login.

## Alternative

[EnvPane](https://github.com/hschmidt/EnvPane) is a nice GUI app doing exactly the same things as `vienv`.
It needs to install `~/.MacOSX/environment.plist`,
which is a problem when your `$HOME` is [not writable](https://soc.me/standards/defending-home).
