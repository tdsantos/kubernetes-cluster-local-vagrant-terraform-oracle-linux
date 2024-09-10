# Número de VMs
variable "vm_count" {
  description = "Número de máquinas virtuais a serem criadas"
  type        = number
  default     = 2
}

# Formato de nome das VMs
variable "vm_name_format" {
  description = "Formato de nome para as VMs"
  type        = string
  default     = "node-%02d"
}

# Imagem da VM
variable "vm_image" {
  description = "Imagem para provisionar as VMs"
  type        = string
  default     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
}

# Número de CPUs
variable "vm_cpus" {
  description = "Número de CPUs para cada VM"
  type        = number
  default     = 2
}

# Tamanho da memória RAM
variable "vm_memory" {
  description = "Quantidade de memória RAM para as VMs"
  type        = string
  default     = "1024 mib"
}

# Status da VM
variable "vm_status" {
  description = "Status da VM (running ou poweroff)"
  type        = string
  default     = "running"
}

# Configuração de rede
variable "network_type" {
  description = "Tipo de rede para o adaptador"
  type        = string
  default     = "hostonly"
}

variable "network_host_interface" {
  description = "Interface do host para usar com o adaptador de rede"
  type        = string
  default     = "vboxnet1"
}

# Discos ópticos
variable "optical_disks" {
  description = "ISO(s) a ser(em) anexado(s) à VM"
  type        = list(string)
  default     = []
}
