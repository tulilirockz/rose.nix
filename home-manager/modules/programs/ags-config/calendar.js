const CalendarWidget = () => {
  return Widget.Calendar({
    class_name: "calendar",
    showDayNames: true,
    showWeekNumbers: true,
  })
}

export const WINDOW_NAME = "main_calendar"

// there needs to be only one instance
export const Calendar = () => Widget.Window({
    name: WINDOW_NAME,
    setup: self => self.keybind("Escape", () => {
        App.closeWindow(WINDOW_NAME)
    }),
    visible: false,
    anchor: ["top"],
    keymode: "exclusive",
    child: CalendarWidget(),
})
