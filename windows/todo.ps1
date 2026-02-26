# Command-line arguments - MUST be at the top of the script
param (
    [string]$command,
    [string]$arg
)

# Path to the todo file (in the same folder)
$todoPath = Join-Path -Path $PSScriptRoot -ChildPath "todo.json"

# Ensure file exists
if (-not (Test-Path $todoPath)) {
    @() | ConvertTo-Json | Set-Content $todoPath
}

function Load-Todo {
    if ((Get-Content $todoPath -Raw).Trim()) {
        $data = Get-Content $todoPath -Raw | ConvertFrom-Json
        # Ensure we always return an array
        if ($data -is [System.Array]) {
            return $data
        } else {
            return @($data)
        }
    } else {
        return @()
    }
}

function Save-Todo($tasks) {
    $tasks | ConvertTo-Json -Depth 3 | Set-Content $todoPath
}

function Add-Task($task) {
    $tasks = Load-Todo
    # Ensure $tasks is an array
    $tasks = @($tasks)
    $newTask = [PSCustomObject]@{
        Task = $task
        Done = $false
    }
    $tasks += $newTask
    Save-Todo $tasks
    Write-Host "Added task: $task"
}

function List-Tasks {
    $tasks = Load-Todo
    if ($tasks.Count -eq 0) {
        Write-Host "No tasks found."
        return
    }
    for ($i = 0; $i -lt $tasks.Count; $i++) {
        $status = if ($tasks[$i].Done) { "[x]" } else { "[ ]" }
        Write-Host "$($i+1). $status $($tasks[$i].Task)"
    }
}

function Remove-Task($index) {
    $tasks = Load-Todo
    if ($index -lt 1 -or $index -gt $tasks.Count) {
        Write-Host "Invalid index."
        return
    }
    $removed = $tasks[$index - 1].Task
    $tasks = $tasks | Where-Object { $_ -ne $tasks[$index - 1] }
    Save-Todo $tasks
    Write-Host "Removed task: $removed"
}

function Mark-Done($index) {
    $tasks = Load-Todo
    if ($index -lt 1 -or $index -gt $tasks.Count) {
        Write-Host "Invalid index."
        return
    }
    $tasks[$index - 1].Done = $true
    Save-Todo $tasks
    Write-Host "Marked task as done: $($tasks[$index - 1].Task)"
}

# Main script logic
switch ($command) {
    "add"    { Add-Task $arg }
    "list"   { List-Tasks }
    "remove" { Remove-Task ([int]$arg) }
    "done"   { Mark-Done ([int]$arg) }
    default  { 
        Write-Host "Usage: .\todo.ps1 [add|list|remove|done] [argument]"
        Write-Host "Commands:"
        Write-Host "  add <task>    - Add a new task"
        Write-Host "  list          - List all tasks"
        Write-Host "  remove <num>  - Remove task by number"
        Write-Host "  done <num>    - Mark task as done by number"
    }
}