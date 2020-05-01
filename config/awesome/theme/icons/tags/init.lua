local iconDir = require("gears.filesystem").get_configuration_dir()
    .. "theme/icons/tags/"

return
{
    browser = iconDir .. "google-chrome.svg",
    code = iconDir .. "code-braces.svg",
    folder = iconDir .. "folder.svg",
    game = iconDir .. "google-controller.svg",
    music = iconDir .. "music.svg",
    social = iconDir .. "forum.svg",
    lab = iconDir .. "flask.svg",
    temp = iconDir .. "close.svg"
}
