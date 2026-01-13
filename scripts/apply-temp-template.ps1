param(
  [string]$Root = "",
  [switch]$WhatIf,
  [string]$TemplateCssHref = "res/pst-template.css"
)

$ErrorActionPreference = 'Stop'

function Ensure-HeadCssLink([string]$Html, [string]$Href) {
  if ([string]::IsNullOrWhiteSpace($Href)) { return $Html }

  # If the href already exists anywhere, skip.
  if ($Html -match [regex]::Escape($Href)) { return $Html }

  $linkTag = "<link rel=`"stylesheet`" href=`"$Href`">"

  # Insert before </head> if present.
  if ($Html -match '(?is)</head>') {
    return [regex]::Replace($Html, '(?is)</head>', "$linkTag`r`n</head>", 1)
  }

  return $Html
}

function Remove-DuplicateCanonicals([string]$Html) {
  $pattern = '(?is)<link\b[^>]*\brel\s*=\s*["\'']canonical["\''][^>]*>'
  $matches = [regex]::Matches($Html, $pattern)
  if ($matches.Count -le 1) { return $Html }

  # Remove from the end to preserve earlier indices.
  for ($i = $matches.Count - 1; $i -ge 1; $i--) {
    $m = $matches[$i]
    $Html = $Html.Remove($m.Index, $m.Length)
  }
  return $Html
}

if ([string]::IsNullOrWhiteSpace($Root)) {
  $Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
} else {
  $Root = (Resolve-Path $Root).Path
}

$tempPath = Join-Path $Root 'temp.html'
if (-not (Test-Path $tempPath)) {
  throw "temp.html not found at: $tempPath"
}

$temp = Get-Content -Path $tempPath -Raw -Encoding UTF8

$footerMatch = [regex]::Match($temp, '(?is)<footer\b[^>]*class="footer"[^>]*>.*?</footer>')
if (-not $footerMatch.Success) {
  throw 'Could not find <footer class="footer">...</footer> in temp.html'
}
$footerHtml = $footerMatch.Value

$whatsMatch = [regex]::Match($temp, '(?is)<a\b[^>]*href="https://wa\.me/8240002684"[^>]*class="whatsapp-float"[^>]*>.*?</a>')
if ($whatsMatch.Success) {
  $whatsHtml = $whatsMatch.Value
} else {
  $whatsHtml = '<a href="https://wa.me/8240002684" class="whatsapp-float" target="_blank" rel="noopener" aria-label="Chat on WhatsApp"><i class="fab fa-whatsapp"></i></a>'
}

$yearScript = @'
<script>
  (function () {
    var el = document.getElementById('currentYear');
    if (el) el.textContent = new Date().getFullYear();
  })();
</script>
'@

$htmlFiles = Get-ChildItem -Path $Root -Filter *.html -File -Recurse |
  Where-Object { $_.FullName -notlike "*\temp.html" }

$changed = 0
$scanned = 0

foreach ($file in $htmlFiles) {
  $scanned++
  $path = $file.FullName

  $raw = Get-Content -Path $path -Raw -Encoding UTF8
  $updated = $raw

  # Ensure shared template CSS is linked for consistent footer/WhatsApp styling
  $updated = Ensure-HeadCssLink -Html $updated -Href $TemplateCssHref

  # Enforce single canonical tag
  $updated = Remove-DuplicateCanonicals -Html $updated

  # Replace any existing footer with the template footer
  if ($updated -match '(?s)<footer\b[\s\S]*?</footer>') {
    $updated = [regex]::Replace($updated, '(?s)<footer\b[\s\S]*?</footer>', $footerHtml, 1)
  }

  # Ensure WhatsApp floating button exists (insert right after <body ...>)
  if ($updated -notmatch 'class="whatsapp-float"') {
    $updated = [regex]::Replace($updated, '(?i)(<body\b[^>]*>)', "`$1`r`n  $whatsHtml", 1)
  }

  # Ensure currentYear script exists if footer includes currentYear span
  if (($updated -match 'id="currentYear"') -and ($updated -notmatch "getElementById\('currentYear'\)")) {
    $updated = [regex]::Replace($updated, '(?i)</body>', "  $yearScript`r`n</body>", 1)
  }

  # Remove any accidental content appended after </html>
  $idx = $updated.IndexOf('</html>', [System.StringComparison]::OrdinalIgnoreCase)
  if ($idx -ge 0) {
    $end = $idx + 7
    if ($updated.Length -gt $end) {
      $tail = $updated.Substring($end).Trim()
      if ($tail.Length -gt 0) {
        $updated = $updated.Substring(0, $end) + "`r`n"
      }
    }
  }

  if ($updated -ne $raw) {
    $changed++
    if ($WhatIf) {
      Write-Host "[WhatIf] Would update: $path"
    } else {
      Set-Content -Path $path -Value $updated -Encoding UTF8
      Write-Host "Updated: $path"
    }
  }
}

Write-Host "Done. Scanned: $scanned, Changed: $changed"
