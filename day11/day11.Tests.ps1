using module "./day11.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"
}

Describe "SplitMoneyInput" {
  It "Should split the text input into the correct amount of monkeys." {
    (SplitMonkeyInput $inputText).Count | Should -be 4
  }
}

Describe "ParseMonkeyInput" {
  It "Should parse a monkey in text format." {
    $monkey = ParseMonkeyInput (SplitMonkeyInput $inputText)[0]
    $monkey.Name | Should -be 0
    $monkey.Items | Should -BeIn @(79, 98)
    $monkey.WorryLevelOperation | Should -be "*"
    $monkey.WorryLevelChange | Should -be "19"
    $monkey.ThrowTest | Should -be 23
    $monkey.ThrowTargets[$true] | Should -be 2
    $monkey.ThrowTargets[$false] | Should -be 3
  }
}

Describe "PlayGame" {
  It "Should advance the game and have the monkies in their correct state" {
    $monkies = PlayGame 1 $inputText
    $monkies[0].Items.Count | Should -be 4
    $monkies[1].Items.Count | Should -be 6
    $monkies[2].Items.Count | Should -be 0
    $monkies[3].Items.Count | Should -be 0
  }
}

Describe "PlayGame" {
  It "Should increase inspection by correct amount" {
    $monkies = PlayGame 20 $inputText
    $monkies[0].Inspections | Should -be 101
    $monkies[1].Inspections | Should -be 95
    $monkies[2].Inspections | Should -be 7
    $monkies[3].Inspections | Should -be 105
  }
}

Describe "SolveDay11PartOne" {
  It "Should return the correct answer for part one on day 11" {
    SolveDay11PartOne $inputText | Should -be 10605
  }
}

AfterAll {
  Remove-Module day11
}
