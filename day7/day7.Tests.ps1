using module "./day7.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k"
}

Describe "FileInListReturnsFile" {
  It "Should convert a file line in text input to a file object." `
  -TestCases `
    @{line = "4060174 j"; expectedFile = [File]::new("j", "4060174")},
    @{line = "5626152 d.ext"; expectedFile = [File]::new("d.ext", "5626152")},
    @{line = "8504156 c.dat"; expectedFile = [File]::new("c.dat", "8504156")} {
    param(
      $line,
      $expectedFile
    )

    $file = FileInListReturnsFile $line
    $file.Name | Should -be $expectedFile.Name
    $file.Size | Should -be $expectedFile.Size
  }
}

Describe "FolderInListReturnsFolder" {
  It "Should convert a folder line in text input to a folder object" {
    (FolderInListReturnsFolder "dir e").FolderName | Should -be "e"
  }
}

Describe "CheckLineType" {
  It "Should return what type of line the input line is." `
  -TestCases `
    @{line = "$ ls"; expectedOutcome = ([LineType]::Input)},
    @{line = "dir d"; expectedOutcome = ([LineType]::Output)},
    @{line = "5626152 d.ext"; expectedOutcome = ([LineType]::Output)} {
    param(
      $line,
      $expectedOutcome
    )

    CheckLineType $line | Should -be $expectedOutcome
  }
}

Describe "CheckInputCommand" {
  It "Should return what type of input command is used" {
    CheckInputCommand "$ ls" | Should -be ([InputCommands]::ls)
    CheckInputCommand "$ cd .." | Should -be ([InputCommands]::cd)
  }
}

Describe "CheckIfSubFolderExist" {
  It "Should return true or false depending on if a subfolder exist already" {
    $folder = CreateFolder "a"
    CheckIfSubFolderExist $folder "b" | Should -be $false
    $folderb = CreateFolder "b"
    $folder.SubFolders.Add($folderb)
    CheckIfSubFolderExist $folder "b" | Should -be $true
  }
}

Describe "ProcessHistory" {
  It "Should process the history and return the root folder" {
    $rootFolder = ProcessHistory $inputText
    $rootFolder.RootFolder.FolderName | Should -be "/"
    ($rootFolder.RootFolder.SubFolders.Where({$_.FolderName -eq "a"})[0]).Size | Should -be 94853
  }
}

Describe "SumFoldersWithAtMostXSize" {
  It "Should give you the size of all folders summed together that are under X size." {
    $rootFolder = ProcessHistory $inputText
    SumFoldersWithAtMostXSize $rootFolder.FlatFolderList | Should -be 95437
  }
}

Describe "SolvePartOne" {
  It "Should give you the size of all folders summed together that are under X size." {
    SolvePartOne $inputText | Should -be 95437
  }
}

AfterAll {
  Remove-Module day7
}
