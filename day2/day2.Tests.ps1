BeforeAll {
  . $PSScriptRoot/day2.ps1

  $inputText = "A Y
B X
C Z"

  $inputText
}

Describe "HandValues" {
  It "Rock, Paper an Scissor should have their values" {
    [HandValues]::Rock | Should -be 1
    [HandValues]::Paper | Should -be 2
    [HandValues]::Scissor | Should -be 3
  }
}

Describe "PossibleResults" {
  It "Loose, tie and win should give their correct points" {
    [PossibleResults]::Loose | Should -be 0
    [PossibleResults]::Tie | Should -be 3
    [PossibleResults]::Win | Should -be 6
  }
}

Describe "GetHandValue" {
  It "Check that hand value converts string to value" {
    GetHandValue "X" | Should -be (1)
    GetHandValue "Y" | Should -be (2)
    GetHandValue "Z" | Should -be (3)
  }
}

Describe "CheckGameRound" {
  It "Check that wins and losses give correct score." {
    CheckGameRound "A" "X" | Should -be 4
    CheckGameRound "A" "Z" | Should -be 3
    CheckGameRound "B" "Z" | Should -be 9
  }
}

Describe "Parse" {
  It "Should return correct size array" {
    $rounds = Parse $inputText
    $rounds.Count | Should -be 3
    $rounds[0] | Should -be "A Y"

  }
}

Describe "ParseRound" {
  It "A round should be parsed to two hands" {
    $rounds = Parse $inputText
    $round = ParseRound $rounds[0]
    $round[0] | Should -be "A"
    $round[1] | Should -be "Y"
  }
}

Describe "PlayGame" {
  It "Sum of rounds should be what's in the example" {
    PlayGame $inputText | Should -be 15
  }
}

Describe "PlayPart2Game" {
  It "Part two is different, should return other value" {
    PlayPart2Game $inputText | Should -be 12
  }
}

Describe "CheckGameRoundPart2" {
  It "Should be checked that the rule examples work." {
    CheckGameRoundPart2 "A" "Y" | Should -be 4
    CheckGameRoundPart2 "B" "X" | Should -be 1
    CheckGameRoundPart2 "C" "Z" | Should -be 7
  }
}
