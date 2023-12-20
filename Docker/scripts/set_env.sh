append_path()
{
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

# Check if sourced
[[ "${BASH_SOURCE[0]}" != "${0}" ]] || ( echo "Must be sourced" && exit 1 );

# Paths
WORK_DIR=$(pwd)
CROSSTOOL_DIR=$WORK_DIR/crosstool-ng
TOOLCHAIN_DIR=$WORK_DIR/x-tools

# Targets
TGT_QEMU=arm-unknown-linux-gnueabi
TGT_QEMU_BIN=$TOOLCHAIN_DIR/$TGT_QEMU/bin
TGT_QEMU_ARCH=arm
TGT_RPI4=aarch64-rpi4-linux-gnu
TGT_RPI4_BIN=$TOOLCHAIN_DIR/$TGT_RPI4/bin
TGT_RPI4_ARCH=arm

# Handle setup
case $1 in
	"setup_ct")
		if [[ ! -d $CROSSTOOL_DIR ]]; then
			git clone https://github.com/crosstool-ng/crosstool-ng.git $CROSSTOOL_DIR
			cd $CROSSTOOL_DIR
			git checkout crosstool-ng-1.26.0
			rm -rf ${WORK_DIR}/src
			mkdir ${WORK_DIR}/src
			./bootstrap
			./configure --prefix=$(pwd)
			make -j .$(nproc --all)
			make install
			cd $WORK_DIR
		else
			echo "CROSSTOOL is already installed"
		fi
		;;
	"setup_qemu")
		append_path $CROSSTOOL_DIR
		if [[ -d $CROSSTOOL_DIR ]]; then
			if [[ ! -d $TGT_QEMU_BIN ]]; then
				cd $CROSSTOOL_DIR
				bin/ct-ng distclean
				bin/ct-ng $TGT_QEMU
				sed -i 's+CT_LOCAL_TARBALLS_DIR="${HOME}/src"+CT_LOCAL_TARBALLS_DIR="'"$WORK_DIR"'/src"+g' .config
				sed -i 's/CT_PREFIX_DIR_RO=y/# CT_PREFIX_DIR_RO is not set/g' .config
				sed -i 's+CT_PREFIX_DIR="${CT_PREFIX:-${HOME}/+CT_PREFIX_DIR="${CT_PREFIX:-"'"$WORK_DIR"'"/+g' .config
				bin/ct-ng build.$(nproc --all)
				cd $WORK_DIR
			else
				echo "TOOLCHAIN already installed"
			fi
		else
			echo "CROSSTOOL is not installed"
		fi
		;;
	"setup_rpi4")
		append_path $CROSSTOOL_DIR
		if [[ -d $CROSSTOOL_DIR ]]; then
			if [[ ! -d $TGT_RPI4_BIN ]]; then
				cd $CROSSTOOL_DIR
				bin/ct-ng distclean
				bin/ct-ng $TGT_RPI4
				sed -i 's+CT_LOCAL_TARBALLS_DIR="${HOME}/src"+CT_LOCAL_TARBALLS_DIR="'"$WORK_DIR"'/src"+g' .config
				sed -i 's/CT_PREFIX_DIR_RO=y/# CT_PREFIX_DIR_RO is not set/g' .config
				sed -i 's+CT_PREFIX_DIR="${CT_PREFIX:-${HOME}/+CT_PREFIX_DIR="${CT_PREFIX:-"'"$WORK_DIR"'"/+g' .config
				bin/ct-ng build.$(nproc --all)
				cd $WORK_DIR
			else
				echo "TOOLCHAIN already installed"
			fi
		else
			echo "CROSSTOOL is not installed"
		fi
		;;
	"set_qemu")
		if [[ -d $TGT_QEMU_BIN ]]; then
			append_path $TGT_QEMU_BIN
			export CROSS_COMPILE=$TGT_QEMU-
			export ARCH=$TGT_QEMU_ARCH
		else
			echo "TOOLCHAIN is not installed"
		fi
		;;
	"set_rpi4")
		if [[ -d $TGT_RPI4_BIN ]]; then
			append_path $TGT_RPI4_BIN
			export CROSS_COMPILE=$TGT_RPI4-
			export ARCH=$TGT_RPI4_ARCH
		else
			echo "TOOLCHAIN is not installed"
		fi
		;;
esac

