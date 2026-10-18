param([switch]$NoLaunch,[switch]$NoShortcut)
$ErrorActionPreference='Stop'
[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
$repo='https://github.com/tommowx/jarvis/releases'
$jarvisRoot=Join-Path $env:LOCALAPPDATA 'JarvisBeta'
New-Item -ItemType Directory -Path $jarvisRoot -Force|Out-Null
$stage=Join-Path $jarvisRoot ('install-'+[guid]::NewGuid().ToString('N'));New-Item -ItemType Directory -Path $stage|Out-Null
try{
 Write-Host 'Scarico Jarvis e i componenti vocali. Il primo download richiede circa 2 GB.'
 $envelope=Invoke-RestMethod -Uri ($repo+'/latest/download/update.json')
 $bytes=[Convert]::FromBase64String($envelope.payload);$signature=[Convert]::FromBase64String($envelope.signature)
 $rsa=New-Object Security.Cryptography.RSACryptoServiceProvider
 $rsa.FromXmlString('<RSAKeyValue><Modulus>p7ZQ0o2QMcfuHLYJPQjFDruuiBlcAFuiOSKqATa60NIaw+mXxQngAWM3ghle9hQxdFlskOTEn1qnkW/Qd+XIcDtSYrVpaZL4vMcdspOe5q6207y+tUhOQ+PSSkTJCV5mELgTn6ZCSY9rGEfkncEyDaELPiqtzv4XYdFsHWZv2+x9G++CPU0lrvGcj7yxCFLALtWBUcOFaGTpwi1gKfufqMNOPGCjpGMx/PMj7vXRyVbn9Srkl9GzchokH7d+XQ90ImXLUynWu4IiTQPHLOYTbAqCnMfD9RDoD7Y8MukJBUYzcazQET2GtZd5KjiPAxWpYogK1FTEFnYhv1lNc9sTEzT/Hj2v0NrCR5XzByFHokQG0beFCf7pbbL0Za3XjmXC2KopTR4r9T21YV9ApSvXwI5Hk5KBt6fdFj3tKe2o8I0sgg9aaHKbznpIzXVtMLO7VPalu2ZDBFAoCSh/BB2yVZLXts86wiKQyB8/Tg+29G0QK3iR1Dn46ojjm5HKcG+7</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>')
 if(!$rsa.VerifyData($bytes,'SHA256',$signature)){throw 'Firma del manifest non valida.'}
 $manifest=[Text.Encoding]::UTF8.GetString($bytes)|ConvertFrom-Json
 if($manifest.version -notmatch '^\d+\.\d+\.\d+$'){throw 'Versione non valida.'}
 Add-Type -AssemblyName System.IO.Compression.FileSystem
 foreach($asset in $manifest.assets){
  if($asset.id -notin @('app','voice','documents') -or $asset.name -notmatch '^Jarvis-[A-Za-z0-9.-]+\.zip$' -or $asset.sha256 -notmatch '^[a-f0-9]{64}$' -or $asset.bytes -lt 1 -or $asset.bytes -gt 2147483647){throw 'Pacchetto non valido.'}
  if($asset.url -ne ($repo+'/download/v'+$manifest.version+'/'+$asset.name)){throw 'Origine download non autorizzata.'}
  $zip=Join-Path $stage $asset.name
  Write-Host ('Scarico '+$asset.name)
  (New-Object Net.WebClient).DownloadFile($asset.url,$zip)
  if((Get-Item -LiteralPath $zip).Length -ne $asset.bytes -or (Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash.ToLower() -ne $asset.sha256){throw 'File incompleto o modificato.'}
  $top=@{app='App';voice='voice';documents='documents'}[$asset.id]
  $archive=[IO.Compression.ZipFile]::OpenRead($zip)
  try{foreach($entry in $archive.Entries){$target=[IO.Path]::GetFullPath((Join-Path $stage $entry.FullName));if(!$entry.FullName.StartsWith($top+'/') -or !$target.StartsWith($stage+[IO.Path]::DirectorySeparatorChar) -or $entry.FullName.Contains(':') -or $entry.FullName.Contains('\') -or $entry.FullName.Split('/') -contains '..'){throw 'Percorso nel pacchetto non valido.'}}}finally{$archive.Dispose()}
  [IO.Compression.ZipFile]::ExtractToDirectory($zip,$stage);Remove-Item -LiteralPath $zip
 }
 $exe=Join-Path $jarvisRoot 'App\Jarvis.exe'
 if(Get-Process -Name Jarvis -ErrorAction SilentlyContinue|Where-Object Path -eq $exe){throw 'Chiudi Jarvis dalla sua icona vicino all orologio, poi ripeti la installazione.'}
 $replaced=@();$saved=@()
 try{foreach($name in @('App','voice','documents')){
  $new=Join-Path $stage $name;if(!(Test-Path -LiteralPath $new)){throw ('Componente mancante: '+$name)}
  $target=Join-Path $jarvisRoot $name
  if(Test-Path -LiteralPath $target){Move-Item -LiteralPath $target -Destination (Join-Path $stage ('Previous-'+$name));$saved+=@($name)}
  Move-Item -LiteralPath $new -Destination $target;$replaced+=@($name)
 }}catch{foreach($name in @('documents','voice','App')){$target=Join-Path $jarvisRoot $name;if($replaced -contains $name){Move-Item -LiteralPath $target -Destination (Join-Path $stage ('Failed-'+$name))};if($saved -contains $name){Move-Item -LiteralPath (Join-Path $stage ('Previous-'+$name)) -Destination $target}};throw}
 New-Item -ItemType Directory -Path (Join-Path $jarvisRoot 'updates') -Force|Out-Null
 $components=@{};foreach($asset in $manifest.assets){$components[$asset.id]=$asset.sha256};$components|ConvertTo-Json|Set-Content -LiteralPath (Join-Path $jarvisRoot 'updates\components.json') -Encoding UTF8
 if(!$NoShortcut){$shell=New-Object -ComObject WScript.Shell
 $link=$shell.CreateShortcut((Join-Path ([Environment]::GetFolderPath('Desktop')) 'Jarvis Beta.lnk'));$link.TargetPath=$exe;$link.WorkingDirectory=Split-Path $exe;$link.Save()}
 Write-Host 'Jarvis installato. Al primo avvio collega il tuo account ChatGPT. I dati personali esistenti sono conservati.'
 if(!$NoLaunch){Start-Process -FilePath $exe}
}catch{Write-Host ('Installazione non completata: '+$_.Exception.Message);throw}
