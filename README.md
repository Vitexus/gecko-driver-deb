# gecko-driver-deb

repacked current [geckodriver](https://github.com/mozilla/geckodriver) as debian package

Build your own package:

```shell
debuild -us -uc
```

gives you **geckodriver_VERSION_amd64.deb**

Install gecko-driver from vitexsoftware repository:

```shell
sudo apt install lsb-release wget apt-transport-https bzip2

wget -qO- https://repo.vitexsoftware.com/keyring.gpg | sudo tee /etc/apt/trusted.gpg.d/vitexsoftware.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/vitexsoftware.gpg]  https://repo.vitexsoftware.com  $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/vitexsoftware.list
sudo apt update

sudo apt install gecko-driver
```
