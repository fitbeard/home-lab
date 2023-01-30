# iPXE

```bash
dnf install -y xz-devel gcc binutils mtools

git clone https://github.com/ipxe/ipxe.git

cd ipxe/src/

make bin/undionly.kpxe
make bin-x86_64-efi/ipxe.efi
make bin-i386-efi/ipxe.efi

mkdir /var/tftp

cp bin/undionly.kpxe /var/tftp/undionly.kpxe
cp bin-x86_64-efi/ipxe.efi /var/tftp/ipxe-x86_64.efi
cp bin-i386-efi/ipxe.efi /var/tftp/ipxe-i386.efi
```

# PXE

```bash
dnf install -y syslinux syslinux-nonlinux

cp /usr/share/syslinux/* /var/tftp/

cp -r <content_of_this_folder> /var/tftp/
```
