#!/bin/bash
GREEN='\033[1;32m'
ORANGE='\033[0;33m'
NC='\033[0m'
rm -rf ./build
rm -rf ./dist
rm ./yt-dlp
printf "${GREEN}Installing dependencies${NC}\n"
apt-get -y install zip pandoc man
python3 -m pip install -U pip setuptools wheel twine
python3 -m pip install -U "https://observeroftime01.github.io/Pyinstaller-Builds/x86_64/pyinstaller-5.6.2-py3-none-any.whl" -r requirements.txt
printf "${GREEN}Preparing for build${NC}\n"
python3 devscripts/update-version.py
python3 devscripts/make_lazy_extractors.py
printf "${GREEN}Building the various packages${NC}\n"
make all tar
python3 pyinst.py --onedir
(cd ./dist/yt-dlp_linux && zip -r ../yt-dlp_linux.zip .)
python3 pyinst.py
mv ./yt-dlp ./dist/yt-dlp
printf "${GREEN}Creating checksums${NC}\n"
sha256sum ./dist/yt-dlp >> ./dist/sha256sum
sha256sum ./dist/yt-dlp_linux >> ./dist/sha256sum
sha256sum ./dist/yt-dlp_linux.zip >> ./dist/sha256sum
sha512sum ./dist/yt-dlp >> ./dist/sha512sum
sha512sum ./dist/yt-dlp_linux >>./dist/sha512sum
sha512sum ./dist/yt-dlp_linux.zip >> ./dist/sha512sum
# uncomment and modify the paths below to have the script automatically update your local executable after build
# printf "${GREEN}Updating local version${NC}\n"
# rm /usr/local/bin/youtube-dl
# cp ./dist/yt-dlp_linux /usr/local/bin/youtube-dl
# chmod +x /usr/local/bin/youtube-dl
printf "${ORANGE}All finished, all your executables are in the dist folder${NC}\n"
