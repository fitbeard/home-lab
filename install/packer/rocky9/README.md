# `Rocky Linux 9`

## build

```bash
/usr/local/bin/packer init rocky9.pkr.hcl
PACKER_LOG=1 /usr/local/bin/packer build -force rocky9.pkr.hcl
```

## resize

In Kickstart configuration used by this example `/dev/sda2` is `root` partition.

```bash
qemu-img create -f qcow2 -o preallocation=metadata newdisk.qcow2 80G
virsh destroy domain.name
virt-resize --expand /dev/sda2 domain.name.qcow2 newdisk.qcow2
rm domain.name.qcow2
mv newdisk.qcow2 domain.name.qcow2
virsh start domain.name
```
