$ErrorActionPreference = 'Stop'

$root = 'C:\xampp\htdocs\pstourism'
$files = Get-ChildItem -Path $root -Filter 'north-bengal*.html' -File
$changed = 0

foreach ($f in $files) {
  $p = $f.FullName
  $raw = Get-Content -LiteralPath $p -Raw
  $raw2 = $raw

  # Non-www PSTourism URLs only
  $raw2 = $raw2 -replace 'https?://www\.pstourism\.in', 'https://pstourism.in'

  # Required Services link slug
  $raw2 = $raw2 -replace 'href="other-travel-services"', 'href="other-tavel-servises"'

  # WhatsApp href normalization (no ?text=, no 918...)
  $raw2 = $raw2 -replace 'https?://wa\.me/8240002684\?text=[^"\s>]*', 'https://wa.me/8240002684'
  $raw2 = $raw2 -replace 'https?://wa\.me/918240002684(\?text=[^"\s>]*|)', 'https://wa.me/8240002684'

  # Ensure rel has both tokens when present
  $raw2 = $raw2 -replace 'rel="noopener"', 'rel="noopener noreferrer"'

  # Standardize OG/Twitter image to Logo.png
  $raw2 = [regex]::Replace(
    $raw2,
    '(<meta\s+(?:property|name)="og:image"[^>]*?content=")[^"]*(")',
    '${1}https://pstourism.in/res/Logo.png${2}',
    'IgnoreCase'
  )
  $raw2 = [regex]::Replace(
    $raw2,
    '(<meta\s+(?:property|name)="twitter:image"[^>]*?content=")[^"]*(")',
    '${1}https://pstourism.in/res/Logo.png${2}',
    'IgnoreCase'
  )

  # Normalize wrong GA IDs to the approved property
  $raw2 = $raw2 -replace 'G-V86D49N5ET', 'G-3L1HG1EYFZ'
  $raw2 = $raw2 -replace 'G-70V4YQPJ7D', 'G-3L1HG1EYFZ'

  # Inject shared WhatsApp hardener once (keeps HTML changes minimal)
  if ($raw2 -notmatch 'res/pst-wa\.js') {
    $raw2 = $raw2 -replace '(</body>)', "    <script src=`"res/pst-wa.js`" defer></script>`r`n$1"
  }

  if ($raw2 -ne $raw) {
    Set-Content -LiteralPath $p -Value $raw2 -Encoding UTF8
    $changed++
  }
}

Write-Output "Files: $($files.Count) | Changed: $changed"
