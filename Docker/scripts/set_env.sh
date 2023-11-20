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
	"setup_ct")
		if [[ ! -d $CROSSTOOL_DIR]]; then
			git clone https://github.com/crosstool-ng/crosstool-ng.git $CROSSTOOL_DIR
			cd $CROSSTOOL_DIR
			git checkout crosstool-ng-1.24.0
			rm -rf ~/src
			mkdir ~/src &>/dev/null
			wget -P -nv ~/src https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2
			wget -P -nv ~/src https://libisl.sourceforge.io/isl-0.20.tar.gz
			./bootstrap
			./configure --prefix=$(pwd)
			make
			make install
			cd $WORK_DIR
		else
			echo "CROSSTOOL is already installed"
		fi
		;;
	"setup_qemu")
		append_path $CROSSTOOL_DIR
		BIN_DIR=$TOOLCHAIN_DIR/arm-unknown-linux-gnueabi/bin
		if [[ -d $CROSSTOOL_DIR ]]; then
			if [[ ! -d $BIN_DIR ]]; then
				cd $CROSSTOOL_DIR
				bin/ct-ng distclean
				bin/ct-ng arm-unknown-linux-gnueabi
				sed -i 's/CT_PREFIX_DIR_RO=y/# CT_PREFIX_DIR_RO is not set/g' .config
				bin/ct-ng build
				cd $WORK_DIR
			else
				echo "TOOLCHAIN already installed"
			fi
		else
			echo "CROSSTOOL is not installed"
		fi
		;;
	"set_qemu")
		append_path $CROSSTOOL_DIR
		append_path $BIN_DIR
		BIN_DIR=$TOOLCHAIN_DIR/arm-unknown-linux-gnueabi/bin
		if [[ -d $BIN_DIR ]]; then
			export CROSS_COMPILE=arm-unknown-linux-gnueabi-
			export ARCH=arm
		else
			echo "TOOLCHAIN is not installed"
		fi
		;;
esac

