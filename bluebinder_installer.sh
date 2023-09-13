#!/bin/bash


NOCOL="\033[0m" #all default attributes
BLACK="\033[30m" #black color of signs
RED="\033[31m" #red color signs
GREEN="\033[32m" #green color signs
YELLOW="\033[33m" #yellow color signs
BLUE="\033[34m" #blue color signs
PURPL="\033[35m" #purple color signs
GREY="\033[37m" #grey color signs


clear
echo -e "$BLUE#=============================#"
echo -e "Automatic install bluebinder to android"
echo -e "#=============================#$NOCOL"
sleep 3
echo ""


clear
echo -e "$YELLOW#=============================#"
echo -e "${RED}1${YELLOW}/${GREEN}3${YELLOW} Stage is go - install requirements"
echo -e "#=============================#$NOCOL"
sudo apt-get update
sudo apt-get install make gcc build-essential libglib2.0*-dev libsystemd-dev libbluetooth-dev -y
sleep 3


clear
echo -e "$YELLOW#=============================#"
echo -e "2/${GREEN}3${YELLOW} Stage is go - download sources"
echo -e "#=============================#$NOCOL"
GIT_BLUEBINDER=https://github.com/mer-hybris/bluebinder
GIT_BLUEBINDER2=https://github.com/p3h3n9-pr0j3ct/bluebinder
GIT_LIBGBINDER=https://github.com/mer-hybris/libgbinder
GIT_LIBGBINDER2=https://github.com/p3h3n9-pr0j3ct/libgbinder
GIT_LIBGLIBUTIL=https://git.sailfishos.org/mer-core/libglibutil
GIT_LIBGLIBUTIL2=https://github.com/p3h3n9-pr0j3ct/libglibutil
WORK_DIR=~/build_bluebinder

mkdir -p $WORK_DIR
cd $WORK_DIR
git clone $GIT_BLUEBINDER || git clone --depth 1 $GIT_BLUEBINDER2
git clone $GIT_LIBGBINDER || git clone --depth 1 $GIT_LIBGBINDER2
git clone $GIT_LIBGLIBUTIL || git clone --depth 1 $GIT_LIBGLIBUTIL2
sleep 3


clear
echo -e "$YELLOW#=============================#"
echo -e "${GREEN}3${YELLOW}/${GREEN}3${YELLOW} Stage is go - building files"
echo -e "#=============================#$NOCOL"
cd libglibutil
make -j$(nproc --all)
make install-dev -j$(nproc --all)
cd ..

cd libgbinder
make -j$(nproc --all)
make install-dev -j$(nproc --all)
cd ..

cd bluebinder
make -j$(nproc --all)
make install -j$(nproc --all)
cd ~
rm -rf $WORK_DIR

echo -e "$YELLOW#=============================#"
echo -e "${GREEN}Successful building. Let's enjoy!$NOCOL"
echo -e "$YELLOW#=============================#$NOCOL"
