<#
.SYNOPSIS
    Example script demonstrating the ScribbleStack "download" pattern.

.DESCRIPTION
    This sample script lists all files in a given folder along with their
    size, sorted largest first. Replace this with your real script logic —
    this file only exists to demonstrate how downloadable scripts are
    structured and linked from a ScribbleStack post.

.PARAMETER Path
    The folder to scan. Defaults to the current directory.

.EXAMPLE
    .\list-files-by-size.ps1 -Path "C:\Projects"
#>

param(
    [string]$Path = "."
)

Get-ChildItem -Path $Path -File -Recurse |
    Sort-Object Length -Descending |
    Select-Object FullName, @{Name = "SizeKB"; Expression = { [math]::Round($_.Length / 1KB, 1) } }
