<p align="center">
  <img src="https://img.shields.io/badge/Godot-4.4-blue?logo=godot-engine&logoColor=white" alt="Godot 4.4" />
  <img src="https://img.shields.io/badge/Status-Ready-green?style=flat-square" alt="Status: Ready" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey?style=flat-square" alt="License: MIT" />
  <img src="https://img.shields.io/badge/Made%20with-%F0%9F%A7%91%E2%80%8D%F0%9F%92%BB%20+%20%E2%9A%94%EF%B8%8F%20+%20%F0%9F%8E%AE-blue" alt="Made with dev love" />
</p>

# 🎮 Godot - Project Starter

🚀 A lightweight, modular starter kit for building your next **Godot 4.4** game — with menus, audio, splash screens, debug logs, save system & more!

## 🧩 Features

- 🐛 Debug / Logging system (`src/global/debug.gd`)
- 🌐 Global Variables script (`src/global/vars.gd`)
- 🎬 Title Screen with Main Menu
- 🔊 Global AudioPlayer Scene
- 🎚️ Audio Volume Settings Scene
- ⏸️ Pause System
- 💾 Basic Save System (JSON format)

## 🛠️ How to Use & Project Design Details

### 🐞 1. Debug script

#### 🌍 1.1 Global Scripts

Scenes or scripts can be made **global** and accessed from any node.  
➡️ To create one, go to **Projects Settings > Globals**.

#### 🧪 1.2 Example Usage

```gdscript
  # Logs one value
  Debug.log("Some message")
  # Use an Array to log many values
  Debug.log(["Message", some_var, value])
```

### 🎮 2. Main Menu Setup

- Customize behavior when users navigate with direction keys via the **focus** section
- Exit the game with: **get_tree().quit()**

### 🔊 3. Audio System

- Playing sounds via a dedicated scene (`AudioPlayer.tscn`) is good practice
- `AudioPlayer.tscn` is _global scene_
- Is good practice to play sound in a dedicated scene: audio*player.tscn is \_global* scene
- Each sound is played by a dynamic **AudioStreamPlayer** created on the fly, deleted when sound is finished
- Two custom audio _busses_ will be used for **SFX** and **Music**

#### 🎛️ 3.1 Audio Bus Layout Setup

- Create resource **AudioBusLayout**, name it _default_bus_layout_
- In this resource, create to new _busses_: **Music** and **SFX**

#### 📦 3.2 How to use

- Make sure _AudioPlayer Scene_ is set as a **global** in `Project Settings > Autoload`
- If you play a _sound loop_ or want to stop manually a sound, you need to assign the _returned asp_ in a var

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

#### 🔁 3.3 Pause & stop

```gdscript
  # Pause all sounds (you shall use this when pausing game)
  AudioPlayer.pause_all()

  # Kill all sounds (you shall use this when changing scene)
  AudioPlayer.kill_all()
```

🌀 3.4 Change pitch (slow/fast playback):

```gdscript
  asp.pitch_scale = 0.5
```

### 🎚️ 4. Audio Volume Controls

- Requires a global **game.gd** script
- Two sliders with _value_changed_ signals to change volume of **SFX** or **MUSIC** _busses_

### 🎬 5. Splash Screens

- Use the **SplashScreens** scene and add **SplashScreen** instances under the _Screens_ node
- Right-click each splash node & enable **Editable Children**
- Inside each **SplashScreen**, under _MediaContainer_, add a **Sprite2d**, **VideoStreamPlayer**, etc.
- Assign a sound name (must be registered in _audio_player.gd_)

⏩ Each **SplashScreen** can be skipped via a click or press of _"ui_cancel"_, you can add more skip events if needed.

### ⏸️ 6. Pause Game

- Uses Godot's built-in pause system
- Pause node is _global_, with `Process > Mode` set to **Always**, this makes bypasse the `get_tree().paused = true`

💡 Slow-motion effect before pause:

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

### 💾 7. Save System

Basic save and load functions are located in global **game.gd**.  
Saves data in _json_ format:

```json
{
  "key1": ["A first string", 1, 1.5, true],
  "key2": ["Another string", 9, 0.1, false]
}
```

📝 Usage:

- Define a custom file path via var **save_path**
- Use **save_data** and **load_data** functions to store **Array** of values of types _String_, _int_, _float_ or _bool_
- You have to ensure data validity on each use case

📚 For advanced save systems, check [Godot Docs – Saving Games](https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html).
