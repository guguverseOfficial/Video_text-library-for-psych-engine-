import sys.io.File;
import sys.FileSystem;

// Эта функция вызывается из Lua через runHaxeCode
function readTextFile(path:String):String {
    // Проверяем, существует ли файл
    if (FileSystem.exists(path)) {
        try {
            // Читаем содержимое файла
            var content = File.getContent(path);
            return content;
        } catch (e:Dynamic) {
            trace("Ошибка чтения файла: " + e);
            return "ERROR";
        }
    } else {
        trace("Файл не найден: " + path);
        return "NOT_FOUND";
    }
}