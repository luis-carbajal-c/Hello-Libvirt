# Hello Libvirt

## Integrantes
* Jorge Castillo
* Luis Carbajal

## Creación de la VM
```
sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager cloud-image-utils libguestfs-tools

wget https://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64.img

cat >user-data.txt <<EOF
#cloud-config
password: password
chpasswd: { expire: False }
ssh_pwauth: True
EOF

cloud-localds user-data.img user-data.txt

qemu-img create -b ubuntu-18.04-server-cloudimg-amd64.img -F qcow2 -f qcow2 ubuntu-vm-disk.qcow2 20G

virt-install --name ubuntu \
  --memory 2048 --vcpus 2 \
  --boot hd,menu=on \
  --disk path=ubuntu-vm-disk.qcow2,device=disk \
  --disk path=user-data.img,format=raw \
  --graphics none \
  --os-type Linux --os-variant ubuntu18.04 
```

## Prueba de ciclo de vida
```
./vm_functions.sh ubuntu cycle
```

## Monitoreo
En el host:
```
./vm_functions.sh ubuntu monitor
```
En la VM:
```
virsh console ubuntu #ejecutar en una terminal para conectarse a la vm
sudo apt-get install stress-ng
stress-ng --vm 1 --vm-bytes 512M --timeout 20s
```
