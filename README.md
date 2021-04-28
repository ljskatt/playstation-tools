# Playstation-tools
A playstation tool that can helps you making a .rap file or helps you find ps3 game patch for RPCS3

## rif2rap
This makes it possible to make .rap file by using your `act.dat`, `idps` and `.rif` file

### act.dat and .rif file:
Can be found in /dev_hdd0/home/00000001/exdata/ on your PS3.

You can use multiMAN to either copy to a USB stick, or transfer with FTP.

> The `act.dat` is your PS3, and is only needed to copy once.<br>
The `.rif` is each game you have downloaded on your PS3.

### idps:
You will need one of the following:<br>
1. Using [http://ps3xploit.com](http://ps3xploit.com) with HEN
2. Find IDPS with multiMAN:<br>
   You can find IDPS under `Settings > System Information` (if IDPS is not listed, go to: `mmCM > Switch to multiMAN mode` first)
   
After finding IDPS (32 characters), then you need to put it in a hex editor, and save the file as `idps`.

## Find PS3 game patch

This requires you to input the game serial number, example: `NPEA00457`.

This will then display the newest patch version, and link to the `.pkg` file.