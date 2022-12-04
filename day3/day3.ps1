function GetItemPrioritisationValue($itemType) {
  $charValue = [byte][char]$itemType % 32
  if ($itemType -cmatch "[A-Z]") {
    $charValue += 26
  }

  return $charValue
}

function SplitIntoCompartments($rucksack) {
  $midPoint = $rucksack.Length / 2
  return @(
    $rucksack.Substring(0, $midPoint);
    $rucksack.Substring($midPoint)
  )
}

function Parse($textInput) {
  $stringSplitOptions = [System.StringSplitOptions]::RemoveEmptyEntries
  return $textInput.Split([System.Environment]::NewLine, $stringSplitOptions)
}

function FindTheError($rucksackCompartments) {
  $itemsToLookFor = $rucksackCompartments[0].ToCharArray() | Select-Object -Unique
  foreach ($item in $itemsToLookFor) {
    if ($rucksackCompartments[1].Contains($item)) {
      return $item
    }
  }
}

function SumAllErrors($rucksacks) {
  $sum = 0
  foreach ($rucksack in $rucksacks) {
    $sum += GetItemPrioritisationValue (FindTheError (SplitIntoCompartments ($rucksack)))
  }

  return $sum
}

function FindBadge($rucksackOne, $ruckSackTwo, $ruckSackThree) {
  $itemsToLookFor = $rucksackOne.ToCharArray() | Select-Object -Unique
  foreach ($item in $itemsToLookFor) {
    if ($ruckSackTwo.Contains($item) -and $ruckSackThree.Contains($item)) {
      return $item
    }
  }
}

function SumAllBadges($rucksacks) {
  $sum = 0
  for ($i = 0; $i -lt $rucksacks.Count; $i += 3) {
    $sum += GetItemPrioritisationValue (FindBadge $rucksacks[$i] $rucksacks[$i+1] $rucksacks[$i+2])
  }

  return $sum
}
