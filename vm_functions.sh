#!/bin/bash

vm_name=$1
modo=$2

start_vm() {
    virsh list --all
    sudo virsh start $vm_name
    virsh list --all
}

shutdown_vm() {
    sudo virsh shutdown $vm_name
}

destroy_vm() {
    sudo virsh destroy $vm_name
}

delete_vm() {
    sudo virsh undefine $vm_name --remove-all-storage
}

save_vm() {
    sudo virsh save $vm_name /mnt/c/UTEC/Cloud/snapshot.qcow2
}

restore_vm() {
    sudo virsh restore /mnt/c/UTEC/Cloud/snapshot.qcow2
}

monitor_vm() {
    sudo virsh start $vm_name
    virt-top
}

if [ "$modo" = "cycle" ]; then
    start_vm
    save_vm
    sleep 10
    restore_vm
    shutdown_vm
    sleep 10
    destroy_vm
    virsh list --all

elif [ "$modo" = "monitor" ]; then
    start_vm
    monitor_vm
else
    echo "Parámetro inválido"
fi