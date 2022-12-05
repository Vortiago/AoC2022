BeforeAll {
  . $PSScriptRoot/day5.ps1

  $inputText = "    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"

  $inputText
}

Describe "ParseSplitInTwo" {
  It "Should split the input in two components." {
    (ParseSplitInTwo $inputText).Count | Should -be 2
  }
}

Describe "ParseInitialState" {
  It "Should parse the input and create the initial state of stacks." {
    $stacks = ParseInitialState $inputText
    $stacks.Count | Should -be 3
    $stacks["1"].Pop() | Should -be "D"
    $stacks["2"].Pop() | Should -be "C"
    $stacks["3"].Pop() | Should -be "P"
  }
}

Describe "SplitStackRows" {
  It "Should return only the rows with crates in the initial state" {
    $stackRows = SplitStackRows (ParseSplitInTwo $inputText)[0]
    $stackRows.Count | Should -be 3
    $stackRows[-1] | Should -be "    [D]    "
    $stackRows[0] | Should -be "[Z] [M] [P]"
  }
}

Describe "FindAllStacks" {
  It "Should find the row in the bottom and create the stacks" {
    $stacks = FindAllStacks (ParseSplitInTwo $inputText)[0]
    $stacks.Count | Should -be 3
    $stacks["1"] -is [System.Collections.Generic.Stack[String]] | Should -be $true
  }
}

Describe "ParseCrateOnStack" {
  It "Should return the crate on that stack position" {
    ParseCrateOnStack "    [D]    " 2 | Should -be "D"
    ParseCrateOnStack "    [D]    " 3 | Should -be " "
    ParseCrateOnStack "[Z] [M] [P]" 3 | Should -be "P"
    ParseCrateOnStack "[Z] [M] [P]" 1 | Should -be "Z"
  }
}

Describe "ParseCommands" {
  It "Should parse each command line to the integers needed" {
    $command = ParseCommands "move 1 from 2 to 1"
    $command.Count | Should -be 3
    $command[0] | Should -be 1
    $command[1] | Should -be 2
    $command[2] | Should -be 1
    $command = ParseCommands "move 15 from 2 to 1"
    $command.Count | Should -be 3
    $command[0] | Should -be 15
    $command[1] | Should -be 2
    $command[2] | Should -be 1
  }
}

Describe "RunCommand" {
  It "Should run a command and move crates on the stack" {
    $stacks = ParseInitialState $inputText
    $cmd = ParseCommands "move 1 from 2 to 1"
    $stacks = RunCommand $cmd $stacks
    $stacks["2"].Pop() | Should -be "M"
    $stacks["1"].Pop() | Should -be "C"
  }
}

Describe "RunCrane" {
  It "Should give end result as expected" {
    $stacks = RunCrane $inputText
    $stacks["1"].Pop() | Should -be "C"
    $stacks["2"].Pop() | Should -be "M"
    $stacks["3"].Pop() | Should -be "Z"
  }
}

Describe "PartOneSolution" {
  It "Should print answer as text output" {
    PartOneSolution $inputText | Should -be "CMZ"
  }
}

Describe "PartTwoSolution" {
  It "Should print the CrateMover 9001 solution." {
    PartTwoSolution $inputText | Should -be "MCD"
  }
}
