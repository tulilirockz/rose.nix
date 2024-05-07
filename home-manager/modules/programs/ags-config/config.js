import { Bar } from "./navbar.js"
import { applauncher } from "./applauncher.js"
import { NotificationPopups } from "./notificationPopups.js"
import { Calendar } from "./calendar.js"
import { win } from "./mediaplayer.js"

App.addIcons(`${App.configDir}/assets`)

App.config({
  style: "./style.css",
  windows: [
    Bar(),
    applauncher,
    Calendar(),
    win
  ],
})
