# README

```bash
git clone https://github.com/hieunt79/dotfiles
cd dotfiles
apt install python3-pip -y

git submodule update --init --recursive
git submodule update --remote dotdrop

pip install -r dotdrop/requirements.txt
./dotdrop.sh install --profile server
```
