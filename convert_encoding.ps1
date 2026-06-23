$enc = [System.Text.Encoding]::GetEncoding('GB2312')
$files = Get-ChildItem -Filter *.pas
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, $enc)
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
}
Write-Host "Converted files to UTF-8"
