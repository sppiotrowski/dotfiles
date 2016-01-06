TT_HOME="$HOME"'/.tt'
TT_VENV="$TT_HOME/venv"

# install system dependency
sudo apt-get install -yy python-pip python-dev libssl-dev build-essential libffi-dev
sudo -H pip install virtualenv
sudo -H pip install --upgrade pip

# install additions in virtualenv
virtualenv "$TT_VENV"

# install python deps into a virtual env
"$TT_VENV/bin/pip" install -q -r ./requirements.txt
