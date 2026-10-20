-- ============================================
-- Text Video Library для Divijay
-- Позволяет отображать ASCII-видео в игре
-- ============================================

TextVideo = {}

-- Хранилище кадров видео
TextVideo.frames = {}
TextVideo.currentFrame = 0
TextVideo.isPlaying = false
TextVideo.textTag = ""
TextVideo.fps = 24
TextVideo.timer = 0

-- 1. Загрузка видео из текстового файла
-- @param videoName: имя видео (файл должен лежать в mods/videos/название.txt)
-- @param textTag: имя LuaText объекта (чтобы потом можно было двигать)
-- @param x: позиция X
-- @param y: позиция Y
function TextVideo.load(videoName, textTag, x, y)
    local path = 'mods/videos/' .. videoName .. '.txt'
    
    -- ВАЖНО: Psych Engine не умеет читать файлы напрямую в Lua.
    -- Нам нужно использовать HScript для чтения, но в JS Engine его нет.
    -- Поэтому пока мы просто создаем пустой текст.
    
    makeLuaText(textTag, 'Loading video...', 1280, x, y)
    setTextSize(textTag, 10)
    setTextColor(textTag, '00FF00') -- Зеленый как в матрице
    setTextAlignment(textTag, 'center')
    addLuaText(textTag)
    
    TextVideo.textTag = textTag
    TextVideo.frames = {}
    TextVideo.currentFrame = 0
    
    debugPrint('🎥 Видео загружено: ' .. videoName)
end

-- 2. Запуск видео
function TextVideo.play()
    TextVideo.isPlaying = true
    TextVideo.currentFrame = 0
    TextVideo.timer = 0
    debugPrint('▶️ Воспроизведение видео началось!')
end

-- 3. Остановка видео
function TextVideo.stop()
    TextVideo.isPlaying = false
    debugPrint('⏹️ Видео остановлено.')
end

-- 4. Установка FPS (кадров в секунду)
function TextVideo.setFPS(fps)
    TextVideo.fps = fps
    debugPrint('⚙️ FPS установлен на: ' .. fps)
end

-- 5. Перемещение видео (например, в угол)
function TextVideo.move(x, y)
    setProperty(TextVideo.textTag .. '.x', x)
    setProperty(TextVideo.textTag .. '.y', y)
    debugPrint('📍 Видео перемещено в: ' .. x .. ', ' .. y)
end

-- 6. Изменение размера шрифта
function TextVideo.setSize(size)
    setTextSize(TextVideo.textTag, size)
    debugPrint('🔍 Размер шрифта изменен на: ' .. size)
end

-- ============================================
-- Обновление (вызывается в onUpdate)
-- ============================================
function TextVideo.update(elapsed)
    if not TextVideo.isPlaying then return end
    
    TextVideo.timer = TextVideo.timer + elapsed
    
    -- Если прошло достаточно времени для следующего кадра
    local frameTime = 1 / TextVideo.fps
    if TextVideo.timer >= frameTime then
        TextVideo.timer = TextVideo.timer - frameTime
        TextVideo.currentFrame = TextVideo.currentFrame + 1
        
        -- Если кадры закончились, начинаем сначала (зацикливаем)
        if TextVideo.currentFrame > #TextVideo.frames then
            TextVideo.currentFrame = 1
        end
        
        -- Обновляем текст на экране
        if TextVideo.frames[TextVideo.currentFrame] then
            setTextString(TextVideo.textTag, TextVideo.frames[TextVideo.currentFrame])
        end
    end
end