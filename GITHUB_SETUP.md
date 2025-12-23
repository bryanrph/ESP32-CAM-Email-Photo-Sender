# GitHub Setup Instructions

Your local Git repository has been initialized and files have been committed. Follow these steps to push to GitHub:

## Option 1: Using GitHub Website (Recommended)

### Step 1: Create a New Repository on GitHub

1. Go to [https://github.com/new](https://github.com/new)
2. **Repository name:** `ESP32-CAM-Email-Photo-Sender` (or any name you prefer)
3. **Description:** "Send photos from ESP32-CAM to email using SMTP"
4. **Visibility:** Choose Public or Private
5. **Important:** Do NOT check any of these boxes:
   - ❌ Add a README file (we already have one)
   - ❌ Add .gitignore (we already have one)
   - ❌ Choose a license (optional, but skip for now)
6. Click **"Create repository"**

### Step 2: Push Your Code

After creating the repository, GitHub will show you commands. Use these instead:

```powershell
cd "C:\Users\Black storm\ESP32-CAM-Email-Photo-Sender"
git remote add origin https://github.com/YOUR_USERNAME/ESP32-CAM-Email-Photo-Sender.git
git branch -M main
git push -u origin main
```

**Replace `YOUR_USERNAME` with your GitHub username!**

Or use the provided script:
```powershell
.\push_to_github.ps1
```

### Step 3: Authentication

When you push, you may be prompted for credentials:
- **Username:** Your GitHub username
- **Password:** Use a Personal Access Token (not your GitHub password)

#### Creating a Personal Access Token:

1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Name it: "ESP32-CAM Project"
4. Select scopes: Check `repo` (full control of private repositories)
5. Click "Generate token"
6. **Copy the token immediately** (you won't see it again)
7. Use this token as your password when pushing

## Option 2: Using GitHub Desktop (Alternative)

1. Download [GitHub Desktop](https://desktop.github.com/)
2. Sign in with your GitHub account
3. File → Add Local Repository
4. Browse to: `C:\Users\Black storm\ESP32-CAM-Email-Photo-Sender`
5. Click "Publish repository" and choose a name
6. Click "Publish Repository"

## Option 3: Using GitHub CLI (Advanced)

If you prefer command line:

```powershell
winget install --id GitHub.cli
gh auth login
gh repo create ESP32-CAM-Email-Photo-Sender --public --source=. --remote=origin --push
```

## Current Repository Status

✅ Git repository initialized  
✅ Files committed  
✅ Branch set to `main`  
⏳ Ready to push to GitHub

## Files Included

- `ESP32_CAM_Send_Photo_Email.ino` - Arduino code (with placeholder credentials)
- `README.md` - Complete documentation
- `.gitignore` - Git ignore rules

## Security Note

The code in this repository uses placeholder values for sensitive information:
- WiFi SSID: `YOUR_WIFI_SSID`
- WiFi Password: `YOUR_WIFI_PASSWORD`
- Email credentials: Placeholder values

**Make sure to update these values in your local copy before using!**

