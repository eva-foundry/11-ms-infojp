# Local-Pre-Validation.ps1
# Run this in PowerShell from: I:\EVA-JP-v1.2\docs\eva-foundation\projects\11-MS-InfoJP

$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "LOCAL PRE-VALIDATION FOR CODESPACE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Colors
function Write-Success { param($msg) Write-Host "[PASS] $msg" -ForegroundColor Green }
function Write-Fail { param($msg) Write-Host "[FAIL] $msg" -ForegroundColor Red }
function Write-Info { param($msg) Write-Host "[INFO] $msg" -ForegroundColor Yellow }

# Step 1: Check Azure CLI
Write-Host "STEP 1: Azure CLI Installation Check" -ForegroundColor Cyan
Write-Host "--------------------------------------"
try {
    $azVersion = az --version 2>&1 | Select-String "azure-cli" | Select-Object -First 1
    if ($azVersion) {
        Write-Success "Azure CLI installed: $azVersion"
    } else {
        Write-Fail "Azure CLI not found"
        Write-Info "Install with: winget install -e --id Microsoft.AzureCLI"
        exit 1
    }
} catch {
    Write-Fail "Azure CLI not found"
    Write-Info "Install with: winget install -e --id Microsoft.AzureCLI"
    exit 1
}
Write-Host ""

# Step 2: Check Azure Authentication
Write-Host "STEP 2: Azure Authentication Status" -ForegroundColor Cyan
Write-Host "--------------------------------------"
try {
    $account = az account show 2>&1 | ConvertFrom-Json
    if ($account.id -eq "c59ee575-eb2a-4b51-a865-4b618f9add0a") {
        Write-Success "Authenticated to MarcoSub"
        Write-Host "  Subscription: $($account.name)" -ForegroundColor Gray
        Write-Host "  Subscription ID: $($account.id)" -ForegroundColor Gray
        Write-Host "  Tenant: $($account.tenantId)" -ForegroundColor Gray
    } else {
        Write-Fail "Wrong subscription: $($account.id)"
        Write-Info "Run: az account set --subscription c59ee575-eb2a-4b51-a865-4b618f9add0a"
        exit 1
    }
} catch {
    Write-Fail "Not authenticated to Azure"
    Write-Info "Run: az login --use-device-code"
    Write-Info "Then: az account set --subscription c59ee575-eb2a-4b51-a865-4b618f9add0a"
    exit 1
}
Write-Host ""

# Step 3: Generate backend.env using Git Bash
Write-Host "STEP 3: Generate backend.env" -ForegroundColor Cyan
Write-Host "--------------------------------------"

# Check for Git Bash
$gitBash = "C:\Program Files\Git\bin\bash.exe"
if (-not (Test-Path $gitBash)) {
    Write-Fail "Git Bash not found at: $gitBash"
    Write-Info "Looking for alternative bash installations..."
    $gitBash = Get-Command bash -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source
    if (-not $gitBash) {
        Write-Fail "No bash found. Using PowerShell fallback..."
        
        # PowerShell fallback for generating backend.env
        $RG = "infojp-sandbox"
        $OPENAI_RG = "rg-sandbox"
        $BACKEND_ENV = "base-platform/app/backend/backend.env"
        
        Write-Info "Querying Azure resources..."
        $OPENAI_ENDPOINT = az cognitiveservices account show --name ao-sandbox --resource-group $OPENAI_RG --query "properties.endpoint" -o tsv 2>$null
        $SEARCH_ENDPOINT = az search service show --name infojp-srch --resource-group $RG --query "endpoint" -o tsv 2>$null
        if ([string]::IsNullOrEmpty($SEARCH_ENDPOINT)) { $SEARCH_ENDPOINT = "https://infojp-srch.search.windows.net/" }
        $COSMOS_ENDPOINT = az cosmosdb show --name infojp-cosmos --resource-group $RG --query "documentEndpoint" -o tsv 2>$null
        $AI_ENDPOINT = az cognitiveservices account show --name infojp-ai-svc --resource-group $RG --query "properties.endpoint" -o tsv 2>$null
        $DOCINT_ENDPOINT = az cognitiveservices account show --name infojp-doc-intel --resource-group $RG --query "properties.endpoint" -o tsv 2>$null
        $STORAGE_ENDPOINT = "https://infojpst01.blob.core.windows.net/"
        
        # Create backend.env
        $envContent = @"
# Azure Storage
AZURE_BLOB_STORAGE_ACCOUNT=infojpst01
AZURE_BLOB_STORAGE_ENDPOINT=$STORAGE_ENDPOINT
AZURE_QUEUE_STORAGE_ENDPOINT=https://infojpst01.queue.core.windows.net/

# Azure Search
AZURE_SEARCH_SERVICE=infojp-srch
AZURE_SEARCH_SERVICE_ENDPOINT=$SEARCH_ENDPOINT
AZURE_SEARCH_INDEX=index-jurisprudence
AZURE_SEARCH_AUDIENCE=https://search.azure.com

# Azure OpenAI
AZURE_OPENAI_SERVICE=ao-sandbox
AZURE_OPENAI_ENDPOINT=$OPENAI_ENDPOINT
AZURE_OPENAI_RESOURCE_GROUP=$RG
AZURE_OPENAI_CHATGPT_DEPLOYMENT=gpt-4o
AZURE_OPENAI_CHATGPT_MODEL_NAME=gpt-4o
AZURE_OPENAI_EMBEDDINGS_DEPLOYMENT=text-embedding-3-small
AZURE_OPENAI_EMBEDDINGS_MODEL_NAME=text-embedding-3-small
USE_AZURE_OPENAI_EMBEDDINGS=true
AZURE_OPENAI_AUTHORITY_HOST=AzureCloud

# Cosmos DB
COSMOSDB_URL=$COSMOS_ENDPOINT
COSMOSDB_LOG_DATABASE_NAME=statusdb
COSMOSDB_LOG_CONTAINER_NAME=statuscontainer

# Azure AI Services
AZURE_AI_ENDPOINT=$AI_ENDPOINT
AZURE_AI_CREDENTIAL_DOMAIN=cognitiveservices.azure.com

# Document Intelligence
AZURE_FORM_RECOGNIZER_ENDPOINT=$DOCINT_ENDPOINT

# General
AZURE_SUBSCRIPTION_ID=c59ee575-eb2a-4b51-a865-4b618f9add0a
RESOURCE_GROUP_NAME=$RG
AZURE_ARM_MANAGEMENT_API=https://management.azure.com

# App Settings
MODEL_NAME=gpt-4o
EMBEDDING_DEPLOYMENT_NAME=text-embedding-3-small
OPENAI_DEPLOYMENT_NAME=gpt-4o
APP_LOGGER_NAME=DA_APP
"@
        
        # Ensure directory exists
        $envDir = Split-Path $BACKEND_ENV -Parent
        if (-not (Test-Path $envDir)) {
            New-Item -ItemType Directory -Path $envDir -Force | Out-Null
        }
        
        Set-Content -Path $BACKEND_ENV -Value $envContent
        Write-Success "Generated $BACKEND_ENV (PowerShell)"
    } else {
        Write-Info "Using bash at: $gitBash"
        & $gitBash -c "./generate-backend-env.sh"
    }
} else {
    Write-Info "Using Git Bash: $gitBash"
    & $gitBash -c "./generate-backend-env.sh"
}

