BeforeAll {
  . $PSScriptRoot/day6.ps1

  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
}

Describe "CheckIfFourCharactersAreUnique" {
  It "Should return true or false depending on if the 4 characters are unique." {
    CheckIfFourCharactersAreUnique "mjqj" | Should -be $false
    CheckIfFourCharactersAreUnique "jqjp" | Should -be $false
    CheckIfFourCharactersAreUnique "jpqm" | Should -be $true
  }
}

Describe "FindPositionAfterMarker" {
  It "Should find the position after the first four unique characters" {
    FindPositionAfterMarker $inputText | Should -be 7
    FindPositionAfterMarker "bvwbjplbgvbhsrlpgdmjqwftvncz" | Should -be 5
    FindPositionAfterMarker "nppdvjthqldpwncqszvftbrmjlhg" | Should -be 6
    FindPositionAfterMarker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" | Should -be 10
    FindPositionAfterMarker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" | Should -be 11
  }
}

Describe "FindPositionAfterMarker" {
  It "Should return the position after the message marker is found." {
    FindPositionAfterMarker $inputText 14 | Should -be 19
    FindPositionAfterMarker "bvwbjplbgvbhsrlpgdmjqwftvncz" 14 | Should -be 23
    FindPositionAfterMarker "nppdvjthqldpwncqszvftbrmjlhg" 14 | Should -be 23
    FindPositionAfterMarker "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" 14 | Should -be 29
    FindPositionAfterMarker "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" 14 | Should -be 26
  }
}
