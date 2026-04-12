# The program requires a string (commit message) argument or will fail to run
param(
	[Parameter(Mandatory=$true)]
	[string]$message
)

# Pulls any changes to the GitHub repo that have been made externally so the local repo is synced before push
Write-Host "Syncing with GitHub repo..."
git pull

# Lists all changes that will be committed if proceeding
Write-Host "Proposed commit:"
git status

# Checks if the user wants to proceed or exit given status
$confirm = Read-Host "Commit and push? (Y/n)" 
if ($confirm -ne "Y") {
	Write-Host "Commit cancelled"
	exit
}

# Commits and pushes all changes to the repo and then informs user of completion
git add .
git commit -m "$message"
git push

Write-Host "Complete"