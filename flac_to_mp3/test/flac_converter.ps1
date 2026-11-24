<#
	depends on ffmpeg being installed

    converter src_fname -from -to 
    src_fname -> relative or abs fpath
	-out -> relative or abs fpath to a folder can be a fname

	-from from type
	-to to type 
	
	check file exists src 
	make sure is file not dir
	
	outfname = withoutPath(withoutExtensionIfExists(src_fname))

	if out specified 
	   if is directory
		   if folder not exists
			  create
	   else if is file
		   if path to file not exists
			   create folder on path
	
		   
	convert src_fname to outfname        
	
	if -all specified and src_fname is a path to dir:
		find all files of -from type
		for every file of -from type in src_fname
			convert  

   would need to implement support for many different audio codecs and types and formats and 

   make specific

   flac converter 
   flac to mp3,wav,m4a 

   flac_converter src -to mp3/m4a 
   src should be file or folder	
   if src is directory convert all flac to -to format 
   out_(mp3|m4a)
   use highest quality settings 

#>
[CmdletBinding(PositionalBinding=$false)]
param ( 
	[string] $src,
	[string] $out
)


if ($src -eq 0 -or (Test-Path $src) -eq $false){
	write-host "Invalid src file or src directory"
	exit
}

if ($out.length -eq 0){
	write-host "No output format specified with -to [format]"
	write-host "Valid formats=[mp3,m4a]"
	exit
}

if ($out -ne "mp3" -and $out -ne "m4a") {
	write-host "Invalid output format specified"
	exit
}


write-host ("src: " + $src)
write-host $out

#if source is a file then output into same location but folder out_format/filename.out_format
$isFile = (get-item $src).GetType() -ne [System.IO.DirectoryInfo]

$outParent = (Split-Path -Path $src -Parent) +"out_" + $out
Write-Host ("outParent: " + $outParent)

if ($isFile -eq $true){
	write-host "Src is a file!"
	$file = get-item $src
	$outFileName = $file.Name.substring(0,$file.Name.Length - 4) + $out
}else {
	$files = Get-ChildItem ($src+"\\*.flac")
	foreach ($file in $files){
		write-host ("found: " + $file.Name)
		$outFileName = $file.Name.substring(0,$file.Name.Length - 4) + $out
		$outFilePath = ($outParent + "\" + $outFileName)
		#do conversion 
		ffmpeg -i $file $outFilePath
	}
}
