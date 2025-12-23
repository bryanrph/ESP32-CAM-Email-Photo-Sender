# Script to push ESP32-CAM Email Photo Sender to GitHub
# Before running this script:
# 1. Go to https://github.com/new and create a new repository
# 2. Name it "ESP32-CAM-Email-Photo-Sender" (or any name you prefer)
# 3. Do NOT initialize with README, .gitignore, or license (we already have these)
# 4. Copy the repository URL (e.g., https://github.com/yourusername/ESP32-CAM-Email-Photo-Sender.git)

Write-Host "ESP32-CAM Email Photo Sender - GitHub Push Script" -ForegroundColor Cyan
Write-Host ""

$repoUrl = Read-Host "Enter your GitHub repository URL (e.g., https://github.com/yourusername/ESP32-CAM-Email-Photo-Sender.git)"

if ([string]::IsNullOrWhiteSpace($repoUrl)) {
    Write-Host "Error: Repository URL cannot be empty!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Adding remote origin..." -ForegroundColor Yellow
git remote add origin $repoUrl

if ($LASTEXITCODE -ne 0) {
    Write-Host "Remote might already exist. Trying to set URL..." -ForegroundColor Yellow
    git remote set-url origin $repoUrl
}

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Success! Your code has been pushed to GitHub!" -ForegroundColor Green
    Write-Host "Repository URL: $repoUrl" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "Push failed. Common issues:" -ForegroundColor Red
    Write-Host "1. Make sure you've created the repository on GitHub first" -ForegroundColor Yellow
    Write-Host "2. Check your authentication (you may need to use a personal access token)" -ForegroundColor Yellow
    Write-Host "3. Verify the repository URL is correct" -ForegroundColor Yellow
}

