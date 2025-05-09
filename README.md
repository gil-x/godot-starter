# Godot - Project Starter

Godot 4.4 starter project.

## Features

- Debug/Log Script (src/global/debug.gd)
- Global Vars Script (src/global/vars.gd)
- Title Screen with Main Menu
- Global AudioPlayer Scene
- Audio Volume Set Scene
- Pause system
- Basic Save System

## How to use & conception details

### 1. Debug script

#### 1.1 Global

Scenes or Script can be made _globals_ and be accessed from any node.
To create one, go in Projects Settings > Globals.

#### 1.2 Use cases:

```gdscript
# Logs one value
Debug.log("Some message")
# Use an Array to log many values
Debug.log(["Message", some_var, value])
```

### 2. Main Menu Recipe

- Customize what appends when User use directions on each entry in **focus** section
- **get_tree().quit()** exits game

### 2. Audio Script

Is good practice to play sound in a dedicated scene: audio*player.tscn is \_global* scene.
Each sound is played by an **AudioStreamPlayer** created on the fly, deleted when sound is finished.
Two custom sound _busses_ will be used for **SFX** and **Music**.

#### 2.1 Bus Layout Recipe

- Create resource **AudioBusLayout**, name it _default_bus_layout_
- In this resource, create to new _busses_: **Music** and **SFX**

#### 2.2 How to use

- _AudioPlayer Scene_ must be set in Project Settings > Globals
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

- You shall use Audioplayer.pause_all() when pausing game
- You shall use Audioplayer.kill_all() when leaving a scene
- If you want to slow down or speed up a sound, use:

```gdscript
asp.pitch_scale = 0.5
```

### 3. Audio volume

- Need a global **game.gd** script
- Two sliders with _value_changed event_ change volume of SFX or MUSIC

### 4. Splash Screens

- In **SplashScreens** scene reate **SplashScreen** instances under node Screens
- Set _'Editable children'_ (right click menu in node tree) on each of these **SplashScreen** nodes
- In each **SplashScreen**, under MediaContainer, add a **Sprite2d**, **VideoStreamPlayer** or whatever visual, and the name of sound (wich need to be registered in audio_player.gd)
- Each **SplashScreen** can be bypass with a click or press on _"ui_cancel"_, you can add more events if needed.

### 5. Pause Game

- Uses native pause system of Godot
- Pause node is _global_, and as Process > Mode is set to **Always**, it make ignore the get_tree().paused = true
- Tip: you can use slow motion effect before pausing with this method:

```gdscript
func _tween_finished():
	if Engine.time_scale < 0.2:
		Game.current_state = Game.State.PAUSED
		get_tree().paused = true
	else:
		Game.current_state = Game.State.IN_GAME
		get_tree().paused = false

func _pause() -> void:
    var tween : Tween
        tween = create_tween().set_parallel(true)
        tween.tween_property(Engine, "time_scale", 0.05, 0.5)
        tween.finished.connect(_tween_finished)
        # or await tween.finished
        # do pause here
```

### 6. Save System

Basic save and load functions are located in global **game.gd**.
Saves data in json format:

```json
{
  "key1": ["A first string", 1, 1.5, true],
  "key2": ["Another string", 9, 0.1, false]
}
```

- Set a custom file save name (var **save_path**)
- Use save_data and load_data to save an **Array** of values of types String, int, float or bool
- You have to ensure data validity on each use case

For more complex save system, look at [GD Script Documentation](https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html).
