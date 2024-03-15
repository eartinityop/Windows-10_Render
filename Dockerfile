# Use a base Linux image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    qemu \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-clients \
    bridge-utils \
    virt-manager \
    ovmf \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for Windows ISO
WORKDIR /windows

# Download Windows 11 ISO (Replace <URL_TO_WINDOWS11_ISO> with the actual URL)
RUN wget -O Windows11.iso https://archive.org/download/21996.1.210529-1541.co-release-client-consumer-x-64-fre-en-us_20210619_0140/21996.1.210529-1541.co_release_CLIENT_CONSU

# Run QEMU to start Windows 11 VM
CMD qemu-system-x86_64 \
    -m 8G \
    -cdrom /windows/Windows11.iso \
    -boot d \
    -enable-kvm \
    -vga virtio \
    -soundhw hda \
    -display gtk
