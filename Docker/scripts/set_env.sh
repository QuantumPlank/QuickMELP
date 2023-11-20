append_path()
{
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

#PATHS
WORK_DIR=$(pwd)
CROSSTOOL_DIR=$WORK_DIR/crosstool-ng
TOOLCHAIN_DIR=$WORK_DIR/x-tools

#MAIN HANDLE
case $1 in
	"setup")
		git clone https://github.com/crosstool-ng/crosstool-ng.git $CROSSTOOL_DIR
		cd $CROSSTOOL_DIR
		git checkout crosstool-ng-1.24.0
		rm -rf ~/src
		mkdir ~/src &>/dev/null
		wget -P ~/src https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2
		wget -P ~/src https://libisl.sourceforge.io/isl-0.20.tar.gz
		./bootstrap
		./configure --prefix=$(pwd)
		make
		make install
		cd $WORK_DIR
		;;
	"rpi")
		BIN_DIR=$TOOLCHAIN_DIR/aarch64-rpi4-linux-gnu/bin
		export CROSS_COMPILE=aarch64-rpi4-linux-gnu-
		export ARCH=arm
		;;
	"qemu")
		BIN_DIR=$TOOLCHAIN_DIR/arm-unknown-linux-gnueabi/bin
		export CROSS_COMPILE=arm-unknown-linux-gnueabi-
		export ARCH=arm
		;;
esac

#PATH HANDLE
append_path $CROSSTOOL_DIR
append_path $BIN_DIR
