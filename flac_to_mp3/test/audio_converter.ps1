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
#>
