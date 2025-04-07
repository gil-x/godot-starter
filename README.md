# Godot - Project Starter

## Features

- nice debug script (src/global/debug.gd)
- global vars script (src/global/vars.gd)
- title screen with main menu

## How to use & conception details

### Debug script

Use cases:

```gdscript
# Logs one value
Debug.log("Some message")
# Use an Array to log many values
Debug.log(["Message", some_var, value])
```

### Main Menu Recipe

- customize what appends when player use directions on each entry in **focus** section
- **get_tree().quit()** exits game
