. $PSScriptRoot/../common.ps1

function CheckIfFourCharactersAreUnique($text) {
  return ($text.ToCharArray() | Select-Object -Unique).Count -eq $text.Length
}

function FindPositionAfterMarker($dataTransfer, $length = 4) {
  for ($position = 0; $position -lt ($dataTransfer.Length - $length); $position++) {
    if (CheckIfFourCharactersAreUnique ($dataTransfer.Substring($position, $length))) {
      return $position + $length
    }
  }
}
