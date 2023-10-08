# gecko-driver-deb

repack current geckodriver as debian package

sudo apt install lsb-release wget apt-transport-https bzip2

Build:

```shell
debuild -us -uc
```

gives you **geckodriver_VERSION-1_amd64.deb**

Install gecko-driver from vitexsoftware repository:

```shell
wget -qO- https://repo.vitexsoftware.com/keyring.gpg | sudo tee /etc/apt/trusted.gpg.d/vitexsoftware.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/vitexsoftware.gpg]  https://repo.vitexsoftware.com  $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/vitexsoftware.list
sudo apt update

sudo apt install gecko-driver
```
