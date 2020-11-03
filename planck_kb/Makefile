all:

install:
	rm -rf ../resources/qmk_firmware/keyboards/planck/keymaps/nono
	ln -s ../../../../../planck_kb/keymap/ ../resources/qmk_firmware/keyboards/planck/keymaps/nono

compile:
	make planck/rev6:nono --directory ../resources/qmk_firmware
	rm -rf ./build/*
	cp ../resources/qmk_firmware/.build/*.bin ./build

flash:
	sudo make planck/rev6:nono:flash --directory ../resources/qmk_firmware

