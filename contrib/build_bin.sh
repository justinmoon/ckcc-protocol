#! /bin/bash
# Script for building standalone binary releases deterministically

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv shell 3.6.8
pip install -U pip
pip install poetry

# Setup poetry and install the dependencies
poetry install

# We now need to remove debugging symbols and build id from the hidapi SO file
so_dir=`dirname $(dirname $(poetry run which python))`/lib/python3.6/site-packages
find ${so_dir} -name '*.so' -type f -execdir strip '{}' \;
if [[ $OSTYPE != *"darwin"* ]]; then
    find ${so_dir} -name '*.so' -type f -execdir strip -R .note.gnu.build-id '{}' \;
fi

# We also need to change the timestamps of all of the base library files
lib_dir=`pyenv root`/versions/3.6.8/lib/python3.6
TZ=UTC find ${lib_dir} -name '*.py' -type f -execdir touch -t "201901010000.00" '{}' \;

# Make the standalone binary
export PYTHONHASHSEED=42
poetry run pyinstaller ckcc.spec
unset PYTHONHASHSEED

# Make the final compressed package
pushd dist
# FIXME
# VERSION=`poetry run hwi --version | cut -d " " -f 2`
VERSION=1
OS=`uname | tr '[:upper:]' '[:lower:]'`
if [[ $OS == "darwin" ]]; then
    OS="mac"
fi
tar -czf "ckcc-${VERSION}-${OS}-amd64.tar.gz" ckcc
popd
