# Arch with RAID 0

RAID 0로 Arch Linux 설치하기

2개의 디스크가 각각 `sda`, `sdb` 라고 가정하고,  
`sda1` 을 boot, `sdb1` 을 swap으로 설정, 디스크의 남은 공간 `sda2`, `sdb2` 를 RAID 0로 묶는다.

자세하게 설명되지 않은 것들은 [arch=linux-installation.md](arch=linux-installation.md) 참고

1. UEFI로 부팅되었는지 체크
1. Wifi가 필요하다면 연결
1. 시계 업데이트
1. 디스크 파티셔닝

    ```bash
    cgdisk /dev/sda
    ```
    - /dev/sda1 : 1GB (넉넉잡아 2GB도 무방할 듯), EFI System (EF00)
    - /dev/sda2 : Linux filesystem (8300, default)
    ```bash
    cgdisk /dev/sdb
    ```
    - /dev/sdb1 : depends on RAM, Linux swap (8200)
    - /dev/sdb2 : Linux filesystem (8300, default)

1. RAID 0로 묶기

    ```bash
    modprobe raid0
    mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda2 /dev/sdb2
    ```

1. 파티션 포맷 및 마운트

    ```bash
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sdb1
    mkfs.ext4 /dev/md0

    mount /dev/md0 /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/sdb1
    ```

1. 기본 패키지 설치

1. mdadm 설정
    1. 설정 파일 생성

        ```bash
        mdadm --examine --scan > /mnet/etc/dadm.conf
        ```

    1. rc.conf 수정

        ```bash
        nano /mnt/etc/rc.conf
        ```

        - `MODULES` : `(raid0)`
    1. mkinitcpio.conf 수정

        ```bash
        nano /mnt/etc/mkinitcpio.conf
        ```

        - `MODULES` : `(dm_mod)`
        - `HOOKS` : `filesystems` 앞에 `mdadm` 추가
          - 예: `HOOKS=(base udev autodetect modconf block mdadm filesystems keyboard fsck)`

1. fstab 파일 생성
1. 설치한 리눅스로 chroot

이후는 [arch=linux-installation.md](arch=linux-installation.md)를 따르면 된다.
