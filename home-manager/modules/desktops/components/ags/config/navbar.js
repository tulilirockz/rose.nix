import { WINDOW_NAME as WINDOW_NAME_APPLAUNCHER} from "./applauncher.js"
import { WINDOW_NAME as WINDOW_NAME_PLAYER } from "./mediaplayer.js"
import { WINDOW_NAME as WINDOW_NAME_CALENDAR } from "./calendar.js"

const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
    poll: [1000, 'date "+%H:%M %b %e"'],
})

function Clock() {
    return Widget.Button({
        on_primary_click: (event) => {
            App.toggleWindow(WINDOW_NAME_CALENDAR)
        },
        child: Widget.Label({
            class_name: "clock",
            label: date.bind(),
        })
    })
}


function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0]
            return `${track_artists.join(", ")} - ${track_title}`
        } else {
            return "Nothing is playing"
        }
    })

    return Widget.Button({
        class_name: "media",
        on_primary_click: (_, _event) => {
            App.toggleWindow(WINDOW_NAME_PLAYER)
        },
        child: Widget.Label({ label }),
    })
}


function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    return Widget.Box({
        class_name: "volume",
        children: [
            Widget.Button({
                on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
                child: Widget.Icon().hook(audio.speaker, self => {
                    const vol = audio.speaker.volume * 100;
                    const icon = [
                        [101, 'overamplified'],
                        [67, 'high'],
                        [34, 'medium'],
                        [1, 'low'],
                        [0, 'muted'],
                    ].find(([threshold]) => threshold <= vol)?.[1];
                    
                    self.icon = `audio-volume-${icon}-symbolic`;
                    self.tooltip_text = `Volume ${Math.floor(vol)}%`;
                }),
                on_scroll_down: (_) => {
                    audio.speaker.volume -= 0.05
                },
                on_scroll_up: (_) => {
                    audio.speaker.volume += 0.05
                }
            }),
            Widget.Label().hook(audio.speaker, self => {
               self.label = `${Math.floor(audio.speaker.volume * 100)}%`        
            })
        ]
    })
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        children: items,
    })
}

const AppButton = () => {
    let activity_icon = Variable("activities")

    return Widget.Button({
        class_name: "activities-button",
        child: Widget.Icon({icon: activity_icon.bind()}),
        on_primary_click: (_, event) => {
            App.toggleWindow(WINDOW_NAME_APPLAUNCHER)
            activity_icon.value = "activities-active"
        },
        on_hover: (event) => {
            activity_icon.value = "activities-active"
        },
        on_hover_lost: (event) => {
            activity_icon.value = "activities"
        }
    })
}

const LogoutButton = () => {
    return Widget.Button({
        child: Widget.Icon({icon: `system-log-out-symbolic`}),
        on_primary_click: (_, event) => {
            Utils.exec("wlogout")
        },
    })
}

const KdeConnectButton = () => {
    return Widget.Button({
        child: Widget.Icon({icon: `phone-symbolic`}),
        on_primary_click: (_, event) => {
            Utils.exec("kdeconnect-app")
        },
    })
}

const ConectivityButton = () => {
    return Widget.Button({
        child: Widget.Icon({icon: `phone-symbolic`}),
        on_primary_click: (_, event) => {
            Utils.exec("kdeconnect-app")
        },
    })
}

// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 8,
        children: [
            AppButton(),
            Media(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
            Clock(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            Volume(),
            SysTray(),
            KdeConnectButton(),
            LogoutButton(),
        ],
    })
}

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

export { Bar };
