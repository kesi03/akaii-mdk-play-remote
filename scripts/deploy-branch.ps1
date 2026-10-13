#Requires -Version 5.1
<#
.SYNOPSIS
    Deploys the current working tree as a branch-named, side-by-side variant of
    the "MPK Mini Play" Remote surface, WITHOUT touching the canonical files.

.DESCRIPTION
    Reason identifies a control surface by the manufacturer/model declared in
    its .luacodec (the `source` field may name any .lua file, so several
    surfaces can share one codec folder). This script derives a variant from
    the working tree on the current git branch:

        MPKMiniPlay_<branch>.luacodec   model  = "MPK Mini Play (<branch>)"
        MPKMiniPlay_<branch>.lua        source = MPKMiniPlay_<branch>.lua
        MPKMiniPlay_<branch>.remotemap  Control Surface Model = same variant

    and copies them next to the canonical MPKMiniPlay.* files. In Reason use
    Preferences > Control Surfaces > Add > Akai > "MPK Mini Play (<branch>)"
    to add the variant, then switch between it and the original.

    Only MPKMiniPlay_* files are written by this script; the canonical
    MPKMiniPlay.lua / .luacodec / .png / .remotemap are never modified.
    The shared picture MPKMiniPlay.png is reused (copied only if missing).

    Reason must be closed before running.

.PARAMETER Branch
    Label to build the variant from. Defaults to the current git branch.

.PARAMETER Clean
    Remove every previously generated MPKMiniPlay_* variant and exit.

.PARAMETER Force
    Run even if Reason appears to be running (not recommended).

.PARAMETER Backup
    Back up the current variant files (if any) before overwriting them. The
    copy is written to <repo>\backups\<timestamp>\ (git-ignored).
#>
[CmdletBinding()]
param(
    [string]$Branch,
    [switch]$Clean,
    [switch]$Force,
    [switch]$Backup
)

$ErrorActionPreference = 'Stop'

$RepoRoot   = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$RemoteRoot = Join-Path $env:ProgramData 'Propellerhead Software\Remote'
$CodecSrc   = Join-Path $RepoRoot 'Codecs\Lua Codecs\Akai'
$CodecDest  = Join-Path $RemoteRoot 'Codecs\Lua Codecs\Akai'
$MapsSrc    = Join-Path $RepoRoot 'Maps\Akai'
$MapsDest   = Join-Path $RemoteRoot 'Maps\Akai'
$BackupRoot = Join-Path $RepoRoot 'backups'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-Utf8NoBom([string]$Path, [string]$Text) {
    [System.IO.File]::WriteAllText($Path, $Text, $utf8NoBom)
}

# --- optional backup of the files that will be overwritten ----------------
$backupRunDir = Join-Path $BackupRoot (Get-Date -Format 'yyyyMMdd-HHmmss')
$backedUp = @()

function Backup-One([string]$Path) {
    if (-not $Backup) { return }
    if (-not (Test-Path -LiteralPath $Path)) { return }
    $rel = $Path.Substring($RemoteRoot.Length).TrimStart('\', '/')
    $target = Join-Path $backupRunDir $rel
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $target) | Out-Null
    Copy-Item -LiteralPath $Path -Destination $target -Force
    $script:backedUp += $rel
}

# --- Reason-running guard -------------------------------------------------
if (-not $Force) {
    $reason = Get-Process -Name Reason, reason -ErrorAction SilentlyContinue
    if ($reason) {
        throw "Reason is running (PID $($reason.Id -join ', ')). Close it before deploying, or pass -Force."
    }
}

if (-not (Test-Path -LiteralPath $RemoteRoot)) {
    throw "Reason Remote folder not found: $RemoteRoot. Is Reason installed?"
}

# --- Clean mode -----------------------------------------------------------
if ($Clean) {
    $removed = 0
    if (Test-Path -LiteralPath $CodecDest) {
        Get-ChildItem -LiteralPath $CodecDest -Filter 'MPKMiniPlay_*' -File -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force; $removed++; Write-Host "  removed $($_.Name)" }
    }
    if (Test-Path -LiteralPath $MapsDest) {
        Get-ChildItem -LiteralPath $MapsDest -Filter 'MPKMiniPlay_*' -File -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item -LiteralPath $_.FullName -Force; $removed++; Write-Host "  removed $($_.Name)" }
    }
    Write-Host "Removed $removed branch variant file(s)." -ForegroundColor Yellow
    return
}

