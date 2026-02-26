# Exit on error
$ErrorActionPreference = "Stop"

# Hardcoded branch name
$BranchName = "latest_branch"

# Function to get random commit message
function Get-RandomCommitMessage {
    try {
        $response = Invoke-RestMethod -Uri "https://api.github.com/zen" -Headers @{
            "User-Agent" = "PowerShell"
        }
        return $response
    }
    catch {
        Write-Host "Failed to fetch random message. Using fallback."
        return "Random reset commit $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    }
}

# Fetch random commit message
$CommitMessage = Get-RandomCommitMessage
Write-Host "Using commit message: $CommitMessage"

# Create an orphan branch
Write-Host "Creating orphan branch: $BranchName"
git checkout --orphan $BranchName

# Add and commit all files
Write-Host "Adding and committing files to $BranchName"
git add -A
git commit -m "$CommitMessage"

# Delete the current main branch if exists
if (git branch --list main) {
    Write-Host "Deleting main branch"
    git branch -D main
}

# Rename orphan branch to main
Write-Host "Renaming branch $BranchName to main"
git branch -m main

# Force push to remote
Write-Host "Force pushing changes to remote"
git push -f origin main

Write-Host "Git repository has been reset successfully!"
