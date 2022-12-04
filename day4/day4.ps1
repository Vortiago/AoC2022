function SectionInOtherSection($sectionA, $sectionB) {
  if ($sectionA[0] -le $sectionB[0] -and $sectionA[1] -ge $sectionB[1]){
    return 1
  } elseif ($sectionB[0] -le $sectionA[0] -and $sectionB[1] -ge $sectionA[1]){
    return 1
  }

  return 0
}

function ParseSection($sectionInText) {
  $tmp = $sectionInText.Split("-")
  return @([int]$tmp[0], [int]$tmp[1])
}

function FindAllSectionsForReconsideration($sectionAssigments) {
  $sum = 0
  foreach ($sectionAssigment in $sectionAssigments) {
    $sections = $sectionAssigment.Split(",")
    $sum += SectionInOtherSection (ParseSection $sections[0]) (ParseSection $sections[1])
  }

  return $sum
}

function Parse($textInput) {
  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  return $textInput.Split([System.Environment]::NewLine, $stringSplitOptions)
}

function IntersectingSectionAreas($sectionA, $sectionB) {
  $zoneA = $sectionA[0]..$sectionA[1]
  $zoneB = $sectionB[0]..$sectionB[1]

  if ($zoneA | Where-Object{$zoneB -contains $_ }) {
    return 1
  }

  return 0
}

function FindAllIntersectingSections($sectionAssigments) {
  $sum = 0
  foreach ($sectionAssigment in $sectionAssigments) {
    $sections = $sectionAssigment.Split(",")
    $sum += IntersectingSectionAreas (ParseSection $sections[0]) (ParseSection $sections[1])
  }

  return $sum
}