# --- Resolve branch + names ----------------------------------------------
if (-not $Branch) {
    $Branch = (& git -C $RepoRoot rev-parse --abbrev-ref HEAD 2>$null)
    if (-not $Branch -or $Branch -eq 'HEAD') { throw "Could not determine the current git branch; pass -Branch." }
}

$suffix      = ($Branch -replace '[^0-9A-Za-z_.-]', '_')
$variantBase = "MPKMiniPlay_$suffix"
$display     = "MPK Mini Play ($Branch)"

$canonLua    = Join-Path $CodecSrc 'MPKMiniPlay.lua'
$canonCodec  = Join-Path $CodecSrc 'MPKMiniPlay.luacodec'
$canonPng    = Join-Path $CodecSrc 'MPKMiniPlay.png'
$canonMap    = Join-Path $MapsSrc  'MPKMiniPlay.remotemap'

foreach ($f in $canonLua, $canonCodec, $canonMap) {
    if (-not (Test-Path -LiteralPath $f)) { throw "Missing source file: $f" }
}

New-Item -ItemType Directory -Force -Path $CodecDest, $MapsDest | Out-Null

# --- Build variant .luacodec ---------------------------------------------
$codecText = [System.IO.File]::ReadAllText($canonCodec)
$codecText = $codecText.Replace('model="MPK Mini Play"', "model=`"$display`"")
$codecText = $codecText.Replace('source="MPKMiniPlay.lua"', "source=`"$variantBase.lua`"")
if ($codecText -notmatch [regex]::Escape($display)) {
    throw "Could not find model=`"MPK Mini Play`" in $canonCodec; adjust the replacement."
}

# --- Build variant .remotemap --------------------------------------------
$mapText = [System.IO.File]::ReadAllText($canonMap)
$mapText = [regex]::Replace($mapText, '(?m)^Control Surface Model\t.*$', "Control Surface Model`t$display")
if ($mapText -notmatch [regex]::Escape("Control Surface Model`t$display")) {
    throw "Could not rewrite the Control Surface Model line in $canonMap."
}

# --- Deploy ---------------------------------------------------------------
Write-Host "Branch      : $Branch" -ForegroundColor Cyan
Write-Host "Variant name: $display" -ForegroundColor Cyan
Write-Host ""

$variantLua   = Join-Path $CodecDest "$variantBase.lua"
$variantCodec = Join-Path $CodecDest "$variantBase.luacodec"
$variantMap   = Join-Path $MapsDest  "$variantBase.remotemap"

if (-not (Test-Path -LiteralPath (Join-Path $CodecDest 'MPKMiniPlay.png'))) {
    Copy-Item -LiteralPath $canonPng -Destination $CodecDest -Force
    Write-Host "  picture -> MPKMiniPlay.png (shared)" -ForegroundColor Green
}

Backup-One $variantLua
Backup-One $variantCodec
Backup-One $variantMap

Copy-Item -LiteralPath $canonLua -Destination $variantLua -Force
Write-Utf8NoBom $variantCodec $codecText
Write-Utf8NoBom $variantMap $mapText

Write-Host "  codec   -> $variantLua" -ForegroundColor Green
Write-Host "  codec   -> $variantCodec" -ForegroundColor Green
Write-Host "  map     -> $variantMap" -ForegroundColor Green
Write-Host ""
if ($Backup) {
    if ($backedUp.Count -gt 0) {
        Write-Host "Backed up $($backedUp.Count) file(s) to $backupRunDir" -ForegroundColor Yellow
    } else {
        Write-Host "Backup: no existing variant files to back up." -ForegroundColor Yellow
    }
}
Write-Host "Canonical MPKMiniPlay.* left untouched." -ForegroundColor Yellow
Write-Host "In Reason: Preferences > Control Surfaces > Add > Akai > `"$display`"." -ForegroundColor Yellow
Write-Host "Keep only ONE MPK Mini Play surface on the MIDI input at a time." -ForegroundColor Yellow
