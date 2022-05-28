Invoke-Command -ScriptBlock {
	$urlsc = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/Decipher.py'
	$urlscb = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/SafeDelete.py'
	Invoke-WebRequest -Uri $urlsc -OutFile $Env:userprofile\Desktop\scriptD.py
	Invoke-WebRequest -Uri $urlscb -OutFile $Env:userprofile\Desktop\borra.py
	& openssl rsautl -decrypt -inkey $Env:userprofile\Desktop\private.pem -in $Env:userprofile\Desktop\keyenc.enc -out $Env:userprofile\Desktop\key.bin
	& python.exe scriptD.py
	& python.exe borra.py
	Remove-Item $Env:userprofile\Desktop\borra.py
}