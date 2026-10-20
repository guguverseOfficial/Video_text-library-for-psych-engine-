function onCreatePost()
    -- Загружаем видео "kotik_dance.txt" в правый нижний угол
    TextVideo.load('kotik_dance', 'videoText', 800, 500)
    
    -- Настраиваем размер шрифта (чтобы влезло)
    TextVideo.setSize(8)
    
    -- Запускаем
    TextVideo.play()
    TextVideo.setFPS(15) -- 15 кадров в секунду
end

function onUpdate(elapsed)
    -- Обновляем видео каждый кадр
    TextVideo.update(elapsed)
end