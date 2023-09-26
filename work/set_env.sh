if [ "$1" = "full" ]; then
	git clone https://github.com/crosstool-ng/crosstool-ng.git
	cd crosstool-ng
	git checkout crosstool-ng-1.24.0
	./bootstrap
	./configure --prefix=$(pwd)
	make
	make install
fi

export PATH="${PATH}:/work/crosstool-ng/bin"
