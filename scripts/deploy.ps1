#Requires -Version 5.1
<#
.SYNOPSIS
    Deploys the MPK Mini Play Remote codec and maps into Reason's Remote folder (Windows).

.DESCRIPTION
    Copies:
        Codecs/Lua Codecs/Akai/MPKMiniPlay.lua
        Codecs/Lua Codecs/Akai/MPKMiniPlay.luacodec
        Codecs/Lua Codecs/Akai/MPKMiniPlay.png
            -> <ProgramData>\Propellerhead Software\Remote\Codecs\Lua Codecs\Akai\
        Maps/Akai/*.remotemap
            -> <ProgramData>\Propellerhead Software\Remote\Maps\Akai\

    Reason must be closed before running. Restart Reason afterwards and add
    the surface manually: Preferences > Control Surfaces > Add > Akai > MPK Mini Play.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$RemoteRoot = Join-Path $env:ProgramData 'Propellerhead Software\Remote'

$CodecDest = Join-Path $RemoteRoot 'Codecs\Lua Codecs\Akai'
$MapsDest  = Join-Path $RemoteRoot 'Maps\Akai'

$codecSrcDir = Join-Path $RepoRoot 'Codecs\Lua Codecs\Akai'
$codecFiles  = @(Get-ChildItem -Path (Join-Path $codecSrcDir 'MPKMiniPlay.*') -ErrorAction SilentlyContinue)
$mapFiles    = Join-Path $RepoRoot 'Maps\Akai\*.remotemap'

if (-not (Test-Path -LiteralPath $RemoteRoot)) {
    throw "Reason Remote folder not found: $RemoteRoot. Is Reason installed?"
}
if ($codecFiles.Count -eq 0) {
    throw "Codec files not found in $codecSrcDir (expected MPKMiniPlay.lua/.luacodec/.png)"
}
$foundMaps = @(Get-ChildItem -Path $mapFiles -ErrorAction SilentlyContinue)
if ($foundMaps.Count -eq 0) {
    throw "No .remotemap files found in $RepoRoot\Maps\Akai\"
}

Write-Host "Deploying to: $RemoteRoot" -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $CodecDest, $MapsDest | Out-Null

foreach ($codec in $codecFiles) {
    Copy-Item -LiteralPath $codec.FullName -Destination $CodecDest -Force
    Write-Host "  Codec  -> $CodecDest\$($codec.Name)" -ForegroundColor Green
}

foreach ($map in $foundMaps) {
    Copy-Item -LiteralPath $map.FullName -Destination $MapsDest -Force
    Write-Host "  Map    -> $MapsDest\$($map.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "Done. Close and reopen Reason, then add 'MPK Mini Play' under" -ForegroundColor Yellow
Write-Host "Preferences > Control Surfaces (it is added manually, not auto-detected)." -ForegroundColor Yellow