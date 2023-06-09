using namespace System.Management.Automation
using namespace System.Management.Automation.Language
# Import-Module posh-git
# Import-Module oh-my-posh
Invoke-Expression (&starship init powershell)

Clear-Host

# Set-PoshPrompt -Theme star
Set-Alias -Name np -Value "c:\Program Files\notepad++\notepad++.exe"
Set-Alias -Name grep -Value Select-String
Set-Alias -Name touch -Value New-Item
Set-Alias -Name tree -Value rstree
Set-Alias -Name nv -Value nvim

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})


$proxy = # add proxy here
[System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy($proxy)
[System.Net.Http.HttpClient]::DefaultProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

$PSStyle.FileInfo.Directory = ""

########## Aliases ##########
function Get-WezLua {
    [cmdletbinding()]
    [Alias('wez')]
    Param(
    )
	start-process -FilePath "C:\Program Files\Notepad++\notepad++.exe" -ArgumentList "C:\Users\a124129\.config\wezterm\wezterm.lua"
}
Set-Alias -Name do -Value docker


function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

Register-ArgumentCompleter -Native -CommandName 'btm' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'btm'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-')) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'btm' {
            [CompletionResult]::new('-C', 'C', [CompletionResultType]::ParameterName, 'Sets the location of the config file.')
            [CompletionResult]::new('--config', 'config', [CompletionResultType]::ParameterName, 'Sets the location of the config file.')
            [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'Use a color scheme, use --help for supported values.')
            [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'Default time value for graphs in ms.')
            [CompletionResult]::new('--default_time_value', 'default_time_value', [CompletionResultType]::ParameterName, 'Default time value for graphs in ms.')
            [CompletionResult]::new('--default_widget_count', 'default_widget_count', [CompletionResultType]::ParameterName, 'Sets the n''th selected widget type as the default.')
            [CompletionResult]::new('--default_widget_type', 'default_widget_type', [CompletionResultType]::ParameterName, 'Sets the default widget type, use --help for more info.')
            [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Sets a refresh rate in ms.')
            [CompletionResult]::new('--rate', 'rate', [CompletionResultType]::ParameterName, 'Sets a refresh rate in ms.')
            [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'The amount in ms changed upon zooming.')
            [CompletionResult]::new('--time_delta', 'time_delta', [CompletionResultType]::ParameterName, 'The amount in ms changed upon zooming.')
            [CompletionResult]::new('-k', 'k', [CompletionResultType]::ParameterName, 'Sets the temperature type to Kelvin.')
            [CompletionResult]::new('--kelvin', 'kelvin', [CompletionResultType]::ParameterName, 'Sets the temperature type to Kelvin.')
            [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Sets the temperature type to Fahrenheit.')
            [CompletionResult]::new('--fahrenheit', 'fahrenheit', [CompletionResultType]::ParameterName, 'Sets the temperature type to Fahrenheit.')
            [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Sets the temperature type to Celsius.')
            [CompletionResult]::new('--celsius', 'celsius', [CompletionResultType]::ParameterName, 'Sets the temperature type to Celsius.')
            [CompletionResult]::new('--autohide_time', 'autohide_time', [CompletionResultType]::ParameterName, 'Temporarily shows the time scale in graphs.')
            [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Hides graphs and uses a more basic look.')
            [CompletionResult]::new('--basic', 'basic', [CompletionResultType]::ParameterName, 'Hides graphs and uses a more basic look.')
            [CompletionResult]::new('-S', 'S', [CompletionResultType]::ParameterName, 'Enables case sensitivity by default.')
            [CompletionResult]::new('--case_sensitive', 'case_sensitive', [CompletionResultType]::ParameterName, 'Enables case sensitivity by default.')
            [CompletionResult]::new('--process_command', 'process_command', [CompletionResultType]::ParameterName, 'Show processes as their commands by default.')
            [CompletionResult]::new('--mem_as_value', 'mem_as_value', [CompletionResultType]::ParameterName, 'Defaults to showing process memory usage by value.')
            [CompletionResult]::new('--disable_click', 'disable_click', [CompletionResultType]::ParameterName, 'Disables mouse clicks.')
            [CompletionResult]::new('-m', 'm', [CompletionResultType]::ParameterName, 'Uses a dot marker for graphs.')
            [CompletionResult]::new('--dot_marker', 'dot_marker', [CompletionResultType]::ParameterName, 'Uses a dot marker for graphs.')
            [CompletionResult]::new('-g', 'g', [CompletionResultType]::ParameterName, 'Groups processes with the same name by default.')
            [CompletionResult]::new('--group', 'group', [CompletionResultType]::ParameterName, 'Groups processes with the same name by default.')
            [CompletionResult]::new('-a', 'a', [CompletionResultType]::ParameterName, 'Hides the average CPU usage.')
            [CompletionResult]::new('--hide_avg_cpu', 'hide_avg_cpu', [CompletionResultType]::ParameterName, 'Hides the average CPU usage.')
            [CompletionResult]::new('--hide_table_gap', 'hide_table_gap', [CompletionResultType]::ParameterName, 'Hides the spacing between table headers and entries.')
            [CompletionResult]::new('--hide_time', 'hide_time', [CompletionResultType]::ParameterName, 'Hides the time scale.')
            [CompletionResult]::new('--show_table_scroll_position', 'show_table_scroll_position', [CompletionResultType]::ParameterName, 'Shows the scroll position tracker in table widgets.')
            [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'Puts the CPU chart legend to the left side.')
            [CompletionResult]::new('--left_legend', 'left_legend', [CompletionResultType]::ParameterName, 'Puts the CPU chart legend to the left side.')
            [CompletionResult]::new('--disable_advanced_kill', 'disable_advanced_kill', [CompletionResultType]::ParameterName, 'Hides advanced options to stop a process on Unix-like systems.')
            [CompletionResult]::new('-R', 'R', [CompletionResultType]::ParameterName, 'Enables regex by default.')
            [CompletionResult]::new('--regex', 'regex', [CompletionResultType]::ParameterName, 'Enables regex by default.')
            [CompletionResult]::new('-T', 'T', [CompletionResultType]::ParameterName, 'Defaults to showing the process widget in tree mode.')
            [CompletionResult]::new('--tree', 'tree', [CompletionResultType]::ParameterName, 'Defaults to showing the process widget in tree mode.')
            [CompletionResult]::new('--network_use_bytes', 'network_use_bytes', [CompletionResultType]::ParameterName, 'Displays the network widget using bytes.')
            [CompletionResult]::new('--network_use_log', 'network_use_log', [CompletionResultType]::ParameterName, 'Displays the network widget with a log scale.')
            [CompletionResult]::new('--network_use_binary_prefix', 'network_use_binary_prefix', [CompletionResultType]::ParameterName, 'Displays the network widget with binary prefixes.')
            [CompletionResult]::new('-u', 'u', [CompletionResultType]::ParameterName, 'Sets process CPU% to be based on current CPU%.')
            [CompletionResult]::new('--current_usage', 'current_usage', [CompletionResultType]::ParameterName, 'Sets process CPU% to be based on current CPU%.')
            [CompletionResult]::new('--use_old_network_legend', 'use_old_network_legend', [CompletionResultType]::ParameterName, 'DEPRECATED - uses the older network legend.')
            [CompletionResult]::new('-W', 'W', [CompletionResultType]::ParameterName, 'Enables whole-word matching by default.')
            [CompletionResult]::new('--whole_word', 'whole_word', [CompletionResultType]::ParameterName, 'Enables whole-word matching by default.')
            [CompletionResult]::new('--battery', 'battery', [CompletionResultType]::ParameterName, 'Shows the battery widget.')
            [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Prints help information.  Use --help for more info.')
            [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Prints help information.  Use --help for more info.')
            [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Prints version information.')
            [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Prints version information.')
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}

$colors = @{


  Command            = '#8470FF'
  Number             = '#8470FF'
  Member             = '#8470FF'
  Operator           = '#8470FF'
  Type               = '#8470FF'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = '#8470FF'
  Default            = '#8470FF'
}

Set-PSReadlineOption -PredictionSource HistoryAndPlugin
# Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineOption -EditMode Windows
# Set-PSReadlineOption -Colors $colors
