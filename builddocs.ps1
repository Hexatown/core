$htmlPath = Join-Path $PSScriptRoot "html"
if (!(Test-Path ($htmlPath)) ){
    New-Item -ItemType Directory -Force -Path $htmlPath
}

$docsPath = Join-Path $PSScriptRoot "src/jobs/files"

Convert-MarkdownToHTML -Path $docsPath -SiteDirectory $htmlPath #-IncludeExtension 