설치 전 할 일
--------
홍차 한 잔을 준비한다 (중요)

ArchLinux 홈페이지에서 [Archlinux ISO 파일](https://www.archlinux.org/download/)을 받는다

[Rufus](https://rufus.akeo.ie/)에서 MBR 파티션 형식의 BIOS로 부팅디스크 생성 (VM은 불필요)

부팅디스크로 부팅한다

<br>

부팅미디어에서 할 일
--------
```bash
timedatectl set-ntp true # 시계 업데이트

cfdisk /dev/sda # 디스크 파티셔닝
    # /dev/sda1 : 2GB, Linux swap(8200)
    # /dev/sda2 : Linux filesystem(8300, default)
mkswap /dev/sda1
swapon /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt

nano /etc/pacman.d/mirrorlist # 미러 우선순위 변경
    # Server = http://mirror.premi.st/archlinux/$repo/os/$arch
pacstrap /mnt base base-devel grub efibootmgr sudo openssh
genfstab -U /mnt >> /mnt/etc/fstab
echo '<PC_NAME>' > /mnt/etc/hostname # 컴퓨터 이름 설정
arch-chroot /mnt /bin/bash
```

<br>

설치 직후 할 일
--------
```bash
# Grub 설치
grub-install --recheck /dev/sda
```

[Timezone 설정 부터 동일](arch_gpt+uefi.md)
