# Stop Vibe Coding: Install Senior AI Engineering Rules in 10 Seconds
# Run in PowerShell: .\install.ps1  (or .\install.ps1 -Project)

param (
    [switch]$Project = $false
)

$ErrorActionPreference = "Stop"
$RepoUrl = "https://github.com/khallad2/ai-agent-engineering-skills.git"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "🚀 Installing AI Agent Engineering Skills Pack (by @Khallad-tech)..." -ForegroundColor Cyan

$TempDir = $null
if (-not (Test-Path (Join-Path $ScriptDir "skills"))) {
    $TempDir = Join-Path $env:TEMP ("ai-skills-" + [guid]::NewGuid().ToString())
    Write-Host "📥 Downloading latest skills & agents from GitHub..." -ForegroundColor Yellow
    git clone --depth 1 $RepoUrl $TempDir | Out-Null
    $SourceDir = $TempDir
} else {
    $SourceDir = $ScriptDir
}

try {
    # 1. Google Antigravity / Gemini CLI
    $GeminiSkills = Join-Path $HOME ".gemini\config\skills"
    $GeminiAgents = Join-Path $HOME ".gemini\config\agents"
    New-Item -ItemType Directory -Force -Path $GeminiSkills | Out-Null
    New-Item -ItemType Directory -Force -Path $GeminiAgents | Out-Null
    Copy-Item -Path (Join-Path $SourceDir "skills\*") -Destination $GeminiSkills -Recurse -Force
    Copy-Item -Path (Join-Path $SourceDir "agents\*") -Destination $GeminiAgents -Recurse -Force
    Write-Host "✅ Installed 9 Skills -> $GeminiSkills" -ForegroundColor Green
    Write-Host "✅ Installed 5 Agents -> $GeminiAgents" -ForegroundColor Green

    # 2. Claude Code
    $ClaudeSkills = Join-Path $HOME ".claude\skills"
    $ClaudeAgents = Join-Path $HOME ".claude\agents"
    New-Item -ItemType Directory -Force -Path $ClaudeSkills | Out-Null
    New-Item -ItemType Directory -Force -Path $ClaudeAgents | Out-Null
    Copy-Item -Path (Join-Path $SourceDir "skills\*") -Destination $ClaudeSkills -Recurse -Force
    Copy-Item -Path (Join-Path $SourceDir "agents\*") -Destination $ClaudeAgents -Recurse -Force
    Write-Host "✅ Installed Skills & Agents for Claude Code -> $HOME\.claude\" -ForegroundColor Green

    # 3. Project-level AGENTS.md if requested
    if ($Project) {
        $TemplatePath = Join-Path $SourceDir "AGENTS_TEMPLATE.md"
        Copy-Item -Path $TemplatePath -Destination ".\AGENTS.md" -Force
        Copy-Item -Path $TemplatePath -Destination ".\GEMINI.md" -Force
        Copy-Item -Path $TemplatePath -Destination ".\.cursorrules" -Force
        Write-Host "✅ Created AGENTS.md, GEMINI.md, and .cursorrules in current project!" -ForegroundColor Green
    }

    Write-Host "`n🎉 Installation Complete! Your AI Agent now builds production-ready software." -ForegroundColor Cyan
} finally {
    if ($TempDir -and (Test-Path $TempDir)) {
        Remove-Item -Recurse -Force $TempDir
    }
}
