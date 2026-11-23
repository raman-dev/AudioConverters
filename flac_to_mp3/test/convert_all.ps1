<#

    ffmpeg options
    -ar sets sample rate
    -b:a sets bitrate 
    -i means input 
     
    for every flac file in this folder
    ffmpeg.convert file.flac to mp3_output\file.mp3

#>

$files = get-childitem *.flac
if ($files.length -eq 0){
    write-output "No flac files to convert"
    exit
}

$outdir = "out_mp3"
#check if folder exists
if ((test-path "out_mp3") -eq $false) {
    new-item $outdir -itemtype "directory"
}

foreach ($file in $files) {
    write-output ("Converting " + $file.name)
    $fileOut = $outdir+"\" + $file.name.subString(0,$file.name.Length - 4) + "mp3"
    write-output $fileOut
    ffmpeg -i $file.name -ar 44100 -b:a 320k $fileOut
}
