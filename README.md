# 🐱 Divijay Text Video Library

A library for Psych Engine that allows you to display ASCII videos (text-based animations) anywhere on screen.

## 📦 Installation
1. Copy `text_video.lua` to your mod's `scripts/` folder.
2. Copy `reader.hx` to your mod's `scripts/` folder (if you need to read files).
3. Create a `videos/` folder in your mod and put your `.txt` ASCII videos there.

## 🛠️ Usage
```lua
function onCreatePost()
    TextVideo.load('kotik_dance', 'videoText', 800, 500)
    TextVideo.setSize(8)
    TextVideo.play()
    TextVideo.setFPS(15)
end

function onUpdate(elapsed)
    TextVideo.update(elapsed)
end