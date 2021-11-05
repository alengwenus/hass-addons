# Home Assistant eBUSd Add-on

## About
This add-on runs the [eBUSd deamon](https://github.com/john30/ebusd) on the same hardware as your Home Assistant installation.
The connectiion to the eBUS adapter is limited to LAN/WLAN. USB or GPIO connection is not supported.

## Installation

Follow these steps to get the add-on installed on your system:

1. Follow the installation instructions provided [here](https://github.com/alengwenus/hass-addons).
2. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
3. Find the "eBUSd" add-on and click it.
4. Click on the "INSTALL" button.

## Requirements
To connect to the eBUS an [eBUS adapter](https://ebusd.de/) connected to an ESP8266 or ESP32 development board flashed with the [ebusd-esp](firmware) is needed.

## Configure the add-on

The add-on provides several configuration options via the add-on's configuration tab.

| Key      | Required | Description |
| ---------|----------|-------------|
| ip | yes | ip address of ESP device |
| port | yes | port of the ESP device (default: 9999) |
| latency | no | transfer latency (default: 10) |
| readonly | no | Readonly mode (default: false) |

In addition the add-on exposes a TCP port (default: 8888) to the eBUSd deamon. This port is used by the Home Assistant [eBUSd integration](https://www.home-assistant.io/integrations/ebusd/).
