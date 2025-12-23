# Script to push ESP32-CAM Email Photo Sender to GitHub
# Before running this script:
# 1. Go to https://github.com/new and create a new repository
# 2. Name it "ESP32-CAM-Email-Photo-Sender" (or any name you prefer)
# 3. Do NOT initialize with README, .gitignore, or license (we already have these)
# 4. Copy the repository URL (e.g., https://github.com/yourusername/ESP32-CAM-Email-Photo-Sender.git)

$gitPath = "C:\Program Files\Git\bin\git.exe"

Write-Host "ESP32-CAM Email Photo Sender - GitHub Push Script" -ForegroundColor Cyan
Write-Host ""

# Use the configured remote URL
$repoUrl = "https://github.com/bryanrph/ESP32-CAM-Email-Photo-Sender.git"

Write-Host "Repository URL: $repoUrl" -ForegroundColor Yellow
Write-Host ""

# Verify remote is set correctly
Write-Host "Setting remote origin..." -ForegroundColor Yellow
& $gitPath remote set-url origin $repoUrl

if ($LASTEXITCODE -ne 0) {
    Write-Host "Adding remote origin..." -ForegroundColor Yellow
    & $gitPath remote add origin $repoUrl
}

Write-Host "Checking repository status..." -ForegroundColor Yellow
& $gitPath status

Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
& $gitPath push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Success! Your code has been pushed to GitHub!" -ForegroundColor Green
    Write-Host "Repository URL: $repoUrl" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "Push failed. Common issues:" -ForegroundColor Red
    Write-Host "1. Make sure you've created the repository on GitHub first at:" -ForegroundColor Yellow
    Write-Host "   https://github.com/new" -ForegroundColor Cyan
    Write-Host "   Name it: ESP32-CAM-Email-Photo-Sender" -ForegroundColor Yellow
    Write-Host "   Do NOT initialize with README, .gitignore, or license" -ForegroundColor Yellow
    Write-Host "2. Check your authentication (you may need to use a personal access token)" -ForegroundColor Yellow
    Write-Host "3. Verify the repository URL is correct" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "After creating the repository, run this script again." -ForegroundColor Cyan
}

