# README

```bash
git clone
cd dotfiles
apt install python3-pip -y

git submodule update --init --recursive
git submodule update --remote dotdrop

pip install -r dotdrop/requirements.txt
./ddrop.sh install --profile server
```
