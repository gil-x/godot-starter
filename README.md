# Godot - Project Starter

## Features

- Debug/Log Script (src/global/debug.gd)
- Global Vars script (src/global/vars.gd)
- Title Screen with Main Menu
- Global AudioPlayer Scene

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

### Audio

Each sound is played by an AudioStreamPlayer created on the fly, deleted when sound is finished.
Two custom sound busses will be used for **SFX** and **Music**.

#### Bus Layout

- Create resource **AudioBusLayout**, name it _default_bus_layout_
- In this resource, create to new busses: **Music** and **SFX**

#### How to use

- AudioPlayer Scene must be set in Project Settings > Globals
- If you play a _sound loop_ or want to stop manually a sound, you need to assign the _returned asp_ in a var.

```gdscript
    # Simple case of a short sound, asp will self delete at end
    AudioPlayer.play_sound("sfx_random")
    # Keep sound in a var if you need to stop it manually
	var music = AudioPlayer.fade_in("music_random", 5.0, -10.0)
    var music = AudioPlayer.play_sound("music_random", -10.0, true)
    # For many sounds, you can use groups
    music.add_to_group("musics")
    for music in musics:
		AudioPlayer.stop(music)
```

### Audio volume

- need a global **game.gd** script
- two sliders with _value_changed event_ change volume of SFX or MUSIC

## Splash Screens

- In **SplashScreens** scene reate **SplashScreen** instances under node Screens
- Set _'Editable children'_ (right click menu in node tree) on each of these **SplashScreen** nodes
- In each **SplashScreen**, under MediaContainer, add a **Sprite2d**, **VideoStreamPlayer** or whatever visual, and the name of sound (wich need to be registered in audio_player.gd)
- Each **SplashScreen** can be bypass with a click or press on _"ui_cancel"_, you can add more events if needed.
