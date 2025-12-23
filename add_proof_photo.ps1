# Script to add proof photo to GitHub
# Make sure you've saved the photo from your email to the proof folder first

$gitPath = "C:\Program Files\Git\bin\git.exe"
$proofFolder = Join-Path $PSScriptRoot "proof"
$projectRoot = $PSScriptRoot

Write-Host "ESP32-CAM Proof Photo Upload Script" -ForegroundColor Cyan
Write-Host ""

# Check for image files in proof folder
$imageFiles = Get-ChildItem -Path $proofFolder -File -Include *.jpg,*.jpeg,*.png,*.gif,*.bmp -ErrorAction SilentlyContinue

if ($imageFiles.Count -eq 0) {
    Write-Host "No image files found in the proof folder!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please save the photo from your Gmail to:" -ForegroundColor Yellow
    Write-Host "  $proofFolder" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Steps:" -ForegroundColor Yellow
    Write-Host "1. Open the email in Gmail" -ForegroundColor White
    Write-Host "2. Click on the photo attachment" -ForegroundColor White
    Write-Host "3. Right-click the image and select 'Save image as...'" -ForegroundColor White
    Write-Host "4. Save it to the proof folder above" -ForegroundColor White
    Write-Host "5. Run this script again" -ForegroundColor White
    exit 1
}

Write-Host "Found image file(s):" -ForegroundColor Green
foreach ($file in $imageFiles) {
    Write-Host "  - $($file.Name) ($([math]::Round($file.Length/1KB, 2)) KB)" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Adding files to Git..." -ForegroundColor Yellow
Set-Location $projectRoot

& $gitPath add proof/

Write-Host "Committing changes..." -ForegroundColor Yellow
& $gitPath commit -m "Add proof photo demonstrating successful ESP32-CAM email functionality"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    & $gitPath push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Success! Proof photo has been uploaded to GitHub!" -ForegroundColor Green
        Write-Host "Repository: https://github.com/bryanrph/ESP32-CAM-Email-Photo-Sender" -ForegroundColor Cyan
    } else {
        Write-Host ""
        Write-Host "Failed to push to GitHub. Check your authentication." -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "Failed to commit. Files may already be committed." -ForegroundColor Yellow
    Write-Host "Trying to push anyway..." -ForegroundColor Yellow
    & $gitPath push origin main
}

