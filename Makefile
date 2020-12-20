# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean

	mkdir --parents $(PWD)/build/Nomacs.AppDir
	apprepo --destination=$(PWD)/build appdir nomacs nomacs-l10n
	echo "exec \$${APPDIR}/bin/nomacs \"\$${@}\"" >> $(PWD)/build/Nomacs.AppDir/AppRun

	rm --force $(PWD)/build/Nomacs.AppDir/*.desktop		| true
	rm --force $(PWD)/build/Nomacs.AppDir/*.svg			| true
	rm --force $(PWD)/build/Nomacs.AppDir/*.png			| true

	cp -r --force $(PWD)/AppDir/*.desktop	$(PWD)/build/Nomacs.AppDir/	| true
	cp -r --force $(PWD)/AppDir/*.svg		$(PWD)/build/Nomacs.AppDir/ 	| true
	cp -r --force $(PWD)/AppDir/*.png		$(PWD)/build/Nomacs.AppDir/ 	| true

	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/Nomacs.AppDir $(PWD)/Nomacs.AppImage
	chmod +x $(PWD)/Nomacs.AppImage

clean:
	rm -rf $(PWD)/build
