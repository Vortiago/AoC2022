. $PSScriptRoot/../common.ps1

function CheckIfFourCharactersAreUnique($text) {
  return ($text.ToCharArray() | Select-Object -Unique).Count -eq 4
}

function FindPositionAfterMarker($dataTransfer) {
  for ($position = 0; $position -lt ($dataTransfer.Length - 4); $position++) {
    if (CheckIfFourCharactersAreUnique ($dataTransfer.Substring($position, 4))) {
      return $position + 4
    }
  }
}

