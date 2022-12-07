. $PSScriptRoot/../common.ps1

class File {
  File($name, $size) {
    $this.FileName = $name
    $this.Size = $size
  }

  [string] $FileName
  [string] $Size
}

class Folder {
  Folder($name) {
    $this.FolderName = $name
  }
  
  [String] $FolderName
  [System.Collections.Generic.List[File]] $Files
  [System.Collections.Generic.List[Folder]] $SubFolders
  [Folder] $ParentFolder
  [Int64] $Size

  [void] AddFile($file) {
    $this.Files.Add($file)
    $this.AddToSize($file.Size)
  }

  [void] AddToSize($size) {
    $this.Size += $size
    $this.ParentFolder?.AddToSize($size)
  }
}

enum LineType {
  Input
  Output
}

enum InputCommands {
  ls
  cd
}

function CreateFolder($name) {
  $folder = [Folder]::new($name)
  $folder.Files = [System.Collections.Generic.List[File]]::new()
  $folder.SubFolders = [System.Collections.Generic.List[Folder]]::new()
  return $folder
}

function FileInListReturnsFile($fileLine) {
  $fileLineComponents = $fileLine.Split(" ")
  return [File]::new($fileLineComponents[1], $fileLineComponents[0])
}

function FolderInListReturnsFolder($folderLine) {
  return (CreateFolder ($folderLine.Split(" ")[1]))
}

function CheckLineType($inputLine) {
  if ($inputLine[0] -eq "$") {
    return [LineType]::Input
  } else {
    return [LineType]::Output
  }
}

function CheckInputCommand($inputLine) {
  if ($inputLine -like "$ ls") {
    return [InputCommands]::ls
  }
  
  return [InputCommands]::cd
}

function CheckIfSubFolderExist($folder, $subfolder) {
  if ($folder.SubFolders.Where({$_.FolderName -eq $subfolder})) {
    return $true
  }

  return $false
}


function ProcessHistory($history) {
  $currentFolder
  $flatFolderList = [System.Collections.Generic.List[Folder]]::new()
  foreach($line in $history.Split([System.Environment]::NewLine)) {
    if ((CheckLineType $line) -eq [LineType]::Input) {
      if ((CheckInputCommand $line) -eq [InputCommands]::cd) {
        $folderAction = $line.Split(" ")[2]
        if ($folderAction -eq "/") {
          $currentFolder = CreateFolder "/"
        } elseif ($folderAction -eq "..") {
          $currentFolder = $currentFolder.ParentFolder
        } else {
          $currentFolder = $currentFolder.SubFolders.Where({$_.FolderName -eq $folderAction})[0]
        }
      }
    } else {
      $outputComponents = $line.Split(" ")
      if ($outputComponents[0] -eq "dir") {
        if (!(CheckIfSubFolderExist $outputComponents[1])) {
          $newFolder = FolderInListReturnsFolder $line
          $newFolder.ParentFolder = $currentFolder
          $currentFolder.SubFolders.Add($newFolder)
          $flatFolderList.Add($newFolder)
        }
      } else {
        $currentFolder.AddFile((FileInListReturnsFile $line))
      }
    }
  }

  while ($null -ne $currentFolder.ParentFolder) {
    $currentFolder = $currentFolder.ParentFolder
  }

  return @{RootFolder = $currentFolder; FlatFolderList = $flatFolderList}
}

function SumFoldersWithAtMostXSize($flatFolderList, $sizeLimit = 100000) {
  return ($flatFolderList.Where({$_.Size -le $sizeLimit}).Size | Measure-Object -Sum).Sum
}

function SolvePartOne($inputText) {
  $rootFolder = ProcessHistory $inputText
  return SumFoldersWithAtMostXSize $rootFolder.FlatFolderList
}

function FindSmallestDirectoryAboveASize($flatFolderList, $rootFileSize) {
  $breakpointSize = 30000000- (70000000 - $rootFileSize)
  return ($flatFolderList.Where({$_.Size -ge $breakpointSize}).Size | Measure-Object -Minimum).Minimum
}

function SolvePartTwo($inputText) {
  $rootFolder = ProcessHistory $inputText
  FindSmallestDirectoryAboveASize $rootFolder.FlatFolderList $rootFolder.RootFolder.Size
  
}
