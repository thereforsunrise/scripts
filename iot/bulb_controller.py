#!/usr/bin/env python3

from meross_iot.http_api import MerossHttpClient
from meross_iot.manager import MerossManager

import asyncio
import csv
import os
import sys

def usage():
    print("Usage: %s <csv-file>" % sys.argv[0])
    sys.exit(1)

def read_bulb_settings_from_csv(file):
    bulb_settings = {}

    with open(file, newline='') as csvfile:
        reader = csv.reader(csvfile, delimiter=',', quotechar='|')
        for row in reader:
            name, onoff, r, g, b, luminance = row
            luminance = int(luminance)
            name = name.strip().lower()
            onoff = onoff.lower().strip() == "on"
            rgb = int(r), int(g), int(b)

            bulb_settings[name] = {'onoff': onoff, 'rgb': rgb, 'luminance': luminance}

    return bulb_settings

async def main():
    if len(sys.argv) != 2:
        usage()

    file = sys.argv[1]

    email = os.environ.get('MEROSS_EMAIL')
    password = os.environ.get('MEROSS_PASSWORD')

    http_api_client = await MerossHttpClient.async_from_user_password(email=email, password=password)

    manager = MerossManager(http_client=http_api_client)

    await manager.async_init()
    await manager.async_device_discovery()

    bulbs = manager.find_devices(device_type="msl120d")
    bulbs += manager.find_devices(device_type="msl120j")

    bulb_settings = read_bulb_settings_from_csv(file)

    for bulb in bulbs:
        this_bulb_settings = bulb_settings[bulb.name.lower()]

        if this_bulb_settings['onoff']:
            await bulb.async_update()
            await bulb.async_set_light_color(rgb=this_bulb_settings['rgb'], luminance=this_bulb_settings['luminance'])
        else:
            await bulb.async_update()
            await bulb.async_turn_off()

    manager.close()
    await http_api_client.async_logout()

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
    loop.close()