# Check if file was created
if (Test-Path "base-platform/app/backend/backend.env") {
    Write-Success "backend.env file created"
} else {
    Write-Fail "backend.env file not created"
    exit 1
}
Write-Host ""

# Step 4: Validate backend.env
Write-Host "STEP 4: Validate backend.env" -ForegroundColor Cyan
Write-Host "--------------------------------------"

$BACKEND_ENV = "base-platform/app/backend/backend.env"
$envContent = Get-Content $BACKEND_ENV -Raw

# Critical variables to check
$criticalVars = @(
    "AZURE_SEARCH_SERVICE_ENDPOINT",
    "AZURE_OPENAI_ENDPOINT",
    "COSMOSDB_URL",
    "AZURE_AI_ENDPOINT",
    "AZURE_FORM_RECOGNIZER_ENDPOINT"
)

$allValid = $true
foreach ($var in $criticalVars) {
    $pattern = "^${var}=(.+)$"
    $match = [regex]::Match($envContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    
    if ($match.Success -and -not [string]::IsNullOrWhiteSpace($match.Groups[1].Value)) {
        $value = $match.Groups[1].Value.Trim()
        $shortValue = if ($value.Length -gt 50) { $value.Substring(0, 50) + "..." } else { $value }
        Write-Success "$var = $shortValue"
    } else {
        Write-Fail "$var is empty or missing"
        $allValid = $false
    }
}
Write-Host ""

# Step 5: Show Results
Write-Host "STEP 5: Generated backend.env Content (First 30 Lines)" -ForegroundColor Cyan
Write-Host "--------------------------------------"
Get-Content $BACKEND_ENV -First 30 | ForEach-Object {
    Write-Host $_ -ForegroundColor Gray
}
Write-Host ""

# Step 6: Validation Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VALIDATION SUMMARY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "Critical Endpoints Status:" -ForegroundColor Yellow
$criticalVars | ForEach-Object {
    $var = $_
    $pattern = "^${var}=(.+)$"
    $match = [regex]::Match($envContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    
    if ($match.Success -and -not [string]::IsNullOrWhiteSpace($match.Groups[1].Value)) {
        Write-Host "  [PASS] $var" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] $var" -ForegroundColor Red
    }
}

Write-Host ""
if ($allValid) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "READY FOR CODESPACE DEPLOYMENT" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "  1. Push backend.env to GitHub" -ForegroundColor Gray
    Write-Host "  2. Open GitHub Codespace" -ForegroundColor Gray
    Write-Host "  3. Run: bash DEPLOY.sh" -ForegroundColor Gray
    exit 0
} else {
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "NOT READY - FIX ERRORS ABOVE" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    exit 1
}
