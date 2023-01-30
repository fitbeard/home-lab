# Intel AMT (vPRO) KVM with Linux

You can remotely control Intel vPro based CPU that includes AMT using Linux. Intel Active Management Technology (AMT) is a combination of hardware, software and firmware technology for remote out-of-band management of servers, desktops, and laptop computers. AMT is built into modern CPUs such as i7, i5, Xeon (look for vPro) and based on Intel ME. This document shows how to remotely access Intel AMT KVM using VNC client when you have vPro enabled system from Intel.

## Configure Intel AMT for remote access

As pointed out earlier only vPro CPUs such as i7, i5 and Xeon CPU support Intel AMT. Intel does not support AMT on all processors but does include Intel ME in every CPU made since 2008. Boot your system and visit BIOS settings. To enable Hardware KVM and Intel AMT find option that read as follows in your BIOS and enable it:

![intel1](https://user-images.githubusercontent.com/18698204/215517189-8aafca43-92f6-4e9d-b239-f73b8d87f261.jpg)

You must save setting in BIOS and restart the computer. Press CTRL+p to configure the Intel Management engine and AMT hardware KVM by login into MBEx. If AMT has never been set up on your server or desktop, use admin as password:

![intel2](https://user-images.githubusercontent.com/18698204/215518098-927cd9e0-5bae-4f3c-b650-81fb2a37d1c5.jpg)

Enter `AMT Configuration`. Set `Manageability feature Selection` to Enabled. Press Enter to select `Network Setup` and choose `TCP/IP Settings`:

![intel3](https://user-images.githubusercontent.com/18698204/215519050-b5178dcb-5981-4341-80c7-b8801a128346.jpg)

Finally choose Wired LAN IPv4 Configurations. Set `DHCP Mode` to `Disabled` and set all IPv4 settings as per your network:

![intel4](https://user-images.githubusercontent.com/18698204/215519538-2ae36edd-f67a-4a66-8d41-3fa7cfbdd6d3.jpg)

You are all. Press `ESC` key to get back to main menu. Save current network settings by selecting `Activate Network Access`. Enter `MEBx Exit` and wait until the system reboot.

![intel5](https://user-images.githubusercontent.com/18698204/215519887-13cd61e8-5604-4c6e-8d8c-22e01f55d303.jpg)

## Access Intel AMT web interface

Once your system turned on. Go back to your desktop. Fire a web browser and type the following url:

```shell
http://IP-ADDRESS:16992
```

Type username as “admin” and password set previously.

## Enable remote VNC access for Intel AMT KVM

Install WS-management tools:

```bash
sudo apt install wsmancli

OR

sudo yum install wsmancli

OR

sudo dnf install wsmancli
```

Run shell script:

```bash
bash intel-amt-kvm.sh IP-ADDRESS

Open Linux vnc client. Use "10.13.55.175:5900" as host and when promoted enter "P@ssw0rd" as password
```

## Remotely access Intel AMT KVM with VNC client

Use any VNC client. Type the password as set in `$xVNC_PWD` and you should able to login to remote desktop using Intel AMT. You can reboot the device. Access BIOS. Unlock disk. Turn off PC. Turn it on from Web interface. Fix OS disk or networking. Install a new OS and so on.

![intel6](https://user-images.githubusercontent.com/18698204/215522753-d943d610-5fac-4d5f-9f30-82ba07b8cce3.jpg)

![intel7](https://user-images.githubusercontent.com/18698204/215522817-42896492-1d4a-4c86-b1ba-d47089705df8.jpg)

## Dummy Display Emulator with an HDMI/DVI/DP-VGA adapter

The main goal of this dummy dongle is to fool Windows (or Linux or macOS) by simulating a ghost monitor that would be plugged on the display port. In Intel AMT case this allows use (and see) display output over VNC without real monitor plugged in.

To build this simple DisplayPort emulator, you need an DP-VGA adapter and three resistors:

![dp2](https://user-images.githubusercontent.com/18698204/215524698-10b3e869-aae0-47a5-9d57-3d90bcb6eb2a.jpg)

I selected the 120 ohms resistances in order to draw less current. To concretely build the display emulator, just connect the three resistors on the VGA side of the adapter following this schema:

![dummy_vga_electronic_schema](https://user-images.githubusercontent.com/18698204/215525153-4760c107-e10f-41b8-8ee2-e023b750487e.jpg)

![dp3](https://user-images.githubusercontent.com/18698204/215524887-717a7393-8ea7-4feb-8b10-e7e420d7477c.jpg)

Now just plug this fake display dongle on the HDMI/DP port and and you're done:

![dp1](https://user-images.githubusercontent.com/18698204/215525872-6765edd4-eef3-4d78-8839-ca9094ebf738.jpg)
