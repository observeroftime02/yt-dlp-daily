Remove-Item -LiteralPath ".\dist\" -Force -Recurse
python devscripts/update-version.py
python devscripts/make_lazy_extractors.py
python -m pip install -U pip setuptools wheel py2exe
pip install "https://observeroftime01.github.io/Pyinstaller-Builds/x86_64/pyinstaller-5.6.2-py3-none-any.whl" -r requirements.txt
python setup.py py2exe
Move-Item ./dist/yt-dlp.exe ./dist/yt-dlp_min.exe
python pyinst.py
python pyinst.py --onedir
Compress-Archive -Path ./dist/yt-dlp/* -DestinationPath ./dist/yt-dlp_win.zip
echo "yt-dlp_min.exe: $((Get-FileHash dist\yt-dlp_min.exe -Algorithm SHA256).Hash.ToLower())" >> ./dist/SHA256SUM.txt
echo "yt-dlp_min.exe: $((Get-FileHash dist\yt-dlp_min.exe -Algorithm SHA512).Hash.ToLower())" >> ./dist/SHA512SUM.txt
echo "yt-dlp.exe: $((Get-FileHash dist\yt-dlp.exe -Algorithm SHA256).Hash.ToLower())" >> ./dist/SHA256SUM.txt
echo "yt-dlp.exe: $((Get-FileHash dist\yt-dlp.exe -Algorithm SHA512).Hash.ToLower())" >> ./dist/SHA512SUM.txt
echo "yt-dlp_win.zip: $((Get-FileHash dist\yt-dlp_win.zip -Algorithm SHA256).Hash.ToLower())" >> ./dist/SHA256SUM.txt
echo "yt-dlp_win.zip: $((Get-FileHash dist\yt-dlp_win.zip -Algorithm SHA512).Hash.ToLower())" >> ./dist/SHA512SUM.txt
<#
.installation

uncomment and modify the path below to have the script automatically update your local executable

Remove-Item -LiteralPath "$HOME\apps\youtube-dl\youtube-dl.exe" -Force
Copy-Item -LiteralPath ".\dist\yt-dlp.exe" "$HOME\apps\youtube-dl\youtube-dl.exe"
#>
pause
