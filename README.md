### Dependencies

Used apps:
- tmux   (https://github.com/tmux/tmux/wiki)
- st     (https://st.suckless.org/)
- slock  (https://tools.suckless.org/slock/)
- dmenu  (https://tools.suckless.org/dmenu/) 
- xmobar (https://xmobar.org/)
- trayer

Optional apps:
 - dunst  (https://github.com/dunst-project/dunst)

Base Fonts:
    - Fira Code (https://github.com/tonsky/FiraCode)

Build dependencies:
    - stack  (https://docs.haskellstack.org/en/stable/README/)

base instructions for xmonad: https://xmonad.org/INSTALL.html 
#!Don't forget install dependencies for your linux distribution 

### Xmonad setup
Get latest xmonad and xmonad-contrib
```bash
$ git clone https://github.com/xmonad/xmonad (version on latest build 0.17.0.9)
```
```bash
$ git clone https://github.com/xmonad/xmonad-contrib (version on latest build 0.17.0.9)
```
or specific versions
```bash
$ git clone --branch v0.15 https://github.com/xmonad/xmonad
```
```bash
$ git clone --branch v0.16 https://github.com/xmonad/xmonad-contrib
```
```bash
stack init
```
```bash
stack install
```
```bash
ln -s {PATH}/xmonad-desktop {HOME}/.xmonad
```
```bash
sudo ln -s {HOME}/.local/bin/xmonad /usr/bin
```
then you can use ```xmonad --recompile``` to rebuild project

```bash
ln -s {PATH}/xmonad-desktop/dot_files/xinitrc {HOME}/.xinitrc
```

### Apps setup
dunstrc
```bash
ln -s {PATH}/xmonad-desktop/dot_files/dunstrc {HOME}/.config/dunstrc
```
dmenu:
```bash
git clone https://git.suckless.org/dmenu
```
```bash
cd dmenu
```
```bash 
rm dmenu_run
```
```bash
ln -s {PATH}/xmonad-desktop/suckless.org/dmenu_run {PATH}/xmonad-desktop/suckless.org/dmenu/dmenu_run
```
```bash
ln -s {PATH}/xmonad-desktop/suckless.org/dmenu.config.h {PATH}/xmonad-desktop/suckless.org/dmenu/config.h
```
```bash
sudo make clean install
```
