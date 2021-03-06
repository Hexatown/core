#
# Module manifest for module 'MarkDownToHTML'
#
# Generated by: WetHat
#
# Generated on: 11/7/2017 7:57:32 AM
#

@{
# Script module or binary module file associated with this manifest.
RootModule = 'MarkdownToHtml.psm1'

# Version number of this module.
ModuleVersion = '2.2.2'

# Supported PSEditions
CompatiblePSEditions = 'Desktop'

# ID used to uniquely identify this module
GUID = 'ac6c6204-4097-4693-ba7e-3e0167383c24'

# Author of this module
Author = 'WetHat'

# Company or vendor of this module
CompanyName = 'WetHat Lab'

# Copyright statement for this module
Copyright = '(c) 2018-2020 WetHat Lab. All rights reserved.'

# Description of the functionality provided by this module
Description = @'
Highly configurable markdown to HTML conversion using customizable templates.

### Features

* Open Source and fully _hackable_.
* Out-of-the box support for diagrams, math typesetting and code syntax
  highlighting.
* Based on [Markdig](https://github.com/lunet-io/markdig),
  a fast, powerful, [CommonMark](http://commonmark.org/) compliant Markdown
  processor for .NET with more than 20 configurable extensions.
* High quality Open Source web components:
  - **Code Highlighting**: [highlight.js](https://highlightjs.org/); supports
    189 languages and 91 styles.
  - **Math typesetting**: [KaTeX](https://katex.org/); The fastest math
    typesetting library for the web.
  - **Diagramming**: [Mermaid](http://mermaid-js.github.io/mermaid/); Generation
    of diagrams and flowcharts from text in a similar manner as Markdown.
* Highly configurable static website projects with configuration file and build
  script. See `New-StaticHTMLSiteProject`.
* Sites can be used offline (without connection to the internet). All site
  assets are local.

### Prerequisites

To successfully create web sites from Markdown you should know:
* Markdown: A good starting point would be
  [GitHub Flavored Markdown](https://github.github.com/gfm/)
* Some knowledge about HTML and CSS (Cascading Stylesheets).
* Some PowerShell knowledge

See `about_MarkdownToHTML` for more information about configuration
and operation of this module.

### Incompatibilities

This version is incompatible with existing conversion projects
which use the _mathematics_ extensions and were created with versions of this module
older than 2.0.0 (i.e. 1.* or 0.*).

**Make sure to read the release notes for 2.0.0 below for instructions on how to upgrade your
existing conversion projects.**
'@

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
RequiredAssemblies = @('Markdig.dll')

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = @(
	                   'Convert-MarkdownToHTML'
	                   'Convert-MarkdownToHTMLFragment'
                       'ConvertTo-PageHeadingNavigation'
                       'ConvertTo-NavigationItem'
	                   'Find-MarkdownFiles'
                       'New-StaticHTMLSiteProject'
	                   'New-HTMLTemplate'
	                   'Publish-StaticHtmlSite'
	                 )

# Cmdlets to export from this module
CmdletsToExport = '*'

# Variables to export from this module
VariablesToExport = '*'

# Aliases to export from this module
AliasesToExport = '*'

# List of all modules packaged with this module
ModuleList = @()

# List of all files packaged with this module
FileList = @(
	          'MarkdownToHtml.psm1'
	          'Markdig.dll'
              'System.Memory.dll'
              'System.Runtime.CompilerServices.Unsafe.dll'
              'System.Numerics.Vectors.dll'
            )

# Private data to pass to the module specified in RootModule/ModuleToProcess
PrivateData = @{
    PSData = @{
        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @(
                  'Markdown'
                  'HTML'
			      'Converter'
                )

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/WetHat/MarkdownToHtml/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/WetHat/MarkdownToHtml'

        # A URL to an icon representing this module.
        IconUri = 'https://upload.wikimedia.org/wikipedia/commons/2/2f/PowerShell_5.0_icon.png'

        # ReleaseNotes of this module
        ReleaseNotes = @'
## 2.2.2

*  added referenced .net assemblies which may not be guaranteed to be present

## 2.2.1

* Katex Updated to version 0.12.0
* Mermaid updated to version 8.8.2
* Markdig updated to version 0.22.0
* Code signed With long term self signed certificate

## 2.2.0

* Fixed issue with `ConvertTo-NavigationItem` not understanding hyperlinks
  with `#` fragments.
* Added `autoidentifiers` to the `Build.json` in the project template so that
  headings get `id` attributes.
* Added navigation items for headings on the current page to the navbar.

## 2.1.1

* Bugfix: Site assets not copied in build script

## 2.1.0

#### Enhancements

* `Publish-StaticHtmlSite` now accepts definition of custom placeholder
  mappins for expansion of `md-template.html`.
* Default template placeholder delimiters changed to `{{` and `}}`.
* Static HTML site projects added: See `New-StaticHTMLSiteProject`.
* Documentation made more `Get-Help` friendly.
* _Mermaid_ assets updated to version 8.5.0

#### Maintenance

* Minimum required Powershell version now 5.1 (Desktop)

## 2.0.0

The updated version of _Markdig_ incuded in this release introduces
an incompatiblity in the _mathematics_ extension which breaks _KaTeX_ math rendering.

See `about_MarkdownToHTML` for options to upgrade existing projects.
To address this incompaibility the KaTex configuration in **all** deployed html templates

#### New Features

* Highlighting languages _Perl_ and _YAML_ added

#### Maintenance

* Updated to _Markdig_ 0.18.0.
* KaTeX updated to version 0.11.1
* Code syntax highlighting updated to version 9.17.1

#### Bugfixes
* Rendering of math blocks now creates centered output with the correct (bigger) font.
* Changed the default html template (`md_template.html`) to address the incompatible
  change in the LaTeX math output of the _mathematics_ extension of _Markdig_.

## 1.3.0

* upgrade of markdig to version 0.17.2
* KaTex upgraded to 0.11.0
* Re-factored the Markdown converter pipeline and made it parts public
  to make it useful for a broader range of Markdown conversion scenarios.

## 1.2.8

* `Write-Host` replaced by the more benign `Write-Verbose`
* Minor code cleanup

## 1.2.7

* Empty lines allowed im 'md-template.html` to remove an ugly but harmless
  exception.
* Syntax highlighting updated to version 9.14.2
* Upgrade to markdig version 0.15.7
* Added Resources and configuration for the [mermaid](https://mermaidjs.github.io/) diagram and
  flowchart generator version 8.0.0 to the HTML template.
* Added Resources and configuration for the [KaTeX](https://katex.org/) LaTeX Math
  typesetting library version 0.10.0 to the HTML template.
* Documentation improved.

## 1.2.6

* Powershell Gallery metadata added.

## 1.2.4

* Replaced `[System.Web.HttpUtility]` by `[System.Net.WebUtility]` to fix issue
  when powershell is run with `-noprofile`

## 1.2.3

* Fixed regression introduced in 1.2.2
* Regression test setup

## 1.2.2

* Support for markdown files in a directory hierarchy fixed.
  (directory scanning fixed and relative path added to resource links)
## 1.2.1

Handle partially HTML encoded code blocks

## 1.2.0

* Replaced XML template processing with text based template processing,
  to relax constraints on the HTML fragment quality.
* HTML encode text in `<code>` blocks

## 1.1.0

* Setting of Markdown parser options implemented
* Wildcard support for pathes added

## 1.0.0

Initial Release
'@
    } # End of PSData hashtable
} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/WetHat/MarkdownToHtml/blob/master/Documentation/MarkdownToHTML.md'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''
}
