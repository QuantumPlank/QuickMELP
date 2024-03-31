
cd /work
WORK_DIR=$(pwd)
UBOOT_DIR=$WORK_DIR/u-boot

# Check if sourced
[[ "${BASH_SOURCE[0]}" != "${0}" ]] || { echo "Must be sourced" && exit 1; }

if [ -z $UBOOT_VERSION ]; then
	UBOOT_VERSION="v2024.01"
fi

git clone https://source.denx.de/u-boot/u-boot.git --depth 1 --single-branch -b $UBOOT_VERSION $UBOOT_DIR

cd $UBOOT_DIR


