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
RUN wget https://archive.org/download/21996.1.210529-1541.co-release-client-consumer-x-64-fre-en-us_20210619_0140/21996.1.210529-1541.co_release_CLIENT_CONSUMER_x64FRE_en-us.iso

# Extract Windows 11 ISO
RUN mkdir /windows11 && \
    unzip -o "*.iso" -d /windows11

# Run QEMU to start Windows 11 VM
CMD qemu-system-x86_64 \
    -m 8G \
    -drive file=/windows11/Windows11.iso,format=raw \
    -cpu host \
    -smp cores=4,threads=2 \
    -vga std \
    -display gtk \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0 \
    -device virtio-mouse-pci \
    -device virtio-keyboard-pci \
    -soundhw hda \
    -boot order=d
