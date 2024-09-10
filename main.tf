terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"  # Você já está utilizando a versão mais recente compatível
    }
  }
}

provider "virtualbox" {
  # Mantemos a configuração padrão para o provider
}

# Definindo as VMs
resource "virtualbox_vm" "node" {
  count     = var.vm_count
  name      = format(var.vm_name_format, count.index + 1)

  # Utilizando a Vagrant box do Oracle Linux
  image     = "https://app.vagrantup.com/oracle/boxes/ol7-latest/versions/7.8.228/virtualbox.box"
  
  cpus      = var.vm_cpus
  memory    = var.vm_memory
  user_data = file("${path.module}/user_data")  # Arquivo de dados de usuário para scripts de provisionamento
  status    = var.vm_status

  # Configurando adaptadores de rede
  network_adapter {
    type           = var.network_type
    host_interface = var.network_host_interface
  }

  network_adapter {
    type = "nat"
  }

  optical_disks = var.optical_disks  # ISO(s) adicionais, caso seja necessário
}
