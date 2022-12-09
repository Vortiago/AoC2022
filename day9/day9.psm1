. $PSScriptRoot/../common.ps1

class Rope {
  $Head
  $Tail
  $Visited = @{}
  [void] Move([Direction]$Direction, $Distance) {
    foreach($i in 1..$Distance) {
      switch ($Direction) {
        ([Direction]::Right) {
            $this.Head.X += 1
            if ((CalculateDistance $this.Head $this.Tail) -ge 2) {
              $this.Tail.Y = $this.Head.Y
              $this.Tail.X += 1
            }
        }
        ([Direction]::Up) {
          $this.Head.Y += 1
          if ((CalculateDistance $this.Head $this.Tail) -ge 2) {
            $this.Tail.X = $this.Head.X
            $this.Tail.Y += 1
          }
        }
        ([Direction]::Left) {
          $this.Head.X -= 1
          if ((CalculateDistance $this.Head $this.Tail) -ge 2) {
            $this.Tail.Y = $this.Head.Y
            $this.Tail.X -= 1
          }
        }
        ([Direction]::Down) {
          $this.Head.Y -= 1
          if ((CalculateDistance $this.Head $this.Tail) -ge 2) {
            $this.Tail.X = $this.Head.X
            $this.Tail.Y -= 1
          }
        }

        Default {}
      }
      
      if ($null -eq $this.Visited[$this.Tail.X]) {
        $this.Visited[$this.Tail.X] = @{}
      }

      $this.Visited[$this.Tail.X][$this.Tail.Y] += 1
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

class Planks {
  $VisitedPositions = @{}
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

function GetStart {
  $rope = [Rope]::new()
  $rope.Head = [Knot]::new(0, 0)
  $rope.Tail = [Knot]::new(0 ,0)
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
