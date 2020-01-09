# !/bin/bash
# Instruction

# 1. Setup Anaconda downloaded from https://www.continuum.io/downloads#_macosx, and choose Python 2.7 64bit.
# 2. Run this shell script and check whether it generates any error 
# 3. Under Python prompt >>> Type in "import numpy, scipy, sklearn, pandas, matplotlib, gensim, nltk, xgboost, tensorflow"
echo 'Please setup the Anaconda first!'

sudo easy_install pip
sudo pip install -U pip

sudo pip install -U sklearn
sudo pip install -U matplotlib
sudo pip install -U pandas
sudo pip install -U nltk
sudo pip install -U gensim
sudo pip install -U xgboost
sudo easy_install -U six
sudo pip install --upgrade https://storage.googleapis.com/tensorflow/mac/tensorflow-0.5.0-py2-none-any.whl
sudo pip install git+git://github.com/tensorflow/skflow.git
python