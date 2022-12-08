using namespace System.Collections.Generic
 . $PSScriptRoot/../common.ps1

 class Tree {
  $Height
  $Visible
  $Row
  $Column
 }

class Forest {
  $Rows
}

function BuildForest($textRepresentationForest) {
  $forest = [Forest]::new()
  $trees = [List[Tree]]::new()
  $forest.Rows = @{}
  $rows = DefaultParser $textRepresentationForest
  for ($row = 0; $row -lt $rows.Count; $row++) {
    $columns = $rows[$row]
    $forest.Rows[$row] = @{}
    for ($column = 0; $column -lt $columns.Length; $column++) {
      $tree = [Tree]::new()
      $tree.Height = [int]::Parse($rows[$row][$column])
      $tree.Row = $row
      $tree.Column = $column
      $forest.Rows[$row][$column] = $tree
      $trees.Add($tree)
    }
  }

  return @($forest, $trees)
}

function CheckTree($tree, $maxHeightSoFar) {
  if ($tree.Height -gt $maxHeightSoFar) {
    $tree.Visible = $true
  } elseif ($null -eq $tree.Visible) {
    $tree.Visible = $false
  }

  if ($tree.Height -gt $maxHeightSoFar) {
    $maxHeightSoFar = $tree.Height
  }

  return @($tree, $maxHeightSoFar)
}

function CheckVisibility($forest) {
  #Left side
  for ($row = 0; $row -lt $forest.Rows.Count; $row++) {
    $maxHeightSoFar = -1
    for ($column = 0; $column -lt $forest.Rows[0].Count; $column++) {
      $result = CheckTree $forest.Rows[$row][$column] $maxHeightSoFar
      $maxHeightSoFar = $result[1]
    }
  }

  #Right side
  for ($row = 0; $row -lt $forest.Rows.Count; $row++) {
    $maxHeightSoFar = -1
    for ($column = $forest.Rows[0].Count-1; $column -ge 0 ; $column--) {
      $result = CheckTree $forest.Rows[$row][$column] $maxHeightSoFar
      $maxHeightSoFar = $result[1]
    }
  }

  #Top side
  for ($column = 0; $column -lt $forest.Rows[0].Count; $column++) {
    $maxHeightSoFar = -1
    for ($row = 0; $row -lt $forest.Rows.Count; $row++) {
      $result = CheckTree $forest.Rows[$row][$column] $maxHeightSoFar
      $maxHeightSoFar = $result[1]
    }
  }

  #Bottom side
  for ($column = 0; $column -lt $forest.Rows[0].Count ; $column++) {
    $maxHeightSoFar = -1
    for ($row = $forest.Rows.Count-1; $row -ge 0 ; $row--) {
      $result = CheckTree $forest.Rows[$row][$column] $maxHeightSoFar
      $maxHeightSoFar = $result[1]
    }
  }
}

function SumAllVisibleTrees($inputText) {
  $forest = BuildForest $inputText
  CheckVisibility $forest[0]
  $count = ($forest[1].Where({$_.Visible -eq $true}) | Measure-Object).Count
  return $count
}

function FindHighestScenicValue($inputText) {
  $forest = BuildForest $inputText
  CheckVisibility $forest[0]
  $highestScenicScore = 0
  foreach($tree in ($forest[1].Where({$_.Visible -eq $true}))) {
    $score = FindScenicValueOfTree $forest[0] $tree
    if ($score -gt $highestScenicScore) {
      $highestScenicScore = $score
    }
  }

  return $highestScenicScore
}

function FindScenicValueOfTree($forest, $tree) {
  $treesLeft = 0
  for($column = $tree.Column - 1; $column -ge 0; $column--) {
    $treesLeft += 1
    if ($forest.Rows[$tree.Row][$column].Height -ge $tree.Height) {
      break;
    }
  }

  $treesRight = 0
  for($column = $tree.Column + 1; $column -lt $forest.Rows[0].Count; $column++) {
    $treesRight += 1
    if ($forest.Rows[$tree.Row][$column].Height -ge $tree.Height) {
      break;
    }
  }

  $treesUp = 0
  for ($row = $tree.Row - 1; $row -ge 0; $row--) {
    $treesUp += 1
    if ($forest.Rows[$row][$tree.Column].Height -ge $tree.Height) {
      break;
    }
  }

  $treesDown = 0
  for ($row = $tree.Row + 1; $row -lt $forest.Rows.Count; $row++) {
    $treesDown += 1
    if ($forest.Rows[$row][$tree.Column].Height -ge $tree.Height) {
      break;
    }
  }

  return ($treesLeft * $treesRight * $treesUp * $treesDown)
}
