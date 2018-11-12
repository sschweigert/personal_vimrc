
let s:sourceTopDirectories = ["src", "source"]
let s:headerTopDirectories = ["include"]

" Generate a path used to search for the related file
" This function will look up from the current file path
" until it finds a directory matching one of the topDirectories
" Then, it will return the directory above that directory.
" For example, if topDirectories = ["include"] and the path is
" /something/include/.../my_file the function will return /something/
function GetSearchDownPath(topDirectories)
	for directory in a:topDirectories

		" Delete everything after directory
		let pathQualifier = "%:p:s?" . directory . ".*??"
		let candidateTop = expand(pathQualifier)

		" Check if different from file path, which shows directory
		" occurs somewhere in the path
		if candidateTop !=? expand("%:p")
			return candidateTop
		endif
	endfor

	" TODO: Search upward for .git and use that as top directory
	" before using current directory

	" Search in current directory only
	return expand("%:p:h")
endfunction

" A function to get related header or source path
" Returns an empty string if the path could not be found
function GetRelatedPath()
	let l:filename = expand("%:t:r")
	let extension = expand("%:e")

	let searchDownPath = ""
	let searchExtensions = []
	if extension == "h"
		let searchDownPath = GetSearchDownPath(s:headerTopDirectories)	
		let searchExtensions = ["hpp", "cpp"]
	elseif extension == "hpp"
		let searchDownPath = GetSearchDownPath(s:headerTopDirectories)	
		let searchExtensions = ["cpp", "h"]
	elseif extension == "cpp"
		let searchDownPath = GetSearchDownPath(s:sourceTopDirectories)	
		let searchExtensions = ["h", "hpp"]
	else
		echom "Not a C++ file"
		return ""
	endif	

	" Search downward from searchDownPath to find the file
	for candidateExtension in searchExtensions
		let newFileName = l:filename . "." . candidateExtension
		let searchTerm = searchDownPath . "**"
		let filePath = findfile(newFileName, searchTerm)

		" Check if the file was found
		if filePath !=? ""
			return filePath
		endif
	endfor

	echom "Could not find related file"
	return ""
endfunction

" A function to decide whether to jump to split
" If current file is not modified, then jump to new file
" else split for the new file
function SplitOrJump(fullPath)
	if &modified
		exe "vert sf" a:fullPath 
	else
		exe "find" a:fullPath
	endif
endfunction

" A funtion to jump to the source or header file of current file
" if current file is not modified, do jump
" else do split
function HeaderJump()
	let path = GetRelatedPath()
	if path != ""
		call SplitOrJump(path)
	endif
endfunction

" A function to split and open the source or header file of current file
function HeaderSplit()
	let path = GetRelatedPath()
	if path != ""
		exe "vert sf" path
	endif
endfunction
