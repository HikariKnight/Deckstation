# Kargs to make my threadripper 1920x not freeze the system
tr-kargs:
    rpm-ostree kargs \
          --append-if-missing="pci=noaer" \
          --append-if-missing="processor.max_cstate=1" \
          --append-if-missing="idle=nomwait" \
          --append-if-missing="rcu_nocbs=0-15" \
          --append-if-missing="usbcore.autosuspend=-1" \
          --append-if-missing="pcie_aspm=off"

# VFIO tailored for HikariKnight's system
my-vfio:
    #!/usr/bin/env bash
    echo "Enabling VFIO..."
    VIRT_TEST=$(rpm-ostree kargs)
    CPU_VENDOR=$(grep "vendor_id" "/proc/cpuinfo" | uniq | awk -F": " '{ print $2 }')
    VENDOR_KARG="unset"
    if [[ ${VIRT_TEST} == *kvm.report_ignored_msrs* ]]; then
      rpm-ostree initramfs \
        --enable \
        --arg="--add-drivers" \
        --arg="vfio vfio_iommu_type1 vfio-pci"
      if [[ ${CPU_VENDOR} == "AuthenticAMD" ]]; then
        VENDOR_KARG="amd_iommu=on"
      elif [[ ${CPU_VENDOR} == "GenuineIntel" ]]; then
        VENDOR_KARG="intel_iommu=on"
      fi
      if [[ ${VENDOR_KARG} == "unset" ]]; then
        echo "Failed to get CPU vendor, exiting..."
        exit 1
      else
        rpm-ostree kargs \
          --append-if-missing="${VENDOR_KARG}" \
          --append-if-missing="iommu=pt" \
          --append-if-missing="rd.driver.pre=vfio_pci" \
          --append-if-missing="vfio_pci.disable_vga=1" \
          --append-if-missing="vfio_pci.ids=10de:10f9,10de:1ada,10de:1adb,10de:1f02"
        echo "VFIO enabled, make sure you enable IOMMU, VT-d or AMD-v in your BIOS!"
        echo "Please understand that since this is such a niche use case, support will be very limited!"
        echo "To add your unused/second GPU device ids to the vfio driver by running"
        echo 'rpm-ostree kargs --append-if-missing="vfio-pci.ids=xxxx:yyyy,xxxx:yyzz"'
        echo "NOTE: Your second GPU will not be usable by the host after you do this!"
      fi
    else
      echo "Enable virtualization with just enable-virtualization before running just enable-vfio."
    fi

