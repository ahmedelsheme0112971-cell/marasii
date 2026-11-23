$base = "https://script.google.com/macros/s/AKfycbz_gXvUwKQeqIAt32zhfKJ_x_myC3Tdig5dhCjC8VpKZwmQwQw2ctGPmjEpobkFSRKSxQ/exec"
$letters = [System.IO.File]::ReadAllLines("$PSScriptRoot\q.txt", [System.Text.Encoding]::UTF8) | Where-Object { $_.Trim() }
$all = @{}
foreach ($L in $letters) {
  $L = $L.Trim()
  if (-not $L) { continue }
  $enc = [uri]::EscapeDataString($L)
  $u = "$base" + "?action=search&section=flight&query=$enc&callback=cb"
  try {
    $r = Invoke-WebRequest -UseBasicParsing -Uri $u -TimeoutSec 60
    $c = $r.Content
    [regex]::Matches($c, '"rowNumber":(\d+)') | ForEach-Object {
      $rn = $_.Groups[1].Value
      if (-not $all.ContainsKey($rn)) { $all[$rn] = $true }
    }
    Write-Output ("L=" + $L + " totalUniqueSoFar=" + $all.Count)
  } catch {
    Write-Output ("L=" + $L + " ERR")
  }
}
Write-Output ("FINAL UNIQUE ROWS=" + $all.Count)
