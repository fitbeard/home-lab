# pxe-weboort

```bash
docker-compose up

wget https://releases.ubuntu.com/20.04.5/ubuntu-20.04.5-live-server-amd64.iso
wget https://releases.ubuntu.com/22.04.1/ubuntu-22.04.1-live-server-amd64.iso

mv ubuntu-20.04.5-live-server-amd64.iso files/ubuntu/2004/
mv ubuntu-22.04.1-live-server-amd64.iso files/ubuntu/2204/

mount -t iso9660 -o loop,ro files/ubuntu/2004/ubuntu-20.04.5-live-server-amd64.iso /mnt/
cp /mnt/casper/vmlinuz files/ubuntu/2004/
cp /mnt/casper/vmlinuz /var/tftp/ubuntu/2004/
cp /mnt/casper/initrd files/ubuntu/2004/
cp /mnt/casper/vmlinuz /var/tftp/ubuntu/2004/
umount /mnt

mount -t iso9660 -o loop,ro files/ubuntu/2204/22.04.1/ubuntu-22.04.1-live-server-amd64.iso /mnt/
cp /mnt/casper/vmlinuz files/ubuntu/2204/
cp /mnt/casper/vmlinuz /var/tftp/ubuntu/2204/
cp /mnt/casper/initrd files/ubuntu/2204/
cp /mnt/casper/vmlinuz /var/tftp/ubuntu/2204/
umount /mnt

wget https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-x86_64-minimal.iso -O Rocky9-x86_64-minimal.iso
wget https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-x86_64-minimal.iso -O Rocky8-x86_64-minimal.iso

mount -t iso9660 -o loop,ro Rocky9-x86_64-minimal.iso /mnt/
cp -r /mnt files/rocky9
cp /mnt/images/pxeboot/vmlinuz /var/tftp/rocky9/
cp /mnt/images/pxeboot/initrd.img /var/tftp/rocky9/
umount /mnt

mount -t iso9660 -o loop,ro Rocky8-x86_64-minimal.iso /mnt/
cp -r /mnt files/rocky8
cp /mnt/images/pxeboot/vmlinuz /var/tftp/rocky8/
cp /mnt/images/pxeboot/initrd.img /var/tftp/rocky8/
umount /mnt

rm Rocky9-x86_64-minimal.iso
rm Rocky8-x86_64-minimal.iso
```
