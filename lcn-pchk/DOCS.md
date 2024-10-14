# Home Assistant LCN Add-on: LCN-PCHK

## About
This add-on provides an easy way to run the [LCN-PCHK](https://www.lcn.eu/en/lcn-tech/products/lcn-pchk/) service on the same hardware as your Home Assistant installation.

LCN-PCHK is a gateway software which provides access to the LCN bus system in conjunction with a USB or serial hardware gateway. The interface is used by the Home Assistant [LCN integration](https://www.home-assistant.io/integrations/lcn/).

LCN-PCHK is provided by Issendorff and is not included in this add-on. However it will be automatically downloaded, installed and configured by this addon.

## Installation

Follow these steps to get the add-on installed on your system:

1. Follow the installation instructions provided [here](https://github.com/alengwenus/hass-addons).
2. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
3. Find the "LCN-PCHK" add-on and click it.
4. Click on the "INSTALL" button.

## Requirements
In order to take full advantage of this add-on you need a USB or serial LCN hardware gateway (LCN-PKU or LCN-PK) and one or more valid license keys for the LCN-PCHK software.

## Configure the add-on

The add-on provides several configuration options via the add-on's configuration tab.

| Key      | Required | Description |
| ---------|----------|-------------|
| device   | yes | serial device port: `ttyUSB0`, `ttyS0`, ... |
| user     | yes | name for login to PCHK connection |
| password | yes | password for login to PCHK connection |
| licensee | yes | licensee for PCHK |
| license_keys | yes | license keys to use for PCHK as a yaml list |
| host_id | no | address id which should be used by PCHK to identify on the bus (default: `4`)|
| sync_time | no | synchronize bus time: `auto`, `system`, `disabled` or a time server URL (default: `auto`) |
| timeout | no | idle time after which PCHK closes the connection (default: `1800`) |

### Comments:
- **device** does not contain the whole device path (e.g. `/dev/ttyUSB0`) but only the last substring! To get a list of the available devices, go to **Supervisor** -> **System**. Click the three vertical dots in the **Host System** section and choose **Hardware**.
- **license-keys** should be provided as a comma separated list of strings (e.g. `["111abcdef", "222abcdef", "333abcdef"]`) or a yaml bullet point list. The order and type of the keys (so whether it's a product key or an update key) does not matter. **Note that the license key needs to entered without dashes!**
- possible time server URLs for **sync_time** are: `pool.ntp.org`, `time.nist.gov`, `time-nw.nist.gov`, `time-a.nist.gov`, `time-b.nist.gov`, `ptbtime1.ptb.de`, `ptbtime2.ptb.de`

### Notes:
- Changes to the configuration done by using the bus monitor application which is shipped with the LCN-PCHK software are not persistent and will be overwritten by the add-on on every start.
Please use the configuration options provided by this add-on!
