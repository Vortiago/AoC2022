. $PSScriptRoot/../common.ps1

class Rope {
  $Knots = @()
  $Head
  $Tail
  $Visited = @{}

  [void] Move([Direction]$Direction, $Distance) {
    foreach($i in 1..$Distance) {
      switch ($Direction) {
        ([Direction]::Right) {
          $this.Knots[0].X += 1
        }
        ([Direction]::Up) {
          $this.Knots[0].Y += 1
        }
        ([Direction]::Left) {
          $this.Knots[0].X -= 1
        }
        ([Direction]::Down) {
          $this.Knots[0].Y -= 1
        }
      }

      for($knotIndex = 1; $knotIndex -lt $this.Knots.Count; $knotIndex++) {
        $previousKnot = $this.Knots[($knotIndex - 1)]
        $thisKnot = $this.Knots[$knotIndex]
        if ((CalculateDistance $previousKnot $thisKnot) -ge 2) {
          $movementX = [Math]::Clamp($previousKnot.X - $thisKnot.X, -1, 1)
          $movementY = [Math]::Clamp($previousKnot.Y - $thisKnot.Y, -1, 1)
          $thisKnot.X += $movementX
          $thisKnot.Y += $movementY
        }

        if ($thisKnot -eq $this.Knots[-1]) {
          if ($null -eq $this.Visited[$thisKnot.X]) {
            $this.Visited[$thisKnot.X] = @{}
          }
          $this.Visited[$thisKnot.X][$thisKnot.Y] += 1
        }
      }
    }
  }
}

class Knot {
  Knot($X, $Y) {
    $this.X = $X
    $this.Y = $Y
  }

  $X
  $Y
}

enum Direction {
  Up
  Down
  Left
  Right
}

function ParseDirection($directionText) {
  switch ($directionText) {
    "R" { return [Direction]::Right }
    "L" { return [Direction]::Left }
    "U" { return [Direction]::Up }
    "D" { return [Direction]::Down}
    Default {}
  }
}

function GetStart($numberOfKnots = 2) {
  $rope = [Rope]::new()
  (1..$numberOfKnots).foreach({
    $rope.Knots += [Knot]::new(0,0)
  })
  $rope.Head = $rope.Knots[0]
  $rope.Tail = $rope.Knots[-1]
  return $rope
}


function CalculateDistance($head, $tail) {
  return [Math]::Sqrt([Math]::Pow(($tail.X - $head.X), 2) + [Math]::Pow(($tail.Y - $head.Y), 2))
}

function MoveTroughInput($inputText, $rope) {
  foreach($moveCommand in (DefaultParser $inputText)) {
    $components = $moveCommand.Split(" ")
    $movementDirection = ParseDirection $components[0]
    $distance = [int]::Parse($components[1])

    $rope.Move($movementDirection, $distance)
  }
}

function SolveDay9PartOne($inputText) {
  $rope = GetStart
  MoveTroughInput $inputText $rope

  $count = 0
  foreach($row in $rope.Visited.Keys) {
    foreach($column in $rope.Visited[$row].Keys) {
      $count += 1
    }
  }
  return $count
}

function SolveDay9PartTwo($inputText) {
  $rope = GetStart 10
  MoveTroughInput $inputText $rope

  $count = 0
  foreach($row in $rope.Visited.Keys) {
    foreach($column in $rope.Visited[$row].Keys) {
      $count += 1
    }
  }
  return $count
}
