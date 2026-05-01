try {
	# The program uses the commit message "updated notes [date]"
	$dateStamp = Get-Date -Format "dd-MM-yyyy"
	$message = "updated notes $dateStamp"

	# The ssh key is added to the ssh client session at the start of the script so the passphrase only needs to be entered once
	Write-Host "Loading SSH Key..." -ForegroundColor Cyan
	& "C:\Windows\System32\OpenSSH\ssh-add.exe" "C:\Users\Theo/.ssh/id_ed25519" # "$env:USERPROFILE/.ssh/id_ed25519"

	# Pulls any changes to the GitHub repo that have been made externally so the local repo is synced before push
	Write-Host "Syncing with GitHub repo..." -ForegroundColor Green
	git pull

	# Lists all changes that will be committed if proceeding
	Write-Host "Proposed commit:" -ForegroundColor Green
	git status

	# Checks if the user wants to proceed or exit given status
	Write-Host "Commit and push?" -ForegroundColor Yellow
	$confirm = Read-Host "(Y/n)"
	if ($confirm -ne "Y") {
		Write-Host "Commit cancelled" -ForegroundColor Red
		exit
	}

	# Commits and pushes all changes to the repo and then informs user of completion
	git add .
	git commit -m "$message"
	git push

	Write-Host "Complete" -ForegroundColor Green
}
finally {
	# The ssh key is removed from the session to maintain security, even in case of error
	& "C:\Windows\System32\OpenSSH\ssh-add.exe" -d "$env:USERPROFILE\.ssh\id_ed25519"
}