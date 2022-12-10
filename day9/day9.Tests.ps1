using module "./day9.psm1"

BeforeAll {
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("UseDeclaredVarsMoreThanAssignments", "")]
  $inputText = "R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"
}

# Don't know why... but PS complains without this here.
enum Direction {
  Up
  Down
  Left
  Right
}

Describe "GetStart" {
  It "Should return a rope that has its knots positioned at 0,0" {
    $rope = GetStart
    $rope.Head.X | Should -be 0
    $rope.Head.Y | Should -be 0
    $rope.Tail.X | Should -be 0
    $rope.Tail.Y | Should -be 0
  }
}

Describe "ParseDirection" {
  It "Should give the proper enum value based on text input" `
  -TestCases `
  @{Text = "R"; Expected=[Direction]::Right},
  @{Text = "L"; Expected=[Direction]::Left},
  @{Text = "U"; Expected=[Direction]::Up},
  @{Text = "D"; Expected=[Direction]::Down} {
    param (
      $Text,
      $Expected
    )

    ParseDirection $Text | Should -be $Expected
  }
}

Describe "Rope::Move" {
  It "Should move the head and tail." {
    $rope = GetStart
    $rope.Move(([Direction]::Right), 4)
    $rope.Head.X | Should -be 4
    $rope.Tail.X | Should -be 3
    $rope.Move(([Direction]::Up), 4)
    $rope.Tail.X | Should -be 4
    $rope.Tail.Y | Should -be 3
    $rope.Move(([DIrection]::Left), 3)
    $rope.Tail.X | Should -be 2
    $rope.Tail.Y | Should -be 4
    $rope.Move(([DIrection]::Down), 1)
    $rope.Tail.X | Should -be 2
    $rope.Tail.Y | Should -be 4
  }
}

Describe "CalculateDistance" {
  It "Should calculate how far away the head is from the tail" `
  -TestCases `
  @{Head = [Knot]::new(0,0); Tail = [Knot]::new(1,1); Expected = [Math]::Sqrt(2)},
  @{Head = [Knot]::new(0,0); Tail = [Knot]::new(0,0); Expected = 0},
  @{Head = [Knot]::new(0,0); Tail = [Knot]::new(0,1); Expected = 1},
  @{Head = [Knot]::new(0,0); Tail = [Knot]::new(0,2); Expected = 2}  {
    param (
      $Head,
      $Tail,
      $Expected
    )

    CalculateDistance $Head $Tail | Should -be $Expected
  }
}

Describe "MoveTroughInput" {
  It "Should move the rope trough the test input" {
    $rope = GetStart
    MoveTroughInput $inputText $rope
    $rope.Head.X | Should -be 2
    $rope.Head.Y | Should -be 2
    $rope.Tail.X | Should -be 1
    $rope.Tail.Y | Should -be 2
  }
}

Describe "SolveDay9PartOne" {
  It "Should calculate visited places" {
    SolveDay9PartOne $inputText | Should -be 13
  }
}

Describe "SolveDay9PartTwo" {
  It "Should calculate visited places" {
    SolveDay9PartTwo $inputText | Should -be 1
  }
}

AfterAll {
  Remove-Module day9
}
