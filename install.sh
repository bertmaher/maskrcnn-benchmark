#!/bin/sh

set -euo pipefail

pip -q install -r requirements.txt
pip -q install opencv-python

TMPDIR="$(mktemp -d)"

pushd "$TMPDIR"
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
python setup.py build_ext install
popd

pushd "$TMPDIR"
git clone https://github.com/mcordts/cityscapesScripts.git
cd cityscapesScripts/
python setup.py build_ext install
popd

pushd "$TMPDIR"
git clone https://github.com/NVIDIA/apex.git
cd apex
python setup.py install --cuda_ext --cpp_ext
popd

python setup.py install
