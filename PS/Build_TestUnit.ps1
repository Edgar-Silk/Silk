# Script to build PDFium.DLL  -- Includes depot_tools
# Arguments
param (
    # Options: x86 | x64
    [string]$Arch ='x64',
    # Not use at the moment
    [string]$Wrapper_Branch  = ' '
)

# Globals
$BuildDir       = (Get-Location).path

# Configuration:
Write-Host "Architecture: " $Arch
Write-Host "Wrapper branch: " $Pdfium_Branch
Write-Host "Directory to Build: " $BuildDir

# Set environmental variables 
$env:Path = "$BuildDir/depot_tools;$env:Path"
$env:DEPOT_TOOLS_WIN_TOOLCHAIN = "0"
$env:DEPOT_TOOLS_UPDATE = "0"

# Set directory variable
$WrapperDir = $BuildDir

# Set build temporary path
if ([System.IO.Directory]::Exists($WrapperDir)) {
    Set-Location $WrapperDir
}
else {
    New-Item -Path $WrapperDir -ItemType Directory
    Set-Location $WrapperDir
}

# Visual Studio MSI-Builder - Find and set compiler
Write-Host "Locate VS 2017 MSBuilder.exe"
function buildVS {
    param (
        [parameter(Mandatory=$true)]
        [String] $path,
            
        [parameter(Mandatory=$false)]
        [bool] $clean = $true
    )
    process {
        $msBuildExe = Resolve-Path "${env:ProgramFiles(x86)}/Microsoft Visual Studio/2017/*/MSBuild/*/bin/msbuild.exe" -ErrorAction SilentlyContinue
      
        if ($clean) {
            Write-Host "Cleaning $($path)" -foregroundcolor green
            & "$($msBuildExe)" "$($path)" /t:Clean /m 
        }

        Write-Host "Building $($path)" -foregroundcolor green
        & "$($msBuildExe)" "$($path)" /t:Build /m /p:Configuration=Release,Platform=$Arch /v:n
    }
}

# Get Git hub project
$Solution_Name = 'Silk'
$Project_Name = 'TestUnit'

Set-Location $WrapperDir'/'$Solution_Name

dotnet restore

buildVS -path ./TestUnit/TestUnit.csproj 
#buildVS -path ./Silk.sln 

Set-Location $WrapperDir'/'$Solution_Name'/'$Project_Name'/bin/'$Arch'/Release'

./"$Project_Name.exe"


Set-Location $BuildDir 