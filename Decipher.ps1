Invoke-Command -ScriptBlock {
	$urlsc = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/Decipher.py'
	$urlscb = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/SafeDelete.py'
	Invoke-WebRequest -Uri $urlsc -OutFile $Env:userprofile\Escritorio\scriptD.py
	Invoke-WebRequest -Uri $urlscb -OutFile $Env:userprofile\Escritorio\borra.py
	& openssl rsautl -decrypt -inkey $Env:userprofile\Escritorio\private.pem -in $Env:userprofile\Escritorio\keyenc.enc -out $Env:userprofile\Escritorio\key.bin
	& python.exe scriptD.py
	& python.exe borra.py
	Remove-Item $Env:userprofile\Escritorio\borra.py
}