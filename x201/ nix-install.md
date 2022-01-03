

   parted /dev/sda -- mklabel msdos
   parted /dev/sda -- mkpart primary 1MiB 512MiB
parted /dev/sda -- mkpart primary 512MiB -1s
parted /dev/sda -- set 1 boot on
parted /dev/sda -- set 2 lvm on
mkfs.vfat -F 32 -n boot /dev/sda1
cryptsetup luksFormat /dev/sda2
cryptsetup luksOpen /dev/sda2 nixos
pvcreate /dev/mapper/nixos
vgcreate vg /dev/mapper/nixos
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n root vg
mkfs.ext4 -L root /dev/vg/root
mkswap -L swap /dev/vg/swap
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/vg/swap
nixos-generate-config --root /mnt
scp ..
nixos-install
