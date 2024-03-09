{ config
, preferences
, ...
}:
with preferences.colorScheme.palette; ''
  * {
    all: unset;
    font-size: 14px;
    font-family: "${preferences.font_family}";
    transition: 200ms;
  }

  .floating-notifications.background .notification-row .notification-background {
    box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${base02};
    border-radius: 12.6px;
    margin: 18px;
    background-color: #${base00};
    color: #${base05};
    padding: 0;
  }

  .floating-notifications.background .notification-row .notification-background .notification {
    padding: 7px;
    border-radius: 12.6px;
  }

  .floating-notifications.background .notification-row .notification-background .notification.critical {
    box-shadow: inset 0 0 7px 0 #${base08};
  }

  .floating-notifications.background .notification-row .notification-background .notification .notification-content {
    margin: 7px;
  }

  .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
    color: #${base05};
  }

  .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
    color: #${base06};
  }

  .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
    color: #${base05};
  }

  .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* {
    min-height: 3.4em;
  }

  .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action {
    border-radius: 7px;
    color: #${base05};
    background-color: #${base02};
    box-shadow: inset 0 0 0 1px #${base03};
    margin: 7px;
  }

  .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base02};
    color: #${base05};
  }

  .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base0C};
    color: #${base05};
  }

  .floating-notifications.background .notification-row .notification-background .close-button {
    margin: 7px;
    padding: 2px;
    border-radius: 6.3px;
    color: #${base00};
    background-color: #${base08};
  }

  .floating-notifications.background .notification-row .notification-background .close-button:hover {
    background-color: #${base08};
    color: #${base00};
  }

  .floating-notifications.background .notification-row .notification-background .close-button:active {
    background-color: #${base08};
    color: #${base00};
  }

  .control-center {
    box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${base02};
    border-radius: 12.6px;
    margin: 18px;
    background-color: #${base00};
    color: #${base05};
    padding: 14px;
  }

  .control-center .widget-title {
    color: #${base05};
    font-size: 1.3em;
  }

  .control-center .widget-title button {
    border-radius: 7px;
    color: #${base05};
    background-color: #${base02};
    box-shadow: inset 0 0 0 1px #${base03};
    padding: 8px;
  }

  .control-center .widget-title button:hover {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base04};
    color: #${base05};
  }

  .control-center .widget-title button:active {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base0C};
    color: #${base00};
  }

  .control-center .notification-row .notification-background {
    border-radius: 7px;
    color: #${base05};
    background-color: #${base02};
    box-shadow: inset 0 0 0 1px #${base03};
    margin-top: 14px;
  }

  .control-center .notification-row .notification-background .notification {
    padding: 7px;
    border-radius: 7px;
  }

  .control-center .notification-row .notification-background .notification.critical {
    box-shadow: inset 0 0 7px 0 #${base08};
  }

  .control-center .notification-row .notification-background .notification .notification-content {
    margin: 7px;
  }

  .control-center .notification-row .notification-background .notification .notification-content .summary {
    color: #${base05};
  }

  .control-center .notification-row .notification-background .notification .notification-content .time {
    color: #${base06};
  }

  .control-center .notification-row .notification-background .notification .notification-content .body {
    color: #${base05};
  }

  .control-center .notification-row .notification-background .notification>*:last-child>* {
    min-height: 3.4em;
  }

  .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action {
    border-radius: 7px;
    color: #${base05};
    background-color: #${base0E};
    box-shadow: inset 0 0 0 1px #${base03};
    margin: 7px;
  }

  .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base02};
    color: #${base05};
  }

  .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base0C};
    color: #${base05};
  }

  .control-center .notification-row .notification-background .close-button {
    margin: 7px;
    padding: 2px;
    border-radius: 6.3px;
    color: #${base00};
    background-color: #${base08};
  }

  .control-center .notification-row .notification-background .close-button:hover {
    background-color: #${base08};
    color: #${base00};
  }

  .control-center .notification-row .notification-background .close-button:active {
    background-color: #${base08};
    color: #${base00};
  }

  .control-center .notification-row .notification-background:hover {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base0D};
    color: #${base05};
  }

  .control-center .notification-row .notification-background:active {
    box-shadow: inset 0 0 0 1px #${base03};
    background-color: #${base0C};
    color: #${base05};
  }

  progressbar,
  progress,
  trough {
    border-radius: 12.6px;
  }

  progressbar {
    box-shadow: inset 0 0 0 1px #${base03};
  }

  .notification.critical progress {
    background-color: #${base08};
  }

  .notification.low progress,
  .notification.normal progress {
    background-color: #${base0D};
  }

  trough {
    background-color: #${base02};
  }

  .control-center trough {
    background-color: #${base03};
  }

  .control-center-dnd {
    margin-top: 5px;
    border-radius: 8px;
    background: #${base02};
    border: 1px solid #${base03};
    box-shadow: none;
  }

  .control-center-dnd:checked {
    background: #${base02};
  }

  .control-center-dnd slider {
    background: #${base03};
    border-radius: 8px;
  }

  .widget-dnd {
    margin: 0px;
    font-size: 1.1rem;
  }

  .widget-dnd>switch {
    font-size: initial;
    border-radius: 8px;
    background: #${base02};
    border: 1px solid #${base03};
    box-shadow: none;
  }

  .widget-dnd>switch:checked {
    background: #${base02};
  }

  .widget-dnd>switch slider {
    background: #${base03};
    border-radius: 8px;
    border: 1px solid #${base06};
  }''
