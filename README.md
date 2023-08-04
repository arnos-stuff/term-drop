# A repository for Quake-Mode terms

## Wezterm

On Fedora 38, wezterm barely works outside Flatpak, so install that:

```shell
flatpak install org.wezfurlong.wezterm
```

Just make it into a shell executable:

```shell
echo "#\!/bin/bash" > wezterm
echo "flatpak run org.wezfurlong.wezterm" >> wezterm
chmod +x wezterm
sudo mv wezterm /usr/local/bin
```
compile `tdrop` (you will need to install a bunch of deps):

```shell
cd tdrop
sudo make install
```
```shell
echo "#\!/bin/bash" > wezterm-quake
echo "tdrop wezterm" >> wezterm-quake
chmod +x wezterm-quake
sudo mv wezterm-quake /usr/local/bin
```
## Config files

The config files for the terms are stored in `./config` when you need a pretty term with shortcuts quickly.

