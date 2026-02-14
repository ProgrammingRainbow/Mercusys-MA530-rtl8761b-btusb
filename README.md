# Mercusys MA530 Bluetooth USB Dongle using RealTek rtl8761b
Add support for the Mercusys MA530 usb to RealTek rtl8762b btusb kernel driver using dkms.

This simply adds the device’s USB VID:PID to the btusb driver’s device table for RealTek rtl8761b.
Without this the usb bluetooth from Mercusys will appear to almost work but never see any devices.

It's a 2 line patch to btusb.c and it compiles that kernel module only. It attempts to use your existing kernel version and simply curl the btusb.c and 4 header files. It will then try to apply the patch below and compile it.

The patch for btusb.c to add support for Mercusys MA530
```
--- a/btusb.c
+++ b/btusb.c
@@ -775,6 +775,8 @@ static const struct usb_device_id quirks_table[] = {
	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },

	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
						     BTUSB_WIDEBAND_SPEECH },
	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
```

Make sure base-devel git curl linux-headers and dkms is installed.
```
sudo pacman -S --needed base-devel git curl linux-headers dkms
```

Clone this repo
```
git clone https://github.com/ProgrammingRainbow/Mercusys-MA530-rtl8761b-btusb
```

Remove any old version then add and install. You should see it download 5 files from the offical linux project using your kernel version.
```
sudo dkms remove Mercusys-MA530-rtl8761b-btusb/1.0 --all
sudo dkms add ./Mercusys-MA530-rtl8761b-btusb
sudo dkms install Mercusys-MA530-rtl8761b-btusb/1.0
```
