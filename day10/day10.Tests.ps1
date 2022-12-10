using module "./day10.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop"
}

Describe "[CPU]::Noop" {
  It "Should make no changes to cycles or X registry" {
    $cpu = CreateCPU
    $cpu.Noop()
    $cpu.Cycles | Should -be 0
    $cpu.RegistryX | Should -be 0
  }
}

Describe "[CPU]::AddX" {
  It "Should increase cycles and either increase or decrease RegistryX" `
  -TestCases `
  @{Value = 2},
  @{Value = -2},
  @{Value = 4},
  @{Value = 0} {
    param(
      $Value
    )

    $cpu = CreateCPU
    $cpu.AddX($Value)
    $cpu.Cycles | Should -be 2
    $cpu.RegistryX | Should -be $Value
  }
}

Describe "ParseInstruction" {
  It "Should parse a line and return instruction" `
  -TestCases `
  @{Line = "addx 2"; Expected = @{Instruction = "addx"; Value = 2}},
  @{Line = "addx -2"; Expected = @{Instruction = "addx"; Value = -2}},
  @{Line = "addx -24"; Expected = @{Instruction = "addx"; Value = -24}},
  @{Line = "noop"; Expected = @{Instruction = "noop"; Value = $null}} {
    param (
      $Line,
      $Expected
    )
    $instruction = ParseInstruction $Line
    $instruction.Instruction | Should -be $Expected.Instruction
    $instruction.Value | Should -be $Expected.Value
  }
}

Describe "[CPU]::AddX" {
  It "If provided with a cycle to check, it should return that cycles X registry value" `
  -TestCases `
  @{CycleToCheck = @(,20); Expected = 420},
  @{CycleToCheck = @(,60); Expected = 1140},
  @{CycleToCheck = @(,100); Expected = 1800},
  @{CycleToCheck = @(20,60); Expected = 1560} {
    param (
      $CycleToCheck,
      $Expected
    )

    $cpu = RunInstructionsOnCPU $inputText $CycleToCheck
    $cpu.CyclesToCheck.Count | Should -be 0
    ($cpu.CycleStrengths | Measure-Object -Sum).Sum | Should -be $Expected  
  }
}

Describe "SolveDay10PartOne" {
  It "Should return the solution to part one in day 10" {
    SolveDay10PartOne $inputText | Should -be 13140
  }
}

AfterAll {
  Remove-Module day10
}
