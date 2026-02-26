# Get current directory (parent repo root)
$rootPath = Get-Location

Write-Host "Root directory:" $rootPath
Write-Host "Cleaning nested git repositories..."
Write-Host ""

# Remove nested .git folders (exclude root .git)
Get-ChildItem -Path $rootPath -Recurse -Directory -Force |
Where-Object {
    $_.Name -eq ".git" -and $_.FullName -ne (Join-Path $rootPath ".git")
} |
ForEach-Object {
    Write-Host "Removing folder:" $_.FullName
    Remove-Item $_.FullName -Recurse -Force
}

# Remove all .gitignore files
Get-ChildItem -Path $rootPath -Recurse -File -Force |
Where-Object { $_.Name -eq ".gitignore" } |
ForEach-Object {
    Write-Host "Removing file:" $_.FullName
    Remove-Item $_.FullName -Force
}

# Remove all .gitattributes files
Get-ChildItem -Path $rootPath -Recurse -File -Force |
Where-Object { $_.Name -eq ".gitattributes" } |
ForEach-Object {
    Write-Host "Removing file:" $_.FullName
    Remove-Item $_.FullName -Force
}

Write-Host ""
Write-Host "✅ Cleanup completed."
