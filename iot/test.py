#!/usr/bin/env python3

from meross_iot.http_api import MerossHttpClient
from meross_iot.manager import MerossManager

import asyncio
import os
import sys

EMAIL = os.environ.get('MEROSS_EMAIL') or "YOUR_MEROSS_CLOUD_EMAIL"
PASSWORD = os.environ.get('MEROSS_PASSWORD') or "YOUR_MEROSS_CLOUD_PASSWORD"

async def main():
    http_api_client = await MerossHttpClient.async_from_user_password(email=EMAIL, password=PASSWORD)

    manager = MerossManager(http_client=http_api_client)
    await manager.async_init()

    await manager.async_device_discovery()
    bulbs = manager.find_devices(device_type="msl120d")
    bulbs += manager.find_devices(device_type="msl120j")

    for bulb in bulbs:
        await bulb.async_update()

        current_color = bulb.get_rgb_color()
        print(f"Currently, device {bulb.name} is set to color (RGB) = {current_color}")

        rgb = 255, 30, 0
        await bulb.async_set_light_color(onoff=True, rgb=rgb, luminance=100)

    manager.close()
    await http_api_client.async_logout()

if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    loop.run_until_complete(main())
    loop.close()
